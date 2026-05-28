using System.Diagnostics;
using AcreFacturacion.Web.Data;
using AcreFacturacion.Web.Models;
using AcreFacturacion.Web.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;

namespace AcreFacturacion.Web.Controllers
{
    [Authorize]
    public class HomeController : Controller
    {
        private const int InventoryLowThreshold = 5;
        private const string DashboardCacheKey = "dashboard";

        private readonly ApplicationDbContext _context;
        private readonly IMemoryCache _cache;

        public HomeController(ApplicationDbContext context, IMemoryCache cache)
        {
            _context = context;
            _cache = cache;
        }

        public async Task<IActionResult> Index(CancellationToken cancellationToken)
        {
            if (!_cache.TryGetValue(DashboardCacheKey, out DashboardViewModel? model))
            {
                model = new DashboardViewModel
                {
                    ClientesActivos = await _context.Clientes
                        .AsNoTracking()
                        .CountAsync(c => c.Estado, cancellationToken),

                    ProductosActivos = await _context.Productos
                        .AsNoTracking()
                        .CountAsync(p => p.Estado, cancellationToken),

                    FacturasEmitidas = await _context.Facturas
                        .AsNoTracking()
                        .CountAsync(f => !f.Anulada, cancellationToken),

                    TotalFacturado = await _context.Facturas
                        .AsNoTracking()
                        .Where(f => !f.Anulada)
                        .SumAsync(f => (decimal?)f.Total, cancellationToken) ?? 0,

                    ProductosInventarioBajo = await _context.Productos
                        .AsNoTracking()
                        .CountAsync(p => p.Estado && p.Stock < InventoryLowThreshold, cancellationToken),

                    UltimasFacturas = await _context.Facturas
                        .AsNoTracking()
                        .Where(f => !f.Anulada)
                        .OrderByDescending(f => f.Fecha)
                        .Take(5)
                        .Select(f => new UltimaFacturaViewModel
                        {
                            Id = f.Id,
                            NumeroFactura = f.NumeroFactura,
                            Cliente = f.Cliente != null ? f.Cliente.Nombre : string.Empty,
                            Fecha = f.Fecha,
                            Total = f.Total
                        })
                        .ToListAsync(cancellationToken)
                };

                _cache.Set(DashboardCacheKey, model, TimeSpan.FromSeconds(60));
            }

            return View(model!);
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel
            {
                RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier
            });
        }
    }
}
