namespace AcreFacturacion.Web.ViewModels
{
    public class ReportesViewModel
    {
        public List<TopProductoVendidoViewModel> TopProductosVendidos { get; set; } = new();
        public List<ClienteMayorFacturacionViewModel> ClientesMayorFacturacion { get; set; } = new();
        public List<InventarioBajoViewModel> InventarioBajo { get; set; } = new();
    }

    public class TopProductoVendidoViewModel
    {
        public int ProductoId { get; set; }
        public string Codigo { get; set; } = string.Empty;
        public string Nombre { get; set; } = string.Empty;
        public int CantidadVendida { get; set; }
        public decimal TotalVendido { get; set; }
    }

    public class ClienteMayorFacturacionViewModel
    {
        public int ClienteId { get; set; }
        public string Nombre { get; set; } = string.Empty;
        public string IdentidadRTN { get; set; } = string.Empty;
        public int CantidadFacturas { get; set; }
        public decimal TotalFacturado { get; set; }
    }

    public class InventarioBajoViewModel
    {
        public int ProductoId { get; set; }
        public string Codigo { get; set; } = string.Empty;
        public string Nombre { get; set; } = string.Empty;
        public int Stock { get; set; }
        public decimal Precio { get; set; }
    }
}