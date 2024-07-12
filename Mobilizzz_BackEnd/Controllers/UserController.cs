using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Mobilizzz_BackEnd.Models;

namespace Mobilizzz_BackEnd.Controllers;

[ApiController]
[Route("[controller]")]
public class UserController : ControllerBase
{
    private readonly Context _dbContext;

    public UserController(Context context)
    {
        _dbContext = context;
    }

    [HttpGet("Get/{id}")]
    public async Task<IActionResult> Get(int id)
    {
        var user = await _dbContext.Users
            .Include(u => u.Teams)
            .Include(u => u.Records)
            .SingleOrDefaultAsync(u => u.Id == id);

        if (user == null)
        {
            return NotFound();
        }

        return Ok(user);
    }

    [HttpGet("GetUsersByTeam/{teamId}")]
    public async Task<IActionResult> GetUsersByTeam(int teamId)
    {
        var team = await _dbContext.Teams
            .Include(t => t.Users).ThenInclude(u => u.Records)
            .FirstOrDefaultAsync(t => t.Id == teamId);

        if (team == null)
        {
            return NotFound();
        }

        return Ok(team.Users);
    }

    [HttpPost("Create")]
    public async Task<IActionResult> Create([FromBody] User user)
    {
        try
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);

            _dbContext.Users.Add(user);
            await _dbContext.SaveChangesAsync();

            return Ok(new { message = "User created successfully", user });
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.ToString());
            return StatusCode(StatusCodes.Status500InternalServerError, new { message = "An error occurred while processing your request" });
        }
    }

    [HttpPut("Update/{id}")]
    public async Task<IActionResult> Update(int id, [FromBody] User updatedUser)
    {
        try
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);

            var user = await _dbContext.Users.FindAsync(id);
            if (user == null) return NotFound();

            // Update only if the password is provided and not null
            if (!string.IsNullOrEmpty(updatedUser.Password))
            {
                user.Password = updatedUser.Password;
            }

            // Update other properties
            user.FirstName = updatedUser.FirstName;
            user.LastName = updatedUser.LastName;
            user.Email = updatedUser.Email;
            user.UserName = updatedUser.UserName;

            _dbContext.Entry(user).State = EntityState.Modified;
            await _dbContext.SaveChangesAsync();

            return Ok(new { message = "User updated successfully", user });
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.ToString());
            return StatusCode(StatusCodes.Status500InternalServerError, new { message = "An error occurred while processing your request" });
        }
    }


    [HttpDelete("Delete/{id}")]
    public async Task<IActionResult> Delete(int id)
    {
        try
        {
            var user = await _dbContext.Users.FindAsync(id);
            if (user == null) return NotFound();

            _dbContext.Users.Remove(user);
            await _dbContext.SaveChangesAsync();

            return Ok(new { message = "User deleted successfully" });
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.ToString());
            return StatusCode(StatusCodes.Status500InternalServerError, new { message = "An error occurred while processing your request" });
        }
    }
}
