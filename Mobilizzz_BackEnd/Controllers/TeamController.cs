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
            // Log the exception
            Console.WriteLine(ex.ToString(), "An error occurred while fetching all teams");

            // Return a generic error message
            return StatusCode(StatusCodes.Status500InternalServerError, new { message = "An error occurred while processing your request" });
        }
    }

    [HttpPost("Create")]
    public async Task<IActionResult> Create([FromBody] Team team)
    {
        try
        {
            // Validate the incoming team data
            if (!ModelState.IsValid) return BadRequest();

            var creatorUser = await _dbContext.Users.FindAsync(team?.AdminIds?.First());

            // Initialize the Users list if it's null
            team.Users = new List<User> { creatorUser };

            // Add the team to the database
            _dbContext.Teams.Add(team);

            await _dbContext.SaveChangesAsync();

            return Ok(new { message = "Team created successfully", team });
        }
        catch (Exception ex)
        {
            // Log the exception
            Console.WriteLine(ex.ToString(), "An error occurred while creating the team");

            // Return a generic error message
            return StatusCode(StatusCodes.Status500InternalServerError, new { message = "An error occurred while processing your request" });
        }
    }

    [HttpGet("GetTeamsByUser/{userId}")]
    public async Task<IActionResult> GetTeamsByUser(int userId)
    {
        try
        {
            // Fetch the user with the associated teams
            var user = await _dbContext.Users
                .Include(u => u.Teams)
                .SingleOrDefaultAsync(u => u.Id == userId);

            if (user == null) return NotFound(new { message = "User not found" });

            // Extract the team IDs from the user's teams
            var teamIds = user.Teams?.Select(t => t.Id).ToList();

            if (teamIds == null || teamIds.Count == 0) return Ok(new List<Team>());

            // Fetch the teams including the associated users
            var teams = await _dbContext.Teams
                .Include(t => t.Users)
                .Include(t => t.PendingUserRequests)
                .Where(t => teamIds.Contains(t.Id))
                .ToListAsync();

            return Ok(teams); // Return the teams with associated users if found
        }
        catch (Exception ex)
        {
            // Log the exception
            Console.WriteLine(ex.ToString(), "An error occurred while fetching teams by user");

            // Return a generic error message
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

            // Check if the user is already a member of the team
            if (user.Teams?.Any(t => t.Id == request.TeamId) ?? false)
            {
                return BadRequest(new { message = "User is already a member of this team" });
            }

            // Check if the user is already in the request members
            if (user.PendingTeamRequests?.Any(t => t.Id == request.TeamId) ?? false)
            {
                return BadRequest(new { message = "User already request to join this team" });
            }

            // Add the user to the team's users list
            team.PendingUserRequests ??= new List<User>();
            team.PendingUserRequests.Add(user);

            // Save changes to the database
            await _dbContext.SaveChangesAsync();

            return Ok(new { message = "User successfully request joined the team" });
        }
        catch (Exception ex)
        {
            // Log the exception
            Console.WriteLine(ex.ToString(), "An error occurred while joining the team");

            // Return a generic error message
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

            // Check if the user is already a member of the team
            if (user.Teams?.Any(t => t.Id == request.TeamId) ?? false)
            {
                return BadRequest(new { message = "User is already a member of this team" });
            }

            if(request.IsApproved)
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
            // Log the exception
            Console.WriteLine(ex.ToString(), "An error occurred while joining the team");

            // Return a generic error message
            return StatusCode(StatusCodes.Status500InternalServerError, new { message = "An error occurred while processing your request" });
        }
    }

}