using AcreFacturacion.Web.Data;
using AcreFacturacion.Web.Models;
using AcreFacturacion.Web.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using AcreFacturacion.Web.Services;

namespace AcreFacturacion.Web.Controllers
{
    public class FacturasController : Controller
    {
        private const decimal ISV_RATE = 0.15m;

        private readonly ApplicationDbContext _context;
        private readonly ILogService _logService;

        public FacturasController(ApplicationDbContext context, ILogService logService)
        {
            _context = context;
            _logService = logService;
        }
        public async Task<IActionResult> Index(int page = 1)
        {
            const int pageSize = 5;

            if (page < 1)
            {
                page = 1;
            }

            var facturasQuery = _context.Facturas
                .AsNoTracking()
                .Include(f => f.Cliente)
                .OrderByDescending(f => f.Fecha)
                .AsQueryable();

            var facturas = await PaginatedList<Factura>.CreateAsync(facturasQuery, page, pageSize);

            return View(facturas);
        }
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var factura = await _context.Facturas
                .Include(f => f.Cliente)
                .Include(f => f.Detalles)
                    .ThenInclude(d => d.Producto)
                .FirstOrDefaultAsync(f => f.Id == id);

            if (factura == null)
            {
                return NotFound();
            }

            return View(factura);
        }

        public async Task<IActionResult> Create()
        {
            await CargarCombosAsync();

            var model = new FacturaCreateViewModel
            {
                Detalles = new List<FacturaDetalleInputViewModel>
                {
                    new FacturaDetalleInputViewModel()
                }
            };

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(FacturaCreateViewModel model)
        {
            model.Detalles = model.Detalles
                .Where(d => d.ProductoId > 0 && d.Cantidad > 0)
                .ToList();

            if (!model.Detalles.Any())
            {
                ModelState.AddModelError("", "Debe agregar al menos un producto a la factura.");
            }

            var clienteExiste = await _context.Clientes
                .AnyAsync(c => c.Id == model.ClienteId && c.Estado);

            if (!clienteExiste)
            {
                ModelState.AddModelError("ClienteId", "Debe seleccionar un cliente activo.");
            }

            if (!ModelState.IsValid)
            {
                await CargarCombosAsync(model.ClienteId);
                return View(model);
            }

            var cantidadesPorProducto = model.Detalles
                .GroupBy(d => d.ProductoId)
                .Select(g => new
                {
                    ProductoId = g.Key,
                    CantidadTotal = g.Sum(x => x.Cantidad)
                })
                .ToList();

            var productoIds = cantidadesPorProducto
                .Select(x => x.ProductoId)
                .ToList();

            var productos = await _context.Productos
                .Where(p => productoIds.Contains(p.Id) && p.Estado)
                .ToListAsync();

            foreach (var item in cantidadesPorProducto)
            {
                var producto = productos.FirstOrDefault(p => p.Id == item.ProductoId);

                if (producto == null)
                {
                    var mensaje = $"Intento fallido de facturación. ProductoId {item.ProductoId} inexistente o inactivo.";

                    ModelState.AddModelError("", "Uno de los productos seleccionados no existe o está inactivo.");

                    await _logService.RegistrarAdvertenciaAsync(
                        mensaje,
                        origen: "FacturasController.Create"
                    );

                    continue;
                }

                if (producto.Stock < item.CantidadTotal)
                {
                    var mensaje = $"Stock insuficiente para el producto {producto.Nombre}. Solicitado: {item.CantidadTotal}, disponible: {producto.Stock}.";

                    ModelState.AddModelError("", mensaje);

                    await _logService.RegistrarAdvertenciaAsync(
                        mensaje,
                        origen: "FacturasController.Create"
                    );
                }

            }

            if (!ModelState.IsValid)
            {
                await CargarCombosAsync(model.ClienteId);
                return View(model);
            }

            await using var transaction = await _context.Database.BeginTransactionAsync();

            try
            {
                var factura = new Factura
                {
                    NumeroFactura = await GenerarNumeroFacturaAsync(),
                    ClienteId = model.ClienteId,
                    Fecha = DateTime.Now,
                    Anulada = false
                };

                decimal subtotal = 0;

                foreach (var detalleInput in model.Detalles)
                {
                    var producto = productos.First(p => p.Id == detalleInput.ProductoId);

                    var detalleSubtotal = producto.Precio * detalleInput.Cantidad;

                    factura.Detalles.Add(new FacturaDetalle
                    {
                        ProductoId = producto.Id,
                        Cantidad = detalleInput.Cantidad,
                        PrecioUnitario = producto.Precio,
                        Subtotal = detalleSubtotal
                    });

                    producto.Stock -= detalleInput.Cantidad;
                    subtotal += detalleSubtotal;
                }

                factura.Subtotal = subtotal;
                factura.Isv = Math.Round(subtotal * ISV_RATE, 2);
                factura.Total = factura.Subtotal + factura.Isv;

                _context.Facturas.Add(factura);
                await _context.SaveChangesAsync();

                await transaction.CommitAsync();

                TempData["Success"] = "Factura creada correctamente.";

                return RedirectToAction(nameof(Details), new { id = factura.Id });
            }
            catch (Exception ex)
            {
                await transaction.RollbackAsync();

                await _logService.RegistrarErrorAsync(
                    "Error al crear factura.",
                    ex.ToString(),
                    "FacturasController.Create"
                );

                throw;
            }
        }

        private async Task CargarCombosAsync(int? clienteSeleccionado = null)
        {
            var clientes = await _context.Clientes
                .Where(c => c.Estado)
                .OrderBy(c => c.Nombre)
                .ToListAsync();

            var productos = await _context.Productos
                .Where(p => p.Estado && p.Stock > 0)
                .OrderBy(p => p.Nombre)
                .ToListAsync();

            ViewBag.Clientes = new SelectList(clientes, "Id", "Nombre", clienteSeleccionado);
            ViewBag.Productos = productos;
        }

        private async Task<string> GenerarNumeroFacturaAsync()
        {
            var ultimoId = await _context.Facturas
                .MaxAsync(f => (int?)f.Id) ?? 0;

            return $"FAC-{DateTime.Now:yyyyMMdd}-{ultimoId + 1:0000}";
        }
    }
}