-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: prue
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ciudadano`
--

DROP TABLE IF EXISTS `ciudadano`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ciudadano` (
  `id_ciudadano` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `apellido` varchar(100) DEFAULT NULL,
  `dni` varchar(20) NOT NULL,
  `domicilio` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `contraseña` varchar(255) DEFAULT NULL,
  `correo_electronico` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_ciudadano`),
  UNIQUE KEY `dni` (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ciudadano`
--

LOCK TABLES `ciudadano` WRITE;
/*!40000 ALTER TABLE `ciudadano` DISABLE KEYS */;
/*!40000 ALTER TABLE `ciudadano` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comercio`
--

DROP TABLE IF EXISTS `comercio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comercio` (
  `id_comercio` int NOT NULL AUTO_INCREMENT,
  `nombre_comercial` varchar(50) DEFAULT NULL,
  `sucursal` int DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo_electronico` varchar(30) DEFAULT NULL,
  `rubro` varchar(255) DEFAULT NULL,
  `id_razon_social` int DEFAULT NULL,
  `id_titular_ambulante` int DEFAULT NULL,
  `categoria` enum('comercio en general','vendedor ambulante','food truck','bares nocturnos, confiterias y restaurantes') DEFAULT NULL,
  `metros_cuadrados` decimal(10,2) DEFAULT NULL,
  `id_empleado_registro` int NOT NULL,
  `ruta_qr` varchar(255) DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `geolocalizacion` varchar(255) DEFAULT NULL,
  `monto_sellado_inspeccion` decimal(10,2) DEFAULT NULL,
  `estado_pago_final` tinyint(1) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `fecha_habilitacion` date DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `pendiente_inspeccion` tinyint DEFAULT '1',
  `numero_renovacion` int DEFAULT NULL,
  PRIMARY KEY (`id_comercio`),
  UNIQUE KEY `nombre_comercial` (`nombre_comercial`,`direccion`),
  KEY `id_razon_social` (`id_razon_social`),
  KEY `id_empleado_registro` (`id_empleado_registro`),
  KEY `idx_comercio_id_titular_ambulante` (`id_titular_ambulante`),
  CONSTRAINT `comercio_ibfk_1` FOREIGN KEY (`id_razon_social`) REFERENCES `razon_social` (`id_razon_social`),
  CONSTRAINT `comercio_ibfk_2` FOREIGN KEY (`id_empleado_registro`) REFERENCES `empleado` (`id_empleado`),
  CONSTRAINT `fk_comercio_titular_ambulante` FOREIGN KEY (`id_titular_ambulante`) REFERENCES `titular_ambulante` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comercio`
--

LOCK TABLES `comercio` WRITE;
/*!40000 ALTER TABLE `comercio` DISABLE KEYS */;
INSERT INTO `comercio` VALUES (7,'Verduleria Santiago',NULL,'San Luis 2321','4257892','santiago@gmail.com','Verduleria',7,NULL,'comercio en general',23.00,21,NULL,'2025-06-18 14:54:01',NULL,NULL,NULL,1,NULL,NULL,1),(8,'Lo de Nuncio',NULL,'Libertad 332','4335566','lodenuncio@gmail.com','Panaderia',8,NULL,'comercio en general',43.00,21,NULL,'2025-06-18 15:11:31',NULL,NULL,NULL,1,NULL,NULL,1),(9,'Caseros',NULL,'Caseros 23','4356655','caseros@gmail.com','Bar',10,NULL,'comercio en general',21.00,21,NULL,'2025-06-18 15:14:16',NULL,NULL,NULL,1,'2025-10-28','2026-10-28',0),(10,'SWD',NULL,'Rivadavia 567','4335533','swd@gmail.com','Carniceria',12,NULL,'comercio en general',32.00,21,NULL,'2025-06-18 15:19:37',NULL,NULL,NULL,1,NULL,'2026-10-28',0),(11,'Croissant Pasteleria',NULL,'Libertad 23','3854333499','croissant@gmail.com','Panaderia',13,NULL,'comercio en general',22.00,22,NULL,'2025-06-18 15:31:22',NULL,NULL,NULL,1,'2025-10-28','2026-10-28',0),(13,'Carniceria Santiago',NULL,'Calle Europa 22','4254490','santy@gmail.co','Carniceria',32,NULL,'comercio en general',22.00,21,NULL,'2025-06-19 07:09:02',NULL,NULL,NULL,0,'2025-10-28','2026-10-28',0),(14,'Prueba',NULL,'asdfasdf','23452345','asdf@asdf.asd','Confiteria',33,NULL,'comercio en general',3.00,21,NULL,'2025-06-19 12:02:33',NULL,NULL,NULL,1,NULL,NULL,1),(16,'Carnicería Santiago E',NULL,'Calle Europa 223e','4254400','carnesantiagoe@gmail.com','Carnicería',7,NULL,'comercio en general',45.00,21,NULL,'2025-07-09 17:49:19',NULL,NULL,NULL,0,'2025-07-09','2026-07-09',1),(82,'La Bailanta',1,'Rocca 505','385 6909090','nuncito1@hotmail.com','Confitería',8,NULL,'bares nocturnos, confiterias y restaurantes',56.00,21,NULL,'2025-09-13 19:04:47','https://maps.app.goo.gl/h6faCX72jmWKr3cS9',120200.00,1,0,NULL,NULL,1),(124,'La Carlotta',1,'Mza 42 Lote 9 B Siglo XIX','385-6895199','nuncito1@hotmail.com','Heladería',8,NULL,'comercio en general',45.00,21,'/uploads/qr/124.png','2025-09-27 18:12:26','https://maps.app.goo.gl/oh57ajed5qPz9XhX6',78200.00,1,0,NULL,NULL,1),(125,'Cevilla Hot',1,'roca sur 30','385-6988776','gerago@gmail.com','Empanadas',39,NULL,'food truck',NULL,21,'/uploads/qr/125.png','2025-09-30 23:20:51','https://maps.app.goo.gl/zxVxnGHCQpiRTMua6',50000.00,1,1,'2025-09-30','2026-09-30',1),(126,'sin nombre',1,'Mza 42 Lote 9 B Siglo XIX','385-6222888','costilla@gmail.com','Venta de golosinas',NULL,5,'vendedor ambulante',NULL,21,'/uploads/qr/126.png','2025-10-10 17:27:38','https://maps.app.goo.gl/maxFntsow2kf8jix5',15000.00,1,1,'2025-10-10','2025-11-10',1),(127,'Los Llanos',1,'Mza 42 Lote 9 B Siglo XIX','385-6999888','costilla@gmail.com','Panadería',34,NULL,'comercio en general',46.00,21,'/uploads/qr/127.png','2025-10-11 15:00:50','https://maps.app.goo.gl/maxFntsow2kf8jix5',78200.00,1,1,'2025-10-11','2026-10-11',1),(128,'La prehistoria',1,'Loreto Simian 1389','385-6999888','costilla@gmail.com','Pescadería',44,NULL,'comercio en general',67.00,21,'/uploads/qr/128.png','2025-10-11 15:16:53','https://maps.app.goo.gl/maxFntsow2kf8jix5',120200.00,1,1,'2025-10-11','2026-10-11',1),(129,'Los Matones',1,'Gumercindo Gubaira','385-6999888','costilla@gmail.com','Kiosco',44,NULL,'comercio en general',15.00,21,'/uploads/qr/129.png','2025-10-11 15:31:43','https://maps.app.goo.gl/maxFntsow2kf8jix5',26000.00,1,1,'2025-10-11','2026-10-11',1),(130,'comechingones',1,'Plano 456','385-6999888','costilla@gmail.com','Vinoteca',34,NULL,'comercio en general',45.00,21,'/uploads/qr/130.png','2025-10-12 12:23:26','https://maps.app.goo.gl/maxFntsow2kf8jix5',78200.00,1,1,'2025-10-12','2026-10-12',1),(131,'Golondrina',1,'Mza 42 Lote 9 B Siglo XIII','385-6999888','costilla@gmail.com','Despensa',34,NULL,'comercio en general',56.00,21,'/uploads/qr/131.png','2025-10-13 17:01:26','https://maps.app.goo.gl/maxFntsow2kf8jix5',120200.00,1,0,'2025-10-13','2026-10-13',1),(132,'Teseando',1,'Mza 42 Lote 9 B Siglo XIX','385-6999888','costilla@gmail.com','Casa de Té',44,NULL,'bares nocturnos, confiterias y restaurantes',30.00,21,'/uploads/qr/comercio_132.png','2025-10-13 17:12:11','https://maps.app.goo.gl/maxFntsow2kf8jix5',78200.00,1,1,'2025-10-13','2026-10-13',1),(135,'Los Llanos',2,'Alpiste Perdite','385-6999888','costilla@gmail.com','Vinoteca',34,NULL,'comercio en general',34.00,21,'/uploads/qr/comercio_135.png','2025-10-14 06:31:20','https://maps.app.goo.gl/maxFntsow2kf8jix5',78200.00,1,1,'2025-10-14','2026-10-14',1),(136,'Los Terodactilos',1,'unzaga 1000','385-6999888','costilla@gmail.com','Heladería',44,NULL,'comercio en general',32.00,21,'/uploads/qr/comercio_136.png','2025-10-14 10:07:29','https://maps.app.goo.gl/maxFntsow2kf8jix5',78200.00,1,1,'2025-10-14','2026-10-14',1),(139,'Los Llanos',1,'Alpiste y Lino 200','385-6999888','costilla@gmail.com','Vinoteca',34,NULL,'comercio en general',34.00,21,NULL,'2025-10-14 11:52:31','https://maps.app.goo.gl/maxFntsow2kf8jix5',78200.00,1,1,'2025-10-14','2026-10-14',1),(144,'Los Llanos',4,'Mar del Plata 823','385-6999888','mocos@gmail.com','Vinoteca',34,NULL,'comercio en general',34.00,21,'/uploads/qr/comercio_144.png','2025-10-14 17:08:51','https://maps.app.goo.gl/maxFntsow2kf8jix5',78200.00,1,1,'2025-10-14','2026-10-14',1),(145,'Cocodrilos',1,'Lavalle 560','385-6999888','costilla@gmail.com','Pollería',44,NULL,'comercio en general',34.00,21,NULL,'2025-10-14 17:11:14','https://maps.app.goo.gl/maxFntsow2kf8jix5',78200.00,1,1,'2025-10-28','2026-10-28',0),(146,'Los Llanos',5,'mono sur 60','385-6999888','mocos@gmail.com','Vinoteca',34,NULL,'comercio en general',34.00,21,'/uploads/qr/comercio_146.png','2025-10-15 00:13:13','https://maps.app.goo.gl/maxFntsow2kf8jix5',78200.00,1,1,'2025-10-15','2026-10-15',1),(147,'Que Lomo',1,'Santa Rita 452','385-6999888','correo@gmail.com','Supermercado',44,NULL,'comercio en general',45.00,21,'/uploads/qr/comercio_147.png','2025-10-15 00:55:00','https://maps.app.goo.gl/maxFntsow2kf8jix5',78200.00,1,1,'2025-10-15','2026-10-15',1),(148,'Las Arandelas',1,'Aguas Turbias 490','385-6999888','costilla@gmail.com','Kiosco',41,NULL,'comercio en general',80.00,21,'/uploads/qr/comercio_148.png','2025-10-15 06:55:39','https://maps.app.goo.gl/maxFntsow2kf8jix5',120200.00,1,1,'2025-10-15','2026-10-15',1),(149,'PROB',1,'salta 105','385-5555555','sadfas@f.g','Autoservicio',7,NULL,'comercio en general',3.00,21,'/uploads/qr/comercio_149.png','2025-10-22 08:21:37','https://maps.app.goo.gl/1dTud7otYe1f355R6',15000.00,1,1,'2025-10-22','2026-10-22',1),(150,'PROB2',1,'Salta 106','385-4568989','asdf@fsd.sdf','Autoservicio',7,NULL,'comercio en general',23.00,21,'/uploads/qr/comercio_150.png','2025-10-22 08:37:45','https://maps.app.goo.gl/hYnY5EiBpXHzZzpF8',78200.00,1,1,'2025-10-22','2026-10-22',0),(151,'Luis Zarate',1,'Salta 105','3854-455654','zarate@gmail.com','Food hall',48,NULL,'bares nocturnos, confiterias y restaurantes',3.00,21,'/uploads/qr/comercio_151.png','2025-10-28 11:27:43','https://maps.app.goo.gl/L5bzHeRvz1bKP148A',15000.00,1,1,'2025-10-28','2026-10-28',0),(152,'Lo de Brito',1,'Jujuy 504','385-4888888','brito@gmail.com','Autoservicio',49,NULL,'comercio en general',40.00,21,'/uploads/qr/comercio_152.png','2025-10-28 17:08:25','https://maps.app.goo.gl/JtZ8ULjQdjEmoH5K7',78200.00,1,1,'2025-10-28','2026-10-28',0);
/*!40000 ALTER TABLE `comercio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comercio_anexo`
--

DROP TABLE IF EXISTS `comercio_anexo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comercio_anexo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_comercio` int NOT NULL,
  `anexo1` varchar(255) DEFAULT NULL,
  `anexo2` varchar(255) DEFAULT NULL,
  `anexo3` varchar(255) DEFAULT NULL,
  `anexo4` varchar(255) DEFAULT NULL,
  `anexo5` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_comercio` (`id_comercio`),
  CONSTRAINT `comercio_anexo_ibfk_1` FOREIGN KEY (`id_comercio`) REFERENCES `comercio` (`id_comercio`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comercio_anexo`
--

LOCK TABLES `comercio_anexo` WRITE;
/*!40000 ALTER TABLE `comercio_anexo` DISABLE KEYS */;
INSERT INTO `comercio_anexo` VALUES (7,13,NULL,NULL,NULL,NULL,NULL),(8,14,NULL,NULL,NULL,NULL,NULL),(79,124,'Pollería','Vinoteca',NULL,NULL,NULL),(80,125,'Sándwiches/Lomitos',NULL,NULL,NULL,NULL),(81,126,'Venta de frutas y verduras',NULL,NULL,NULL,NULL),(82,127,'Vinoteca',NULL,NULL,NULL,NULL),(83,128,'Verdulería',NULL,NULL,NULL,NULL),(84,129,'Pollería',NULL,NULL,NULL,NULL),(85,130,'Pollería',NULL,NULL,NULL,NULL),(86,131,'Pollería',NULL,NULL,NULL,NULL),(87,132,'Patio de comidas',NULL,NULL,NULL,NULL),(88,135,'Verdulería',NULL,NULL,NULL,NULL),(89,136,'Pescadería',NULL,NULL,NULL,NULL),(90,139,'Pollería',NULL,NULL,NULL,NULL),(91,144,'Verdulería',NULL,NULL,NULL,NULL),(92,146,'Pollería',NULL,NULL,NULL,NULL),(93,147,'Verdulería',NULL,NULL,NULL,NULL),(94,148,'Verdulería',NULL,NULL,NULL,NULL),(95,151,'Catering de eventos',NULL,NULL,NULL,NULL),(96,152,'Despensa',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `comercio_anexo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentacion_comercio`
--

DROP TABLE IF EXISTS `documentacion_comercio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documentacion_comercio` (
  `id_documento` int NOT NULL AUTO_INCREMENT,
  `id_comercio` int DEFAULT NULL,
  `tipo_documento` varchar(255) DEFAULT NULL,
  `ruta_archivo` varchar(255) DEFAULT NULL,
  `fecha_subida` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_documento`),
  KEY `id_comercio` (`id_comercio`),
  CONSTRAINT `documentacion_comercio_ibfk_1` FOREIGN KEY (`id_comercio`) REFERENCES `comercio` (`id_comercio`)
) ENGINE=InnoDB AUTO_INCREMENT=405 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentacion_comercio`
--

LOCK TABLES `documentacion_comercio` WRITE;
/*!40000 ALTER TABLE `documentacion_comercio` DISABLE KEYS */;
INSERT INTO `documentacion_comercio` VALUES (223,82,'Pago Inspección','D:\\TECNICATURA EN PROGRAMACION\\2do AÑO\\PP2\\CDV ultimando\\CDV 18.1\\backend\\uploads\\documentos\\doc_pago_inspeccion-1757801087047-281433289.png','2025-09-13 22:04:47'),(224,82,'Plano Local','D:\\TECNICATURA EN PROGRAMACION\\2do AÑO\\PP2\\CDV ultimando\\CDV 18.1\\backend\\uploads\\documentos\\doc_plano-1757801087147-766106603.png','2025-09-13 22:04:47'),(225,82,'Contrato Alquiler','D:\\TECNICATURA EN PROGRAMACION\\2do AÑO\\PP2\\CDV ultimando\\CDV 18.1\\backend\\uploads\\documentos\\doc_alquiler-1757801087198-211573568.png','2025-09-13 22:04:47'),(226,82,'Factibilidad Seguridad','D:\\TECNICATURA EN PROGRAMACION\\2do AÑO\\PP2\\CDV ultimando\\CDV 18.1\\backend\\uploads\\documentos\\doc_seguridad-1757801087225-209954832.png','2025-09-13 22:04:47'),(227,82,'Certificado Bomberos','D:\\TECNICATURA EN PROGRAMACION\\2do AÑO\\PP2\\CDV ultimando\\CDV 18.1\\backend\\uploads\\documentos\\doc_bomberos-1757801087229-490717827.png','2025-09-13 22:04:47'),(328,124,'Declaración Rentas','D:\\TECNICATURA EN PROGRAMACION\\2do AÑO\\PP2\\CDV ultimando\\CDV 18.5\\backend\\uploads\\documentos\\doc_declaracion_rentas-1759007546546-627556614.png','2025-09-27 21:12:27'),(329,124,'Plano Local','D:\\TECNICATURA EN PROGRAMACION\\2do AÑO\\PP2\\CDV ultimando\\CDV 18.5\\backend\\uploads\\documentos\\doc_plano-1759007546713-976753524.png','2025-09-27 21:12:27'),(330,124,'Contrato Alquiler','D:\\TECNICATURA EN PROGRAMACION\\2do AÑO\\PP2\\CDV ultimando\\CDV 18.5\\backend\\uploads\\documentos\\doc_alquiler-1759007546783-182543264.png','2025-09-27 21:12:27'),(331,125,'Declaración Rentas','D:\\TECNICATURA EN PROGRAMACION\\2do AÑO\\PP2\\CDV ultimando\\CDV 18.6\\backend\\uploads\\documentos\\doc_declaracion_rentas-1759285251147-704504919.jpg','2025-10-01 02:20:51'),(332,125,'Certificado Manipulación Alimentos','D:\\TECNICATURA EN PROGRAMACION\\2do AÑO\\PP2\\CDV ultimando\\CDV 18.6\\backend\\uploads\\documentos\\doc_manipulacion-1759285251166-881734376.jpg','2025-10-01 02:20:51'),(333,125,'Póliza Seguro','D:\\TECNICATURA EN PROGRAMACION\\2do AÑO\\PP2\\CDV ultimando\\CDV 18.6\\backend\\uploads\\documentos\\doc_seguro-1759285251175-104037244.jpg','2025-10-01 02:20:51'),(334,125,'Permiso Ubicación','D:\\TECNICATURA EN PROGRAMACION\\2do AÑO\\PP2\\CDV ultimando\\CDV 18.6\\backend\\uploads\\documentos\\doc_permiso-1759285251180-925904284.jpg','2025-10-01 02:20:51'),(335,126,'Conformidad Frentista','F:\\Proyecto CDV\\CDV 08-10\\backend\\uploads\\documentos\\doc_frentista-1760128058085-627462876.jpg','2025-10-10 20:27:38'),(336,127,'Declaración Rentas','F:\\Proyecto CDV\\CDV 08-10\\backend\\uploads\\documentos_titular\\1760205649737-45476962-comercio-internacional-dibujado-mano-dinero_23-2149154535.jpg','2025-10-11 18:00:50'),(337,127,'Plano Local','F:\\Proyecto CDV\\CDV 08-10\\backend\\uploads\\documentos_titular\\1760205649737-415963523-comercio-internacional-dibujado-mano-dinero_23-2149154535.jpg','2025-10-11 18:00:50'),(338,127,'Contrato Alquiler','F:\\Proyecto CDV\\CDV 08-10\\backend\\uploads\\documentos_titular\\1760205649738-436892455-comercio-internacional-dibujado-mano-dinero_23-2149154535.jpg','2025-10-11 18:00:50'),(339,128,'Declaración Rentas','F:\\Proyecto CDV\\CDV 08-10\\backend\\uploads\\documentos_comercio\\doc_declaracion_rentas-1760206612508-815458952.jpg','2025-10-11 18:16:53'),(340,128,'Plano Local','F:\\Proyecto CDV\\CDV 08-10\\backend\\uploads\\documentos_comercio\\doc_plano-1760206612509-239690353.jpg','2025-10-11 18:16:53'),(341,128,'Contrato Alquiler','F:\\Proyecto CDV\\CDV 08-10\\backend\\uploads\\documentos_comercio\\doc_alquiler-1760206612509-180115888.jpg','2025-10-11 18:16:53'),(342,129,'Declaración Rentas','F:/Proyecto CDV/CDV 08-10/backend/uploads/documentos_comercio/doc_declaracion_rentas-1760207503869-42152395.jpg','2025-10-11 18:31:43'),(343,129,'Plano Local','F:/Proyecto CDV/CDV 08-10/backend/uploads/documentos_comercio/doc_plano-1760207503870-676820950.jpg','2025-10-11 18:31:43'),(344,129,'Contrato Alquiler','F:/Proyecto CDV/CDV 08-10/backend/uploads/documentos_comercio/doc_alquiler-1760207503870-800535845.jpg','2025-10-11 18:31:43'),(345,130,'Declaración Rentas','F:/Proyecto CDV/CDV 08-10/backend/uploads/documentos_comercio/doc_declaracion_rentas-1760282606391-28958923.jpg','2025-10-12 15:23:26'),(346,130,'Plano Local','F:/Proyecto CDV/CDV 08-10/backend/uploads/documentos_comercio/doc_plano-1760282606403-523843247.jpg','2025-10-12 15:23:26'),(347,130,'Contrato Alquiler','F:/Proyecto CDV/CDV 08-10/backend/uploads/documentos_comercio/doc_alquiler-1760282606937-998675867.jpg','2025-10-12 15:23:26'),(348,131,'Declaración Rentas','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/doc_declaracion_rentas-1760385686425-295063096.jpg','2025-10-13 20:01:26'),(349,131,'Plano Local','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/doc_plano-1760385686428-941199272.jpg','2025-10-13 20:01:26'),(350,131,'Contrato Alquiler','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/doc_alquiler-1760385686433-204023213.jpg','2025-10-13 20:01:26'),(351,132,'Pago Inspección','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/doc_pago_inspeccion-1760386331553-220534064.jpg','2025-10-13 20:12:11'),(352,132,'Plano Local','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/doc_plano-1760386331560-389262917.jpg','2025-10-13 20:12:11'),(353,132,'Contrato Alquiler','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/doc_alquiler-1760386331566-401901154.jpg','2025-10-13 20:12:11'),(354,132,'Factibilidad Seguridad','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/doc_seguridad-1760386331567-561056917.jpg','2025-10-13 20:12:11'),(355,132,'Certificado Bomberos','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/doc_bomberos-1760386331569-528718523.jpg','2025-10-13 20:12:11'),(356,135,'declaracion_rentas','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/declaracion_rentas_135.jpg','2025-10-14 09:31:20'),(357,135,'plano','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/plano_135.jpg','2025-10-14 09:31:20'),(358,135,'contrato_alquiler','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/contrato_alquiler_135.jpg','2025-10-14 09:31:20'),(359,136,'declaracion_rentas','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/declaracion_rentas_136.jpg','2025-10-14 13:07:29'),(360,136,'sellado_bromatologico','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/sellado_bromatologico_136.jpg','2025-10-14 13:07:29'),(361,136,'plano','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/plano_136.jpg','2025-10-14 13:07:29'),(362,136,'contrato_alquiler','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/contrato_alquiler_136.jpg','2025-10-14 13:07:29'),(363,139,'declaracion_rentas','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/declaracion_rentas_139.jpg','2025-10-14 14:52:31'),(364,139,'sellado_bromatologico','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/sellado_bromatologico_139.jpg','2025-10-14 14:52:31'),(365,139,'plano','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/plano_139.jpg','2025-10-14 14:52:31'),(366,139,'contrato_alquiler','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/contrato_alquiler_139.jpg','2025-10-14 14:52:31'),(367,144,'declaracion_rentas','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/declaracion_rentas_144.jpg','2025-10-14 20:08:51'),(368,144,'sellado_bromatologico','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/sellado_bromatologico_144.jpg','2025-10-14 20:08:51'),(369,144,'plano','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/plano_144.jpg','2025-10-14 20:08:51'),(370,144,'contrato_alquiler','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/contrato_alquiler_144.jpg','2025-10-14 20:08:51'),(371,145,'declaracion_rentas','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/declaracion_rentas_145.jpg','2025-10-14 20:11:14'),(372,145,'sellado_bromatologico','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/sellado_bromatologico_145.jpg','2025-10-14 20:11:14'),(373,145,'plano','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/plano_145.jpg','2025-10-14 20:11:14'),(374,145,'contrato_alquiler','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/contrato_alquiler_145.jpg','2025-10-14 20:11:14'),(375,146,'declaracion_rentas','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/doc_declaracion_rentas-1760497993879-936932658.jpg','2025-10-15 03:13:13'),(376,146,'sellado_bromatologico','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/sellado_bromatologico-1760497993882-227701754.jpg','2025-10-15 03:13:13'),(377,146,'plano','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/doc_plano-1760497993905-607298292.jpg','2025-10-15 03:13:13'),(378,146,'contrato_alquiler','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/doc_alquiler-1760497993905-164514726.jpg','2025-10-15 03:13:13'),(379,147,'declaracion_rentas','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/doc_declaracion_rentas-1760500500198-772651545.jpg','2025-10-15 03:55:00'),(380,147,'sellado_bromatologico','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/sellado_bromatologico-1760500500199-398123595.jpg','2025-10-15 03:55:00'),(381,147,'plano','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/doc_plano-1760500500214-555957458.jpg','2025-10-15 03:55:00'),(382,147,'contrato_alquiler','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/doc_alquiler-1760500500214-657898815.jpg','2025-10-15 03:55:00'),(383,148,'declaracion_rentas','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/declaracion_rentas_148.jpg','2025-10-15 09:55:39'),(384,148,'sellado_bromatologico','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/sellado_bromatologico_148.jpg','2025-10-15 09:55:39'),(385,148,'plano','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/plano_148.jpg','2025-10-15 09:55:39'),(386,148,'contrato_alquiler','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_comercio/contrato_alquiler_148.jpg','2025-10-15 09:55:39'),(387,149,'declaracion_rentas','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_comercio/declaracion_rentas_149.png','2025-10-22 11:21:37'),(388,149,'sellado_bromatologico','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_comercio/sellado_bromatologico_149.png','2025-10-22 11:21:37'),(389,149,'plano','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_comercio/plano_149.png','2025-10-22 11:21:37'),(390,149,'contrato_alquiler','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_comercio/contrato_alquiler_149.png','2025-10-22 11:21:37'),(391,150,'declaracion_rentas','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_comercio/declaracion_rentas_150.png','2025-10-22 11:37:45'),(392,150,'sellado_bromatologico','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_comercio/sellado_bromatologico_150.png','2025-10-22 11:37:45'),(393,150,'plano','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_comercio/plano_150.png','2025-10-22 11:37:45'),(394,150,'contrato_alquiler','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_comercio/contrato_alquiler_150.png','2025-10-22 11:37:45'),(395,151,'declaracion_rentas','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_comercio/declaracion_rentas_151.png','2025-10-28 14:27:43'),(396,151,'sellado_bromatologico','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_comercio/sellado_bromatologico_151.png','2025-10-28 14:27:43'),(397,151,'plano','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_comercio/plano_151.png','2025-10-28 14:27:43'),(398,151,'contrato_alquiler','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_comercio/contrato_alquiler_151.png','2025-10-28 14:27:43'),(399,151,'seguridad','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_comercio/seguridad_151.png','2025-10-28 14:27:43'),(400,151,'bomberos','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_comercio/bomberos_151.png','2025-10-28 14:27:43'),(401,152,'declaracion_rentas','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_comercio/declaracion_rentas_152.png','2025-10-28 20:08:25'),(402,152,'sellado_bromatologico','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_comercio/sellado_bromatologico_152.png','2025-10-28 20:08:25'),(403,152,'plano','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_comercio/plano_152.png','2025-10-28 20:08:25'),(404,152,'contrato_alquiler','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_comercio/contrato_alquiler_152.png','2025-10-28 20:08:25');
/*!40000 ALTER TABLE `documentacion_comercio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentacion_titular`
--

DROP TABLE IF EXISTS `documentacion_titular`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documentacion_titular` (
  `id_documento` int NOT NULL AUTO_INCREMENT,
  `id_razon_social` int DEFAULT NULL,
  `id_titular_ambulante` int DEFAULT NULL,
  `tipo_documento` varchar(255) NOT NULL,
  `ruta_archivo` varchar(255) NOT NULL,
  `fecha_subida` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_documento`),
  KEY `fk_doc_titular_comercio` (`id_razon_social`),
  KEY `fk_doc_titular_ambulante` (`id_titular_ambulante`),
  CONSTRAINT `fk_doc_titular_ambulante` FOREIGN KEY (`id_titular_ambulante`) REFERENCES `titular_ambulante` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_doc_titular_comercio` FOREIGN KEY (`id_razon_social`) REFERENCES `razon_social` (`id_razon_social`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentacion_titular`
--

LOCK TABLES `documentacion_titular` WRITE;
/*!40000 ALTER TABLE `documentacion_titular` DISABLE KEYS */;
INSERT INTO `documentacion_titular` VALUES (1,34,NULL,'dni_frente','uploads\\documentos_titular\\1759222965023-113402920-Imagen de WhatsApp 2025-09-27 a las 18.20.44_1be7f3df.jpg','2025-09-30 09:02:45'),(2,34,NULL,'dni_dorso','uploads\\documentos_titular\\1759222965027-121393890-Imagen de WhatsApp 2025-09-27 a las 18.20.44_35e5de79.jpg','2025-09-30 09:02:45'),(3,34,NULL,'cert_residencia','uploads\\documentos_titular\\1759222965028-18337372-Imagen de WhatsApp 2025-09-27 a las 18.20.44_67748ffa.jpg','2025-09-30 09:02:45'),(4,34,NULL,'cert_salud','uploads\\documentos_titular\\1759222965035-464551977-Imagen de WhatsApp 2025-09-27 a las 18.20.44_9de79e0f.jpg','2025-09-30 09:02:45'),(5,34,NULL,'foto_perfil','uploads\\documentos_titular\\1759222965051-712942811-selfie.jpg','2025-09-30 09:02:45'),(6,35,NULL,'dni_frente','uploads\\documentos_titular\\1759225088932-583461070-Imagen de WhatsApp 2025-09-27 a las 18.20.44_0af9219e.jpg','2025-09-30 09:38:09'),(7,35,NULL,'dni_dorso','uploads\\documentos_titular\\1759225088936-21345090-Imagen de WhatsApp 2025-09-27 a las 18.20.44_a16fc025.jpg','2025-09-30 09:38:09'),(8,35,NULL,'cert_residencia','uploads\\documentos_titular\\1759225088958-200222568-Imagen de WhatsApp 2025-09-27 a las 18.20.44_67748ffa.jpg','2025-09-30 09:38:09'),(9,35,NULL,'cert_salud','uploads\\documentos_titular\\1759225088959-760491843-Imagen de WhatsApp 2025-09-27 a las 18.20.44_9de79e0f.jpg','2025-09-30 09:38:09'),(10,35,NULL,'foto_perfil','uploads\\documentos_titular\\1759225088965-968074682-selfie.jpg','2025-09-30 09:38:09'),(11,NULL,4,'dni_frente','uploads\\documentos_titular\\1759236488055-597829509-Imagen de WhatsApp 2025-09-27 a las 18.20.44_d4bd603e.jpg','2025-09-30 12:48:08'),(12,NULL,4,'dni_dorso','uploads\\documentos_titular\\1759236488059-604501782-Imagen de WhatsApp 2025-09-27 a las 18.20.44_b1b82d3b.jpg','2025-09-30 12:48:08'),(13,NULL,4,'cert_residencia','uploads\\documentos_titular\\1759236488099-249671249-Imagen de WhatsApp 2025-09-27 a las 18.20.44_67748ffa.jpg','2025-09-30 12:48:08'),(14,NULL,4,'cert_salud','uploads\\documentos_titular\\1759236488101-434563612-Imagen de WhatsApp 2025-09-27 a las 18.20.44_9de79e0f.jpg','2025-09-30 12:48:08'),(15,NULL,4,'foto_perfil','uploads\\documentos_titular\\1759236488120-806663706-Imagen de WhatsApp 2025-09-27 a las 18.27.35_456b2cc8.jpg','2025-09-30 12:48:08'),(16,36,NULL,'dni_frente','uploads\\documentos_titular\\1759258473447-422467718-1000_F_543048622_AWO2Pt0K7vuGKg3DmLyX0NCd3Wt9rCIB.jpg','2025-09-30 18:54:33'),(17,36,NULL,'dni_dorso','uploads\\documentos_titular\\1759258473480-829800153-Captura de pantalla 2024-04-12 010225.png','2025-09-30 18:54:33'),(18,36,NULL,'cert_residencia','uploads\\documentos_titular\\1759258473492-539562606-Captura de pantalla 2024-04-12 004750.png','2025-09-30 18:54:33'),(19,36,NULL,'cert_salud','uploads\\documentos_titular\\1759258473525-881103009-Captura de pantalla 2024-04-12 004403.png','2025-09-30 18:54:33'),(20,36,NULL,'foto_perfil','uploads\\documentos_titular\\1759258473530-819081989-Captura de pantalla 2024-04-12 005839.png','2025-09-30 18:54:33'),(21,37,NULL,'dni_frente','uploads\\documentos_titular\\1759259364278-614274821-1000_F_543048622_AWO2Pt0K7vuGKg3DmLyX0NCd3Wt9rCIB.jpg','2025-09-30 19:09:24'),(22,37,NULL,'dni_dorso','uploads\\documentos_titular\\1759259364302-33251437-Captura de pantalla 2024-04-11 084756.png','2025-09-30 19:09:24'),(23,37,NULL,'cert_residencia','uploads\\documentos_titular\\1759259364305-268462636-Captura de pantalla 2024-04-12 003553.png','2025-09-30 19:09:24'),(24,37,NULL,'cert_salud','uploads\\documentos_titular\\1759259364332-344292412-Captura de pantalla 2024-04-12 005448.png','2025-09-30 19:09:24'),(25,37,NULL,'foto_perfil','uploads\\documentos_titular\\1759259364335-776406151-Captura de pantalla 2024-04-12 004403.png','2025-09-30 19:09:24'),(26,38,NULL,'dni_frente','uploads\\documentos_titular\\1759263635005-173815214-1000_F_543048622_AWO2Pt0K7vuGKg3DmLyX0NCd3Wt9rCIB.jpg','2025-09-30 20:20:35'),(27,38,NULL,'dni_dorso','uploads\\documentos_titular\\1759263635085-248085717-Captura de pantalla 2024-04-11 084756.png','2025-09-30 20:20:35'),(28,38,NULL,'cert_residencia','uploads\\documentos_titular\\1759263635090-200184241-Captura de pantalla 2024-04-12 004750.png','2025-09-30 20:20:35'),(29,38,NULL,'cert_salud','uploads\\documentos_titular\\1759263635133-150794645-Captura de pantalla 2024-04-12 005448.png','2025-09-30 20:20:35'),(30,38,NULL,'foto_perfil','uploads\\documentos_titular\\1759263635134-251039068-Captura de pantalla 2024-04-12 003553.png','2025-09-30 20:20:35'),(31,39,NULL,'dni_frente','uploads\\documentos_titular\\1759285009100-837614031-Imagen de WhatsApp 2025-09-27 a las 18.20.44_0af9219e.jpg','2025-10-01 02:16:49'),(32,39,NULL,'dni_dorso','uploads\\documentos_titular\\1759285009106-729497181-Imagen de WhatsApp 2025-09-27 a las 18.20.44_a16fc025.jpg','2025-10-01 02:16:49'),(33,39,NULL,'cert_residencia','uploads\\documentos_titular\\1759285009140-134291447-Imagen de WhatsApp 2025-09-27 a las 18.20.44_67748ffa.jpg','2025-10-01 02:16:49'),(34,39,NULL,'cert_salud','uploads\\documentos_titular\\1759285009141-243193704-Imagen de WhatsApp 2025-09-27 a las 18.20.44_9de79e0f.jpg','2025-10-01 02:16:49'),(35,39,NULL,'foto_perfil','uploads\\documentos_titular\\1759285009152-437599829-selfie.jpg','2025-10-01 02:16:49'),(36,39,NULL,'cert_conducta','uploads\\documentos_titular\\1759285009162-368625410-Imagen de WhatsApp 2025-09-27 a las 18.20.44_2e0e9c63.jpg','2025-10-01 02:16:49'),(37,40,NULL,'dni_frente','uploads\\documentos_titular\\1759906078419-342118480-1053.jpg','2025-10-08 06:47:58'),(38,40,NULL,'dni_dorso','uploads\\documentos_titular\\1759906078444-763243002-ComplejoParqueNorte1.jpg','2025-10-08 06:47:58'),(39,40,NULL,'cert_residencia','uploads\\documentos_titular\\1759906078451-356680252-ComplejoParqueNorte27.jpg','2025-10-08 06:47:58'),(40,40,NULL,'cert_salud','uploads\\documentos_titular\\1759906078458-247784454-ComplejoParqueNorte-1200x800.jpg','2025-10-08 06:47:58'),(41,40,NULL,'foto_perfil','uploads\\documentos_titular\\1759906078463-347593813-Logo_programa_calidad_de_vida_W.png','2025-10-08 06:47:58'),(42,NULL,5,'dni_frente','uploads\\documentos_titular\\1759906333706-550340881-ComplejoParqueNorte4.jpg','2025-10-08 06:52:14'),(43,NULL,5,'dni_dorso','uploads\\documentos_titular\\1759906333708-915537029-ComplejoParqueNorte27.jpg','2025-10-08 06:52:14'),(44,NULL,5,'cert_residencia','uploads\\documentos_titular\\1759906333711-385061504-ComplejoParqueNorte1.jpg','2025-10-08 06:52:14'),(45,NULL,5,'cert_salud','uploads\\documentos_titular\\1759906333718-902263573-ComplejoParqueNorte4.jpg','2025-10-08 06:52:14'),(46,NULL,5,'foto_perfil','uploads\\documentos_titular\\1759906333720-145623401-ComplejoParqueNorte-1200x800.jpg','2025-10-08 06:52:14'),(47,NULL,6,'dni_frente','uploads\\documentos_titular\\1759963684859-303680260-Captura de pantalla 2024-02-21 234335.png','2025-10-08 22:48:04'),(48,NULL,6,'dni_dorso','uploads\\documentos_titular\\1759963684860-63984809-Captura de pantalla 2024-03-19 224503.png','2025-10-08 22:48:04'),(49,NULL,6,'cert_residencia','uploads\\documentos_titular\\1759963684876-780356002-Captura de pantalla 2024-05-28 013957.png','2025-10-08 22:48:04'),(50,NULL,6,'carnet_conducir','uploads\\documentos_titular\\1759963684877-328648032-Captura de pantalla 2025-05-26 044020.png','2025-10-08 22:48:04'),(51,NULL,6,'foto_perfil','uploads\\documentos_titular\\1759963684882-101515119-Captura de pantalla 2025-05-11 224253.png','2025-10-08 22:48:04'),(52,NULL,6,'dni_frente','uploads\\documentos_titular\\1759963684859-303680260-Captura de pantalla 2024-02-21 234335.png','2025-10-08 22:48:04'),(53,NULL,6,'dni_dorso','uploads\\documentos_titular\\1759963684860-63984809-Captura de pantalla 2024-03-19 224503.png','2025-10-08 22:48:04'),(54,NULL,6,'cert_residencia','uploads\\documentos_titular\\1759963684876-780356002-Captura de pantalla 2024-05-28 013957.png','2025-10-08 22:48:04'),(55,NULL,6,'carnet_conducir','uploads\\documentos_titular\\1759963684877-328648032-Captura de pantalla 2025-05-26 044020.png','2025-10-08 22:48:04'),(56,NULL,6,'foto_perfil','uploads\\documentos_titular\\1759963684882-101515119-Captura de pantalla 2025-05-11 224253.png','2025-10-08 22:48:04'),(57,41,NULL,'dni_frente','uploads\\documentos_titular\\1759963909688-821185067-Captura de pantalla 2024-05-28 013957.png','2025-10-08 22:51:50'),(58,41,NULL,'dni_dorso','uploads\\documentos_titular\\1759963909695-941041736-Captura de pantalla 2025-05-11 224253.png','2025-10-08 22:51:50'),(59,41,NULL,'cert_residencia','uploads\\documentos_titular\\1759963910190-421234046-Captura de pantalla 2025-05-26 044020.png','2025-10-08 22:51:50'),(60,41,NULL,'cert_salud','uploads\\documentos_titular\\1759963910191-305681686-Captura de pantalla 2025-10-08 045417.png','2025-10-08 22:51:50'),(61,41,NULL,'foto_perfil','uploads\\documentos_titular\\1759963910192-678772155-Captura de pantalla 2024-05-28 013432.png','2025-10-08 22:51:50'),(62,42,NULL,'dni_frente','uploads\\documentos_titular\\1759964196182-88821525-Captura de pantalla 2024-05-28 013957.png','2025-10-08 22:56:36'),(63,42,NULL,'dni_dorso','uploads\\documentos_titular\\1759964196183-352145419-Captura de pantalla 2025-05-11 224253.png','2025-10-08 22:56:36'),(64,42,NULL,'cert_residencia','uploads\\documentos_titular\\1759964196188-174331114-Captura de pantalla 2025-05-26 044020.png','2025-10-08 22:56:36'),(65,42,NULL,'cert_salud','uploads\\documentos_titular\\1759964196189-458568336-Captura de pantalla 2024-05-28 013500.png','2025-10-08 22:56:36'),(66,42,NULL,'foto_perfil','uploads\\documentos_titular\\1759964196189-881021466-Captura de pantalla 2024-05-28 013432.png','2025-10-08 22:56:36'),(67,NULL,7,'dni_frente','uploads\\documentos_titular\\1759964911134-486428250-Captura de pantalla 2024-02-21 234335.png','2025-10-08 23:08:31'),(68,NULL,7,'dni_dorso','uploads\\documentos_titular\\1759964911135-518510711-Captura de pantalla 2025-05-11 224253.png','2025-10-08 23:08:31'),(69,NULL,7,'cert_residencia','uploads\\documentos_titular\\1759964911620-408620782-Captura de pantalla 2025-05-26 044020.png','2025-10-08 23:08:31'),(70,NULL,7,'cert_salud','uploads\\documentos_titular\\1759964911623-540762472-Captura de pantalla 2024-05-28 013500.png','2025-10-08 23:08:31'),(71,NULL,7,'foto_perfil','uploads\\documentos_titular\\1759964911623-51520102-Captura de pantalla 2024-05-28 013432.png','2025-10-08 23:08:31'),(72,NULL,7,'dni_frente','uploads\\documentos_titular\\1759964911134-486428250-Captura de pantalla 2024-02-21 234335.png','2025-10-08 23:08:31'),(73,NULL,7,'dni_dorso','uploads\\documentos_titular\\1759964911135-518510711-Captura de pantalla 2025-05-11 224253.png','2025-10-08 23:08:31'),(74,NULL,7,'cert_residencia','uploads\\documentos_titular\\1759964911620-408620782-Captura de pantalla 2025-05-26 044020.png','2025-10-08 23:08:31'),(75,NULL,7,'cert_salud','uploads\\documentos_titular\\1759964911623-540762472-Captura de pantalla 2024-05-28 013500.png','2025-10-08 23:08:31'),(76,NULL,7,'foto_perfil','uploads\\documentos_titular\\1759964911623-51520102-Captura de pantalla 2024-05-28 013432.png','2025-10-08 23:08:31'),(77,NULL,8,'dni_frente','uploads\\documentos_titular\\1759965081428-770493538-Captura de pantalla 2024-05-28 013957.png','2025-10-08 23:11:21'),(78,NULL,8,'dni_dorso','uploads\\documentos_titular\\1759965081431-435498912-Captura de pantalla 2025-05-11 224253.png','2025-10-08 23:11:21'),(79,NULL,8,'cert_residencia','uploads\\documentos_titular\\1759965081913-423678252-Captura de pantalla 2025-05-26 044020.png','2025-10-08 23:11:21'),(80,NULL,8,'carnet_conducir','uploads\\documentos_titular\\1759965081915-279202612-Captura de pantalla 2025-05-11 224253.png','2025-10-08 23:11:21'),(81,NULL,8,'foto_perfil','uploads\\documentos_titular\\1759965081922-289930508-Captura de pantalla 2024-05-28 013432.png','2025-10-08 23:11:21'),(82,NULL,8,'dni_frente','uploads\\documentos_titular\\1759965081428-770493538-Captura de pantalla 2024-05-28 013957.png','2025-10-08 23:11:21'),(83,NULL,8,'dni_dorso','uploads\\documentos_titular\\1759965081431-435498912-Captura de pantalla 2025-05-11 224253.png','2025-10-08 23:11:21'),(84,NULL,8,'cert_residencia','uploads\\documentos_titular\\1759965081913-423678252-Captura de pantalla 2025-05-26 044020.png','2025-10-08 23:11:21'),(85,NULL,8,'carnet_conducir','uploads\\documentos_titular\\1759965081915-279202612-Captura de pantalla 2025-05-11 224253.png','2025-10-08 23:11:21'),(86,NULL,8,'foto_perfil','uploads\\documentos_titular\\1759965081922-289930508-Captura de pantalla 2024-05-28 013432.png','2025-10-08 23:11:21'),(87,NULL,9,'dni_frente','uploads\\documentos_titular\\1760128271301-339601400-Imagen de WhatsApp 2025-09-27 a las 18.20.40_6950aa09.jpg','2025-10-10 20:31:11'),(88,NULL,9,'dni_dorso','uploads\\documentos_titular\\1760128271301-712075263-Imagen de WhatsApp 2025-09-27 a las 18.20.40_ef3be308.jpg','2025-10-10 20:31:11'),(89,NULL,9,'cert_residencia','uploads\\documentos_titular\\1760128271301-11652098-Imagen de WhatsApp 2025-09-27 a las 18.20.40_d3718f37.jpg','2025-10-10 20:31:11'),(90,NULL,9,'cert_salud','uploads\\documentos_titular\\1760128271303-935117407-Imagen de WhatsApp 2025-09-27 a las 18.20.40_b4f59eb7.jpg','2025-10-10 20:31:11'),(91,NULL,9,'foto_perfil','uploads\\documentos_titular\\1760128271324-314860909-Imagen de WhatsApp 2025-09-27 a las 18.27.31_704b4a16.jpg','2025-10-10 20:31:11'),(92,NULL,9,'dni_frente','uploads\\documentos_titular\\1760128271301-339601400-Imagen de WhatsApp 2025-09-27 a las 18.20.40_6950aa09.jpg','2025-10-10 20:31:11'),(93,NULL,9,'dni_dorso','uploads\\documentos_titular\\1760128271301-712075263-Imagen de WhatsApp 2025-09-27 a las 18.20.40_ef3be308.jpg','2025-10-10 20:31:11'),(94,NULL,9,'cert_residencia','uploads\\documentos_titular\\1760128271301-11652098-Imagen de WhatsApp 2025-09-27 a las 18.20.40_d3718f37.jpg','2025-10-10 20:31:11'),(95,NULL,9,'cert_salud','uploads\\documentos_titular\\1760128271303-935117407-Imagen de WhatsApp 2025-09-27 a las 18.20.40_b4f59eb7.jpg','2025-10-10 20:31:11'),(96,NULL,9,'foto_perfil','uploads\\documentos_titular\\1760128271324-314860909-Imagen de WhatsApp 2025-09-27 a las 18.27.31_704b4a16.jpg','2025-10-10 20:31:11'),(97,NULL,10,'dni_frente','uploads\\documentos_titular\\1760131980302-297755939-Imagen de WhatsApp 2025-09-27 a las 18.20.40_6950aa09.jpg','2025-10-10 21:33:00'),(98,NULL,10,'dni_dorso','uploads\\documentos_titular\\1760131980302-723194335-Imagen de WhatsApp 2025-09-27 a las 18.20.40_ef3be308.jpg','2025-10-10 21:33:00'),(99,NULL,10,'cert_residencia','uploads\\documentos_titular\\1760131980303-385131310-Imagen de WhatsApp 2025-09-27 a las 18.20.40_d3718f37.jpg','2025-10-10 21:33:00'),(100,NULL,10,'cert_salud','uploads\\documentos_titular\\1760131980308-676540788-Imagen de WhatsApp 2025-09-27 a las 18.20.40_b4f59eb7.jpg','2025-10-10 21:33:00'),(101,NULL,10,'foto_perfil','uploads\\documentos_titular\\1760131980330-931034700-Imagen de WhatsApp 2025-09-27 a las 18.27.31_704b4a16.jpg','2025-10-10 21:33:00'),(102,NULL,10,'dni_frente','uploads\\documentos_titular\\1760131980302-297755939-Imagen de WhatsApp 2025-09-27 a las 18.20.40_6950aa09.jpg','2025-10-10 21:33:00'),(103,NULL,10,'dni_dorso','uploads\\documentos_titular\\1760131980302-723194335-Imagen de WhatsApp 2025-09-27 a las 18.20.40_ef3be308.jpg','2025-10-10 21:33:00'),(104,NULL,10,'cert_residencia','uploads\\documentos_titular\\1760131980303-385131310-Imagen de WhatsApp 2025-09-27 a las 18.20.40_d3718f37.jpg','2025-10-10 21:33:00'),(105,NULL,10,'cert_salud','uploads\\documentos_titular\\1760131980308-676540788-Imagen de WhatsApp 2025-09-27 a las 18.20.40_b4f59eb7.jpg','2025-10-10 21:33:00'),(106,NULL,10,'foto_perfil','uploads\\documentos_titular\\1760131980330-931034700-Imagen de WhatsApp 2025-09-27 a las 18.27.31_704b4a16.jpg','2025-10-10 21:33:00'),(107,NULL,11,'dni_frente','\\uploads\\documentos_titular\\1760134048877-663669544-Imagen de WhatsApp 2025-09-27 a las 18.20.40_6950aa09.jpg','2025-10-10 22:07:28'),(108,NULL,11,'dni_dorso','\\uploads\\documentos_titular\\1760134048877-880452908-Imagen de WhatsApp 2025-09-27 a las 18.20.40_7803ee02.jpg','2025-10-10 22:07:28'),(109,NULL,11,'cert_residencia','\\uploads\\documentos_titular\\1760134048877-832180097-Imagen de WhatsApp 2025-09-27 a las 18.20.40_d3718f37.jpg','2025-10-10 22:07:28'),(110,NULL,11,'cert_salud','\\uploads\\documentos_titular\\1760134048885-604147516-Imagen de WhatsApp 2025-09-27 a las 18.20.40_b4f59eb7.jpg','2025-10-10 22:07:28'),(111,NULL,11,'foto_perfil','\\uploads\\documentos_titular\\1760134048892-168299603-Imagen de WhatsApp 2025-09-27 a las 18.27.31_704b4a16.jpg','2025-10-10 22:07:28'),(112,NULL,11,'dni_frente','\\uploads\\documentos_titular\\1760134048877-663669544-Imagen de WhatsApp 2025-09-27 a las 18.20.40_6950aa09.jpg','2025-10-10 22:07:28'),(113,NULL,11,'dni_dorso','\\uploads\\documentos_titular\\1760134048877-880452908-Imagen de WhatsApp 2025-09-27 a las 18.20.40_7803ee02.jpg','2025-10-10 22:07:28'),(114,NULL,11,'cert_residencia','\\uploads\\documentos_titular\\1760134048877-832180097-Imagen de WhatsApp 2025-09-27 a las 18.20.40_d3718f37.jpg','2025-10-10 22:07:28'),(115,NULL,11,'cert_salud','\\uploads\\documentos_titular\\1760134048885-604147516-Imagen de WhatsApp 2025-09-27 a las 18.20.40_b4f59eb7.jpg','2025-10-10 22:07:28'),(116,NULL,11,'foto_perfil','\\uploads\\documentos_titular\\1760134048892-168299603-Imagen de WhatsApp 2025-09-27 a las 18.27.31_704b4a16.jpg','2025-10-10 22:07:28'),(117,NULL,12,'dni_frente','\\uploads\\documentos_titular\\1760135484378-662989231-Imagen de WhatsApp 2025-09-27 a las 18.20.40_6950aa09.jpg','2025-10-10 22:31:24'),(118,NULL,12,'dni_dorso','\\uploads\\documentos_titular\\1760135484378-599118576-Imagen de WhatsApp 2025-09-27 a las 18.20.40_b81d222f.jpg','2025-10-10 22:31:24'),(119,NULL,12,'cert_residencia','\\uploads\\documentos_titular\\1760135484379-776193614-Imagen de WhatsApp 2025-09-27 a las 18.20.40_d3718f37.jpg','2025-10-10 22:31:24'),(120,NULL,12,'cert_salud','\\uploads\\documentos_titular\\1760135484379-177644187-Imagen de WhatsApp 2025-09-27 a las 18.20.40_b4f59eb7.jpg','2025-10-10 22:31:24'),(121,NULL,12,'foto_perfil','\\uploads\\documentos_titular\\1760135484885-240323047-Imagen de WhatsApp 2025-09-27 a las 18.27.31_704b4a16.jpg','2025-10-10 22:31:24'),(122,NULL,12,'dni_frente','\\uploads\\documentos_titular\\1760135484378-662989231-Imagen de WhatsApp 2025-09-27 a las 18.20.40_6950aa09.jpg','2025-10-10 22:31:24'),(123,NULL,12,'dni_dorso','\\uploads\\documentos_titular\\1760135484378-599118576-Imagen de WhatsApp 2025-09-27 a las 18.20.40_b81d222f.jpg','2025-10-10 22:31:24'),(124,NULL,12,'cert_residencia','\\uploads\\documentos_titular\\1760135484379-776193614-Imagen de WhatsApp 2025-09-27 a las 18.20.40_d3718f37.jpg','2025-10-10 22:31:24'),(125,NULL,12,'cert_salud','\\uploads\\documentos_titular\\1760135484379-177644187-Imagen de WhatsApp 2025-09-27 a las 18.20.40_b4f59eb7.jpg','2025-10-10 22:31:24'),(126,NULL,12,'foto_perfil','\\uploads\\documentos_titular\\1760135484885-240323047-Imagen de WhatsApp 2025-09-27 a las 18.27.31_704b4a16.jpg','2025-10-10 22:31:24'),(127,NULL,13,'dni_frente','documentos_titular/1760136170541-491253849-Imagen de WhatsApp 2025-09-27 a las 18.20.40_6950aa09.jpg','2025-10-10 22:42:50'),(128,NULL,13,'dni_dorso','documentos_titular/1760136170542-521279683-Imagen de WhatsApp 2025-09-27 a las 18.20.40_b81d222f.jpg','2025-10-10 22:42:50'),(129,NULL,13,'cert_residencia','documentos_titular/1760136170542-593810127-Imagen de WhatsApp 2025-09-27 a las 18.20.40_d3718f37.jpg','2025-10-10 22:42:50'),(130,NULL,13,'cert_salud','documentos_titular/1760136170542-205559869-Imagen de WhatsApp 2025-09-27 a las 18.20.40_b4f59eb7.jpg','2025-10-10 22:42:50'),(131,NULL,13,'foto_perfil','documentos_titular/1760136170555-453100070-Imagen de WhatsApp 2025-09-27 a las 18.27.31_704b4a16.jpg','2025-10-10 22:42:50'),(132,NULL,14,'dni_frente','documentos_titular/1760137781290-759032614-Imagen de WhatsApp 2025-09-27 a las 18.20.40_60fa6d54.jpg','2025-10-10 23:09:41'),(133,NULL,14,'dni_dorso','documentos_titular/1760137781290-622423710-Imagen de WhatsApp 2025-09-27 a las 18.20.40_7803ee02.jpg','2025-10-10 23:09:41'),(134,NULL,14,'cert_residencia','documentos_titular/1760137781291-820094413-Imagen de WhatsApp 2025-09-27 a las 18.20.40_b81d222f.jpg','2025-10-10 23:09:41'),(135,NULL,14,'cert_salud','documentos_titular/1760137781294-326961412-Imagen de WhatsApp 2025-09-27 a las 18.20.40_ef3be308.jpg','2025-10-10 23:09:41'),(136,NULL,14,'foto_perfil','documentos_titular/1760137781295-349612815-Imagen de WhatsApp 2025-09-27 a las 18.20.40_b4f59eb7.jpg','2025-10-10 23:09:41'),(137,43,NULL,'dni_frente','documentos_titular/1760138054626-875245323-Imagen de WhatsApp 2025-09-27 a las 18.20.40_b4f59eb7.jpg','2025-10-10 23:14:14'),(138,43,NULL,'dni_dorso','documentos_titular/1760138054629-786223583-Imagen de WhatsApp 2025-09-27 a las 18.20.40_6950aa09.jpg','2025-10-10 23:14:14'),(139,43,NULL,'cert_residencia','documentos_titular/1760138054630-918261857-Imagen de WhatsApp 2025-09-27 a las 18.20.40_7803ee02.jpg','2025-10-10 23:14:14'),(140,43,NULL,'cert_salud','documentos_titular/1760138054630-987238511-Imagen de WhatsApp 2025-09-27 a las 18.20.40_b4f59eb7.jpg','2025-10-10 23:14:14'),(141,43,NULL,'foto_perfil','documentos_titular/1760138054638-825918766-Imagen de WhatsApp 2025-09-27 a las 18.20.40_d3718f37.jpg','2025-10-10 23:14:14'),(142,NULL,15,'dni_frente','documentos_titular/1760139883334-688124632-Imagen de WhatsApp 2025-09-27 a las 18.20.40_6950aa09.jpg','2025-10-10 23:44:43'),(143,NULL,15,'dni_dorso','documentos_titular/1760139883335-405435787-Imagen de WhatsApp 2025-09-27 a las 18.20.40_7803ee02.jpg','2025-10-10 23:44:43'),(144,NULL,15,'cert_residencia','documentos_titular/1760139883335-587935478-Imagen de WhatsApp 2025-09-27 a las 18.20.40_d3718f37.jpg','2025-10-10 23:44:43'),(145,NULL,15,'cert_salud','documentos_titular/1760139883340-710499915-Imagen de WhatsApp 2025-09-27 a las 18.20.40_b4f59eb7.jpg','2025-10-10 23:44:43'),(146,NULL,15,'foto_perfil','documentos_titular/1760139883351-241143360-Imagen de WhatsApp 2025-09-27 a las 18.27.31_704b4a16.jpg','2025-10-10 23:44:43'),(147,NULL,16,'dni_frente','uploads\\documentos_titular\\1760148513226-706820276-Captura de pantalla 2024-05-28 013500.png','2025-10-11 02:08:33'),(148,NULL,16,'dni_dorso','uploads\\documentos_titular\\1760148513227-234005213-Captura de pantalla 2024-05-28 013957.png','2025-10-11 02:08:33'),(149,NULL,16,'cert_residencia','uploads\\documentos_titular\\1760148513231-86085868-Captura de pantalla 2025-05-11 224253.png','2025-10-11 02:08:33'),(150,NULL,16,'cert_salud','uploads\\documentos_titular\\1760148513250-408442649-Captura de pantalla 2025-05-26 044020.png','2025-10-11 02:08:33'),(151,NULL,16,'foto_perfil','uploads\\documentos_titular\\1760148513253-847308475-Captura de pantalla 2024-05-28 013432.png','2025-10-11 02:08:33'),(152,NULL,17,'dni_frente','uploads/documentos_titular/1760149828726-784693206-Captura de pantalla 2024-02-21 234335.png','2025-10-11 02:30:29'),(153,NULL,17,'dni_dorso','uploads/documentos_titular/1760149828726-432440199-Captura de pantalla 2025-10-08 045417.png','2025-10-11 02:30:29'),(154,NULL,17,'cert_residencia','uploads/documentos_titular/1760149828726-726665033-Captura de pantalla 2024-03-19 224503.png','2025-10-11 02:30:29'),(155,NULL,17,'cert_salud','uploads/documentos_titular/1760149829219-18298365-Captura de pantalla 2025-10-10 183453.png','2025-10-11 02:30:29'),(156,NULL,17,'foto_perfil','uploads/documentos_titular/1760149829219-562479757-Captura de pantalla 2025-07-28 173223.png','2025-10-11 02:30:29'),(157,NULL,19,'dni_frente','uploads/documentos_titular/1760151181806-625920688-Captura de pantalla 2024-05-28 013957.png','2025-10-11 02:53:01'),(158,NULL,19,'dni_dorso','uploads/documentos_titular/1760151181808-139376530-Captura de pantalla 2025-05-11 224253.png','2025-10-11 02:53:01'),(159,NULL,19,'cert_residencia','uploads/documentos_titular/1760151181814-658994218-Captura de pantalla 2025-05-26 044020.png','2025-10-11 02:53:01'),(160,NULL,19,'cert_salud','uploads/documentos_titular/1760151181816-531954767-Captura de pantalla 2024-05-28 013500.png','2025-10-11 02:53:01'),(161,NULL,19,'foto_perfil','uploads/documentos_titular/1760151181816-871537447-Captura de pantalla 2024-05-28 013432.png','2025-10-11 02:53:01'),(162,NULL,20,'dni_frente','uploads/documentos_titular/1760204347337-696602320-Captura de pantalla 2024-02-21 234335.png','2025-10-11 17:39:07'),(163,NULL,20,'dni_dorso','uploads/documentos_titular/1760204347339-374567305-Captura de pantalla 2024-03-19 224503.png','2025-10-11 17:39:07'),(164,NULL,20,'cert_residencia','uploads/documentos_titular/1760204347831-289972145-Captura de pantalla 2025-10-08 045417.png','2025-10-11 17:39:07'),(165,NULL,20,'cert_salud','uploads/documentos_titular/1760204347831-773500660-Captura de pantalla 2025-10-10 183453.png','2025-10-11 17:39:07'),(166,NULL,20,'foto_perfil','uploads/documentos_titular/1760204347832-57271303-Captura de pantalla 2024-05-28 013432.png','2025-10-11 17:39:07'),(167,44,NULL,'dni_frente','uploads/documentos_titular/1760206480704-92084656-Imagen de WhatsApp 2025-09-27 a las 18.20.40_7803ee02.jpg','2025-10-11 18:14:40'),(168,44,NULL,'dni_dorso','uploads/documentos_titular/1760206480705-611862712-Imagen de WhatsApp 2025-09-27 a las 18.20.40_f89ed9ea.jpg','2025-10-11 18:14:40'),(169,44,NULL,'cert_residencia','uploads/documentos_titular/1760206480732-301302883-Imagen de WhatsApp 2025-09-27 a las 18.20.40_d3718f37.jpg','2025-10-11 18:14:40'),(170,44,NULL,'cert_salud','uploads/documentos_titular/1760206480732-476072509-Imagen de WhatsApp 2025-09-27 a las 18.20.40_b4f59eb7.jpg','2025-10-11 18:14:40'),(171,44,NULL,'foto_perfil','uploads/documentos_titular/1760206480740-829740033-Imagen de WhatsApp 2025-09-27 a las 18.27.31_704b4a16.jpg','2025-10-11 18:14:40'),(172,NULL,21,'dni_frente','uploads/documentos_titular/1760222071824-634782752-Imagen de WhatsApp 2025-09-27 a las 18.20.40_6950aa09.jpg','2025-10-11 22:34:31'),(173,NULL,21,'dni_dorso','uploads/documentos_titular/1760222071825-145423638-Imagen de WhatsApp 2025-09-27 a las 18.20.40_f89ed9ea.jpg','2025-10-11 22:34:31'),(174,NULL,21,'carnet_frente','uploads/documentos_titular/1760222071849-608369244-Imagen de WhatsApp 2025-09-27 a las 18.20.40_7803ee02.jpg','2025-10-11 22:34:31'),(175,NULL,21,'carnet_dorso','uploads/documentos_titular/1760222071849-72797021-Imagen de WhatsApp 2025-09-27 a las 18.20.40_ef3be308.jpg','2025-10-11 22:34:31'),(176,NULL,21,'cert_residencia','uploads/documentos_titular/1760222071850-268675900-Imagen de WhatsApp 2025-09-27 a las 18.20.40_d3718f37.jpg','2025-10-11 22:34:31'),(177,NULL,21,'foto_perfil','uploads/documentos_titular/1760222071854-434030440-Imagen de WhatsApp 2025-09-27 a las 18.27.31_704b4a16.jpg','2025-10-11 22:34:31'),(178,46,NULL,'dni_frente','uploads/documentos_titular/1760288261827-957697453-Imagen de WhatsApp 2025-09-27 a las 18.20.40_293fb900.jpg','2025-10-12 16:57:41'),(179,46,NULL,'dni_dorso','uploads/documentos_titular/1760288261832-957220449-Imagen de WhatsApp 2025-09-27 a las 18.20.40_7803ee02.jpg','2025-10-12 16:57:41'),(180,46,NULL,'cert_residencia','uploads/documentos_titular/1760288261832-149377841-Imagen de WhatsApp 2025-09-27 a las 18.20.40_b4f59eb7.jpg','2025-10-12 16:57:41'),(181,46,NULL,'cert_salud','uploads/documentos_titular/1760288261853-293447089-Imagen de WhatsApp 2025-09-27 a las 18.20.40_b4f59eb7.jpg','2025-10-12 16:57:41'),(182,46,NULL,'foto_perfil','uploads/documentos_titular/1760288261859-241439976-Imagen de WhatsApp 2025-09-27 a las 18.20.40_293fb900.jpg','2025-10-12 16:57:41'),(183,47,NULL,'dni_frente','uploads/documentos_titular/1760292602752-842550671-Imagen de WhatsApp 2025-09-27 a las 18.20.40_b81d222f.jpg','2025-10-12 18:10:02'),(184,47,NULL,'dni_dorso','uploads/documentos_titular/1760292602752-992694816-Imagen de WhatsApp 2025-09-27 a las 18.20.40_ef3be308.jpg','2025-10-12 18:10:02'),(185,47,NULL,'cert_residencia','uploads/documentos_titular/1760292602753-753712882-Imagen de WhatsApp 2025-09-27 a las 18.20.40_d3718f37.jpg','2025-10-12 18:10:02'),(186,47,NULL,'cert_salud','uploads/documentos_titular/1760292602757-137852802-Imagen de WhatsApp 2025-09-27 a las 18.20.40_b4f59eb7.jpg','2025-10-12 18:10:02'),(187,47,NULL,'foto_perfil','uploads/documentos_titular/1760292602774-918003682-4037090347_a2a3de34ed_c.jpg','2025-10-12 18:10:02'),(188,NULL,22,'dni_frente','uploads/documentos_titular/1760293175370-26460863-Imagen de WhatsApp 2025-09-27 a las 18.27.31_704b4a16.jpg','2025-10-12 18:19:35'),(189,NULL,22,'dni_dorso','uploads/documentos_titular/1760293175371-358496035-Imagen de WhatsApp 2025-09-27 a las 18.20.40_f89ed9ea.jpg','2025-10-12 18:19:35'),(190,NULL,22,'carnet_frente','uploads/documentos_titular/1760293175389-88513886-Imagen de WhatsApp 2025-09-27 a las 18.20.40_7803ee02.jpg','2025-10-12 18:19:35'),(191,NULL,22,'carnet_dorso','uploads/documentos_titular/1760293175392-184266613-Imagen de WhatsApp 2025-09-27 a las 18.20.40_ef3be308.jpg','2025-10-12 18:19:35'),(192,NULL,22,'cert_residencia','uploads/documentos_titular/1760293175393-31437539-Imagen de WhatsApp 2025-09-27 a las 18.20.40_d3718f37.jpg','2025-10-12 18:19:35'),(193,NULL,22,'foto_perfil','uploads/documentos_titular/1760293175397-90168975-depositphotos_60400957-stock-photo-the-man-in-the-office.jpg','2025-10-12 18:19:35'),(194,48,NULL,'dni_frente','uploads/documentos_titular/1761661503743-186005404-Screenshot 2025-02-08 182802.png','2025-10-28 14:25:03'),(195,48,NULL,'dni_dorso','uploads/documentos_titular/1761661503745-937341163-Screenshot 2025-02-08 182802.png','2025-10-28 14:25:03'),(196,48,NULL,'cert_residencia','uploads/documentos_titular/1761661503747-131665693-Screenshot 2025-02-08 182802.png','2025-10-28 14:25:03'),(197,48,NULL,'cert_salud','uploads/documentos_titular/1761661503748-598495524-Screenshot 2025-02-08 182802.png','2025-10-28 14:25:03'),(198,48,NULL,'foto_perfil','uploads/documentos_titular/1761661503750-761430917-Screenshot 2025-02-08 182802.png','2025-10-28 14:25:03'),(199,48,NULL,'cert_conducta','uploads/documentos_titular/1761661503752-61165134-Screenshot 2025-02-08 182802.png','2025-10-28 14:25:03'),(200,49,NULL,'dni_frente','uploads/documentos_titular/1761681979700-499982061-Screenshot 2025-02-08 182802.png','2025-10-28 20:06:19'),(201,49,NULL,'dni_dorso','uploads/documentos_titular/1761681979702-848524690-Screenshot 2025-02-08 182802.png','2025-10-28 20:06:19'),(202,49,NULL,'cert_residencia','uploads/documentos_titular/1761681979705-667063003-Screenshot 2025-01-25 164347.png','2025-10-28 20:06:19'),(203,49,NULL,'cert_salud','uploads/documentos_titular/1761681979708-68996714-Screenshot 2025-01-25 164347.png','2025-10-28 20:06:19'),(204,49,NULL,'foto_perfil','uploads/documentos_titular/1761681979711-178053092-Screenshot 2025-02-12 212443.png','2025-10-28 20:06:19'),(205,49,NULL,'cert_conducta','uploads/documentos_titular/1761681979712-244788409-Screenshot 2025-02-08 182802.png','2025-10-28 20:06:19');
/*!40000 ALTER TABLE `documentacion_titular` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentacion_transporte`
--

DROP TABLE IF EXISTS `documentacion_transporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documentacion_transporte` (
  `id_documento` int NOT NULL AUTO_INCREMENT,
  `id_transporte` int NOT NULL,
  `tipo_documento` varchar(255) NOT NULL,
  `ruta_archivo` varchar(255) NOT NULL,
  `fecha_subida` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_documento`),
  KEY `id_transporte` (`id_transporte`),
  CONSTRAINT `documentacion_transporte_ibfk_1` FOREIGN KEY (`id_transporte`) REFERENCES `transporte` (`id_transporte`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentacion_transporte`
--

LOCK TABLES `documentacion_transporte` WRITE;
/*!40000 ALTER TABLE `documentacion_transporte` DISABLE KEYS */;
INSERT INTO `documentacion_transporte` VALUES (1,9,'dni_frente','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/dni_frente_9.jpg','2025-10-14 09:51:25'),(2,9,'dni_dorso','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/dni_dorso_9.jpg','2025-10-14 09:51:25'),(3,9,'carnet_frente','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/carnet_frente_9.jpg','2025-10-14 09:51:26'),(4,9,'carnet_dorso','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/carnet_dorso_9.jpg','2025-10-14 09:51:26'),(5,9,'cert_salud','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/cert_salud_9.jpg','2025-10-14 09:51:26'),(6,9,'foto_vehiculo','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/foto_vehiculo_9.jpg','2025-10-14 09:51:26'),(7,9,'cedula_verde','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/cedula_verde_9.jpg','2025-10-14 09:51:26'),(8,9,'seguro_vehiculo','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/seguro_vehiculo_9.jpg','2025-10-14 09:51:26'),(9,9,'vto_vehiculo','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/vto_vehiculo_9.jpg','2025-10-14 09:51:26'),(10,9,'sellado_bromatologico','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/sellado_bromatologico_9.jpg','2025-10-14 09:51:26'),(11,10,'dni_frente','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/dni_frente_10.jpg','2025-10-14 13:42:57'),(12,10,'dni_dorso','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/dni_dorso_10.jpg','2025-10-14 13:42:57'),(13,10,'carnet_frente','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/carnet_frente_10.jpg','2025-10-14 13:42:57'),(14,10,'carnet_dorso','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/carnet_dorso_10.jpg','2025-10-14 13:42:57'),(15,10,'cert_salud','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/cert_salud_10.jpg','2025-10-14 13:42:57'),(16,10,'foto_vehiculo','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/foto_vehiculo_10.jpg','2025-10-14 13:42:57'),(17,10,'cedula_verde','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/cedula_verde_10.jpg','2025-10-14 13:42:57'),(18,10,'seguro_vehiculo','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/seguro_vehiculo_10.jpg','2025-10-14 13:42:58'),(19,10,'vto_vehiculo','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/vto_vehiculo_10.jpg','2025-10-14 13:42:58'),(20,10,'sellado_bromatologico','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/sellado_bromatologico_10.jpg','2025-10-14 13:42:58'),(21,11,'dni_frente','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/dni_frente_11.jpg','2025-10-14 13:52:57'),(22,11,'dni_dorso','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/dni_dorso_11.jpg','2025-10-14 13:52:57'),(23,11,'carnet_frente','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/carnet_frente_11.jpg','2025-10-14 13:52:57'),(24,11,'carnet_dorso','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/carnet_dorso_11.jpg','2025-10-14 13:52:57'),(25,11,'cert_salud','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/cert_salud_11.jpg','2025-10-14 13:52:57'),(26,11,'foto_vehiculo','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/foto_vehiculo_11.jpg','2025-10-14 13:52:57'),(27,11,'cedula_verde','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/cedula_verde_11.jpg','2025-10-14 13:52:57'),(28,11,'seguro_vehiculo','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/seguro_vehiculo_11.jpg','2025-10-14 13:52:57'),(29,11,'vto_vehiculo','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/vto_vehiculo_11.jpg','2025-10-14 13:52:57'),(30,11,'sellado_bromatologico','F:/Proyecto CDV/CDV 12-10/backend/uploads/documentos_transporte/sellado_bromatologico_11.jpg','2025-10-14 13:52:57'),(31,12,'cert_salud','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_transporte/cert_salud_12.png','2025-10-28 14:01:37'),(32,12,'foto_vehiculo','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_transporte/foto_vehiculo_12.png','2025-10-28 14:01:37'),(33,12,'cedula_verde','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_transporte/cedula_verde_12.png','2025-10-28 14:01:37'),(34,12,'seguro_vehiculo','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_transporte/seguro_vehiculo_12.png','2025-10-28 14:01:37'),(35,12,'vto_vehiculo','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_transporte/vto_vehiculo_12.png','2025-10-28 14:01:37'),(36,12,'sellado_bromatologico','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_transporte/sellado_bromatologico_12.png','2025-10-28 14:01:37'),(37,12,'cert_salud','uploads/documentos_transporte/cert_salud_12_R1.png','2025-10-28 14:04:51'),(38,12,'foto_vehiculo','uploads/documentos_transporte/foto_vehiculo_12_R2.png','2025-10-28 14:05:29'),(39,12,'seguro_vehiculo','uploads/documentos_transporte/seguro_vehiculo_12_R3.png','2025-10-28 14:05:46'),(40,13,'cert_salud','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_transporte/cert_salud_13.png','2025-10-28 20:16:45'),(41,13,'foto_vehiculo','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_transporte/foto_vehiculo_13.png','2025-10-28 20:16:45'),(42,13,'cedula_verde','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_transporte/cedula_verde_13.png','2025-10-28 20:16:45'),(43,13,'seguro_vehiculo','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_transporte/seguro_vehiculo_13.png','2025-10-28 20:16:45'),(44,13,'vto_vehiculo','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_transporte/vto_vehiculo_13.png','2025-10-28 20:16:45'),(45,13,'sellado_bromatologico','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_transporte/sellado_bromatologico_13.png','2025-10-28 20:16:45'),(46,14,'cert_salud','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_transporte/cert_salud_14.png','2025-10-28 20:23:00'),(47,14,'foto_vehiculo','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_transporte/foto_vehiculo_14.png','2025-10-28 20:23:00'),(48,14,'cedula_verde','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_transporte/cedula_verde_14.png','2025-10-28 20:23:00'),(49,14,'seguro_vehiculo','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_transporte/seguro_vehiculo_14.png','2025-10-28 20:23:00'),(50,14,'vto_vehiculo','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_transporte/vto_vehiculo_14.png','2025-10-28 20:23:00'),(51,14,'sellado_bromatologico','C:/Users/facun/OneDrive/Desktop/CDV 15-10nuevo/CDV 15-10/CDV 15-10/backend/uploads/documentos_transporte/sellado_bromatologico_14.png','2025-10-28 20:23:00'),(52,13,'cedula_verde','uploads/documentos_transporte/cedula_verde_13_R1.png','2025-10-28 20:24:52');
/*!40000 ALTER TABLE `documentacion_transporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleado`
--

DROP TABLE IF EXISTS `empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleado` (
  `id_empleado` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `dni` int DEFAULT NULL,
  `domicilio` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `area` varchar(100) DEFAULT NULL,
  `contraseña` varchar(255) DEFAULT NULL,
  `correo_electronico` varchar(100) DEFAULT NULL,
  `rol` enum('administrador','administrativo','inspector') NOT NULL,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_empleado`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleado`
--

LOCK TABLES `empleado` WRITE;
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
INSERT INTO `empleado` VALUES (21,'Administrador1','Prueba1',44333441,'Calle 121','3851234531','Bromatología','$2b$10$95NvSiZuBtJaLBZ2uCJYZewe/72R6NBsD9lpUqf2H8xbvIUVZYXKm','admin@cdv.gob.ar','administrador',1),(22,'Administrativo','Prueba2',NULL,'Calle 456','385456789','bromatologia','$2b$10$N2caUDMdUEVgzSJQy4sEQuXM8CQtBhRaT2qsErp39xnRBvz6fPRBC','empleado@cdv.gob.ar','administrativo',1),(23,'Inspector','Prueba3',4444444,'Calle 789','385789123','Técnica','$2b$10$1yDckc3vKUXm.FfYDV4Yd.8FRC.HCe6ju0SGDa/nRZNYHYhmebF1G','inspector@cdv.gob.ar','inspector',1),(24,'Carlitos','Tevez',23244555,'Calle Solis','3856788777','Bromatología','$2b$10$lHjg3S4dZzTh3QnjtfQsq.26.KeeW17A4I05nb6Z20WIIOghTzZtq','carlos@gmail.com','administrativo',1),(25,'Carlos','Espinoza',12345678,'Calle Magallanes 23','3855443210','Bromatología','$2b$10$lMgFsqC7KKgrIAp8ItyKB.OVTd4nGIXPVfytZ4/GWjISsh0Asizu.','carlosesp@gmail.com','administrativo',1),(26,'Marcos','Vizoso',15098466,'Los Andes 2342 ','3854669045','Bromatología','$2b$10$HSU03Mpa4NrbXDzczR/YsOez9XHNuPv6i2T..9klI5NZeXedLSMUy','marcosvizoso233@yahoo.com','administrativo',1),(27,'Daniel','Campos',32432555,'Av. Belgrano 1899','3856788000','Bromatología','$2b$10$y4jFnvtihUKJeWu2znGj1elvffQ8bNhu.WE9oQXK2Ra/VdWa6evzq','camposdaniel@gmail.com','inspector',1),(28,'Nuncio','Soria',11111111,'Casa de Nuncio','3232435443','Bromatología','$2b$10$HDbqDxTrN9o62gkb4U/fFOfjLxcHHkOev58GNTrcS0MXDNSVL6j8O','nuncio@gmail.com','inspector',1),(30,'Sol','Solis',57849385,'Las Heras 23','3856948503','Bromatología','$2b$10$c9krmMe379vI02gQIepk3OU1QQ6E5kR1hvv/UK4yUHdW8fZBE2kEa','sol@gmail.com','administrativo',1),(31,'Cielo','Azul',93849309,'Rio Tercero 23','4837495738','Bromatología','$2b$10$HwwJMuPdm5uiGcz7sydqf.jTcSaC8a1qWTXcSB0FoDDNI9urs68gq','cielo@gmail.com','administrativo',1),(32,'sebastian','gerez',32542078,'avellaneda 1156','3855851734','Bromatología','$2b$10$qknQI0U9DdNhHlHNzwPMweETIMKy0qjgV6907428rnNDNRvBocXwW','sebas.gerez.86@gmail.com','administrativo',1),(33,'Sebastiani','Gerezzi',49205244,'Solololo 244','5940385244','Técnica','$2b$10$HcoVbxO7G2pialBOM6Mq/uZvfgTi41lXiMdhNY0S9AXm7LRjIbp8.','sebastiangerez4@gmail.com','inspector',1),(34,'PRUEBA3','PRUEBA3',44888999,'Mza D Lote 12 B Santa Lucia','3854444777','Sonido','$2b$10$bqwvAOQubGLLvtOmCm6F6.kZQfVgTkx5GeUvaa4uepc4XTm1I1VJ6','prueba333@gmail.com','inspector',1),(35,'Alejandro','Sanz',55444555,'Si','3854444714','Técnica','$2b$10$tC1iLoNG2QcijnT9/PhlGOsgD.7iIGw47.eUPHSD5V.M4t.fgh662','alejandrosanz@gmail.com','administrativo',1);
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `infraccion`
--

DROP TABLE IF EXISTS `infraccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infraccion` (
  `id_infraccion` int NOT NULL AUTO_INCREMENT,
  `motivo` varchar(100) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `monto` double DEFAULT NULL,
  `observacion` varchar(200) DEFAULT NULL,
  `id_comercio` int DEFAULT NULL,
  `id_transporte` int DEFAULT NULL,
  PRIMARY KEY (`id_infraccion`),
  KEY `id_vehiculo` (`id_transporte`),
  KEY `id_comercio` (`id_comercio`),
  CONSTRAINT `infraccion_ibfk_1` FOREIGN KEY (`id_transporte`) REFERENCES `transporte` (`id_transporte`),
  CONSTRAINT `infraccion_ibfk_2` FOREIGN KEY (`id_comercio`) REFERENCES `comercio` (`id_comercio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infraccion`
--

LOCK TABLES `infraccion` WRITE;
/*!40000 ALTER TABLE `infraccion` DISABLE KEYS */;
/*!40000 ALTER TABLE `infraccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notificacion`
--

DROP TABLE IF EXISTS `notificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificacion` (
  `id_notificacion` int NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `mensaje` text,
  `id_procedimiento` int DEFAULT NULL,
  `id_infraccion` int DEFAULT NULL,
  `id_tramite` int DEFAULT NULL,
  `id_empleado` int DEFAULT NULL,
  `id_razon_social` int DEFAULT NULL,
  `id_ciudadano` int DEFAULT NULL,
  PRIMARY KEY (`id_notificacion`),
  KEY `id_procedimiento` (`id_procedimiento`),
  KEY `id_infraccion` (`id_infraccion`),
  KEY `id_tramite` (`id_tramite`),
  KEY `id_empleado` (`id_empleado`),
  KEY `id_razon_social` (`id_razon_social`),
  KEY `id_ciudadano` (`id_ciudadano`),
  CONSTRAINT `notificacion_ibfk_1` FOREIGN KEY (`id_procedimiento`) REFERENCES `procedimiento` (`id_procedimiento`),
  CONSTRAINT `notificacion_ibfk_2` FOREIGN KEY (`id_infraccion`) REFERENCES `infraccion` (`id_infraccion`),
  CONSTRAINT `notificacion_ibfk_3` FOREIGN KEY (`id_tramite`) REFERENCES `tramite` (`id_tramite`),
  CONSTRAINT `notificacion_ibfk_4` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`),
  CONSTRAINT `notificacion_ibfk_5` FOREIGN KEY (`id_razon_social`) REFERENCES `razon_social` (`id_razon_social`),
  CONSTRAINT `notificacion_ibfk_6` FOREIGN KEY (`id_ciudadano`) REFERENCES `ciudadano` (`id_ciudadano`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificacion`
--

LOCK TABLES `notificacion` WRITE;
/*!40000 ALTER TABLE `notificacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `notificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `procedimiento`
--

DROP TABLE IF EXISTS `procedimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `procedimiento` (
  `id_procedimiento` int NOT NULL AUTO_INCREMENT,
  `tipo_procedimiento` varchar(50) DEFAULT NULL,
  `fecha_procedimiento` date DEFAULT NULL,
  `resultado` varchar(20) DEFAULT NULL,
  `observacion` varchar(100) DEFAULT NULL,
  `documentacion` varchar(255) DEFAULT NULL,
  `fotos` varchar(255) DEFAULT NULL,
  `id_empleado` int DEFAULT NULL,
  `id_inspector` int NOT NULL,
  `id_comercio` int DEFAULT NULL,
  `id_transporte` int DEFAULT NULL,
  PRIMARY KEY (`id_procedimiento`),
  KEY `id_empleado` (`id_empleado`),
  KEY `id_inspector` (`id_inspector`),
  KEY `id_comercio` (`id_comercio`),
  KEY `id_vehiculo` (`id_transporte`),
  CONSTRAINT `procedimiento_ibfk_1` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`),
  CONSTRAINT `procedimiento_ibfk_2` FOREIGN KEY (`id_inspector`) REFERENCES `empleado` (`id_empleado`),
  CONSTRAINT `procedimiento_ibfk_3` FOREIGN KEY (`id_comercio`) REFERENCES `comercio` (`id_comercio`),
  CONSTRAINT `procedimiento_ibfk_4` FOREIGN KEY (`id_transporte`) REFERENCES `transporte` (`id_transporte`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procedimiento`
--

LOCK TABLES `procedimiento` WRITE;
/*!40000 ALTER TABLE `procedimiento` DISABLE KEYS */;
INSERT INTO `procedimiento` VALUES (1,'Inspección','2025-07-09','Observado','Escombros.','Papeles',NULL,NULL,23,16,NULL),(2,'Inspección','2025-07-09','Observado','Suciedad','En tramites','1752113526485-583954897-Screenshot 2025-02-08 182802.png',NULL,23,16,NULL),(3,'Verificación','2025-06-05','Rechazado','','','1752130804348-174804863-Screenshot 2025-02-12 212005.png',NULL,23,16,NULL),(4,'Inspección','2025-04-13','Observado','Prueba','Prueba','1752765886734-233422594-Calidad de Vida.png',NULL,23,16,NULL),(5,'Inspección','2025-07-13','Aprobado','Prueba','Prueba','1752767912824-791929560-Calidad de Vida.png',NULL,23,16,NULL),(6,'Inspección','2025-07-10','Observado','Prueba','Prueba','1752768530404-390085636-Calidad de Vida.png',NULL,23,16,NULL),(7,'Inspección','2025-07-20','Observado','Prueba','Prueba','1752768572652-197831942-Calidad de Vida.png',NULL,23,16,NULL),(8,'Inspección','2025-07-17','Aprobado','Prueba','Prueba','1752769395187-905328359-Calidad de Vida.png',NULL,23,16,NULL),(9,'Fiscalización','2025-07-17','Aprobado','Aprobado','Aprobado','1752769799525-561370698-Calidad de Vida.png',NULL,23,16,NULL),(10,'Verificación','2025-07-17','Observado','Prueba mas','Prueba','',NULL,23,16,NULL),(11,'Verificación','2025-07-10','Observado','Prueba 2 archivos ong','Prueba 2 archivos png','1752776053338-858926632-Calidad de Vida.png,1752776053338-261429319-diagramaumlhotel.png',NULL,23,16,NULL),(12,'Control','2025-07-17','Aprobado','probar 3 archivos','probar 3 archivos','1752777352069-500614763-Cat03.jpg,1752777352070-644013613-pngtree-refreshing-iced-matcha-latte-in-plastic-cup-png-image_16508314.png,1752777352071-587433898-pngtree-a-large-circular-piece-of-wood-wooden-trunk-png-image_16440252.png',NULL,23,16,NULL),(13,'Fiscalización','2025-07-17','Rechazado','probar pdf jpg y png','probar pdf jpg y png','1752777420156-249551899-pdfprueba1.pdf,1752777420156-792838858-imagess.jpg,1752777420156-959513665-linux.jpg',NULL,23,16,NULL),(14,'Fiscalización','2025-07-17','Observado','Pruebas','Pruebas','1752777558599-120743863-photo-1666389785207-79fd9a364761.jpg,1752777558609-160212524-Cat03.jpg',NULL,23,16,NULL),(15,'Control','2025-07-01','Observado','le falta de todo al pobre','nada','',NULL,23,16,NULL),(16,'inspeccion-ocular','2025-10-22','Aprobado','PROB2','PROB2','1761133110522-298819688-Screenshot 2025-02-08 182802.png',NULL,23,150,NULL),(17,'Inspección','2025-10-23','Aprobado','prueba carga archivos','PRUEBA','1761222057887-7174178-Screenshot 2025-02-08 182802.png',NULL,23,13,NULL),(18,'Inspección','2025-10-23','Aprobado','-------','PRUEBA2',NULL,NULL,23,13,NULL),(19,'Inspección','2025-10-23','Aprobado','-----','---','proc-1761224110963-535554677-Screenshot 2025-02-08 182802.png',NULL,23,13,NULL),(20,'inspeccion-ocular','2025-10-28','Aprobado','-','-','proc-1761661851779-743422321-Screenshot 2025-02-08 182802.png',NULL,23,151,NULL),(21,'inspeccion-ocular','2025-10-28','Aprobado','-','-',NULL,NULL,23,13,NULL),(22,'Inspección ocular','2025-10-28','Aprobado','-','-','proc-1761663342141-810503368-Screenshot 2025-02-08 182802.png',NULL,23,16,NULL),(23,'Inspección ocular','2025-10-28','Aprobado','---','---','proc-1761663504650-425566717-Screenshot 2025-02-08 182802.png',NULL,23,16,NULL),(24,'Inspección ocular','2025-10-28','Aprobado','----','----','proc-1761663577393-528509539-Screenshot 2025-02-08 182802.png',NULL,23,9,NULL),(25,'Inspeccion-ocular','2025-10-28','Aprobado','-----','-----','proc-1761663625548-125512940-Screenshot 2025-02-08 182802.png',NULL,23,145,NULL),(26,'inspeccion-ocular','2025-10-28','Aprobado','---------------','------------------------','proc-1761663696431-166220806-Screenshot 2025-02-08 182802.png',NULL,23,11,NULL),(27,'inspeccion-ocular','2025-10-28','Aprobado','---','---','proc-1761681532380-348564899-Screenshot 2025-02-08 182802.png',NULL,23,9,NULL),(28,'inspeccion-ocular','2025-10-28','Aprobado','------','----','proc-1761682211659-947915260-Screenshot 2025-02-08 182802.png',NULL,23,152,NULL),(29,'inspeccion-ocular','2025-10-28','Aprobado','eeee','ee',NULL,NULL,23,145,NULL);
/*!40000 ALTER TABLE `procedimiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `razon_social`
--

DROP TABLE IF EXISTS `razon_social`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `razon_social` (
  `id_razon_social` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `apellido` varchar(100) DEFAULT NULL,
  `cuit` varchar(20) NOT NULL,
  `domicilio` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo_electronico` varchar(100) DEFAULT NULL,
  `dni` varchar(20) DEFAULT NULL,
  `razon_social` varchar(255) DEFAULT NULL,
  `persona_fisica` tinyint(1) NOT NULL COMMENT '1=Persona física (dueño), 0=Persona jurídica (empresa con representante)',
  `vinculo` enum('dueño','representante') DEFAULT 'dueño',
  PRIMARY KEY (`id_razon_social`),
  UNIQUE KEY `cuit` (`cuit`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `razon_social`
--

LOCK TABLES `razon_social` WRITE;
/*!40000 ALTER TABLE `razon_social` DISABLE KEYS */;
INSERT INTO `razon_social` VALUES (7,'Santiago','Diaz','23-23444543-9','Viamonte 332','3854334234','santiago@gmail.com','23444543','Santiago Diaz Achaval',1,'dueño'),(8,'Nuncio','Soria','23-11222333-9','Libertad 332','4332244','nuncio@gmail.com','11222333','Soria SA',1,'dueño'),(10,'Sebastian','Gerez','23-22099332-9','Caseros 23','3854444356','sebastiangerez@gmail.com','22099332','Gerez SRL',1,'dueño'),(12,'Daniel','Soria','23-33333445-7','Rivadavia 567','4254423','soriadaniel@gmail.com','33333445','Soria Daniel',1,'dueño'),(13,'Lucas','Sanchez','23-34333222-6','Calle Junin S/N','3856788788','sanchezl@gmail.com','34333222','TSanchez Lucas',1,'dueño'),(32,'Santiago','Ibañez','23-22111399-9','Calle Europa 22','3854677584','santy@gmail.com','22111399','Santiago Ibañez',1,'dueño'),(33,'Prueba','DespuesExpo','23453425','wertewrtrewt','2345244344','asd@asd.asd','33333377','asdfsdf',1,'dueño'),(34,'Virginia','Soria','27-55327328-2','moreno 1595','385-4212223','picky@gmail.com','55327328','La Jodida',0,'dueño'),(35,'Nuncio','Paglioni','20-28037640-2','caseros 830','385-385690','nuncito3@hotmail.com','28037640','Los Tacos',1,'dueño'),(36,'RAMON','VALDEZ','27-55444777-3','Riavadavia 340 santa Fe','085-5666888','monchi@gmail.com','43666777','MONCHITO',0,'representante'),(37,'Marcos','Sosa','28-23444222-4','Colon Norte 8500','385-3856777888','sosam@gmail.com','28779886','Maravillas',1,'dueño'),(38,'Alejandra','Boix','20-24447773-2','Riavadavia 380 Santa cruz','085-6111222','alesita@gmail.com','29384449','Tambo s.rl.',0,'representante'),(39,'Gerardo','Gomez','23-38555666-1','morenonorte 50','385-3855677889','gerago@gmail.com','38555666','Loma azul',1,'dueño'),(40,'Carlos','Soria','27-44555666-2','los flores 540','385-3856778899','carlitos@gmail.com','44555666','Carancho',1,'dueño'),(41,'Jaqueline','Coria','27-12777888-1','Loma Ancha 725','385-3855998877','gordilla@gmail.com','12777888','Las deigord',1,'dueño'),(42,'Honorio','Solarium','30-45666777-2','castelli 2350 CP 4000 Cordoba','385-4223344','casimiro@gmail.com','34111222','Las chismosas s.a.',0,'representante'),(43,'Pedro','Ruedas','27-54111222-1','los telares 2400','385-3856778899','carlitos@gmail.com','54111222','Carancho',1,'dueño'),(44,'Pedro','Picapiedras','30-32111999-0','los flores 1500','385-3856778899','carlitos@gmail.com','32111999','Yabadaba-du',1,'dueño'),(46,'Nuncio','Soria','27-25777888-2','lomas del golf','385-3854777666','gordilla@gmail.com','25777888','Carancho',1,'dueño'),(47,'Sofia','Cuerdas','27-48111222-1','Magallanes 233','385-3856111000','sofita@gmail.com','48111222','Las urrejolas',1,'dueño'),(48,'Luis','Zarate','23-88555222-9','Zarate 444','3854-3854164777','luiszarate@gmail.com','88555222','Luis zarate',1,'dueño'),(49,'Jorge','Brito','23-11111000-9','Jujuy 500','385-3854658978','jorgebrito@gmail.com','11111000','Brito sa',1,'dueño');
/*!40000 ALTER TABLE `razon_social` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `titular_ambulante`
--

DROP TABLE IF EXISTS `titular_ambulante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `titular_ambulante` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `dni` varchar(20) NOT NULL,
  `domicilio` varchar(100) DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `correo_electronico` varchar(100) DEFAULT NULL,
  `tipo` varchar(20) NOT NULL DEFAULT 'ambulante',
  PRIMARY KEY (`id`),
  UNIQUE KEY `dni` (`dni`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `titular_ambulante`
--

LOCK TABLES `titular_ambulante` WRITE;
/*!40000 ALTER TABLE `titular_ambulante` DISABLE KEYS */;
INSERT INTO `titular_ambulante` VALUES (1,'Juan','Gómez','30123456','Barrio Belgrano, Mza 12 Lote 3','3854123456','juan.gomez@example.com','ambulante'),(2,'Lucía','Pérez','29876543','Calle 9 de Julio 456','3854765432','lucia.perez@example.com','ambulante'),(3,'Carlos','Sosa','31234567','Av. Roca 123','3854234567','carlos.sosa@example.com','ambulante'),(4,'Benicio','Soria','49797866','mza 42 lote 9 B° siglo 19','385-4313233','beny@gmail.com','ambulante'),(5,'Rogel','Sanchez','33444555','Cancinos 8000','385-3855446677','loquillo@gmail.com','ambulante'),(6,'Nuncio','Soria','55777888','los flores 1500','385-3856778899','loquillo@gmail.com','transporte'),(7,'Carolina','Castro','22000555','lomas del golf','385-3856888555','colocarla@gmail.com','transporte'),(8,'Roberto','Darin','21999333','las candelarias 325','385-3854777666','eternauta@gmail.com','transporte'),(9,'Roman','Riquelme','24666777','Las Talitas 825','385-3856111000','soymalo@gmail.com','ambulante'),(10,'Carito','Llanos','45111222','los telares 2400','385-3856111000','lacarito@gmail.com','ambulante'),(11,'Kari','Miley','12444666','El tres porciento 450','385-3854777666','cari@gmail.com','ambulante'),(12,'Lorena','Coria','32777888','lomas del golf','385-3856888555','lalore@gmail.com','ambulante'),(13,'Casimiro','Puentes','26111222','Loma Ancha 725','385-3856778899','casiveo@gmail.com','ambulante'),(14,'Renato','Puertas','43111777','los flores 540','385-3855998877','eternauta@gmail.com','ambulante'),(15,'Coco','Basile','12333555','Los Comandos','385-3856111000','colocarla@gmail.com','ambulante'),(16,'Lucho','Gramajo','26333111','Las Toronjas','385-3854777666','lacarito@gmail.com','ambulante'),(17,'Moni','Argento','33555222','Cancinos 8000','385-3856778899','racing@gmail.com','ambulante'),(19,'Nuncio','Kent','51777888','Cancinos 8000','385-3856888555','gordilla@gmail.com','ambulante'),(20,'Ramon','Ordoñez','44111222','California 25','385-3855998877','colocarla@gmail.com','ambulante'),(21,'Benicio','Soria','33222111','los flores 1500','385-3855446677','colocarla@gmail.com','transporte'),(22,'Fernando','Casas','48222333','Somalia 2450','385-3856888555','ferito@gmail.com','transporte');
/*!40000 ALTER TABLE `titular_ambulante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tramite`
--

DROP TABLE IF EXISTS `tramite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tramite` (
  `id_tramite` int NOT NULL AUTO_INCREMENT,
  `observacion` text,
  `estado` varchar(50) DEFAULT NULL,
  `fecha_solicitud` date DEFAULT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `id_comercio` int DEFAULT NULL,
  `id_ciudadano` int DEFAULT NULL,
  `id_empleado` int DEFAULT NULL,
  `id_razon_social` int DEFAULT NULL,
  PRIMARY KEY (`id_tramite`),
  KEY `id_comercio` (`id_comercio`),
  KEY `id_ciudadano` (`id_ciudadano`),
  KEY `id_empleado` (`id_empleado`),
  KEY `id_razon_social` (`id_razon_social`),
  CONSTRAINT `tramite_ibfk_1` FOREIGN KEY (`id_comercio`) REFERENCES `comercio` (`id_comercio`),
  CONSTRAINT `tramite_ibfk_2` FOREIGN KEY (`id_ciudadano`) REFERENCES `ciudadano` (`id_ciudadano`),
  CONSTRAINT `tramite_ibfk_3` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`),
  CONSTRAINT `tramite_ibfk_4` FOREIGN KEY (`id_razon_social`) REFERENCES `razon_social` (`id_razon_social`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tramite`
--

LOCK TABLES `tramite` WRITE;
/*!40000 ALTER TABLE `tramite` DISABLE KEYS */;
/*!40000 ALTER TABLE `tramite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transporte`
--

DROP TABLE IF EXISTS `transporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transporte` (
  `id_transporte` int NOT NULL AUTO_INCREMENT,
  `id_titular_ambulante` int NOT NULL,
  `nombre_chofer` varchar(100) DEFAULT NULL,
  `dni_chofer` varchar(20) DEFAULT NULL,
  `carnet_chofer` varchar(50) DEFAULT NULL,
  `telefono_chofer` varchar(30) DEFAULT NULL,
  `tipo_vehiculo` varchar(50) NOT NULL,
  `tipo_alimento` varchar(100) NOT NULL,
  `patente` varchar(10) NOT NULL,
  `vto_fecha` date NOT NULL,
  `seguro_fecha` date NOT NULL,
  `monto_sellado` decimal(10,2) NOT NULL,
  `meses_adelantados` int NOT NULL DEFAULT '1',
  `monto_total` decimal(10,2) NOT NULL,
  `ruta_qr` varchar(255) DEFAULT NULL,
  `fecha_habilitacion` date NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `numero_vehiculo` int DEFAULT '1',
  `numero_renovacion` int DEFAULT NULL,
  `id_empleado_registro` int DEFAULT NULL,
  PRIMARY KEY (`id_transporte`),
  KEY `id_titular_ambulante` (`id_titular_ambulante`),
  CONSTRAINT `transporte_ibfk_1` FOREIGN KEY (`id_titular_ambulante`) REFERENCES `titular_ambulante` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transporte`
--

LOCK TABLES `transporte` WRITE;
/*!40000 ALTER TABLE `transporte` DISABLE KEYS */;
INSERT INTO `transporte` VALUES (3,22,NULL,NULL,NULL,NULL,'camion350','frutas_verduras','AB123CD','2026-02-13','2026-03-21',5700.00,2,11400.00,'/uploads/qr/3.png','2025-10-28','2025-12-28',1,1,1,21),(4,22,'Lalo Mir','12000111','12000111','385-6888999','camion350','frutas_verduras','AB123CD','2026-02-13','2026-03-21',5700.00,1,5700.00,'/uploads/qr/4.png','2025-10-13','2025-11-13',1,1,NULL,NULL),(5,6,'Pedro Galvan','12000111','12000111','385-6888999','superior','congelados','AB123CD','2026-01-24','2026-03-28',11300.00,1,11300.00,'/uploads/qr/5.png','2025-10-13','2025-11-13',1,1,NULL,NULL),(6,6,'Pedro Galvan','12000111','12000111','385-6888999','superior','congelados','AB123CD','2026-01-24','2026-03-28',11300.00,1,11300.00,'/uploads/qr/6.png','2025-10-13','2025-11-13',1,1,NULL,NULL),(7,7,'Soria Nuncio','29555333','29555333','385-6888999','camion350','frutas_verduras','AB123CD','2026-04-25','2026-02-20',5700.00,3,17100.00,'/uploads/qr/7.png','2025-10-13','2026-01-13',1,1,NULL,NULL),(8,8,'Carlos Mera','21222333','21222333','385-6888999','furgon','secos','AB123CD','2026-01-10','2026-02-20',8500.00,1,8500.00,'/uploads/qr/transporte_8.png','2025-10-13','2025-11-13',1,1,NULL,NULL),(9,6,'Rolo Puentes','13.444.555','13444555','385-6888999','camioneta','hielo','AB123CD','2026-01-23','2026-03-27',2800.00,3,8400.00,'/uploads/qr/transporte_9.png','2025-10-14','2026-01-14',1,1,NULL,NULL),(10,6,'Coco Bazques','99.000.000','99000000','385-6888999','camioneta','secos','AB123CD','2026-03-22','2026-03-12',2800.00,5,14000.00,'/uploads/qr/transporte_10.png','2025-10-14','2026-03-14',1,4,NULL,NULL),(11,6,'Lolo Corazon','13.111.222','13111222','385-6888999','camion350','frutas_verduras','AB123CD','2026-01-25','2026-02-22',5700.00,3,17100.00,'/uploads/qr/transporte_11.png','2025-10-14','2026-01-14',1,5,NULL,NULL),(12,1,NULL,NULL,NULL,NULL,'camioneta','hielo','JJ222JJ','2026-03-14','2026-02-27',2800.00,1,2800.00,'/uploads/qr/transporte_12.png','2025-10-28','2025-11-28',1,1,3,21),(13,1,NULL,NULL,NULL,NULL,'furgon','regionales','FF222EE','2027-02-13','2028-02-13',8500.00,1,8500.00,'/uploads/qr/transporte_13.png','2025-10-28','2025-11-28',1,2,1,21),(14,1,NULL,NULL,NULL,NULL,'camion350','hielo','KK222LL','2026-05-22','2026-05-22',5700.00,4,22800.00,'/uploads/qr/transporte_14.png','2025-10-28','2026-02-28',1,3,0,21);
/*!40000 ALTER TABLE `transporte` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-25 19:11:54
