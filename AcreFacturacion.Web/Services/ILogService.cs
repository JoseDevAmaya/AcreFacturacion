namespace AcreFacturacion.Web.Services
{
    public interface ILogService
    {
        Task RegistrarErrorAsync(string mensaje, string? detalle = null, string? origen = null, string? usuario = null);
        Task RegistrarAdvertenciaAsync(string mensaje, string? detalle = null, string? origen = null, string? usuario = null);
        Task RegistrarInformacionAsync(string mensaje, string? detalle = null, string? origen = null, string? usuario = null);
    }
}