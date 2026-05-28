using AcreFacturacion.Web.Data;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AcreFacturacion.Web.Controllers.Api
{
    [Route("api/clientes")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class ClientesApiController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public ClientesApiController(ApplicationDbContext context)
        {
            _context = context;
        }

        /// <summary>Retorna todos los clientes activos.</summary>
        [HttpGet]
        public async Task<IActionResult> Get()
        {
            var clientes = await _context.Clientes
                .AsNoTracking()
                .Where(c => c.Estado)
                .OrderBy(c => c.Nombre)
                .Select(c => new
                {
                    c.Id,
                    c.Nombre,
                    c.IdentidadRTN,
                    c.Telefono,
                    c.Correo,
                    c.FechaRegistro,
                    c.Estado
                })
                .ToListAsync();

            return Ok(clientes);
        }
    }
}
