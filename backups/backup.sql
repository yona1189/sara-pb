-- MySQL dump 10.13  Distrib 8.4.4, for Win64 (x86_64)
--
-- Host: localhost    Database: sara
-- ------------------------------------------------------
-- Server version	8.4.4

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

--
-- Table structure for table `ajustes_imageninicio`
--

DROP TABLE IF EXISTS `ajustes_imageninicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ajustes_imageninicio` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `imagen` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ajustes_imageninicio`
--

LOCK TABLES `ajustes_imageninicio` WRITE;
/*!40000 ALTER TABLE `ajustes_imageninicio` DISABLE KEYS */;
INSERT INTO `ajustes_imageninicio` VALUES (1,'empresa/GA11-210201501-AA2-EV04.jpg');
/*!40000 ALTER TABLE `ajustes_imageninicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alertas`
--

DROP TABLE IF EXISTS `alertas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alertas` (
  `id_alerta` int NOT NULL,
  `tipo_alerta` varchar(25) NOT NULL,
  `mensaje` varchar(255) NOT NULL,
  `fecha_creacion_alerta` datetime NOT NULL,
  `fecha_inicio_alerta` datetime NOT NULL,
  `fecha_fin_alerta` datetime NOT NULL,
  `estado` varchar(15) NOT NULL,
  `id_usuario` int NOT NULL,
  PRIMARY KEY (`id_alerta`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `alertas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alertas`
--

LOCK TABLES `alertas` WRITE;
/*!40000 ALTER TABLE `alertas` DISABLE KEYS */;
/*!40000 ALTER TABLE `alertas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articulos`
--

DROP TABLE IF EXISTS `articulos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articulos` (
  `id_articulo` int NOT NULL AUTO_INCREMENT,
  `articulo` varchar(45) NOT NULL,
  `plu_articulo` smallint DEFAULT NULL,
  `codigo_de_barras` varchar(20) NOT NULL,
  `estado` varchar(15) DEFAULT NULL,
  `presentacion` varchar(20) DEFAULT NULL,
  `tipo_de_producto` varchar(20) DEFAULT NULL,
  `linea` varchar(15) DEFAULT NULL,
  `sublinea` varchar(15) DEFAULT NULL,
  `stock` double NOT NULL,
  `precio_venta` double DEFAULT NULL,
  `stock_minimo` double DEFAULT NULL,
  `stock_maximo` double DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL,
  `id_empresa` int NOT NULL,
  PRIMARY KEY (`id_articulo`),
  UNIQUE KEY `codigo_de_barras` (`codigo_de_barras`),
  UNIQUE KEY `plu_articulo` (`plu_articulo`),
  KEY `id_empresa` (`id_empresa`),
  CONSTRAINT `articulos_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articulos`
--

LOCK TABLES `articulos` WRITE;
/*!40000 ALTER TABLE `articulos` DISABLE KEYS */;
/*!40000 ALTER TABLE `articulos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add cliente',6,'add_cliente'),(22,'Can change cliente',6,'change_cliente'),(23,'Can delete cliente',6,'delete_cliente'),(24,'Can view cliente',6,'view_cliente'),(25,'Can add user',7,'add_usuariopersonalizado'),(26,'Can change user',7,'change_usuariopersonalizado'),(27,'Can delete user',7,'delete_usuariopersonalizado'),(28,'Can view user',7,'view_usuariopersonalizado'),(29,'Can add proveedor',8,'add_proveedor'),(30,'Can change proveedor',8,'change_proveedor'),(31,'Can delete proveedor',8,'delete_proveedor'),(32,'Can view proveedor',8,'view_proveedor'),(33,'Can add articulo',9,'add_articulo'),(34,'Can change articulo',9,'change_articulo'),(35,'Can delete articulo',9,'delete_articulo'),(36,'Can view articulo',9,'view_articulo'),(37,'Can add entrada factura',10,'add_entradafactura'),(38,'Can change entrada factura',10,'change_entradafactura'),(39,'Can delete entrada factura',10,'delete_entradafactura'),(40,'Can view entrada factura',10,'view_entradafactura'),(41,'Can add detalle entrada',11,'add_detalleentrada'),(42,'Can change detalle entrada',11,'change_detalleentrada'),(43,'Can delete detalle entrada',11,'delete_detalleentrada'),(44,'Can view detalle entrada',11,'view_detalleentrada'),(45,'Can add salida factura',12,'add_salidafactura'),(46,'Can change salida factura',12,'change_salidafactura'),(47,'Can delete salida factura',12,'delete_salidafactura'),(48,'Can view salida factura',12,'view_salidafactura'),(49,'Can add detalle salida',13,'add_detallesalida'),(50,'Can change detalle salida',13,'change_detallesalida'),(51,'Can delete detalle salida',13,'delete_detallesalida'),(52,'Can view detalle salida',13,'view_detallesalida'),(53,'Can add imagen inicio',14,'add_imageninicio'),(54,'Can change imagen inicio',14,'change_imageninicio'),(55,'Can delete imagen inicio',14,'delete_imageninicio'),(56,'Can view imagen inicio',14,'view_imageninicio');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(45) NOT NULL,
  `apellidos` varchar(45) NOT NULL,
  `identificacion` varchar(25) NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `whatsapp` varchar(20) DEFAULT NULL,
  `correo` varchar(45) DEFAULT NULL,
  `ciudad` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `pais` varchar(45) DEFAULT NULL,
  `estado` varchar(15) DEFAULT NULL,
  `fecha_resistro` datetime NOT NULL,
  `id_empresa` int NOT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `identificacion` (`identificacion`),
  UNIQUE KEY `correo` (`correo`),
  KEY `id_empresa` (`id_empresa`),
  CONSTRAINT `clientes_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes_cliente`
