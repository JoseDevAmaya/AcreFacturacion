using AcreFacturacion.Web.Data;
using AcreFacturacion.Web.Models;
using AcreFacturacion.Web.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace AcreFacturacion.Web.Controllers
{
    public class ProductosController : Controller
    {
        private readonly ApplicationDbContext _context;

        public ProductosController(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index(string? buscar, int page = 1)
        {
            const int pageSize = 5;

            if (page < 1)
            {
                page = 1;
            }

            var productosQuery = _context.Productos
                .AsNoTracking()
                .AsQueryable();

            if (!string.IsNullOrWhiteSpace(buscar))
            {
                productosQuery = productosQuery.Where(p =>
                    p.Nombre.Contains(buscar) ||
                    p.Codigo.Contains(buscar));
            }

            productosQuery = productosQuery.OrderBy(p => p.Nombre);

            var productos = await PaginatedList<Producto>.CreateAsync(productosQuery, page, pageSize);

            ViewBag.Buscar = buscar;

            return View(productos);
        }
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var producto = await _context.Productos
                .FirstOrDefaultAsync(p => p.Id == id);

            if (producto == null)
            {
                return NotFound();
            }

            return View(producto);
        }

        public IActionResult Create()
        {
            return View(new Producto());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(Producto producto)
        {
            if (await _context.Productos.AnyAsync(p => p.Codigo == producto.Codigo))
            {
                ModelState.AddModelError("Codigo", "Ya existe un producto con este código.");
            }

            if (!ModelState.IsValid)
            {
                return View(producto);
            }

            producto.Estado = true;

            _context.Productos.Add(producto);
            await _context.SaveChangesAsync();

            TempData["Success"] = "Producto creado correctamente.";

            return RedirectToAction(nameof(Index));
        }

        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var producto = await _context.Productos.FindAsync(id);

            if (producto == null)
            {
                return NotFound();
            }

            return View(producto);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, Producto producto)
        {
            if (id != producto.Id)
            {
                return NotFound();
            }

            if (await _context.Productos.AnyAsync(p =>
                    p.Codigo == producto.Codigo &&
                    p.Id != producto.Id))
            {
                ModelState.AddModelError("Codigo", "Ya existe otro producto con este código.");
            }

            if (!ModelState.IsValid)
            {
                return View(producto);
            }

            try
            {
                _context.Update(producto);
                await _context.SaveChangesAsync();

                TempData["Success"] = "Producto actualizado correctamente.";
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!await ProductoExists(producto.Id))
                {
                    return NotFound();
                }

                throw;
            }

            return RedirectToAction(nameof(Index));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Desactivar(int id)
        {
            var producto = await _context.Productos.FindAsync(id);

            if (producto == null)
            {
                return NotFound();
            }

            producto.Estado = false;
            await _context.SaveChangesAsync();

            TempData["Success"] = "Producto desactivado correctamente.";

            return RedirectToAction(nameof(Index));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Activar(int id)
        {
            var producto = await _context.Productos.FindAsync(id);

            if (producto == null)
            {
                return NotFound();
            }

            producto.Estado = true;
            await _context.SaveChangesAsync();

            TempData["Success"] = "Producto activado correctamente.";

            return RedirectToAction(nameof(Index));
        }
        private async Task<bool> ProductoExists(int id)
        {
            return await _context.Productos.AnyAsync(p => p.Id == id);
        }
    }
}