using AcreFacturacion.Web.Data;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AcreFacturacion.Web.Controllers.Api
{
    [Route("api/reportes")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class ReportesApiController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public ReportesApiController(ApplicationDbContext context)
        {
            _context = context;
        }

        /// <summary>Retorna productos activos con stock menor a 5 unidades.</summary>
        [HttpGet("inventario-bajo")]
        public async Task<IActionResult> InventarioBajo()
        {
            var resultado = await _context.Productos
                .AsNoTracking()
                .Where(p => p.Estado && p.Stock < 5)
                .OrderBy(p => p.Stock)
                .ThenBy(p => p.Nombre)
                .Select(p => new
                {
                    p.Id,
                    p.Nombre,
                    p.Codigo,
                    p.Stock,
                    p.Precio
                })
                .ToListAsync();

            return Ok(resultado);
        }
    }
}
