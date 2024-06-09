using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using Mobilizzz_BackEnd.Models;
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
            // Vérifier les informations d'identification de l'utilisateur
            var user = await _dbContext.Users
                .Include(u => u.Teams).ThenInclude(t => t.Company)
                .Include(u => u.Records)
                .FirstOrDefaultAsync(u => u.Email == model.Email && u.Password == model.Password);

            if (user == null)
            {
                // Si les informations d'identification sont incorrectes, retourner une erreur 401
                return Unauthorized();
            }

            // Si les informations d'identification sont correctes, générer un token JWT
            var token = GenerateJwtToken(user);

            // Retourner le token JWT dans la réponse
            return Ok(new { User = user, Token = token });
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
                    // Ajoutez plus de revendications au besoin (par exemple, rôles, autorisations)
                }),
                Expires = DateTime.UtcNow.AddDays(7), // Durée de validité du token
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };

            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }


        [HttpPost("signup")]
        public async Task<IActionResult> SignUp(User model)
        {
            try
            {
                // Vérifier si l'utilisateur existe déjà dans la base de données
                var existingUser = await _dbContext.Users
                    .Include(u => u.Teams).ThenInclude(t => t.Company)
                    .FirstOrDefaultAsync(u => u.Email == model.Email);

                if (existingUser != null)
                {
                    // Si l'utilisateur existe déjà, retourner une erreur 409 (Conflict)
                    return Conflict("User already exists");
                }

                // Créer un nouvel utilisateur avec les données fournies dans le modèle
                var newUser = new User
                {
                    FirstName = model.FirstName,
                    LastName = model.LastName,
                    Email = model.Email,
                    Password = model.Password,
                    // Ajoutez d'autres propriétés si nécessaire
                };

                // Ajouter le nouvel utilisateur à la base de données
                _dbContext.Users.Add(newUser);
                await _dbContext.SaveChangesAsync();

                // Générer un token JWT pour le nouvel utilisateur
                var token = GenerateJwtToken(newUser);

                // Retourner le token JWT et les données de l'utilisateur dans la réponse
                return Ok(new { User = newUser, Token = token });
            }
            catch (Exception ex)
            {
                // En cas d'erreur, retourner une erreur 500 (Internal Server Error)
                return StatusCode(StatusCodes.Status500InternalServerError, $"An error occurred: {ex.Message}");
            }
        }

    }


}
