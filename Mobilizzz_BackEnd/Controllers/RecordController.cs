using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Mobilizzz_BackEnd.Models;

namespace Mobilizzz_BackEnd.Controllers;

[ApiController]
[Route("[controller]")]
public class RecordController : ControllerBase
{
    private readonly Context _dbContext;

    public RecordController(Context context)
    {
        _dbContext = context;
    }

    [HttpGet("GetAll")]
    public async Task<IActionResult> GetAll()
    {
        var records = await _dbContext.Records.ToListAsync();
        return Ok(records);
    }

    [HttpGet("GetRecordsByUserId/{userId}")]
    public async Task<IActionResult> GetRecordsByUserId(int userId)
    {
        var records = await _dbContext.Records
            .Include(r => r.Team) // Include the Team navigation property
            .Where(r => r.UserId == userId)
            .OrderByDescending(r => r.CreationDate)
            .Select(r => new RecordWithTeamDto
            {
                Id = r.Id,
                CreationDate = r.CreationDate,
                TransportMethod = r.TransportMethod,
                RecordType = r.RecordType,
                Distance = r.Distance,
                UserId = r.UserId,
                TeamId = r.TeamId,
                Team = r.Team
            })
            .ToListAsync();

        return Ok(records);
    }

    [HttpGet("GetRecordsByTeamId/{teamId}")]
    public async Task<IActionResult> GetRecordsByTeamId(int teamId)
    {
        var records = await _dbContext.Records
            .Where(r => r.TeamId == teamId)
            .OrderByDescending(r => r.CreationDate)
            .ToListAsync();
        return Ok(records);
    }

    [HttpPost("Create")]
    public async Task<IActionResult> Create(Record model)
    {
        try
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _dbContext.Records?.Add(model);
            await _dbContext.SaveChangesAsync();

            return Ok(model);
        }
        catch (Exception ex)
        {
            return StatusCode(StatusCodes.Status500InternalServerError, $"An error occurred: {ex.Message}");
        }
    }
}