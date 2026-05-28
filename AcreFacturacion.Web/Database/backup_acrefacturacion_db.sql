-- MySQL dump 10.13  Distrib 9.7.0, for Win64 (x86_64)
--
-- Host: localhost    Database: acrefacturacion_db
-- ------------------------------------------------------
-- Server version	9.7.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'e000cc2b-599d-11f1-9404-00ff31c5b652:1-80';

--
-- Current Database: `acrefacturacion_db`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `acrefacturacion_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `acrefacturacion_db`;

--
-- Table structure for table `__efmigrationshistory`
--

DROP TABLE IF EXISTS `__efmigrationshistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `__efmigrationshistory` (
  `MigrationId` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ProductVersion` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__efmigrationshistory`
--

LOCK TABLES `__efmigrationshistory` WRITE;
/*!40000 ALTER TABLE `__efmigrationshistory` DISABLE KEYS */;
INSERT INTO `__efmigrationshistory` VALUES ('20260527101501_InitialCreate','9.0.0');
/*!40000 ALTER TABLE `__efmigrationshistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `IdentidadRTN` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Telefono` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Correo` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `FechaRegistro` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `Estado` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IX_Clientes_IdentidadRTN` (`IdentidadRTN`),
  KEY `IX_Clientes_Correo` (`Correo`),
  KEY `IX_Clientes_Nombre` (`Nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Cliente prueba 1editar','120-0000-001992','95084206','clienteprueba1@gmail.com','2026-05-27 12:35:31.000000',1),(2,'José Oliveros lopez','1213-2001-00108','11111111111111111111','jose@aksdkls.com','2026-05-27 16:50:57.426368',1),(3,'PRUEBA 3','1212-102966-2103','276551589','PRUEBA@GAOAO','2026-05-27 17:16:24.885904',1),(4,'444','444','444','JOSE@AHSJSJGU','2026-05-27 17:16:47.548056',1),(5,'José Oliveros lopez','3','3','JOSEOLIVEROS@GMAIL.COM','2026-05-27 17:17:26.664778',1),(6,'José Oliveros lopez AMAYA','1213-2001-001084','95084206','OLIVERIS@aksdkls.com','2026-05-27 17:18:04.000000',1),(7,'E','83645757373','96833','E3@AJU2G7','2026-05-27 17:18:49.521436',1),(8,'José Oliveros lopez','1213-2001-0010842','222222','jose2@aksdkls.com','2026-05-27 17:32:22.326756',1),(9,'José Oliveros lopez','1213-2001-000192','95084203','Joseprueba2@gmail.com','2026-05-28 09:51:50.458465',0);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `errorlogs`
--

DROP TABLE IF EXISTS `errorlogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `errorlogs` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Fecha` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `Nivel` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Mensaje` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Detalle` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Origen` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Usuario` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_ErrorLogs_Fecha` (`Fecha`),
  KEY `IX_ErrorLogs_Nivel` (`Nivel`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `errorlogs`
--

LOCK TABLES `errorlogs` WRITE;
/*!40000 ALTER TABLE `errorlogs` DISABLE KEYS */;
INSERT INTO `errorlogs` VALUES (1,'2026-05-27 15:04:31.424910','Advertencia','Stock insuficiente para el producto Producto_prueba editar. Solicitado: 10, disponible: 9.',NULL,'FacturasController.Create',NULL),(2,'2026-05-28 09:53:40.878646','Advertencia','Stock insuficiente para el producto CXacao. Solicitado: 11, disponible: 10.',NULL,'FacturasController.Create',NULL);
/*!40000 ALTER TABLE `errorlogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facturadetalles`
--

DROP TABLE IF EXISTS `facturadetalles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facturadetalles` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `FacturaId` int NOT NULL,
  `ProductoId` int NOT NULL,
  `Cantidad` int NOT NULL,
  `PrecioUnitario` decimal(18,2) NOT NULL,
  `Subtotal` decimal(18,2) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_FacturaDetalles_FacturaId` (`FacturaId`),
  KEY `IX_FacturaDetalles_ProductoId` (`ProductoId`),
  CONSTRAINT `FK_FacturaDetalles_Facturas_FacturaId` FOREIGN KEY (`FacturaId`) REFERENCES `facturas` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_FacturaDetalles_Productos_ProductoId` FOREIGN KEY (`ProductoId`) REFERENCES `productos` (`Id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facturadetalles`
--

LOCK TABLES `facturadetalles` WRITE;
/*!40000 ALTER TABLE `facturadetalles` DISABLE KEYS */;
INSERT INTO `facturadetalles` VALUES (1,1,1,1,50.00,50.00),(2,2,3,10,10.00,100.00);
/*!40000 ALTER TABLE `facturadetalles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facturas`
--

DROP TABLE IF EXISTS `facturas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facturas` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `NumeroFactura` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ClienteId` int NOT NULL,
  `Fecha` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `Subtotal` decimal(18,2) NOT NULL,
  `Isv` decimal(18,2) NOT NULL,
  `Total` decimal(18,2) NOT NULL,
  `Anulada` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IX_Facturas_NumeroFactura` (`NumeroFactura`),
  KEY `IX_Facturas_ClienteId` (`ClienteId`),
  KEY `IX_Facturas_Fecha` (`Fecha`),
  CONSTRAINT `FK_Facturas_Clientes_ClienteId` FOREIGN KEY (`ClienteId`) REFERENCES `clientes` (`Id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facturas`
--

LOCK TABLES `facturas` WRITE;
/*!40000 ALTER TABLE `facturas` DISABLE KEYS */;
INSERT INTO `facturas` VALUES (1,'FAC-20260527-0001',1,'2026-05-27 13:30:45.313628',50.00,7.50,57.50,0),(2,'FAC-20260528-0002',6,'2026-05-28 09:53:48.061416',100.00,15.00,115.00,0);
/*!40000 ALTER TABLE `facturas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Codigo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Precio` decimal(18,2) NOT NULL,
  `Stock` int NOT NULL,
  `Estado` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IX_Productos_Codigo` (`Codigo`),
  KEY `IX_Productos_Nombre` (`Nombre`),
  KEY `IX_Productos_Stock` (`Stock`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Producto_prueba editar','01',50.00,9,0),(2,'Producto 2 pruebas ','9363525',232343.00,33333,1),(3,'CXacao','-23456766',10.00,0,1);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'acrefacturacion_db'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_clientes_mayor_facturacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`acrefacturacion_user`@`localhost` PROCEDURE `sp_clientes_mayor_facturacion`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_facturas_por_fecha` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`acrefacturacion_user`@`localhost` PROCEDURE `sp_facturas_por_fecha`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inventario_bajo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`acrefacturacion_user`@`localhost` PROCEDURE `sp_inventario_bajo`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_top_productos_vendidos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`acrefacturacion_user`@`localhost` PROCEDURE `sp_top_productos_vendidos`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-28 13:10:53
