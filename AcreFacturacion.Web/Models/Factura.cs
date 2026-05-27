using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AcreFacturacion.Web.Models
{
    public class Factura
    {
        public int Id { get; set; }

        [Required]
        [StringLength(30)]
        [Display(Name = "Número de factura")]
        public string NumeroFactura { get; set; } = string.Empty;

        [Required]
        [Display(Name = "Cliente")]
        public int ClienteId { get; set; }

        public Cliente? Cliente { get; set; }

        public DateTime Fecha { get; set; } = DateTime.Now;

        [Column(TypeName = "decimal(18,2)")]
        public decimal Subtotal { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        [Display(Name = "ISV")]
        public decimal Isv { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal Total { get; set; }

        public bool Anulada { get; set; } = false;

        public ICollection<FacturaDetalle> Detalles { get; set; } = new List<FacturaDetalle>();
    }
}