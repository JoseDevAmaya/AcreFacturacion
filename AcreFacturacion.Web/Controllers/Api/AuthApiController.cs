using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using AcreFacturacion.Web.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

namespace AcreFacturacion.Web.Controllers.Api
{
    [Route("api/auth")]
    [ApiController]
    [AllowAnonymous]
    public class AuthApiController : ControllerBase
    {
        private readonly ApplicationDbContext _context;
        private readonly IConfiguration _config;

        public AuthApiController(ApplicationDbContext context, IConfiguration config)
        {
            _context = context;
            _config = config;
        }

        /// <summary>Genera un token JWT con credenciales válidas.</summary>
        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginApiRequest request)
        {
            var usuario = await _context.Usuarios
                .AsNoTracking()
                .FirstOrDefaultAsync(u => u.NombreUsuario == request.NombreUsuario && u.Estado);

            if (usuario == null || !BCrypt.Net.BCrypt.Verify(request.Password, usuario.PasswordHash))
                return Unauthorized(new { mensaje = "Credenciales inválidas." });

            var expira = DateTime.UtcNow.AddMinutes(
                int.Parse(_config["Jwt:ExpiresMinutes"]!));

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:Key"]!));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var claims = new[]
            {
                new Claim(ClaimTypes.Name, usuario.NombreUsuario),
                new Claim(ClaimTypes.GivenName, usuario.Nombre ?? usuario.NombreUsuario),
                new Claim(ClaimTypes.NameIdentifier, usuario.Id.ToString())
            };

            var token = new JwtSecurityToken(
                issuer: _config["Jwt:Issuer"],
                audience: _config["Jwt:Audience"],
                claims: claims,
                expires: expira,
                signingCredentials: creds);

            return Ok(new
            {
                token = new JwtSecurityTokenHandler().WriteToken(token),
                nombreUsuario = usuario.NombreUsuario,
                nombre = usuario.Nombre,
                expira
            });
        }
    }

    public record LoginApiRequest(string NombreUsuario, string Password);
}
