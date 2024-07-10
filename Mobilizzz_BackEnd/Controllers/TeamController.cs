using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Mobilizzz_BackEnd.Models;

namespace Mobilizzz_BackEnd.Controllers;

[ApiController]
[Route("[controller]")]
public class TeamController : ControllerBase
{
    private readonly Context _dbContext;

    public TeamController(Context context)
    {
        _dbContext = context;
    }

    [HttpGet("GetAll")]
    public async Task<IActionResult> GetAll()
    {
        try
        {
            var teams = await _dbContext.Teams
                .Include(t => t.Company)
                .ToListAsync();

            return Ok(teams);
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.ToString(), "An error occurred while fetching all teams");

            return StatusCode(StatusCodes.Status500InternalServerError, new { message = "An error occurred while processing your request" });
        }
    }

    [HttpPost("Create")]
    public async Task<IActionResult> Create([FromBody] Team team)
    {
        try
        {
            if (!ModelState.IsValid) return BadRequest();

            var creatorUser = await _dbContext.Users.FindAsync(team?.AdminIds?.First());

            team.Users = new List<User> { creatorUser };

            _dbContext.Teams.Add(team);

            await _dbContext.SaveChangesAsync();

            return Ok(new { message = "Team created successfully", team });
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.ToString(), "An error occurred while creating the team");

            return StatusCode(StatusCodes.Status500InternalServerError, new { message = "An error occurred while processing your request" });
        }
    }

    [HttpGet("GetTeamsByUser/{userId}")]
    public async Task<IActionResult> GetTeamsByUser(int userId)
    {
        try
        {
            var user = await _dbContext.Users
                .Include(u => u.Teams)
                .SingleOrDefaultAsync(u => u.Id == userId);

            if (user == null) return NotFound(new { message = "User not found" });

            var teamIds = user.Teams?.Select(t => t.Id).ToList();

            if (teamIds == null || teamIds.Count == 0) return Ok(new List<Team>());

            var teams = await _dbContext.Teams
                .Include(t => t.Users)
                .ThenInclude(u => u.Records)
                .Include(t => t.PendingUserRequests)
                .Where(t => teamIds.Contains(t.Id))
                .ToListAsync();

            return Ok(teams);
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.ToString(), "An error occurred while fetching teams by user");

            return StatusCode(StatusCodes.Status500InternalServerError, new { message = "An error occurred while processing your request" });
        }
    }


    [HttpPost("JoinTeamRequest")]
    public async Task<IActionResult> JoinTeamRequest([FromBody] JoinTeamRequest request)
    {
        try
        {
            var user = await _dbContext.Users
                .Include(u => u.Teams)
                .Include(u => u.PendingTeamRequests)
                .SingleOrDefaultAsync(u => u.Id == request.UserId);

            if (user == null)
            {
                return NotFound(new { message = "User not found" });
            }

            var team = await _dbContext.Teams
                .Include(t => t.Users)
                .SingleOrDefaultAsync(t => t.Id == request.TeamId);

            if (team == null)
            {
                return NotFound(new { message = "Team not found" });
            }

            if (user.Teams?.Any(t => t.Id == request.TeamId) ?? false)
            {
                return BadRequest(new { message = "User is already a member of this team" });
            }

            if (user.PendingTeamRequests?.Any(t => t.Id == request.TeamId) ?? false)
            {
                return BadRequest(new { message = "User already request to join this team" });
            }

            team.PendingUserRequests ??= new List<User>();
            team.PendingUserRequests.Add(user);

            await _dbContext.SaveChangesAsync();

            return Ok(new { message = "User successfully request joined the team" });
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.ToString(), "An error occurred while joining the team");

            return StatusCode(StatusCodes.Status500InternalServerError, new { message = "An error occurred while processing your request" });
        }
    }

    [HttpPost("ApproveTeamRequest")]
    public async Task<IActionResult> ApproveTeamRequest([FromBody] ApproveTeamRequest request)
    {
        try
        {
            var user = await _dbContext.Users
                .Include(u => u.Teams)
                .SingleOrDefaultAsync(u => u.Id == request.UserId);

            if (user == null)
            {
                return NotFound(new { message = "User not found" });
            }

            var team = await _dbContext.Teams
                .Include(t => t.Users)
                .Include(t => t.PendingUserRequests)
                .SingleOrDefaultAsync(t => t.Id == request.TeamId);

            if (team == null)
            {
                return NotFound(new { message = "Team not found" });
            }

            if (user.Teams?.Any(t => t.Id == request.TeamId) ?? false)
            {
                return BadRequest(new { message = "User is already a member of this team" });
            }

            if (request.IsApproved)
            {
                team.Users ??= new List<User>();
                team.Users.Add(user);
            }

            team?.PendingUserRequests?.Remove(user);

            // Save changes to the database
            await _dbContext.SaveChangesAsync();

            return Ok(new { message = "User request successfully processes" });
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.ToString(), "An error occurred while joining the team");

            return StatusCode(StatusCodes.Status500InternalServerError, new { message = "An error occurred while processing your request" });
        }
    }

}