--

DROP TABLE IF EXISTS `clientes_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes_cliente` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombres` varchar(100) NOT NULL,
  `identificacion` varchar(20) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `email` varchar(254) NOT NULL,
  `placa` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identificacion` (`identificacion`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes_cliente`
--

LOCK TABLES `clientes_cliente` WRITE;
/*!40000 ALTER TABLE `clientes_cliente` DISABLE KEYS */;
INSERT INTO `clientes_cliente` VALUES (1,'Yonatan Martinez Grijalba','1086922464','3182251027','yona20mg@gmail.com','N/A'),(2,'Roxana','1085','3152554544','roux@mail.com','HTT-45P');
/*!40000 ALTER TABLE `clientes_cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuracion`
--

DROP TABLE IF EXISTS `configuracion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configuracion` (
  `id_configuracion` int NOT NULL AUTO_INCREMENT,
  `id_empresa` int NOT NULL,
  `id_usuario` int NOT NULL,
  `tipo_configuracion` varchar(25) NOT NULL,
  `valor_configuracion` varchar(255) NOT NULL,
  PRIMARY KEY (`id_configuracion`),
  KEY `id_empresa` (`id_empresa`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `configuracion_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `configuracion_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuracion`
--

LOCK TABLES `configuracion` WRITE;
/*!40000 ALTER TABLE `configuracion` DISABLE KEYS */;
/*!40000 ALTER TABLE `configuracion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `descuentos`
--

DROP TABLE IF EXISTS `descuentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `descuentos` (
  `id_descuento` int NOT NULL,
  `porcentaje_descuento` double NOT NULL,
  `fecha_inicio_descuento` datetime NOT NULL,
  `fecha_fin_descuento` datetime NOT NULL,
  `desde_cantidad` double NOT NULL,
  `hasta_cantidad` double NOT NULL,
  `id_articulo` int NOT NULL,
  `id_usuario` int NOT NULL,
  `id_empresa` int NOT NULL,
  `estado` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id_descuento`),
  KEY `id_articulo` (`id_articulo`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_empresa` (`id_empresa`),
  CONSTRAINT `descuentos_ibfk_1` FOREIGN KEY (`id_articulo`) REFERENCES `articulos` (`id_articulo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `descuentos_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `descuentos_ibfk_3` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `descuentos`
--

LOCK TABLES `descuentos` WRITE;
/*!40000 ALTER TABLE `descuentos` DISABLE KEYS */;
/*!40000 ALTER TABLE `descuentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_facturas_de_compra`
--

DROP TABLE IF EXISTS `detalle_facturas_de_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_facturas_de_compra` (
  `id_detalle_factura_compra` int NOT NULL AUTO_INCREMENT,
  `id_factura_compra` int NOT NULL,
  `id_articulo` int NOT NULL,
  `lote_articulo_compra` double DEFAULT NULL,
  `cantidad_cajas` double NOT NULL,
  `cantidad_unidades_caja` double NOT NULL,
  `valor_compra_caja` double NOT NULL,
  `valor_compra_unidad` double NOT NULL,
  `valor_venta_caja` double NOT NULL,
  `valor_venta_unidad` double NOT NULL,
  `impuesto` double DEFAULT NULL,
  `descuento` double DEFAULT NULL,
  `subtotal` double NOT NULL,
  `total` double NOT NULL,
  `unidades_restantes` double DEFAULT NULL,
  `Unidades_vendidas` double DEFAULT NULL,
  PRIMARY KEY (`id_detalle_factura_compra`),
  KEY `id_factura_compra` (`id_factura_compra`),
  KEY `id_articulo` (`id_articulo`),
  CONSTRAINT `detalle_facturas_de_compra_ibfk_1` FOREIGN KEY (`id_factura_compra`) REFERENCES `facturas_de_compra` (`id_factura_compra`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detalle_facturas_de_compra_ibfk_2` FOREIGN KEY (`id_articulo`) REFERENCES `articulos` (`id_articulo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_facturas_de_compra`
--

LOCK TABLES `detalle_facturas_de_compra` WRITE;
/*!40000 ALTER TABLE `detalle_facturas_de_compra` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_facturas_de_compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_facturas_de_venta`
--

DROP TABLE IF EXISTS `detalle_facturas_de_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_facturas_de_venta` (
  `id_detalle_factura_venta` int NOT NULL AUTO_INCREMENT,
  `id_factura_venta` int NOT NULL,
  `id_articulo` int NOT NULL,
  `cantidad` double NOT NULL,
  `valor_articulo` double NOT NULL,
  `impuesto_1` double DEFAULT NULL,
  `impuesto_2` double DEFAULT NULL,
  `subtotal` double NOT NULL,
  `total` double NOT NULL,
  PRIMARY KEY (`id_detalle_factura_venta`),
  KEY `id_articulo` (`id_articulo`),
  KEY `idx_detalle_facturas_venta` (`id_factura_venta`,`id_articulo`),
  CONSTRAINT `detalle_facturas_de_venta_ibfk_1` FOREIGN KEY (`id_factura_venta`) REFERENCES `facturas_de_venta` (`id_factura_venta`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detalle_facturas_de_venta_ibfk_2` FOREIGN KEY (`id_articulo`) REFERENCES `articulos` (`id_articulo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_facturas_de_venta`
--

LOCK TABLES `detalle_facturas_de_venta` WRITE;
/*!40000 ALTER TABLE `detalle_facturas_de_venta` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_facturas_de_venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deuda_cliente`
--

DROP TABLE IF EXISTS `deuda_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deuda_cliente` (
  `id_deuda_cliente` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `fecha_limite_pago` datetime NOT NULL,
  `valor_deuda` double NOT NULL,
  `saldo` double NOT NULL,
  `estado` varchar(15) NOT NULL,
  PRIMARY KEY (`id_deuda_cliente`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `deuda_cliente_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deuda_cliente`
--

LOCK TABLES `deuda_cliente` WRITE;
/*!40000 ALTER TABLE `deuda_cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `deuda_cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deuda_proveedor`
--

DROP TABLE IF EXISTS `deuda_proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deuda_proveedor` (
  `id_deuda_proveedor` int NOT NULL AUTO_INCREMENT,
  `id_proveedor` int NOT NULL,
  `fecha_limite_pago` datetime NOT NULL,
  `valor_deuda` double NOT NULL,
  `saldo` double NOT NULL,
  `estado` varchar(15) NOT NULL,
  PRIMARY KEY (`id_deuda_proveedor`),
  KEY `id_proveedor` (`id_proveedor`),
  CONSTRAINT `deuda_proveedor_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deuda_proveedor`
--

LOCK TABLES `deuda_proveedor` WRITE;
/*!40000 ALTER TABLE `deuda_proveedor` DISABLE KEYS */;
/*!40000 ALTER TABLE `deuda_proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_usuarios_` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_usuarios_` FOREIGN KEY (`user_id`) REFERENCES `usuarios_usuariopersonalizado` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(14,'ajustes','imageninicio'),(3,'auth','group'),(2,'auth','permission'),(6,'clientes','cliente'),(4,'contenttypes','contenttype'),(9,'inventarios','articulo'),(11,'inventarios','detalleentrada'),(13,'inventarios','detallesalida'),(10,'inventarios','entradafactura'),(12,'inventarios','salidafactura'),(8,'proveedores','proveedor'),(5,'sessions','session'),(7,'usuarios','usuariopersonalizado');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-07-23 01:42:07.250377'),(2,'contenttypes','0002_remove_content_type_name','2025-07-23 01:42:07.466805'),(3,'auth','0001_initial','2025-07-23 01:42:07.957940'),(4,'auth','0002_alter_permission_name_max_length','2025-07-23 01:42:08.151646'),(5,'auth','0003_alter_user_email_max_length','2025-07-23 01:42:08.174767'),(6,'auth','0004_alter_user_username_opts','2025-07-23 01:42:08.195587'),(7,'auth','0005_alter_user_last_login_null','2025-07-23 01:42:08.209976'),(8,'auth','0006_require_contenttypes_0002','2025-07-23 01:42:08.218590'),(9,'auth','0007_alter_validators_add_error_messages','2025-07-23 01:42:08.237076'),(10,'auth','0008_alter_user_username_max_length','2025-07-23 01:42:08.257572'),(11,'auth','0009_alter_user_last_name_max_length','2025-07-23 01:42:08.278563'),(12,'auth','0010_alter_group_name_max_length','2025-07-23 01:42:08.333343'),(13,'auth','0011_update_proxy_permissions','2025-07-23 01:42:08.353558'),(14,'auth','0012_alter_user_first_name_max_length','2025-07-23 01:42:08.378810'),(15,'usuarios','0001_initial','2025-07-23 01:42:08.987751'),(16,'admin','0001_initial','2025-07-23 01:42:09.248262'),(17,'admin','0002_logentry_remove_auto_add','2025-07-23 01:42:09.262357'),(18,'admin','0003_logentry_add_action_flag_choices','2025-07-23 01:42:09.285636'),(19,'ajustes','0001_initial','2025-07-23 01:42:09.340460'),(20,'clientes','0001_initial','2025-07-23 01:42:09.426277'),(21,'clientes','0002_remove_cliente_rol','2025-07-23 01:42:09.562646'),(22,'clientes','0003_cliente_placa','2025-07-23 01:42:09.720076'),(23,'inventarios','0001_initial','2025-07-23 01:42:09.792696'),(24,'inventarios','0002_rename_nombre_art_articulo_nombre_articulo','2025-07-23 01:42:09.827886'),(25,'inventarios','0003_rename_nombre_articulo_articulo_nombre_art','2025-07-23 01:42:09.864372'),(26,'inventarios','0004_alter_articulo_nombre_art_entradafactura_and_more','2025-07-23 01:42:10.318066'),(27,'inventarios','0005_alter_articulo_stock','2025-07-23 01:42:10.328406'),(28,'inventarios','0006_salidafactura_detallesalida','2025-07-23 01:42:10.778225'),(29,'inventarios','0007_rename_fecha_salidafactura_fecha_salida_and_more','2025-07-23 01:42:10.952568'),(30,'proveedores','0001_initial','2025-07-23 01:42:11.026272'),(31,'sessions','0001_initial','2025-07-23 01:42:11.107730'),(32,'usuarios','0002_remove_usuariopersonalizado_emai','2025-07-23 01:42:11.252115'),(33,'usuarios','0003_alter_usuariopersonalizado_documento_and_more','2025-07-23 01:42:11.709822'),(34,'usuarios','0004_alter_usuariopersonalizado_documento_and_more','2025-07-23 01:42:12.239505'),(35,'usuarios','0005_alter_usuariopersonalizado_documento','2025-07-23 01:42:12.325892'),(36,'usuarios','0006_alter_usuariopersonalizado_rol','2025-07-23 01:42:12.503345'),(37,'usuarios','0007_alter_usuariopersonalizado_rol','2025-07-23 01:42:12.521517'),(38,'usuarios','0008_usuariopersonalizado_tema','2025-07-23 01:42:12.737523');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0uzabs8fwc5708n0g2lzgzkq6l6xah2o','.eJxVjMsOwiAQRf-FtSGlZXi4dO83kGEYpGogKe3K-O_apAvd3nPOfYmA21rC1nkJcxJnocTpd4tID647SHestyap1XWZo9wVedAury3x83K4fwcFe_nWLuthoNHmyDYBE5lsHVijlQfyWiebFKCZsvIRM1gCjSNTdt5PE7IS7w_qyzgf:1ujrb7:2zTIoNSOe4IBB8Ozib_LSZv-UJg92QjhwamqTPATwHk','2025-08-21 03:47:21.364308'),('9q8irqlbyxj6e7v7s8gjqg3tygv3dqkw','.eJxVjEEOwiAQRe_C2pBhKKAu3XsGMjCDVE1JSrsy3l2bdKHb_977LxVpXWpcu8xxZHVWRh1-t0T5IdMG-E7TrencpmUek94UvdOur43ledndv4NKvX5rAmYrJkEZEE_JFifFoPHiMBc-JjJDEIOAHgZXHIIFR4HBW7HBh6TeH-UaN04:1um0wy:nSbzYpW17jcplwPP1kly1Kb4BmYAq1O-6ewiMm59iWs','2025-08-27 02:10:48.003110'),('z92ounzkpi3y07q3oo228v32et52pvc6','.eJxVjMsOwiAQRf-FtSGlZXi4dO83kGEYpGogKe3K-O_apAvd3nPOfYmA21rC1nkJcxJnocTpd4tID647SHestyap1XWZo9wVedAury3x83K4fwcFe_nWLuthoNHmyDYBE5lsHVijlQfyWiebFKCZsvIRM1gCjSNTdt5PE7IS7w_qyzgf:1ueOfe:44ugNkrRKy3jmjRZ6lESdGtjmeLMOVp0eqUoOooUvcc','2025-08-06 01:53:26.178955'),('zqriu9ionp7fhqkl21d34vifo2aykz09','.eJxVjEEOwiAQRe_C2pBhKKAu3XsGMjCDVE1JSrsy3l2bdKHb_977LxVpXWpcu8xxZHVWRh1-t0T5IdMG-E7TrencpmUek94UvdOur43ledndv4NKvX5rAmYrJkEZEE_JFifFoPHiMBc-JjJDEIOAHgZXHIIFR4HBW7HBh6TeH-UaN04:1umcwT:n9MQGykTre_110pP0n-jkSLHbclMqPs8fs9TIJC3oCc','2025-08-28 18:44:49.832956');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresa`
--

DROP TABLE IF EXISTS `empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresa` (
  `id_empresa` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `dependencia` smallint NOT NULL,
  `nit` varchar(30) NOT NULL,
  `tipo` varchar(30) NOT NULL,
  `razon_social` varchar(30) DEFAULT NULL,
  `valor_iva` double DEFAULT NULL,
  `otro_impuesto` double DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_empresa`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa`
--

LOCK TABLES `empresa` WRITE;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
INSERT INTO `empresa` VALUES (1,'Tech Solutions S.A.S',1,'900123456-7','Privada','Tecnología',19,0,'Cra 45 #12-34','3104567890','contacto@techsolutions.com');
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facturas_de_compra`
--

DROP TABLE IF EXISTS `facturas_de_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facturas_de_compra` (
  `id_factura_compra` int NOT NULL AUTO_INCREMENT,
  `no_factura_compra` varchar(35) DEFAULT NULL,
  `id_proveedor` int DEFAULT NULL,
  `id_usuario` int DEFAULT NULL,
  `fecha_compra` datetime NOT NULL,
  `total_factura` double DEFAULT NULL,
  `estado` varchar(15) DEFAULT NULL,
  `id_empresa` int DEFAULT NULL,
  PRIMARY KEY (`id_factura_compra`),
  UNIQUE KEY `no_factura_compra` (`no_factura_compra`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_proveedor` (`id_proveedor`),
  KEY `id_empresa` (`id_empresa`),
  CONSTRAINT `facturas_de_compra_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `facturas_de_compra_ibfk_2` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `facturas_de_compra_ibfk_3` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facturas_de_compra`
--

LOCK TABLES `facturas_de_compra` WRITE;
/*!40000 ALTER TABLE `facturas_de_compra` DISABLE KEYS */;
/*!40000 ALTER TABLE `facturas_de_compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facturas_de_venta`
--

DROP TABLE IF EXISTS `facturas_de_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facturas_de_venta` (
  `id_factura_venta` int NOT NULL AUTO_INCREMENT,
  `no_factura_venta` varchar(25) NOT NULL,
  `id_cliente` int DEFAULT NULL,
  `id_usuario` int DEFAULT NULL,
  `fecha_venta` datetime NOT NULL,
  `total_factura_venta` double NOT NULL,
  `estado` varchar(15) DEFAULT NULL,
  `id_empresa` int NOT NULL,
  PRIMARY KEY (`id_factura_venta`),
  UNIQUE KEY `no_factura_venta` (`no_factura_venta`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_empresa` (`id_empresa`),
  KEY `idx_facturas_venta` (`id_cliente`,`id_usuario`,`id_empresa`),
  CONSTRAINT `facturas_de_venta_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `facturas_de_venta_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `facturas_de_venta_ibfk_3` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facturas_de_venta`
--

LOCK TABLES `facturas_de_venta` WRITE;
/*!40000 ALTER TABLE `facturas_de_venta` DISABLE KEYS */;
/*!40000 ALTER TABLE `facturas_de_venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventarios_articulo`
--

DROP TABLE IF EXISTS `inventarios_articulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventarios_articulo` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre_art` varchar(100) NOT NULL,
  `no_referencia` varchar(50) NOT NULL,
  `presentacion` varchar(10) NOT NULL,
  `stock` int unsigned NOT NULL,
  `stock_min` int unsigned NOT NULL,
  `stock_max` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `no_referencia` (`no_referencia`),
  UNIQUE KEY `inventarios_articulo_nombre_art_f28393c7_uniq` (`nombre_art`),
  CONSTRAINT `inventarios_articulo_chk_1` CHECK ((`stock` >= 0)),
  CONSTRAINT `inventarios_articulo_chk_2` CHECK ((`stock_min` >= 0)),
  CONSTRAINT `inventarios_articulo_chk_3` CHECK ((`stock_max` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventarios_articulo`
--

LOCK TABLES `inventarios_articulo` WRITE;
/*!40000 ALTER TABLE `inventarios_articulo` DISABLE KEYS */;
INSERT INTO `inventarios_articulo` VALUES (1,'Guaya 1A','AA8000','unidad',131,10,50),(2,'Filtro Camion','00123','unidad',28,20,50),(3,'Aceite','as123','balde',510,15,50),(4,'Aceite j89','AA8000 yona','galon',0,56,106),(5,'filpudita','00123efd','unidad',0,10,20),(6,'Aceite 22a','dfdfsdf4','unidad',3,20,40);
/*!40000 ALTER TABLE `inventarios_articulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventarios_detalleentrada`
--

DROP TABLE IF EXISTS `inventarios_detalleentrada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventarios_detalleentrada` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cantidad` int unsigned NOT NULL,
  `articulo_id` bigint NOT NULL,
  `factura_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `inventarios_detallee_articulo_id_f407c609_fk_inventari` (`articulo_id`),
  KEY `inventarios_detallee_factura_id_5d4a2e04_fk_inventari` (`factura_id`),
  CONSTRAINT `inventarios_detallee_articulo_id_f407c609_fk_inventari` FOREIGN KEY (`articulo_id`) REFERENCES `inventarios_articulo` (`id`),
  CONSTRAINT `inventarios_detallee_factura_id_5d4a2e04_fk_inventari` FOREIGN KEY (`factura_id`) REFERENCES `inventarios_entradafactura` (`id`),
  CONSTRAINT `inventarios_detalleentrada_chk_1` CHECK ((`cantidad` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventarios_detalleentrada`
--

LOCK TABLES `inventarios_detalleentrada` WRITE;
/*!40000 ALTER TABLE `inventarios_detalleentrada` DISABLE KEYS */;
INSERT INTO `inventarios_detalleentrada` VALUES (1,10,1,1),(2,10,1,1),(3,10,1,2),(4,10,1,3),(5,10,1,4),(6,10,1,5),(7,18,1,6),(8,5,1,7),(9,10,2,8),(10,35,1,9),(11,12,1,10),(12,11,1,6),(13,12,2,11),(14,1,2,12),(15,2,2,12),(16,3,2,13),(17,55,1,14),(18,500,3,15),(19,10,3,16),(20,5,6,16);
/*!40000 ALTER TABLE `inventarios_detalleentrada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventarios_detallesalida`
--

DROP TABLE IF EXISTS `inventarios_detallesalida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventarios_detallesalida` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cantidad` int unsigned NOT NULL,
  `articulo_id` bigint NOT NULL,
  `factura_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `inventarios_detalles_articulo_id_b7d13601_fk_inventari` (`articulo_id`),
  KEY `inventarios_detalles_factura_id_392b9918_fk_inventari` (`factura_id`),
  CONSTRAINT `inventarios_detalles_articulo_id_b7d13601_fk_inventari` FOREIGN KEY (`articulo_id`) REFERENCES `inventarios_articulo` (`id`),
  CONSTRAINT `inventarios_detalles_factura_id_392b9918_fk_inventari` FOREIGN KEY (`factura_id`) REFERENCES `inventarios_salidafactura` (`id`),
  CONSTRAINT `inventarios_detallesalida_chk_1` CHECK ((`cantidad` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventarios_detallesalida`
--

LOCK TABLES `inventarios_detallesalida` WRITE;
/*!40000 ALTER TABLE `inventarios_detallesalida` DISABLE KEYS */;
INSERT INTO `inventarios_detallesalida` VALUES (1,2,1,1),(2,2,1,2),(3,2,1,3),(4,10,1,4),(5,2,1,5),(6,15,1,4),(7,10,1,6),(8,12,1,2),(9,10,1,7),(10,2,6,8);
/*!40000 ALTER TABLE `inventarios_detallesalida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventarios_entradafactura`
--

DROP TABLE IF EXISTS `inventarios_entradafactura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventarios_entradafactura` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `factura_no` varchar(20) NOT NULL,
  `fecha_entrada` datetime(6) NOT NULL,
  `usuario_responsable_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `inventarios_entradaf_usuario_responsable__f83f7d0f_fk_usuarios_` (`usuario_responsable_id`),
  CONSTRAINT `inventarios_entradaf_usuario_responsable__f83f7d0f_fk_usuarios_` FOREIGN KEY (`usuario_responsable_id`) REFERENCES `usuarios_usuariopersonalizado` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventarios_entradafactura`
--

LOCK TABLES `inventarios_entradafactura` WRITE;
/*!40000 ALTER TABLE `inventarios_entradafactura` DISABLE KEYS */;
INSERT INTO `inventarios_entradafactura` VALUES (1,'e1','2025-08-01 23:47:55.351898',1),(2,'s2','2025-08-02 03:23:50.768124',1),(3,'s1','2025-08-02 03:24:46.770754',1),(4,'d1','2025-08-02 03:27:13.060555',1),(5,'s5','2025-08-02 03:31:50.041200',1),(6,'e2','2025-08-02 03:38:04.846391',1),(7,'e5','2025-08-02 03:40:49.632296',1),(8,'E3','2025-08-02 03:47:04.133405',1),(9,'Gq11','2025-08-07 05:11:06.447299',1),(10,'f1','2025-08-08 01:21:07.689441',1),(11,'e8','2025-08-08 04:04:15.720595',1),(12,'e9','2025-08-08 04:05:00.822535',1),(13,'e10','2025-08-08 04:06:44.891727',1),(14,'e11','2025-08-08 04:11:24.161439',1),(15,'E44','2025-08-12 21:14:36.102891',1),(16,'E22','2025-08-13 02:14:17.664298',1);
/*!40000 ALTER TABLE `inventarios_entradafactura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventarios_salidafactura`
--

DROP TABLE IF EXISTS `inventarios_salidafactura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventarios_salidafactura` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `factura_no` varchar(20) NOT NULL,
  `fecha_salida` datetime(6) NOT NULL,
  `usuario_responsable_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `factura_no` (`factura_no`),
  KEY `inventarios_salidafa_usuario_responsable__044d4ce1_fk_usuarios_` (`usuario_responsable_id`),
  CONSTRAINT `inventarios_salidafa_usuario_responsable__044d4ce1_fk_usuarios_` FOREIGN KEY (`usuario_responsable_id`) REFERENCES `usuarios_usuariopersonalizado` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventarios_salidafactura`
--

LOCK TABLES `inventarios_salidafactura` WRITE;
/*!40000 ALTER TABLE `inventarios_salidafactura` DISABLE KEYS */;
INSERT INTO `inventarios_salidafactura` VALUES (1,'s1','2025-08-02 00:47:59.259382',1),(2,'s2','2025-08-02 01:39:11.913100',1),(3,'s3','2025-08-02 01:45:57.157859',1),(4,'s5','2025-08-02 03:32:08.777106',1),(5,'gh','2025-08-02 03:36:55.831666',1),(6,'a8','2025-08-02 03:45:17.922660',1),(7,'F88','2025-08-10 22:56:28.240528',1),(8,'SA3','2025-08-13 02:15:59.306300',1);
/*!40000 ALTER TABLE `inventarios_salidafactura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `licencias`
--

DROP TABLE IF EXISTS `licencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `licencias` (
  `id_licencia` int NOT NULL AUTO_INCREMENT,
  `id_empresa` int NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `tipo_licencia` enum('Básica','Premium','Enterprise') NOT NULL,
  `estado` enum('Activa','Expirada','Suspendida') NOT NULL DEFAULT 'Activa',
  PRIMARY KEY (`id_licencia`),
  KEY `fk_licencia_empresa` (`id_empresa`),
  CONSTRAINT `fk_licencia_empresa` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `licencias`
--

LOCK TABLES `licencias` WRITE;
/*!40000 ALTER TABLE `licencias` DISABLE KEYS */;
/*!40000 ALTER TABLE `licencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notificaciones`
--

DROP TABLE IF EXISTS `notificaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificaciones` (
  `id_notificaciones` int NOT NULL AUTO_INCREMENT,
  `tipo_notificacion` varchar(25) NOT NULL,
  `detalle_notificacion` varchar(255) NOT NULL,
  `id_cliente` int NOT NULL,
  `id_usuario` int NOT NULL,
  `medio_notificacion` varchar(25) DEFAULT NULL,
  `fecha_envio_notificacion` datetime NOT NULL,
  `id_empresa` int NOT NULL,
  PRIMARY KEY (`id_notificaciones`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_empresa` (`id_empresa`),
  CONSTRAINT `notificaciones_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `notificaciones_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `notificaciones_ibfk_3` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificaciones`
--

LOCK TABLES `notificaciones` WRITE;
/*!40000 ALTER TABLE `notificaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `notificaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenes_de_compra`
--

DROP TABLE IF EXISTS `ordenes_de_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordenes_de_compra` (
  `id_orden_de_compra` int NOT NULL AUTO_INCREMENT,
  `tipo_orden_compra` varchar(15) NOT NULL,
  `id_articulo` int DEFAULT NULL,
  `cantidad` double NOT NULL,
  `fecha_orden` datetime NOT NULL,
  `estado` varchar(15) DEFAULT NULL,
  `id_proveedor` int DEFAULT NULL,
  `id_empresa` int NOT NULL,
  PRIMARY KEY (`id_orden_de_compra`),
  KEY `id_articulo` (`id_articulo`),
  KEY `id_proveedor` (`id_proveedor`),
  KEY `id_empresa` (`id_empresa`),
  CONSTRAINT `ordenes_de_compra_ibfk_1` FOREIGN KEY (`id_articulo`) REFERENCES `articulos` (`id_articulo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ordenes_de_compra_ibfk_2` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ordenes_de_compra_ibfk_3` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenes_de_compra`
--

LOCK TABLES `ordenes_de_compra` WRITE;
/*!40000 ALTER TABLE `ordenes_de_compra` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordenes_de_compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagos_deuda_cliente`
--

DROP TABLE IF EXISTS `pagos_deuda_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagos_deuda_cliente` (
  `id_pagos_deuda_cliente` int NOT NULL AUTO_INCREMENT,
  `id_deuda_cliente` int NOT NULL,
  `fecha_pago` datetime NOT NULL,
  `valor_pago` double NOT NULL,
  `nota` varchar(100) DEFAULT NULL,
  `id_usuario` int NOT NULL,
  PRIMARY KEY (`id_pagos_deuda_cliente`),
  KEY `id_deuda_cliente` (`id_deuda_cliente`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `pagos_deuda_cliente_ibfk_1` FOREIGN KEY (`id_deuda_cliente`) REFERENCES `deuda_cliente` (`id_deuda_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pagos_deuda_cliente_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagos_deuda_cliente`
--

LOCK TABLES `pagos_deuda_cliente` WRITE;
/*!40000 ALTER TABLE `pagos_deuda_cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagos_deuda_cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagos_deuda_proveedor`
--

DROP TABLE IF EXISTS `pagos_deuda_proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagos_deuda_proveedor` (
  `id_pagos_deuda_proveedor` int NOT NULL AUTO_INCREMENT,
  `id_deuda_proveedor` int NOT NULL,
  `fecha_pago` datetime NOT NULL,
  `valor_pago` double NOT NULL,
  `nota` varchar(100) DEFAULT NULL,
  `id_usuario` int NOT NULL,
  PRIMARY KEY (`id_pagos_deuda_proveedor`),
  KEY `id_deuda_proveedor` (`id_deuda_proveedor`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `pagos_deuda_proveedor_ibfk_1` FOREIGN KEY (`id_deuda_proveedor`) REFERENCES `deuda_proveedor` (`id_deuda_proveedor`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pagos_deuda_proveedor_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagos_deuda_proveedor`
--

LOCK TABLES `pagos_deuda_proveedor` WRITE;
/*!40000 ALTER TABLE `pagos_deuda_proveedor` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagos_deuda_proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permisos`
--

DROP TABLE IF EXISTS `permisos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permisos` (
  `id_permiso` int NOT NULL AUTO_INCREMENT,
  `permiso_a` varchar(45) NOT NULL,
  PRIMARY KEY (`id_permiso`),
  UNIQUE KEY `permiso_a` (`permiso_a`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permisos`
--

LOCK TABLES `permisos` WRITE;
/*!40000 ALTER TABLE `permisos` DISABLE KEYS */;
/*!40000 ALTER TABLE `permisos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permisos_usuario`
--

DROP TABLE IF EXISTS `permisos_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permisos_usuario` (
  `id_permiso_usuario` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_permiso` int NOT NULL,
  `valor` varchar(10) NOT NULL,
  PRIMARY KEY (`id_permiso_usuario`),
  KEY `id_permiso` (`id_permiso`),
  KEY `idx_permisos_usuario` (`id_usuario`,`id_permiso`),
  CONSTRAINT `permisos_usuario_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permisos_usuario_ibfk_2` FOREIGN KEY (`id_permiso`) REFERENCES `permisos` (`id_permiso`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permisos_usuario`
--

LOCK TABLES `permisos_usuario` WRITE;
/*!40000 ALTER TABLE `permisos_usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `permisos_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores` (
  `id_proveedor` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(45) NOT NULL,
  `apellidos` varchar(45) NOT NULL,
  `identificacion` varchar(25) NOT NULL,
  `nombre_empresa` varchar(45) NOT NULL,
  `nit` varchar(25) NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `correo` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `ciudad` varchar(45) DEFAULT NULL,
  `pais` varchar(45) DEFAULT NULL,
  `whatsapp` varchar(45) DEFAULT NULL,
  `id_empresa` int DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL,
  PRIMARY KEY (`id_proveedor`),
  UNIQUE KEY `identificacion` (`identificacion`),
  UNIQUE KEY `correo` (`correo`),
  KEY `id_empresa` (`id_empresa`),
  CONSTRAINT `proveedores_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores_proveedor`
--

DROP TABLE IF EXISTS `proveedores_proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores_proveedor` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre_empresa` varchar(30) NOT NULL,
  `nit` varchar(20) NOT NULL,
  `nombre_propietario` varchar(100) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `email` varchar(254) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores_proveedor`
--

LOCK TABLES `proveedores_proveedor` WRITE;
/*!40000 ALTER TABLE `proveedores_proveedor` DISABLE KEYS */;
INSERT INTO `proveedores_proveedor` VALUES (1,'PROVEEDOR N11','814002017-7','Andrea Garces','3182251027','N/A','yona20mg@gmail.com');
/*!40000 ALTER TABLE `proveedores_proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registro_inicio_sesion`
--

DROP TABLE IF EXISTS `registro_inicio_sesion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registro_inicio_sesion` (
  `id_registro_inicio_sesion` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `intento` varchar(20) NOT NULL,
  `fecha_inicio_sesion` datetime NOT NULL,
  `fecha_cierre_sesion` datetime NOT NULL,
  `ip` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id_registro_inicio_sesion`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `registro_inicio_sesion_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registro_inicio_sesion`
--

LOCK TABLES `registro_inicio_sesion` WRITE;
/*!40000 ALTER TABLE `registro_inicio_sesion` DISABLE KEYS */;
/*!40000 ALTER TABLE `registro_inicio_sesion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registro_mod_facturas`
--

DROP TABLE IF EXISTS `registro_mod_facturas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registro_mod_facturas` (
  `id_registro_mod_factura` int NOT NULL AUTO_INCREMENT,
  `id_factura` int NOT NULL,
  `tipo_factura` varchar(20) NOT NULL,
  `fecha_mod_factura` datetime NOT NULL,
  `valor_anterior` double NOT NULL,
  `valor_actual` double NOT NULL,
  `id_usuario` int NOT NULL,
  PRIMARY KEY (`id_registro_mod_factura`),
  KEY `id_factura` (`id_factura`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `registro_mod_facturas_ibfk_1` FOREIGN KEY (`id_factura`) REFERENCES `facturas_de_venta` (`id_factura_venta`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `registro_mod_facturas_ibfk_2` FOREIGN KEY (`id_factura`) REFERENCES `facturas_de_compra` (`id_factura_compra`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `registro_mod_facturas_ibfk_3` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registro_mod_facturas`
--

LOCK TABLES `registro_mod_facturas` WRITE;
/*!40000 ALTER TABLE `registro_mod_facturas` DISABLE KEYS */;
/*!40000 ALTER TABLE `registro_mod_facturas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(20) NOT NULL,
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `nombre_rol` (`nombre_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrador');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `apellidos` varchar(45) NOT NULL,
  `identificacion` varchar(25) NOT NULL,
  `usuario` varchar(45) NOT NULL,
  `contrasenia` varchar(120) NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `correo` varchar(45) DEFAULT NULL,
  `id_rol` int DEFAULT NULL,
  `estado` varchar(15) DEFAULT NULL,
  `whatsapp` varchar(45) DEFAULT NULL,
  `fecha_registro` datetime NOT NULL,
  `id_empresa` int NOT NULL,
  PRIMARY KEY (`id_usuario`),
  KEY `id_empresa` (`id_empresa`),
  KEY `idx_usuarios_id_rol` (`id_rol`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (4,'Laura','González','12211','lauf1','$2b$10$QNnPzA5DbmEVnIPuXORtxevYD.ZFb3Fqo/96mif7J0ge/66Uiy.L6','3101234567','lauraz1@example.com',1,'activo','3101234567','2025-05-17 21:36:08',1),(5,'Nombre por defecto','Apellido por defecto','12345678','juan','$2b$10$snc6mQ3jIaU1rox4WEaB8eJ/uhxEMkjtHt5s316ZtaKB2QI9LD6A6','3000000000','juan@example.com',1,'activo','3000000000','2025-05-17 21:38:02',1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios_usuariopersonalizado`
--

DROP TABLE IF EXISTS `usuarios_usuariopersonalizado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios_usuariopersonalizado` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `tipo_documento` varchar(15) DEFAULT NULL,
  `documento` varchar(20) DEFAULT NULL,
  `rol` varchar(15) NOT NULL,
  `tema` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `usuarios_usuariopersonalizado_documento_3ed31200_uniq` (`documento`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios_usuariopersonalizado`
--

LOCK TABLES `usuarios_usuariopersonalizado` WRITE;
/*!40000 ALTER TABLE `usuarios_usuariopersonalizado` DISABLE KEYS */;
INSERT INTO `usuarios_usuariopersonalizado` VALUES (1,'pbkdf2_sha256$1000000$hYSMxGappsZJzuRdYj4WGc$nhX5YWeT9P5zjf+4jD7e2w8sLhXx4/Hoq7WnXLklDog=','2025-08-14 18:44:49.823811',1,'sara12345','Sara soft','','sara@sara.com.co',1,1,'2025-07-23 01:53:01.104762',NULL,NULL,NULL,'Administrador','claro'),(2,'pbkdf2_sha256$1000000$u6bTblp0P78uBdXtp6WC4I$7iFkYMNJpW+DVEPLjlZ5GMcIFGl23uTUoDVA6AZ0Itk=',NULL,0,'yona','Yonatan','Martinez','yona20mg@gmail.com',1,1,'2025-08-13 02:07:29.543319','3182251027','cc','52793841','Invitado','claro'),(6,'pbkdf2_sha256$1000000$Y4Lkk0dOpBLgmr4H1E1iqY$ndEQZANjRPveb/sZnX6kxGMV0eLN+oUpkq1mZ3e2JAk=','2025-08-13 02:10:22.371979',0,'yona123','Yonatan','Martinez','yona20mg@gmail.com',1,1,'2025-08-13 02:09:04.085279','3182251027','cc','12345678','Invitado','claro');
/*!40000 ALTER TABLE `usuarios_usuariopersonalizado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios_usuariopersonalizado_groups`
--

DROP TABLE IF EXISTS `usuarios_usuariopersonalizado_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios_usuariopersonalizado_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `usuariopersonalizado_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuarios_usuariopersonal_usuariopersonalizado_id__76cbb714_uniq` (`usuariopersonalizado_id`,`group_id`),
  KEY `usuarios_usuariopers_group_id_e477d507_fk_auth_grou` (`group_id`),
  CONSTRAINT `usuarios_usuariopers_group_id_e477d507_fk_auth_grou` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `usuarios_usuariopers_usuariopersonalizado_995abac4_fk_usuarios_` FOREIGN KEY (`usuariopersonalizado_id`) REFERENCES `usuarios_usuariopersonalizado` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios_usuariopersonalizado_groups`
--

LOCK TABLES `usuarios_usuariopersonalizado_groups` WRITE;
/*!40000 ALTER TABLE `usuarios_usuariopersonalizado_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios_usuariopersonalizado_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios_usuariopersonalizado_user_permissions`
--

DROP TABLE IF EXISTS `usuarios_usuariopersonalizado_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios_usuariopersonalizado_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `usuariopersonalizado_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuarios_usuariopersonal_usuariopersonalizado_id__fdd0e6b7_uniq` (`usuariopersonalizado_id`,`permission_id`),
  KEY `usuarios_usuariopers_permission_id_6a016b89_fk_auth_perm` (`permission_id`),
  CONSTRAINT `usuarios_usuariopers_permission_id_6a016b89_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `usuarios_usuariopers_usuariopersonalizado_743172be_fk_usuarios_` FOREIGN KEY (`usuariopersonalizado_id`) REFERENCES `usuarios_usuariopersonalizado` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios_usuariopersonalizado_user_permissions`
--

LOCK TABLES `usuarios_usuariopersonalizado_user_permissions` WRITE;
/*!40000 ALTER TABLE `usuarios_usuariopersonalizado_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios_usuariopersonalizado_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-14 13:49:17
