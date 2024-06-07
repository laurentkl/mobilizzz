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
        var teams = await _dbContext.Teams.ToListAsync();
        return Ok(teams);
    }

    [HttpGet("GetTeams/{userId}")]
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
}