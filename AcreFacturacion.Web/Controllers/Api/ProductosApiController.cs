using AcreFacturacion.Web.Data;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AcreFacturacion.Web.Controllers.Api
{
    [Route("api/productos")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class ProductosApiController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public ProductosApiController(ApplicationDbContext context)
        {
            _context = context;
        }

        /// <summary>Retorna todos los productos activos.</summary>
        [HttpGet]
        public async Task<IActionResult> Get()
        {
            var productos = await _context.Productos
                .AsNoTracking()
                .Where(p => p.Estado)
                .OrderBy(p => p.Nombre)
                .Select(p => new
                {
                    p.Id,
                    p.Nombre,
                    p.Codigo,
                    p.Precio,
                    p.Stock,
                    p.Estado
                })
                .ToListAsync();

            return Ok(productos);
        }
    }
}
