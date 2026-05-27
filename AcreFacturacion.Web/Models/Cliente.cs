using System.ComponentModel.DataAnnotations;

namespace AcreFacturacion.Web.Models
{
    public class Cliente
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "El nombre del cliente es obligatorio.")]
        [StringLength(150, ErrorMessage = "El nombre no puede exceder 150 caracteres.")]
        [RegularExpression(@"^[a-zA-ZáéíóúÁÉÍÓÚñÑ0-9\s\.\-&]+$",
            ErrorMessage = "El nombre solo puede contener letras, números, espacios y caracteres básicos como punto, guion o &.")]
        public string Nombre { get; set; } = string.Empty;

        [Required(ErrorMessage = "La identidad o RTN es obligatoria.")]
        [StringLength(30, ErrorMessage = "La identidad o RTN no puede exceder 30 caracteres.")]
        [RegularExpression(@"^[0-9\-]+$",
            ErrorMessage = "La identidad o RTN solo puede contener números y guiones.")]
        [Display(Name = "Identidad / RTN")]
        public string IdentidadRTN { get; set; } = string.Empty;

        [StringLength(20, ErrorMessage = "El teléfono no puede exceder 20 caracteres.")]
        [RegularExpression(@"^[0-9\+\-\s]+$",
            ErrorMessage = "El teléfono solo puede contener números, espacios, + o guiones.")]
        [Display(Name = "Teléfono")]
        public string? Telefono { get; set; }

        [EmailAddress(ErrorMessage = "Ingrese un correo válido.")]
        [StringLength(120, ErrorMessage = "El correo no puede exceder 120 caracteres.")]
        public string? Correo { get; set; }

        [Display(Name = "Fecha de registro")]
        public DateTime FechaRegistro { get; set; } = DateTime.Now;

        public bool Estado { get; set; } = true;

        public ICollection<Factura> Facturas { get; set; } = new List<Factura>();
    }
}