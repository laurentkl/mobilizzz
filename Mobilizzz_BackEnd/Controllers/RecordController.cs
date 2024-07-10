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
            .Where(r => r.UserId == userId)
            .OrderByDescending(r => r.CreationDate)
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
        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }

        _dbContext.Records?.Add(model);
        await _dbContext.SaveChangesAsync();

        return Ok(model);
    }
}