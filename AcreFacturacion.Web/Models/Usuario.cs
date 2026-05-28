using System.ComponentModel.DataAnnotations;

namespace AcreFacturacion.Web.Models
{
    public class Usuario
    {
        public int Id { get; set; }

        [Required]
        [MaxLength(100)]
        public string NombreUsuario { get; set; } = string.Empty;

        [Required]
        [MaxLength(256)]
        public string PasswordHash { get; set; } = string.Empty;

        [MaxLength(150)]
        public string? Nombre { get; set; }

        public bool Estado { get; set; } = true;

        public DateTime FechaCreacion { get; set; } = DateTime.UtcNow;
    }
}
