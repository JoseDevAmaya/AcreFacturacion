using AcreFacturacion.Web.Data;
using AcreFacturacion.Web.Services;
using AcreFacturacion.Web.ViewModels;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace AcreFacturacion.Web.Controllers
{
    [AllowAnonymous]
    public class AccountController : Controller
    {
        private readonly ApplicationDbContext _context;
        private readonly ILogService _logService;

        public AccountController(ApplicationDbContext context, ILogService logService)
        {
            _context = context;
            _logService = logService;
        }

        [HttpGet]
        public IActionResult Login(string? returnUrl = null)
        {
            if (User.Identity?.IsAuthenticated == true)
                return RedirectToAction("Index", "Home");

            return View(new LoginViewModel { ReturnUrl = returnUrl });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Login(LoginViewModel model)
        {
            if (!ModelState.IsValid)
                return View(model);

            var usuario = await _context.Usuarios
                .AsNoTracking()
                .FirstOrDefaultAsync(u => u.NombreUsuario == model.NombreUsuario && u.Estado);

            if (usuario == null || !BCrypt.Net.BCrypt.Verify(model.Password, usuario.PasswordHash))
            {
                await _logService.RegistrarAdvertenciaAsync(
                    $"Intento de login fallido para usuario '{model.NombreUsuario}'",
                    null,
                    "AccountController.Login",
                    model.NombreUsuario);

                ModelState.AddModelError(string.Empty, "Usuario o contraseña incorrectos.");
                return View(model);
            }

            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.Name, usuario.NombreUsuario),
                new Claim(ClaimTypes.GivenName, usuario.Nombre ?? usuario.NombreUsuario),
                new Claim(ClaimTypes.NameIdentifier, usuario.Id.ToString())
            };

            var identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
            var principal = new ClaimsPrincipal(identity);

            await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, principal);

            await _logService.RegistrarInformacionAsync(
                $"Login exitoso para usuario '{usuario.NombreUsuario}'",
                null,
                "AccountController.Login",
                usuario.NombreUsuario);

            if (!string.IsNullOrEmpty(model.ReturnUrl) && Url.IsLocalUrl(model.ReturnUrl))
                return Redirect(model.ReturnUrl);

            return RedirectToAction("Index", "Home");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Logout()
        {
            var userName = User.Identity?.Name;
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);

            if (!string.IsNullOrEmpty(userName))
                await _logService.RegistrarInformacionAsync(
                    $"Logout del usuario '{userName}'",
                    null,
                    "AccountController.Logout",
                    userName);

            return RedirectToAction("Login");
        }
    }
}