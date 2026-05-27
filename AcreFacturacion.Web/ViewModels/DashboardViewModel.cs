namespace AcreFacturacion.Web.ViewModels
{
    public class DashboardViewModel
    {
        public int ClientesActivos { get; set; }
        public int ProductosActivos { get; set; }
        public int FacturasEmitidas { get; set; }
        public decimal TotalFacturado { get; set; }
        public int ProductosInventarioBajo { get; set; }

        public List<UltimaFacturaViewModel> UltimasFacturas { get; set; } = new();
    }

    public class UltimaFacturaViewModel
    {
        public int Id { get; set; }
        public string NumeroFactura { get; set; } = string.Empty;
        public string Cliente { get; set; } = string.Empty;
        public DateTime Fecha { get; set; }
        public decimal Total { get; set; }
    }
}