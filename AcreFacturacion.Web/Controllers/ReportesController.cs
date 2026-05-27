using AcreFacturacion.Web.Data;
using AcreFacturacion.Web.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AcreFacturacion.Web.Controllers
{
    public class ReportesController : Controller
    {
        private readonly ApplicationDbContext _context;

        public ReportesController(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var topProductos = await (
                from detalle in _context.FacturaDetalles
                join producto in _context.Productos on detalle.ProductoId equals producto.Id
                join factura in _context.Facturas on detalle.FacturaId equals factura.Id
                where !factura.Anulada
                group new { detalle, producto } by new
                {
                    producto.Id,
                    producto.Codigo,
                    producto.Nombre
                }
                into grupo
                orderby grupo.Sum(x => x.detalle.Cantidad) descending
                select new TopProductoVendidoViewModel
                {
                    ProductoId = grupo.Key.Id,
                    Codigo = grupo.Key.Codigo,
                    Nombre = grupo.Key.Nombre,
                    CantidadVendida = grupo.Sum(x => x.detalle.Cantidad),
                    TotalVendido = grupo.Sum(x => x.detalle.Subtotal)
                }
            )
            .Take(5)
            .ToListAsync();

            var clientesMayorFacturacion = await (
                from factura in _context.Facturas
                join cliente in _context.Clientes on factura.ClienteId equals cliente.Id
                where !factura.Anulada
                group factura by new
                {
                    cliente.Id,
                    cliente.Nombre,
                    cliente.IdentidadRTN
                }
                into grupo
                orderby grupo.Sum(x => x.Total) descending
                select new ClienteMayorFacturacionViewModel
                {
                    ClienteId = grupo.Key.Id,
                    Nombre = grupo.Key.Nombre,
                    IdentidadRTN = grupo.Key.IdentidadRTN,
                    CantidadFacturas = grupo.Count(),
                    TotalFacturado = grupo.Sum(x => x.Total)
                }
            )
            .Take(10)
            .ToListAsync();

            var inventarioBajo = await _context.Productos
                .Where(p => p.Estado && p.Stock < 5)
                .OrderBy(p => p.Stock)
                .ThenBy(p => p.Nombre)
                .Select(p => new InventarioBajoViewModel
                {
                    ProductoId = p.Id,
                    Codigo = p.Codigo,
                    Nombre = p.Nombre,
                    Stock = p.Stock,
                    Precio = p.Precio
                })
                .ToListAsync();

            var model = new ReportesViewModel
            {
                TopProductosVendidos = topProductos,
                ClientesMayorFacturacion = clientesMayorFacturacion,
                InventarioBajo = inventarioBajo
            };

            return View(model);
        }
    }
}