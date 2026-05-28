using AcreFacturacion.Web.Data;
using AcreFacturacion.Web.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using AcreFacturacion.Web.ViewModels;

namespace AcreFacturacion.Web.Controllers
{
    [Authorize]
    public class ClientesController : Controller
    {
        private readonly ApplicationDbContext _context;

        public ClientesController(ApplicationDbContext context)
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

            var clientesQuery = _context.Clientes
                .AsNoTracking()
                .AsQueryable();

            var terminoBusqueda = buscar?.Trim();

            if (!string.IsNullOrWhiteSpace(terminoBusqueda))
            {
                var filtros = terminoBusqueda
                    .Split(' ', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries);

                foreach (var filtroOriginal in filtros)
                {
                    var filtro = filtroOriginal.ToLower();

                    clientesQuery = clientesQuery.Where(c =>
                        c.Nombre.ToLower().Contains(filtro) ||
                        c.IdentidadRTN.ToLower().Contains(filtro) ||
                        (c.Correo != null && c.Correo.ToLower().Contains(filtro)) ||
                        (c.Telefono != null && c.Telefono.ToLower().Contains(filtro)));
                }
            }

            clientesQuery = clientesQuery.OrderByDescending(c => c.FechaRegistro);

            var clientes = await PaginatedList<Cliente>.CreateAsync(clientesQuery, page, pageSize);

            ViewBag.Buscar = terminoBusqueda;

            return View(clientes);
        }

        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var cliente = await _context.Clientes
                .FirstOrDefaultAsync(c => c.Id == id);

            if (cliente == null)
            {
                return NotFound();
            }

            return View(cliente);
        }

        public IActionResult Create()
        {
            return View(new Cliente());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(Cliente cliente)
        {
            if (await _context.Clientes.AnyAsync(c => c.IdentidadRTN == cliente.IdentidadRTN))
            {
                ModelState.AddModelError("IdentidadRTN", "Ya existe un cliente con esta identidad o RTN.");
            }

            if (!string.IsNullOrWhiteSpace(cliente.Correo) &&
                await _context.Clientes.AnyAsync(c => c.Correo == cliente.Correo))
            {
                ModelState.AddModelError("Correo", "Ya existe un cliente con este correo.");
            }

            if (!ModelState.IsValid)
            {
                return View(cliente);
            }

            cliente.FechaRegistro = DateTime.Now;
            cliente.Estado = true;

            _context.Clientes.Add(cliente);
            await _context.SaveChangesAsync();

            TempData["Success"] = "Cliente creado correctamente.";

            return RedirectToAction(nameof(Index));
        }

        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var cliente = await _context.Clientes.FindAsync(id);

            if (cliente == null)
            {
                return NotFound();
            }

            return View(cliente);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, Cliente cliente)
        {
            if (id != cliente.Id)
            {
                return NotFound();
            }

            if (await _context.Clientes.AnyAsync(c =>
                    c.IdentidadRTN == cliente.IdentidadRTN &&
                    c.Id != cliente.Id))
            {
                ModelState.AddModelError("IdentidadRTN", "Ya existe otro cliente con esta identidad o RTN.");
            }

            if (!string.IsNullOrWhiteSpace(cliente.Correo) &&
                await _context.Clientes.AnyAsync(c =>
                    c.Correo == cliente.Correo &&
                    c.Id != cliente.Id))
            {
                ModelState.AddModelError("Correo", "Ya existe otro cliente con este correo.");
            }

            if (!ModelState.IsValid)
            {
                return View(cliente);
            }

            try
            {
                _context.Update(cliente);
                await _context.SaveChangesAsync();

                TempData["Success"] = "Cliente actualizado correctamente.";
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!await ClienteExists(cliente.Id))
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
            var cliente = await _context.Clientes.FindAsync(id);

            if (cliente == null)
            {
                return NotFound();
            }

            cliente.Estado = false;
            await _context.SaveChangesAsync();

            TempData["Success"] = "Cliente desactivado correctamente.";

            return RedirectToAction(nameof(Index));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Activar(int id)
        {
            var cliente = await _context.Clientes.FindAsync(id);

            if (cliente == null)
            {
                return NotFound();
            }

            cliente.Estado = true;
            await _context.SaveChangesAsync();

            TempData["Success"] = "Cliente activado correctamente.";

            return RedirectToAction(nameof(Index));
        }
        private async Task<bool> ClienteExists(int id)
        {
            return await _context.Clientes.AnyAsync(c => c.Id == id);
        }
    }
}