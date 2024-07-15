using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using Mobilizzz_BackEnd.Models;
using Npgsql.Replication;
using System;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace Mobilizzz_BackEnd.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly Context _dbContext;
        private readonly IConfiguration _configuration;

        public AuthController(Context context, IConfiguration configuration)
        {
            _dbContext = context;
            _configuration = configuration;
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login(LoginRequest model)
        {
            var user = await _dbContext.Users
                .Include(u => u.Teams).ThenInclude(t => t.Company)
                .Include(u => u.Records)
                .FirstOrDefaultAsync(u => u.Email == model.Email && u.Password == model.Password);

            if (user == null)
            {
                return Unauthorized(new { message = "Wrong email/password" });
            }

            var token = GenerateJwtToken(user);

            var userWithTeamDto = new UserWithTeamDto
            {
                Id = user.Id,
                UserName = user.UserName,
                LastName = user.LastName,
                FirstName = user.FirstName,
                Email = user.Email,
                CompaniesOwnerShip = user.CompaniesOwnerShip,
                TeamsOwnerShip = user.TeamsOwnerShip,
                Teams = user.Teams,
            };

            return Ok(new { User = userWithTeamDto, Token = token });
        }

        private string GenerateJwtToken(User user)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_configuration["Jwt:SecretKey"]);

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[]
                {
                    new Claim(ClaimTypes.Name, user.FirstName),
                }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };

            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }


        [HttpPost("SignUp")]
        public async Task<IActionResult> SignUp(SignUpRequest model)
        {
            try
            {
                var existingUser = await _dbContext.Users
                    .Include(u => u.Teams).ThenInclude(t => t.Company)
                    .Include(u => u.CompaniesOwnerShip)
                    .Include(u => u.TeamsOwnerShip)
                    .FirstOrDefaultAsync(u => u.Email == model.Email || u.UserName == model.UserName);

                if (existingUser != null)
                {
                    return Conflict(new { message = "User already exists" });
                }

                var newUser = new User
                {
                    FirstName = model.FirstName,
                    LastName = model.LastName,
                    Email = model.Email,
                    Password = model.Password,
                    UserName = model.UserName,
                };

                _dbContext.Users.Add(newUser);

                if (model.TeamCode != 0)
                {
                    var team = await _dbContext.Teams
                        .Include(t => t.PendingUserRequests)
                        .FirstOrDefaultAsync(t => t.Id == model.TeamCode);

                    if (team == null)
                    {
                        return NotFound(new { message = "Team not found" });
                    }

                    team?.PendingUserRequests.Add(newUser);
                }

                var company = await _dbContext.Companies.FirstOrDefaultAsync(c => c.Name.ToLower() == "mobilitizzz");

                if (company == null)
                {
                    return NotFound(new { message = "Company 'mobilitizzz' not found" });
                }

                newUser.CompaniesOwnerShip = new List<Company> { company };

                await _dbContext.SaveChangesAsync();

                // Mapper les données vers le DTO UserWithTeam
                var userWithTeamDto = new UserWithTeamDto
                {
                    Id = newUser.Id,
                    UserName = newUser.UserName,
                    LastName = newUser.LastName,
                    FirstName = newUser.FirstName,
                    Email = newUser.Email,
                    Password = newUser.Password,  // Vous devriez envisager de ne pas retourner le mot de passe dans le DTO
                    CompaniesOwnerShip = newUser.CompaniesOwnerShip,
                    TeamsOwnerShip = newUser.TeamsOwnerShip,
                    Teams = newUser.Teams,
                };

                var token = GenerateJwtToken(newUser);

                return Ok(new { User = userWithTeamDto, Token = token });
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, $"An error occurred: {ex.Message}");
            }
        }


    }


}
