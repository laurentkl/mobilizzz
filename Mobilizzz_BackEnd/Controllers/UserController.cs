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


}