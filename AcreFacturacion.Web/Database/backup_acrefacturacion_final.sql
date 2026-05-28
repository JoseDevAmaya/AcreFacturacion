
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
SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'e000cc2b-599d-11f1-9404-00ff31c5b652:1-146';

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `acrefacturacion_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `acrefacturacion_db`;
DROP TABLE IF EXISTS `__efmigrationshistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `__efmigrationshistory` (
  `MigrationId` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ProductVersion` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `__efmigrationshistory` DISABLE KEYS */;
INSERT INTO `__efmigrationshistory` VALUES ('20260527101501_InitialCreate','9.0.0'),('20260528104010_AddUsuarios','9.0.0');
/*!40000 ALTER TABLE `__efmigrationshistory` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Cliente prueba 1editar','120-0000-001992','95084206','clienteprueba1@gmail.com','2026-05-27 12:35:31.000000',1),(2,'José Oliveros lopez','1213-2001-00108','11111111111111111111','jose@aksdkls.com','2026-05-27 16:50:57.426368',1),(3,'PRUEBA 3','1212-102966-2103','276551589','PRUEBA@GAOAO','2026-05-27 17:16:24.885904',1),(4,'MANUEL BEZERRA','09283764378290','23432','JOSE@AHSJSJGU','2026-05-27 17:16:47.000000',1),(5,'José Oliveros lopez','3','3','JOSEOLIVEROS@GMAIL.COM','2026-05-27 17:17:26.664778',1),(6,'Buscar','1213-2001-001084','95084206','OLIVERIS@aksdkls.com','2026-05-27 17:18:04.000000',1),(7,'E','83645757373','96833','E3@AJU2G7','2026-05-27 17:18:49.521436',1),(8,'José Oliveros lopez','1213-2001-0010842','92826836','jose2@aksdkls.com','2026-05-27 17:32:22.000000',0),(9,'José Oliveros lopez','1213-2001-000192','95084203','Joseprueba2@gmail.com','2026-05-28 09:51:50.458465',1),(10,'PRUEBA VALIDACION','1216-23322-2322','976533','CORREO@SSSSS.COM','2026-05-28 16:19:02.789676',1),(11,'Orlando J','120-0000-0012211','484739279','clienteprueba123@gmail.com','2026-05-28 20:40:50.000000',1);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `errorlogs` DISABLE KEYS */;
INSERT INTO `errorlogs` VALUES (1,'2026-05-27 15:04:31.424910','Advertencia','Stock insuficiente para el producto Producto_prueba editar. Solicitado: 10, disponible: 9.',NULL,'FacturasController.Create',NULL),(2,'2026-05-28 09:53:40.878646','Advertencia','Stock insuficiente para el producto CXacao. Solicitado: 11, disponible: 10.',NULL,'FacturasController.Create',NULL),(3,'2026-05-28 15:19:52.576373','Informacion','Login exitoso para usuario \'admin\'',NULL,'AccountController.Login','admin'),(4,'2026-05-28 15:27:05.539957','Informacion','Logout del usuario \'admin\'',NULL,'AccountController.Logout','admin'),(5,'2026-05-28 15:32:16.824288','Advertencia','Intento de login fallido para usuario \'f\'',NULL,'AccountController.Login','f'),(6,'2026-05-28 15:34:40.221861','Informacion','Login exitoso para usuario \'admin\'',NULL,'AccountController.Login','admin'),(7,'2026-05-28 15:39:46.816305','Informacion','Logout del usuario \'admin\'',NULL,'AccountController.Logout','admin'),(8,'2026-05-28 15:40:17.394712','Informacion','Login exitoso para usuario \'admin\'',NULL,'AccountController.Login','admin'),(9,'2026-05-28 15:43:48.416644','Informacion','Logout del usuario \'admin\'',NULL,'AccountController.Logout','admin'),(10,'2026-05-28 15:45:37.552513','Informacion','Login exitoso para usuario \'admin\'',NULL,'AccountController.Login','admin'),(11,'2026-05-28 15:46:08.343795','Informacion','Logout del usuario \'admin\'',NULL,'AccountController.Logout','admin'),(12,'2026-05-28 15:46:34.189953','Informacion','Login exitoso para usuario \'admin\'',NULL,'AccountController.Login','admin'),(13,'2026-05-28 15:46:42.346670','Informacion','Logout del usuario \'admin\'',NULL,'AccountController.Logout','admin'),(14,'2026-05-28 15:49:45.830440','Advertencia','Intento de login fallido para usuario \'anuel\'',NULL,'AccountController.Login','anuel'),(15,'2026-05-28 15:50:25.153897','Informacion','Login exitoso para usuario \'admin\'',NULL,'AccountController.Login','admin'),(16,'2026-05-28 15:51:54.079668','Informacion','Logout del usuario \'admin\'',NULL,'AccountController.Logout','admin'),(17,'2026-05-28 16:03:45.569549','Informacion','Login exitoso para usuario \'admin\'',NULL,'AccountController.Login','admin'),(18,'2026-05-28 16:31:03.453171','Advertencia','Stock insuficiente para el producto Producto_prueba editar. Solicitado: 12, disponible: 8.',NULL,'FacturasController.Create',NULL),(19,'2026-05-28 16:42:38.667107','Informacion','Logout del usuario \'admin\'',NULL,'AccountController.Logout','admin'),(20,'2026-05-28 16:42:55.638189','Informacion','Login exitoso para usuario \'admin\'',NULL,'AccountController.Login','admin'),(21,'2026-05-28 16:46:52.916930','Advertencia','Stock insuficiente para el producto manguitos. Solicitado: 65, disponible: 3.',NULL,'FacturasController.Create',NULL),(22,'2026-05-28 20:05:52.474218','Informacion','Login exitoso para usuario \'admin\'',NULL,'AccountController.Login','admin'),(23,'2026-05-28 20:21:32.502463','Informacion','Logout del usuario \'admin\'',NULL,'AccountController.Logout','admin'),(24,'2026-05-28 20:24:02.489461','Informacion','Login exitoso para usuario \'admin\'',NULL,'AccountController.Login','admin'),(25,'2026-05-28 20:35:28.996647','Informacion','Logout del usuario \'admin\'',NULL,'AccountController.Logout','admin'),(26,'2026-05-28 20:36:46.683654','Informacion','Login exitoso para usuario \'admin\'',NULL,'AccountController.Login','admin'),(27,'2026-05-28 20:46:40.591720','Advertencia','Stock insuficiente para el producto orlando J. Solicitado: 22, disponible: 20.',NULL,'FacturasController.Create',NULL),(28,'2026-05-28 20:49:30.492622','Informacion','Logout del usuario \'admin\'',NULL,'AccountController.Logout','admin');
/*!40000 ALTER TABLE `errorlogs` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `facturadetalles` DISABLE KEYS */;
INSERT INTO `facturadetalles` VALUES (1,1,1,1,50.00,50.00),(2,2,3,10,10.00,100.00),(3,3,1,1,50.00,50.00),(4,4,7,245,33333.00,8166585.00),(5,5,1,8,50.00,400.00),(6,6,7,1,33333.00,33333.00),(7,7,7,3,33333.00,99999.00),(8,8,8,20,232.00,4640.00),(9,8,2,33333,232343.00,7744689219.00);
/*!40000 ALTER TABLE `facturadetalles` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `facturas` DISABLE KEYS */;
INSERT INTO `facturas` VALUES (1,'FAC-20260527-0001',1,'2026-05-27 13:30:45.313628',50.00,7.50,57.50,0),(2,'FAC-20260528-0002',6,'2026-05-28 09:53:48.061416',100.00,15.00,115.00,0),(3,'FAC-20260528-0003',4,'2026-05-28 16:29:07.165858',50.00,7.50,57.50,0),(4,'FAC-20260528-0004',2,'2026-05-28 16:29:44.209263',8166585.00,1224987.75,9391572.75,0),(5,'FAC-20260528-0005',7,'2026-05-28 16:31:31.905877',400.00,60.00,460.00,0),(6,'FAC-20260528-0006',1,'2026-05-28 16:43:48.230456',33333.00,4999.95,38332.95,0),(7,'FAC-20260528-0007',2,'2026-05-28 16:47:00.426087',99999.00,14999.85,114998.85,0),(8,'FAC-20260528-0008',11,'2026-05-28 20:47:48.745874',7744693859.00,1161704078.85,8906397937.85,0);
/*!40000 ALTER TABLE `facturas` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Producto_prueba editar','01',50.00,0,1),(2,'Producto 2 pruebas ','9363525',232343.00,0,1),(3,'CXacao','-23456766',10.00,0,1),(4,'prueba 23','908',19.98,23,1),(5,'prueba 23','02937464',2.00,22,1),(6,'prueba de validacion','22',2.99,0,0),(7,'manguitos','234',33333.00,0,1),(8,'orlando J','2222',232.00,0,1);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `NombreUsuario` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `PasswordHash` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Nombre` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Estado` tinyint(1) NOT NULL DEFAULT '1',
  `FechaCreacion` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IX_Usuarios_NombreUsuario` (`NombreUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'admin','$2a$11$FKMRo73zVrTy2KF82Ws5nuXiNCWu3RvKvu1NzSX/d1A3MNFBvtmfS','Administrador',1,'2026-05-28 13:18:02.080116');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

