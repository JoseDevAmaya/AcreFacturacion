using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AcreFacturacion.Web.Models
{
    public class FacturaDetalle
    {
        public int Id { get; set; }

        [Required]
        public int FacturaId { get; set; }

        public Factura? Factura { get; set; }

        [Required]
        [Display(Name = "Producto")]
        public int ProductoId { get; set; }

        public Producto? Producto { get; set; }

        [Required(ErrorMessage = "La cantidad es obligatoria.")]
        [Range(1, int.MaxValue, ErrorMessage = "La cantidad debe ser mayor que cero.")]
        public int Cantidad { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        [Display(Name = "Precio")]
        public decimal PrecioUnitario { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal Subtotal { get; set; }
    }
}