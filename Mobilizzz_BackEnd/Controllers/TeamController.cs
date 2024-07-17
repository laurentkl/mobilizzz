using System.Linq;
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

            // Check if companyId is 0
            if (team.CompanyId == 0)
            {
                // Find the company with name "mobilitizzz"
                var company = await _dbContext.Companies.FirstOrDefaultAsync(c => c.Name.ToLower() == "mobilitizzz");

                if (company == null)
                {
                    // If company is not found, return a 404 Not Found response or handle accordingly
                    return NotFound(new { message = "Company 'mobilitizzz' not found" });
                }

                // Set the team's companyId to the found company's ID
                team.CompanyId = company.Id;
            }

            team.Users = new List<User> { team.Admins.First() };

            // Prevent ef core to try recreating the user
            _dbContext.Users.Attach(team.Admins.First());

            // Add the team to the Teams DbSet
            _dbContext.Teams.Add(team);

            // Save changes to the database
            await _dbContext.SaveChangesAsync();

            // Return success response with created team
            return Ok(new { message = "Team created successfully", team });
        }
        catch (Exception ex)
        {
            // Log exception
            Console.WriteLine(ex.ToString(), "An error occurred while creating the team");

            // Return 500 Internal Server Error response
            return StatusCode(StatusCodes.Status500InternalServerError, new { message = "An error occurred while processing your request" });
        }
    }

    [HttpPut("Update/{id}")]
    public async Task<IActionResult> Update(int id, [FromBody] Team updatedTeam)
    {
        try
        {
            if (!ModelState.IsValid) return BadRequest();

            // Find the existing team by ID
            var existingTeam = await _dbContext.Teams.Include(t => t.Admins).FirstOrDefaultAsync(t => t.Id == id);

            if (existingTeam == null)
            {
                // If team is not found, return a 404 Not Found response
                return NotFound(new { message = "Team not found" });
            }

            // Update the team's properties with the new values
            existingTeam.Name = updatedTeam.Name;
            existingTeam.IsHidden = updatedTeam.IsHidden;
            existingTeam.IsPrivate = updatedTeam.IsPrivate;

            // Save changes to the database
            await _dbContext.SaveChangesAsync();

            // Return success response with updated team
            return Ok(new { message = "Team updated successfully", team = existingTeam });
        }
        catch (Exception ex)
        {
            // Log exception
            Console.WriteLine(ex.ToString(), "An error occurred while updating the team");

            // Return 500 Internal Server Error response
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
                .Include(t => t.Admins)
                .Include(t => t.PendingUserRequests)
                .Where(t => teamIds.Contains(t.Id))
                .ToListAsync();

            var recordsWithoutUser = await _dbContext.Records
                .Where(r => r.UserId == null && teamIds.Contains(r.TeamId ?? 0))
                .ToListAsync();

            foreach (var team in teams)
            {
                var teamRecordsWithoutUser = recordsWithoutUser
                    .Where(r => r.TeamId == team.Id)
                    .ToList();

                if (teamRecordsWithoutUser.Any())
                {
                    var deletedUser = new User
                    {
                        UserName = "Utilisateurs supprimés",
                        FirstName = "",
                        LastName = "",
                        Email = "",
                        Records = teamRecordsWithoutUser,
                        Teams = new List<Team> { team }
                    };

                    if (team.Users == null)
                    {
                        team.Users = new List<User>();
                    }

                    team.Users.Add(deletedUser);
                }
            }

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

    [HttpPost("GrantAdminRights")]
    public async Task<IActionResult> GrantAdminRights([FromBody] GrantAdminRightsRequest request)
    {
        try
        {
            var team = await _dbContext.Teams
                .Include(t => t.Users)
                .Include(t => t.Admins)
                .SingleOrDefaultAsync(t => t.Id == request.TeamId);

            if (team == null)
            {
                return NotFound(new { message = "Team not found" });
            }


            var userToPromote = await _dbContext.Users
                .SingleOrDefaultAsync(u => u.Id == request.UserToPromoteId);

            if (userToPromote == null)
            {
                return NotFound(new { message = "User to promote not found" });
            }

            team.Admins.Add(userToPromote);

            await _dbContext.SaveChangesAsync();

            return Ok(new { message = "Admin rights granted successfully" });
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.ToString(), "An error occurred while granting admin rights");

            return StatusCode(StatusCodes.Status500InternalServerError, new { message = "An error occurred while processing your request" });
        }
    }

    [HttpPost("EjectUser")]
    public async Task<IActionResult> EjectUser([FromBody] EjectUserRequest request)
    {
        try
        {
            var team = await _dbContext.Teams
                .Include(t => t.Users)
                .SingleOrDefaultAsync(t => t.Id == request.TeamId);

            if (team == null)
            {
                return NotFound(new { message = "Team not found" });
            }

            var userToEject = team.Users.SingleOrDefault(u => u.Id == request.UserId);
            if (userToEject == null)
            {
                return NotFound(new { message = "User not found in the team" });
            }

            team.Users.Remove(userToEject);
            await _dbContext.SaveChangesAsync();

            return Ok(new { message = "User ejected successfully" });
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.ToString(), "An error occurred while ejecting user");

            return StatusCode(StatusCodes.Status500InternalServerError, new { message = "An error occurred while processing your request" });
        }
    }

    [HttpPost("LeaveTeam")]
    public async Task<IActionResult> LeaveTeam([FromBody] LeaveTeamRequest request)
    {
        try
        {
            var team = await _dbContext.Teams
                .Include(t => t.Users)
                .SingleOrDefaultAsync(t => t.Id == request.TeamId);

            if (team == null)
            {
                return NotFound(new { message = "Team not found" });
            }

            var userToLeave = team.Users.SingleOrDefault(u => u.Id == request.UserId);
            if (userToLeave == null)
            {
                return NotFound(new { message = "User not found in the team" });
            }

            team.Users.Remove(userToLeave);
            await _dbContext.SaveChangesAsync();

            return Ok(new { message = "User left the team successfully" });
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.ToString(), "An error occurred while leaving the team");

            return StatusCode(StatusCodes.Status500InternalServerError, new { message = "An error occurred while processing your request" });
        }
    }

}