using AcreFacturacion.Web.Data;
using AcreFacturacion.Web.Models;

namespace AcreFacturacion.Web.Services
{
    public class LogService : ILogService
    {
        private readonly ApplicationDbContext _context;
        private readonly IWebHostEnvironment _environment;

        public LogService(ApplicationDbContext context, IWebHostEnvironment environment)
        {
            _context = context;
            _environment = environment;
        }

        public async Task RegistrarErrorAsync(string mensaje, string? detalle = null, string? origen = null, string? usuario = null)
        {
            await RegistrarAsync("Error", mensaje, detalle, origen, usuario);
        }

        public async Task RegistrarAdvertenciaAsync(string mensaje, string? detalle = null, string? origen = null, string? usuario = null)
        {
            await RegistrarAsync("Advertencia", mensaje, detalle, origen, usuario);
        }

        public async Task RegistrarInformacionAsync(string mensaje, string? detalle = null, string? origen = null, string? usuario = null)
        {
            await RegistrarAsync("Informacion", mensaje, detalle, origen, usuario);
        }

        private async Task RegistrarAsync(string nivel, string mensaje, string? detalle, string? origen, string? usuario)
        {
            try
            {
                var log = new ErrorLog
                {
                    Fecha = DateTime.Now,
                    Nivel = nivel,
                    Mensaje = mensaje,
                    Detalle = detalle,
                    Origen = origen,
                    Usuario = usuario
                };

                _context.ErrorLogs.Add(log);
                await _context.SaveChangesAsync();

                await EscribirArchivoAsync(log);
            }
            catch
            {
                // Evita que una falla del sistema de logs rompa la aplicación principal.
            }
        }

        private async Task EscribirArchivoAsync(ErrorLog log)
        {
            var logsPath = Path.Combine(_environment.ContentRootPath, "Logs");

            if (!Directory.Exists(logsPath))
            {
                Directory.CreateDirectory(logsPath);
            }

            var filePath = Path.Combine(logsPath, $"logs-{DateTime.Now:yyyy-MM-dd}.txt");

            var linea = $"[{log.Fecha:yyyy-MM-dd HH:mm:ss}] [{log.Nivel}] Origen: {log.Origen ?? "N/A"} | Usuario: {log.Usuario ?? "N/A"} | Mensaje: {log.Mensaje} | Detalle: {log.Detalle ?? "N/A"}";

            await File.AppendAllTextAsync(filePath, linea + Environment.NewLine);
        }
    }
}