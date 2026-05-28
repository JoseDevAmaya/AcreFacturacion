USE acrefacturacion_db;

DROP PROCEDURE IF EXISTS sp_top_productos_vendidos;
DELIMITER //
CREATE PROCEDURE sp_top_productos_vendidos()
BEGIN
    SELECT 
        p.Id,
        p.Codigo,
        p.Nombre,
        SUM(fd.Cantidad) AS CantidadVendida,
        SUM(fd.Subtotal) AS TotalVendido
    FROM FacturaDetalles fd
    INNER JOIN Productos p ON fd.ProductoId = p.Id
    INNER JOIN Facturas f ON fd.FacturaId = f.Id
    WHERE f.Anulada = 0
    GROUP BY p.Id, p.Codigo, p.Nombre
    ORDER BY CantidadVendida DESC
    LIMIT 5;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_clientes_mayor_facturacion;
DELIMITER //
CREATE PROCEDURE sp_clientes_mayor_facturacion()
BEGIN
    SELECT 
        c.Id,
        c.Nombre,
        c.IdentidadRTN,
        COUNT(f.Id) AS CantidadFacturas,
        SUM(f.Total) AS TotalFacturado
    FROM Facturas f
    INNER JOIN Clientes c ON f.ClienteId = c.Id
    WHERE f.Anulada = 0
    GROUP BY c.Id, c.Nombre, c.IdentidadRTN
    ORDER BY TotalFacturado DESC;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_inventario_bajo;
DELIMITER //
CREATE PROCEDURE sp_inventario_bajo()
BEGIN
    SELECT 
        Id,
        Codigo,
        Nombre,
        Precio,
        Stock
    FROM Productos
    WHERE Estado = 1
      AND Stock < 5
    ORDER BY Stock ASC, Nombre ASC;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_facturas_por_fecha;
DELIMITER //
CREATE PROCEDURE sp_facturas_por_fecha(
    IN fecha_inicio DATETIME,
    IN fecha_fin DATETIME
)
BEGIN
    SELECT 
        f.Id,
        f.NumeroFactura,
        c.Nombre AS Cliente,
        f.Fecha,
        f.Subtotal,
        f.Isv,
        f.Total
    FROM Facturas f
    INNER JOIN Clientes c ON f.ClienteId = c.Id
    WHERE f.Anulada = 0
      AND f.Fecha BETWEEN fecha_inicio AND fecha_fin
    ORDER BY f.Fecha DESC;
END //
DELIMITER ;


-- Pruebas:
-- CALL sp_top_productos_vendidos();
-- CALL sp_clientes_mayor_facturacion();
-- CALL sp_inventario_bajo();
-- CALL sp_facturas_por_fecha('2026-01-01', '2026-12-31');