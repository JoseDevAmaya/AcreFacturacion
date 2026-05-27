using System.ComponentModel.DataAnnotations;

namespace AcreFacturacion.Web.ViewModels
{
    public class FacturaCreateViewModel
    {
        [Required(ErrorMessage = "Debe seleccionar un cliente.")]
        [Display(Name = "Cliente")]
        public int ClienteId { get; set; }

        public List<FacturaDetalleInputViewModel> Detalles { get; set; } = new();
    }

    public class FacturaDetalleInputViewModel
    {
        [Required(ErrorMessage = "Debe seleccionar un producto.")]
        [Display(Name = "Producto")]
        public int ProductoId { get; set; }

        [Required(ErrorMessage = "La cantidad es obligatoria.")]
        [Range(1, int.MaxValue, ErrorMessage = "La cantidad debe ser mayor que cero.")]
        public int Cantidad { get; set; } = 1;
    }
}