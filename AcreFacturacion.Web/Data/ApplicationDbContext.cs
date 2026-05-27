using AcreFacturacion.Web.Models;
using Microsoft.EntityFrameworkCore;

namespace AcreFacturacion.Web.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        public DbSet<Cliente> Clientes { get; set; }
        public DbSet<Producto> Productos { get; set; }
        public DbSet<Factura> Facturas { get; set; }
        public DbSet<FacturaDetalle> FacturaDetalles { get; set; }
        public DbSet<ErrorLog> ErrorLogs { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Cliente>(entity =>
            {
                entity.ToTable("Clientes");

                entity.HasKey(e => e.Id);

                entity.Property(e => e.Nombre)
                    .IsRequired()
                    .HasMaxLength(150);

                entity.Property(e => e.IdentidadRTN)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.Telefono)
                    .HasMaxLength(20);

                entity.Property(e => e.Correo)
                    .HasMaxLength(120);

                entity.Property(e => e.FechaRegistro)
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.Estado)
                    .HasDefaultValue(true);

                entity.HasIndex(e => e.Nombre);
                entity.HasIndex(e => e.IdentidadRTN).IsUnique();
                entity.HasIndex(e => e.Correo);
            });

            modelBuilder.Entity<Producto>(entity =>
            {
                entity.ToTable("Productos");

                entity.HasKey(e => e.Id);

                entity.Property(e => e.Nombre)
                    .IsRequired()
                    .HasMaxLength(150);

                entity.Property(e => e.Codigo)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.Precio)
                    .HasPrecision(18, 2);

                entity.Property(e => e.Estado)
                    .HasDefaultValue(true);

                entity.HasIndex(e => e.Nombre);
                entity.HasIndex(e => e.Codigo).IsUnique();
                entity.HasIndex(e => e.Stock);
            });

            modelBuilder.Entity<Factura>(entity =>
            {
                entity.ToTable("Facturas");

                entity.HasKey(e => e.Id);

                entity.Property(e => e.NumeroFactura)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.Fecha)
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.Subtotal)
                    .HasPrecision(18, 2);

                entity.Property(e => e.Isv)
                    .HasPrecision(18, 2);

                entity.Property(e => e.Total)
                    .HasPrecision(18, 2);

                entity.Property(e => e.Anulada)
                    .HasDefaultValue(false);

                entity.HasIndex(e => e.NumeroFactura).IsUnique();
                entity.HasIndex(e => e.ClienteId);
                entity.HasIndex(e => e.Fecha);

                entity.HasOne(e => e.Cliente)
                    .WithMany(e => e.Facturas)
                    .HasForeignKey(e => e.ClienteId)
                    .OnDelete(DeleteBehavior.Restrict);
            });

            modelBuilder.Entity<FacturaDetalle>(entity =>
            {
                entity.ToTable("FacturaDetalles");

                entity.HasKey(e => e.Id);

                entity.Property(e => e.PrecioUnitario)
                    .HasPrecision(18, 2);

                entity.Property(e => e.Subtotal)
                    .HasPrecision(18, 2);

                entity.HasIndex(e => e.FacturaId);
                entity.HasIndex(e => e.ProductoId);

                entity.HasOne(e => e.Factura)
                    .WithMany(e => e.Detalles)
                    .HasForeignKey(e => e.FacturaId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasOne(e => e.Producto)
                    .WithMany(e => e.FacturaDetalles)
                    .HasForeignKey(e => e.ProductoId)
                    .OnDelete(DeleteBehavior.Restrict);
            });

            modelBuilder.Entity<ErrorLog>(entity =>
            {
                entity.ToTable("ErrorLogs");

                entity.HasKey(e => e.Id);

                entity.Property(e => e.Fecha)
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.Nivel)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.Mensaje)
                    .IsRequired()
                    .HasMaxLength(500);

                entity.Property(e => e.Origen)
                    .HasMaxLength(150);

                entity.Property(e => e.Usuario)
                    .HasMaxLength(100);

                entity.HasIndex(e => e.Fecha);
                entity.HasIndex(e => e.Nivel);
            });
        }
    }
}