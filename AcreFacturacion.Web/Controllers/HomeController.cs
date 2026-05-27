using System.Diagnostics;
using AcreFacturacion.Web.Data;
using AcreFacturacion.Web.Models;
using AcreFacturacion.Web.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AcreFacturacion.Web.Controllers
{
    public class HomeController : Controller
    {
        private const int InventoryLowThreshold = 5;

        private readonly ApplicationDbContext _context;

        public HomeController(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index(CancellationToken cancellationToken)
        {
            var model = new DashboardViewModel
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

            return View(model);
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