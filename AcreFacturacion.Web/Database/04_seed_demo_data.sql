USE acrefacturacion_db;

SET FOREIGN_KEY_CHECKS = 0;

DELETE FROM facturadetalles;
DELETE FROM facturas;
DELETE FROM clientes;
DELETE FROM productos;
DELETE FROM errorlogs;

ALTER TABLE facturadetalles AUTO_INCREMENT = 1;
ALTER TABLE facturas AUTO_INCREMENT = 1;
ALTER TABLE clientes AUTO_INCREMENT = 1;
ALTER TABLE productos AUTO_INCREMENT = 1;
ALTER TABLE errorlogs AUTO_INCREMENT = 1;

SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO clientes
(Id, Nombre, IdentidadRTN, Telefono, Correo, FechaRegistro, Estado)
VALUES
(1, 'Cliente General', '0801-1990-00001', '9999-0001', 'cliente.general@demo.com', NOW(), 1),
(2, 'Empresa Demo S.A.', '0801-1995-00002', '9999-0002', 'contacto@empresademo.com', NOW(), 1),
(3, 'Inversiones Centroamerica', '0801-2000-00003', '9999-0003', 'ventas@inversionesca.com', NOW(), 1),
(4, 'Comercial La Esperanza', '0801-2001-00004', '9999-0004', 'info@laesperanza.com', NOW(), 1),
(5, 'Servicios Profesionales Lopez', '0801-2002-00005', '9999-0005', 'contacto@servicioslopez.com', NOW(), 1);

INSERT INTO productos
(Id, Nombre, Codigo, Precio, Stock, Estado)
VALUES
(1, 'Teclado inalambrico', 'COD-001', 450.00, 18, 1),
(2, 'Mouse optico', 'COD-002', 250.00, 29, 1),
(3, 'Monitor 24 pulgadas', 'COD-003', 3500.00, 8, 1),
(4, 'Impresora termica', 'COD-004', 2800.00, 4, 1),
(5, 'Resma de papel carta', 'COD-005', 120.00, 45, 1),
(6, 'Toner laser negro', 'COD-006', 1250.00, 3, 1),
(7, 'Cable HDMI 2 metros', 'COD-007', 180.00, 25, 1);

INSERT INTO facturas
(Id, NumeroFactura, ClienteId, Fecha, Subtotal, Isv, Total, Anulada)
VALUES
(1, 'FAC-20260528-0001', 1, '2026-05-28 09:30:00', 1150.00, 172.50, 1322.50, 0),
(2, 'FAC-20260528-0002', 2, '2026-05-28 10:15:00', 6300.00, 945.00, 7245.00, 0),
(3, 'FAC-20260528-0003', 3, '2026-05-28 11:00:00', 5350.00, 802.50, 6152.50, 0);

INSERT INTO facturadetalles
(Id, FacturaId, ProductoId, Cantidad, PrecioUnitario, Subtotal)
VALUES
(1, 1, 1, 2, 450.00, 900.00),
(2, 1, 2, 1, 250.00, 250.00),
(3, 2, 3, 1, 3500.00, 3500.00),
(4, 2, 4, 1, 2800.00, 2800.00),
(5, 3, 3, 1, 3500.00, 3500.00),
(6, 3, 6, 1, 1250.00, 1250.00),
(7, 3, 5, 5, 120.00, 600.00);
