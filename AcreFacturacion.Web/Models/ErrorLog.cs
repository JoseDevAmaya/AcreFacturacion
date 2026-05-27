using System.ComponentModel.DataAnnotations;

namespace AcreFacturacion.Web.Models
{
    public class ErrorLog
    {
        public int Id { get; set; }

        public DateTime Fecha { get; set; } = DateTime.Now;

        [Required]
        [StringLength(50)]
        public string Nivel { get; set; } = "Error";

        [Required]
        [StringLength(500)]
        public string Mensaje { get; set; } = string.Empty;

        public string? Detalle { get; set; }

        [StringLength(150)]
        public string? Origen { get; set; }

        [StringLength(100)]
        public string? Usuario { get; set; }
    }
}