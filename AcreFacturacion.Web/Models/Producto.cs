using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AcreFacturacion.Web.Models
{
    public class Producto
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "El nombre del producto es obligatorio.")]
        [StringLength(150, ErrorMessage = "El nombre no puede exceder 150 caracteres.")]
        [RegularExpression(@"^[a-zA-ZáéíóúÁÉÍÓÚñÑ0-9\s\.\-_]+$",
            ErrorMessage = "El nombre del producto solo puede contener letras, números, espacios, punto, guion o guion bajo.")]
        public string Nombre { get; set; } = string.Empty;

        [Required(ErrorMessage = "El código del producto es obligatorio.")]
        [StringLength(50, ErrorMessage = "El código no puede exceder 50 caracteres.")]
        [RegularExpression(@"^[a-zA-Z0-9\-_\.]+$",
            ErrorMessage = "El código solo puede contener letras, números, punto, guion o guion bajo.")]
        public string Codigo { get; set; } = string.Empty;

        [Required(ErrorMessage = "El precio es obligatorio.")]
        [Range(0.01, 999999.99, ErrorMessage = "El precio debe ser mayor que cero.")]
        [Column(TypeName = "decimal(18,2)")]
        public decimal Precio { get; set; }

        [Required(ErrorMessage = "El stock es obligatorio.")]
        [Range(0, 999999, ErrorMessage = "El stock debe estar entre 0 y 999999.")]
        public int Stock { get; set; }

        public bool Estado { get; set; } = true;

        public ICollection<FacturaDetalle> FacturaDetalles { get; set; } = new List<FacturaDetalle>();
    }
}