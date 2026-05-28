-- =============================================================
-- AcreFacturacion - Stored Procedures
-- Archivo: 03_stored_procedures.sql
-- Base de datos: acrefacturacion_db
-- Ejecutar con: mysql -u acrefacturacion_user -p acrefacturacion_db < 03_stored_procedures.sql
-- =============================================================

USE acrefacturacion_db;

-- =============================================================
-- SP 1: Top 5 productos más vendidos (por cantidad total)
-- Replica la lógica del ReportesController.Index()
-- =============================================================
DROP PROCEDURE IF EXISTS sp_top_productos_vendidos;

DELIMITER //
CREATE PROCEDURE sp_top_productos_vendidos()
BEGIN
    SELECT
        p.Id          AS ProductoId,
        p.Codigo      AS Codigo,
        p.Nombre      AS Nombre,
        SUM(fd.Cantidad)  AS CantidadVendida,
        SUM(fd.Subtotal)  AS TotalVendido
    FROM FacturaDetalles fd
        INNER JOIN Productos p ON fd.ProductoId = p.Id
        INNER JOIN Facturas  f ON fd.FacturaId  = f.Id
    WHERE f.Anulada = 0
    GROUP BY p.Id, p.Codigo, p.Nombre
    ORDER BY CantidadVendida DESC
    LIMIT 5;
END //
DELIMITER ;


-- =============================================================
-- SP 2: Top 10 clientes con mayor facturación
-- Replica la lógica del ReportesController.Index()
-- =============================================================
DROP PROCEDURE IF EXISTS sp_clientes_mayor_facturacion;

DELIMITER //
CREATE PROCEDURE sp_clientes_mayor_facturacion()
BEGIN
    SELECT
        c.Id              AS ClienteId,
        c.Nombre          AS Nombre,
        c.IdentidadRTN    AS IdentidadRTN,
        COUNT(f.Id)       AS CantidadFacturas,
        SUM(f.Total)      AS TotalFacturado
    FROM Facturas f
        INNER JOIN Clientes c ON f.ClienteId = c.Id
    WHERE f.Anulada = 0
    GROUP BY c.Id, c.Nombre, c.IdentidadRTN
    ORDER BY TotalFacturado DESC
    LIMIT 10;
END //
DELIMITER ;


-- =============================================================
-- SP 3: Productos activos con inventario bajo (stock < 5)
-- Replica la lógica del ReportesController.Index()
-- =============================================================
DROP PROCEDURE IF EXISTS sp_inventario_bajo;

DELIMITER //
CREATE PROCEDURE sp_inventario_bajo()
BEGIN
    SELECT
        Id      AS ProductoId,
        Codigo  AS Codigo,
        Nombre  AS Nombre,
        Stock   AS Stock,
        Precio  AS Precio
    FROM Productos
    WHERE Estado = 1
      AND Stock < 5
    ORDER BY Stock ASC, Nombre ASC;
END //
DELIMITER ;


-- =============================================================
-- SP 4: Facturas por rango de fechas
-- Parámetros:
--   p_fecha_inicio  DATE  Fecha inicial (ej: '2026-01-01')
--   p_fecha_fin     DATE  Fecha final   (ej: '2026-12-31')
-- =============================================================
DROP PROCEDURE IF EXISTS sp_facturas_por_fecha;

DELIMITER //
CREATE PROCEDURE sp_facturas_por_fecha(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin    DATE
)
BEGIN
    IF p_fecha_inicio IS NULL THEN
        SET p_fecha_inicio = CURDATE() - INTERVAL 30 DAY;
    END IF;
    IF p_fecha_fin IS NULL THEN
        SET p_fecha_fin = CURDATE();
    END IF;

    SELECT
        f.Id                AS Id,
        f.NumeroFactura     AS NumeroFactura,
        c.Nombre            AS Cliente,
        c.IdentidadRTN      AS RTN,
        DATE(f.Fecha)       AS Fecha,
        f.Subtotal          AS Subtotal,
        f.Isv               AS Isv,
        f.Total             AS Total,
        f.Anulada           AS Anulada
    FROM Facturas f
        INNER JOIN Clientes c ON f.ClienteId = c.Id
    WHERE DATE(f.Fecha) BETWEEN p_fecha_inicio AND p_fecha_fin
    ORDER BY f.Fecha DESC;
END //
DELIMITER ;


-- =============================================================
-- COMANDOS CALL DE PRUEBA
-- Copiar y ejecutar uno por uno desde MySQL Workbench o CLI
-- =============================================================

-- Prueba SP 1: top 5 productos más vendidos
CALL sp_top_productos_vendidos();

-- Prueba SP 2: top 10 clientes con mayor facturación
CALL sp_clientes_mayor_facturacion();

-- Prueba SP 3: inventario bajo (stock < 5)
CALL sp_inventario_bajo();

-- Prueba SP 4: facturas del mes actual
CALL sp_facturas_por_fecha(
    DATE_FORMAT(NOW(), '%Y-%m-01'),   -- primer día del mes
    LAST_DAY(NOW())                    -- último día del mes
);

-- Prueba SP 4: facturas de los últimos 90 días
CALL sp_facturas_por_fecha(
    CURDATE() - INTERVAL 90 DAY,
    CURDATE()
);

-- Prueba SP 4: todas las facturas del año 2026
CALL sp_facturas_por_fecha('2026-01-01', '2026-12-31');

-- Verificar que los SPs quedaron creados
SELECT
    ROUTINE_NAME      AS Procedimiento,
    ROUTINE_TYPE      AS Tipo,
    CREATED           AS FechaCreacion,
    LAST_ALTERED      AS UltimaModificacion
FROM information_schema.ROUTINES
WHERE ROUTINE_SCHEMA = 'acrefacturacion_db'
  AND ROUTINE_TYPE   = 'PROCEDURE'
ORDER BY ROUTINE_NAME;
