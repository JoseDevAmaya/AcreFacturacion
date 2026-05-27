-- Reporte 1: Top 5 productos más vendidos
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


-- Reporte 2: Clientes con mayor facturación
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


-- Reporte 3: Inventario bajo
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