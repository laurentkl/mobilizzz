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
        var teams = await _dbContext.Teams
            .Include(t => t.Company)
            .ToListAsync();
        return Ok(teams);
    }

    [HttpPost("Create")]
    public async Task<IActionResult> Create([FromBody] Team team)
    {
        // Validate the incoming team data
        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }

        // Add the team to the database
        _dbContext.Teams.Add(team);
        await _dbContext.SaveChangesAsync();

        return Ok(new { message = "Team created successfully", team });
    }

    [HttpGet("GetTeamsByUser/{userId}")]
    public async Task<IActionResult> GetTeamsByUser(int userId)
    {
        // Fetch the user with the associated teams
        var user = await _dbContext.Users
            .Include(u => u.Teams)
            .SingleOrDefaultAsync(u => u.Id == userId);

        if (user == null)
        {
            return NotFound(); // Return 404 if the user is not found
        }

        // Extract the team IDs from the user's teams
        var teamIds = user.Teams?.Select(t => t.Id).ToList();

        if (teamIds == null || teamIds.Count == 0)
        {
            return NotFound(); // Return 404 if the user is not part of any teams
        }

        // Fetch the teams including the associated users
        var teams = await _dbContext.Teams
            .Include(t => t.Users)
            .Where(t => teamIds.Contains(t.Id))
            .ToListAsync();

        return Ok(teams); // Return the teams with associated users if found
    }

    [HttpPost("JoinTeam")]
    public async Task<IActionResult> JoinTeam([FromBody] JoinTeamRequest request)
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
            .SingleOrDefaultAsync(t => t.Id == request.TeamId);

        if (team == null)
        {
            return NotFound(new { message = "Team not found" });
        }

        // Check if the user is already a member of the team
        if (user.Teams.Any(t => t.Id == request.TeamId))
        {
            return BadRequest(new { message = "User is already a member of this team" });
        }

        // Add the user to the team's users list
        team.Users.Add(user);

        // Save changes to the database
        await _dbContext.SaveChangesAsync();

        return Ok(new { message = "User successfully joined the team" });
    }
}