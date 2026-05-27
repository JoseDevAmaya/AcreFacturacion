CREATE TABLE IF NOT EXISTS `__EFMigrationsHistory` (
    `MigrationId` varchar(150) CHARACTER SET utf8mb4 NOT NULL,
    `ProductVersion` varchar(32) CHARACTER SET utf8mb4 NOT NULL,
    CONSTRAINT `PK___EFMigrationsHistory` PRIMARY KEY (`MigrationId`)
) CHARACTER SET=utf8mb4;

START TRANSACTION;
ALTER DATABASE CHARACTER SET utf8mb4;

CREATE TABLE `Clientes` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Nombre` varchar(150) CHARACTER SET utf8mb4 NOT NULL,
    `IdentidadRTN` varchar(30) CHARACTER SET utf8mb4 NOT NULL,
    `Telefono` varchar(20) CHARACTER SET utf8mb4 NULL,
    `Correo` varchar(120) CHARACTER SET utf8mb4 NULL,
    `FechaRegistro` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `Estado` tinyint(1) NOT NULL DEFAULT TRUE,
    CONSTRAINT `PK_Clientes` PRIMARY KEY (`Id`)
) CHARACTER SET=utf8mb4;

CREATE TABLE `ErrorLogs` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Fecha` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `Nivel` varchar(50) CHARACTER SET utf8mb4 NOT NULL,
    `Mensaje` varchar(500) CHARACTER SET utf8mb4 NOT NULL,
    `Detalle` longtext CHARACTER SET utf8mb4 NULL,
    `Origen` varchar(150) CHARACTER SET utf8mb4 NULL,
    `Usuario` varchar(100) CHARACTER SET utf8mb4 NULL,
    CONSTRAINT `PK_ErrorLogs` PRIMARY KEY (`Id`)
) CHARACTER SET=utf8mb4;

CREATE TABLE `Productos` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Nombre` varchar(150) CHARACTER SET utf8mb4 NOT NULL,
    `Codigo` varchar(50) CHARACTER SET utf8mb4 NOT NULL,
    `Precio` decimal(18,2) NOT NULL,
    `Stock` int NOT NULL,
    `Estado` tinyint(1) NOT NULL DEFAULT TRUE,
    CONSTRAINT `PK_Productos` PRIMARY KEY (`Id`)
) CHARACTER SET=utf8mb4;

CREATE TABLE `Facturas` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `NumeroFactura` varchar(30) CHARACTER SET utf8mb4 NOT NULL,
    `ClienteId` int NOT NULL,
    `Fecha` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `Subtotal` decimal(18,2) NOT NULL,
    `Isv` decimal(18,2) NOT NULL,
    `Total` decimal(18,2) NOT NULL,
    `Anulada` tinyint(1) NOT NULL DEFAULT FALSE,
    CONSTRAINT `PK_Facturas` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_Facturas_Clientes_ClienteId` FOREIGN KEY (`ClienteId`) REFERENCES `Clientes` (`Id`) ON DELETE RESTRICT
) CHARACTER SET=utf8mb4;

CREATE TABLE `FacturaDetalles` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `FacturaId` int NOT NULL,
    `ProductoId` int NOT NULL,
    `Cantidad` int NOT NULL,
    `PrecioUnitario` decimal(18,2) NOT NULL,
    `Subtotal` decimal(18,2) NOT NULL,
    CONSTRAINT `PK_FacturaDetalles` PRIMARY KEY (`Id`),
    CONSTRAINT `FK_FacturaDetalles_Facturas_FacturaId` FOREIGN KEY (`FacturaId`) REFERENCES `Facturas` (`Id`) ON DELETE CASCADE,
    CONSTRAINT `FK_FacturaDetalles_Productos_ProductoId` FOREIGN KEY (`ProductoId`) REFERENCES `Productos` (`Id`) ON DELETE RESTRICT
) CHARACTER SET=utf8mb4;

CREATE INDEX `IX_Clientes_Correo` ON `Clientes` (`Correo`);

CREATE UNIQUE INDEX `IX_Clientes_IdentidadRTN` ON `Clientes` (`IdentidadRTN`);

CREATE INDEX `IX_Clientes_Nombre` ON `Clientes` (`Nombre`);

CREATE INDEX `IX_ErrorLogs_Fecha` ON `ErrorLogs` (`Fecha`);

CREATE INDEX `IX_ErrorLogs_Nivel` ON `ErrorLogs` (`Nivel`);

CREATE INDEX `IX_FacturaDetalles_FacturaId` ON `FacturaDetalles` (`FacturaId`);

CREATE INDEX `IX_FacturaDetalles_ProductoId` ON `FacturaDetalles` (`ProductoId`);

CREATE INDEX `IX_Facturas_ClienteId` ON `Facturas` (`ClienteId`);

CREATE INDEX `IX_Facturas_Fecha` ON `Facturas` (`Fecha`);

CREATE UNIQUE INDEX `IX_Facturas_NumeroFactura` ON `Facturas` (`NumeroFactura`);

CREATE UNIQUE INDEX `IX_Productos_Codigo` ON `Productos` (`Codigo`);

CREATE INDEX `IX_Productos_Nombre` ON `Productos` (`Nombre`);

CREATE INDEX `IX_Productos_Stock` ON `Productos` (`Stock`);

INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20260527101501_InitialCreate', '9.0.0');

COMMIT;

