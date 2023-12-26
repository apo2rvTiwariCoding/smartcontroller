-- MySQL dump 10.13  Distrib 5.5.25, for Win64 (x86)
--
-- Host: localhost    Database: smart2014
-- ------------------------------------------------------
-- Server version	5.5.25

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ref_table` varchar(200) DEFAULT NULL,
  `ref_id` int(11) DEFAULT NULL,
  `type_` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MEMORY AUTO_INCREMENT=216 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
INSERT INTO `actions` VALUES (1,'commands',327,0,0),(2,'commands',328,0,0),(3,'commands',329,0,0),(4,'commands',330,0,0),(5,'commands',331,0,0),(6,'commands',332,0,0),(7,'commands',333,0,0),(8,'commands',334,0,0),(9,'commands',335,0,0),(10,'commands',336,0,0),(11,'commands',337,0,0),(12,'commands',338,0,0),(13,'commands',339,0,0),(14,'commands',340,0,0),(15,'commands',341,0,0),(16,'commands',342,0,0),(17,'commands',343,0,0),(18,'commands',344,0,0),(19,'commands',345,0,0),(20,'commands',346,0,0),(21,'commands',347,0,0),(22,'commands',348,0,0),(23,'commands',349,0,0),(24,'commands',350,0,0),(25,'commands',351,0,0),(26,'commands',352,0,0),(27,'commands',353,0,0),(28,'commands',354,0,0),(29,'commands',355,0,0),(30,'commands',356,0,0),(31,'commands',357,0,0),(32,'commands',358,0,0),(33,'commands',359,0,0),(34,'commands',360,0,0),(35,'commands',361,0,0),(36,'commands',362,0,0),(37,'commands',363,0,0),(38,'commands',364,0,0),(39,'commands',365,0,0),(40,'commands',366,0,0),(41,'commands',367,0,0),(42,'commands',368,0,0),(43,'commands',369,0,0),(44,'commands',370,0,0),(45,'commands',371,0,0),(46,'commands',372,0,0),(47,'commands',373,0,0),(48,'commands',374,0,0),(49,'commands',375,0,0),(50,'commands',376,0,0),(51,'commands',377,0,0),(52,'commands',378,0,0),(53,'commands',379,0,0),(54,'commands',380,0,0),(55,'commands',381,0,0),(56,'commands',382,0,0),(57,'commands',383,0,0),(58,'commands',384,0,0),(59,'commands',385,0,0),(60,'commands',386,0,0),(61,'commands',387,0,0),(62,'commands',388,0,0),(63,'commands',389,0,0),(64,'commands',390,0,0),(65,'commands',391,0,0),(66,'commands',392,0,0),(67,'commands',393,0,0),(68,'commands',394,0,0),(69,'commands',395,0,0),(70,'commands',396,0,0),(71,'commands',397,0,0),(72,'commands',398,0,0),(73,'commands',399,0,0),(74,'commands',400,0,0),(75,'commands',401,0,0),(76,'commands',402,0,0),(77,'commands',403,0,0),(78,'commands',404,0,0),(79,'commands',405,0,0),(80,'commands',406,0,0),(81,'commands',407,0,0),(82,'commands',408,0,0),(83,'commands',409,0,0),(84,'commands',410,0,0),(85,'commands',411,0,0),(86,'commands',412,0,0),(87,'commands',413,0,0),(88,'commands',414,0,0),(89,'commands',415,0,0),(90,'commands',416,0,0),(91,'commands',417,0,0),(92,'commands',418,0,0),(93,'commands',419,0,0),(94,'commands',420,0,0),(95,'commands',421,0,0),(96,'commands',422,0,0),(97,'commands',423,0,0),(98,'commands',424,0,0),(99,'commands',425,0,0),(100,'commands',426,0,0),(101,'commands',427,0,0),(102,'commands',428,0,0),(103,'commands',429,0,0),(104,'commands',430,0,0),(105,'commands',431,0,0),(106,'commands',432,0,0),(107,'commands',433,0,0),(108,'commands',434,0,0),(109,'commands',435,0,0),(110,'commands',436,0,0),(111,'commands',437,0,0),(112,'commands',438,0,0),(113,'commands',439,0,0),(114,'commands',440,0,0),(115,'commands',441,0,0),(116,'commands',442,0,0),(117,'commands',443,0,0),(118,'commands',444,0,0),(119,'commands',445,0,0),(120,'commands',446,0,0),(121,'commands',447,0,0),(122,'commands',448,0,0),(123,'commands',449,0,0),(124,'commands',450,0,0),(125,'commands',451,0,0),(126,'commands',452,0,0),(127,'commands',453,0,0),(128,'commands',454,0,0),(129,'commands',455,0,0),(130,'commands',456,0,0),(131,'commands',457,0,0),(132,'commands',458,0,0),(133,'commands',459,0,0),(134,'commands',460,0,0),(135,'commands',461,0,0),(136,'commands',462,0,0),(137,'commands',463,0,0),(138,'commands',464,0,0),(139,'commands',465,0,0),(140,'commands',466,0,0),(141,'commands',467,0,0),(142,'commands',468,0,0),(143,'commands',469,0,0),(144,'commands',470,0,0),(145,'commands',471,0,0),(146,'commands',472,0,0),(147,'commands',473,0,0),(148,'commands',474,0,0),(149,'commands',475,0,0),(150,'commands',476,0,0),(151,'commands',477,0,0),(152,'commands',478,0,0),(153,'commands',479,0,0),(154,'commands',480,0,0),(155,'commands',481,0,0),(156,'commands',482,0,0),(157,'commands',483,0,0),(158,'commands',484,0,0),(159,'commands',485,0,0),(160,'commands',486,0,0),(161,'commands',487,0,0),(162,'commands',488,0,0),(163,'commands',489,0,0),(164,'commands',490,0,0),(165,'commands',491,0,0),(166,'commands',492,0,0),(167,'commands',493,0,0),(168,'commands',494,0,0),(169,'commands',495,0,0),(170,'commands',496,0,0),(171,'commands',497,0,0),(172,'commands',498,0,0),(173,'commands',499,0,0),(174,'commands',500,0,0),(175,'commands',501,0,0),(176,'commands',502,0,0),(177,'commands',503,0,0),(178,'commands',504,0,0),(179,'commands',505,0,0),(180,'commands',506,0,0),(181,'commands',507,0,0),(182,'commands',508,0,0),(183,'commands',509,0,0),(184,'commands',510,0,0),(185,'commands',511,0,0),(186,'commands',512,0,0),(187,'commands',513,0,0),(188,'commands',514,0,0),(189,'commands',515,0,0),(190,'commands',516,0,0),(191,'commands',517,0,0),(192,'commands',518,0,0),(193,'commands',519,0,0),(194,'commands',520,0,0),(195,'commands',521,0,0),(196,'commands',522,0,0),(197,'commands',523,0,0),(198,'commands',524,0,0),(199,'commands',525,0,0),(200,'commands',526,0,0),(201,'commands',527,0,0),(202,'commands',528,0,0),(203,'commands',529,0,0),(204,'commands',530,0,0),(205,'commands',531,0,0),(206,'commands',532,0,0),(207,'commands',533,0,0),(208,'commands',534,0,0),(209,'commands',535,0,0),(210,'commands',536,0,0),(211,'commands',537,0,0),(212,'commands',538,0,0),(213,'commands',539,0,0),(214,'commands',540,0,0),(215,'commands',541,0,0);
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER action_notify_MuxDemux
	AFTER INSERT
	ON actions
	FOR EACH ROW
BEGIN
  DECLARE notResult VARCHAR(50);
  IF (1 = 1) THEN
    SELECT notifyMuxDemux() INTO 'notResult';
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `alarms_networks`
--

DROP TABLE IF EXISTS `alarms_networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alarms_networks` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `updated` datetime DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  `type_` int(11) DEFAULT NULL,
  `severity` int(11) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarms_networks`
--

LOCK TABLES `alarms_networks` WRITE;
/*!40000 ALTER TABLE `alarms_networks` DISABLE KEYS */;
INSERT INTO `alarms_networks` VALUES (1,'2014-05-17 01:42:39','127.0.0.1',1,1,'failed attempt to connect to ISP name server'),(2,'2014-05-17 01:43:41','127.0.0.1',2,2,'consecutive failed attempts to connect to ISP name server'),(3,'2014-05-19 23:28:22','192.168.1.1',1,1,'connect attempt failed');
/*!40000 ALTER TABLE `alarms_networks` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_alarms_networks` AFTER INSERT ON `alarms_networks`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_alarms_networks IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_networks'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_alarms_networks` AFTER UPDATE ON `alarms_networks`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_networks IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_networks';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_alarms_networks` AFTER DELETE ON `alarms_networks`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_networks IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_networks';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `alarms_pressure`
--

DROP TABLE IF EXISTS `alarms_pressure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alarms_pressure` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `updated` datetime DEFAULT NULL,
  `pressure` int(11) DEFAULT NULL,
  `threshold` int(11) DEFAULT NULL,
  `type_` int(11) DEFAULT NULL,
  `severity` int(11) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarms_pressure`
--

LOCK TABLES `alarms_pressure` WRITE;
/*!40000 ALTER TABLE `alarms_pressure` DISABLE KEYS */;
INSERT INTO `alarms_pressure` VALUES (1,'2014-05-18 00:40:22',100,100,1,1,'blow'),(2,'2014-05-19 23:29:09',110,110,1,1,'bahh');
/*!40000 ALTER TABLE `alarms_pressure` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_alarms_pressure` AFTER INSERT ON `alarms_pressure`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_alarms_pressure IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_pressure'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_alarms_pressure` AFTER UPDATE ON `alarms_pressure`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_pressure IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_pressure';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_alarms_pressure` AFTER DELETE ON `alarms_pressure`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_pressure IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_pressure';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `alarms_retrosave`
--

DROP TABLE IF EXISTS `alarms_retrosave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alarms_retrosave` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `updated` datetime DEFAULT NULL,
  `type_` int(11) DEFAULT NULL,
  `severity` int(11) DEFAULT NULL,
  `zone_desc` varchar(100) DEFAULT NULL,
  `device_desc` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarms_retrosave`
--

LOCK TABLES `alarms_retrosave` WRITE;
/*!40000 ALTER TABLE `alarms_retrosave` DISABLE KEYS */;
INSERT INTO `alarms_retrosave` VALUES (1,'2014-05-18 00:41:26',2,0,'Kitchen','Louver'),(2,'2014-05-18 00:42:03',8,1,'Room','Wall sensor'),(3,'2014-05-19 23:29:39',2,0,'Hall','Sensor'),(4,'2014-10-22 02:49:53',12,1,NULL,NULL),(5,'2014-10-22 02:52:04',15,2,NULL,NULL);
/*!40000 ALTER TABLE `alarms_retrosave` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_alarms_retrosave` AFTER INSERT ON `alarms_retrosave`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_alarms_retrosave IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_retrosave'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_alarms_retrosave` AFTER UPDATE ON `alarms_retrosave`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_retrosave IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_retrosave';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_alarms_retrosave` AFTER DELETE ON `alarms_retrosave`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_retrosave IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_retrosave';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `alarms_system`
--

DROP TABLE IF EXISTS `alarms_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alarms_system` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `updated` datetime DEFAULT NULL,
  `type_` int(11) DEFAULT NULL,
  `severity` int(11) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarms_system`
--

LOCK TABLES `alarms_system` WRITE;
/*!40000 ALTER TABLE `alarms_system` DISABLE KEYS */;
INSERT INTO `alarms_system` VALUES (1,'2014-05-17 00:43:59',0,0,'Completed'),(2,'2014-05-18 00:44:14',0,0,'Update completed'),(3,'2014-06-13 00:44:45',2,2,''),(4,'2014-06-13 00:53:27',2,2,'0x00 error'),(5,'2014-09-18 01:28:04',10,1,'0x73 error'),(6,'2014-12-17 19:42:30',3,0,'Test notification');
/*!40000 ALTER TABLE `alarms_system` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_alarms_system` AFTER INSERT ON `alarms_system`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_alarms_system IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_system'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_alarms_system` AFTER UPDATE ON `alarms_system`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_system IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_system';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_alarms_system` AFTER DELETE ON `alarms_system`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_system IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_system';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `alarms_types`
--

DROP TABLE IF EXISTS `alarms_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alarms_types` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `alarm_id` int(11) NOT NULL DEFAULT '0',
  `type_` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `severity` tinyint(4) NOT NULL DEFAULT '0',
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarms_types`
--

LOCK TABLES `alarms_types` WRITE;
/*!40000 ALTER TABLE `alarms_types` DISABLE KEYS */;
INSERT INTO `alarms_types` VALUES (1,0,0,0,0,'Time based triggered period'),(2,1,0,1,1,'PIR triggered report'),(3,2,0,1,2,'Battery Level triggered report'),(4,3,0,1,2,'Upper Temperature Value Report Trigger'),(5,4,0,1,2,'Lower Temperature Value Report Trigger'),(6,5,0,1,1,'Upper Humidity Value Report Trigger'),(7,6,0,0,0,'Lower Humidity Value Report Trigger'),(8,7,0,0,0,'Upper CO Value Trigger Report'),(9,8,0,1,1,'Upper CO2 Value Trigger Report'),(10,9,0,1,2,'ASEMP Central Command Request'),(11,10,0,1,2,'Board power-up or reset triggered'),(12,0,1,0,0,'Zigbee Device Connected to Smart Controller Network'),(13,1,1,1,1,'Loss of Communication with Remote Device'),(14,2,1,1,2,'PAN ID Conflict'),(15,3,1,1,1,'PAN ID Resolution'),(16,4,1,1,0,'RF Interference'),(17,5,1,0,0,'RF Interference Resolution'),(18,0,2,1,0,'System Update Initiated by Admin'),(19,1,2,1,2,'DB Max Storage Level Reached'),(20,0,3,0,0,'Connection Was Successful'),(21,1,3,1,1,'First Failed Attempt to Connect to ISP Name Server'),(22,2,3,1,2,'Consecutive Failed Attempts to Connect to ISP Name Server'),(23,0,4,0,1,'Calculated Static Pressure Below Threshold'),(24,1,4,1,1,'Calculated Static Pressure Exceeded Threshold for the First Time'),(25,2,4,1,1,'Consecutive Calculated Static Pressure Values Exceeded Threshold'),(26,0,5,0,0,'Deletion of a Previously Added Zigbee Device'),(27,1,5,1,1,'Addition of a New Zigbee Device to the Smart Controller DB'),(28,2,5,0,0,'Update the ASEMP Profile of the Remote Device'),(29,3,5,0,0,'Update the Status of the Remote Device'),(30,4,5,0,0,'Update the Zigbee Short Address of the Remote Device'),(31,-1,0,0,0,'RetroSAVE Alarms'),(32,-1,1,0,0,'Zigbee Alarms'),(33,-1,2,0,0,'System Alarms'),(34,-1,3,0,0,'IP Network Alarms'),(35,-1,4,0,0,'Pressure Alarms'),(36,-1,5,0,0,'Registration Events'),(37,6,1,1,0,'Radio module unsuccessful restart'),(38,7,1,1,0,'Radio module successful restart'),(39,8,1,1,0,'Unable to create new zigbee network with passed parameters'),(40,9,1,1,0,'New Zigbee network successfully created'),(41,10,1,1,0,'Existing Zigbee network parameters change error'),(42,11,1,1,0,'Existing Zigbee network parameters successful change'),(43,12,1,1,0,'Unable to change configuration mode'),(44,13,1,1,0,'Configuration mode successfully enabled'),(45,14,1,1,0,'Configuration mode successfully disabled'),(46,15,1,1,0,'Network discovery result'),(47,16,1,1,0,'Ping remote device result'),(48,17,1,1,0,'Route discovery result'),(49,18,1,1,0,'non-ASE device command status'),(50,19,1,1,0,'ASEMP device command status'),(51,20,1,1,0,'Unable to set ZED enable or disable status'),(52,2,2,1,0,'Smart controller board unsuccessful restart'),(53,3,2,1,0,'Smart controller diagnostics result'),(54,4,2,1,0,'Set relays status error'),(55,5,2,1,0,'Onboard sensor read error'),(56,6,2,1,0,'Thermostat wires read error'),(57,7,2,1,0,'Unable to set RTC value'),(58,8,2,1,0,'Date and time received from RTC'),(59,9,2,1,0,'Unable to get RTC value'),(60,10,2,1,0,'Local sensor set status error'),(61,11,0,1,0,'AC current Upper threshold triggered'),(62,12,0,1,0,'ADC2 threshold triggered'),(63,13,0,1,0,'ADC3 threshold triggered'),(64,14,0,1,0,'ADC4 threshold triggered'),(65,15,0,1,0,'CO_Aout ADC1 threshold triggered'),(66,5,5,1,0,'Registration request from new device');
/*!40000 ALTER TABLE `alarms_types` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_alarms_types` AFTER INSERT ON `alarms_types`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_alarms_types IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_types'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_alarms_types` AFTER UPDATE ON `alarms_types`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_types IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_types';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_alarms_types` AFTER DELETE ON `alarms_types`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_types IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_types';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `alarms_zigbee`
--

DROP TABLE IF EXISTS `alarms_zigbee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alarms_zigbee` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `zone_id` int(11) DEFAULT NULL,
  `device_id` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `panid` int(11) DEFAULT NULL,
  `addr64` varchar(32) DEFAULT NULL,
  `address` int(11) DEFAULT NULL,
  `rssi` int(11) DEFAULT NULL,
  `channel` int(11) DEFAULT NULL,
  `type_` int(11) DEFAULT NULL,
  `severity` int(11) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarms_zigbee`
--

LOCK TABLES `alarms_zigbee` WRITE;
/*!40000 ALTER TABLE `alarms_zigbee` DISABLE KEYS */;
INSERT INTO `alarms_zigbee` VALUES (1,1,1,'2014-05-18 00:45:02',1111,'1111',1111,11,11,1,1,'signal loss'),(2,2,2,'2014-05-18 00:45:33',2222,'2222',2222,22,1,4,2,'interferecence'),(3,3,3,'2014-05-18 00:46:16',3333,'3333',3333,3,3,5,1,'all ok'),(4,1,1,'2014-05-19 23:25:50',1111,'111',111,11,11,1,0,'signal loss'),(5,2,2,'2014-05-19 23:26:15',1111,'111',111,11,11,1,0,'signal loss'),(6,NULL,0,'2014-06-16 13:54:51',NULL,'1122334455667788',NULL,NULL,NULL,6,2,'0x30 error'),(7,NULL,0,'2014-06-16 17:50:16',NULL,'',12345,NULL,NULL,7,1,'0x30 OK'),(8,NULL,0,'2014-06-16 18:18:19',NULL,NULL,NULL,NULL,NULL,8,2,'0x31 error'),(9,NULL,0,'2014-06-16 18:45:49',1234,'1122334455667788',5678,NULL,13,9,2,'0x31 OK'),(10,NULL,0,'2014-06-16 19:05:28',1234,NULL,NULL,NULL,NULL,11,2,'0x32 OK'),(11,NULL,0,'2014-06-16 19:05:54',NULL,NULL,NULL,NULL,NULL,10,2,'0x32 error'),(12,NULL,0,'2014-06-16 19:13:31',NULL,NULL,NULL,NULL,13,11,1,'0x33 OK'),(13,NULL,0,'2014-06-16 19:20:49',NULL,NULL,NULL,NULL,NULL,11,1,'0x34 OK'),(14,NULL,0,'2014-06-16 19:41:17',NULL,NULL,NULL,NULL,NULL,13,1,'0x35 OK'),(15,NULL,NULL,'2014-06-17 00:40:21',1234,'2233445566778899',5678,11,13,15,0,'0x37 OK'),(16,NULL,20,'2014-06-17 00:56:35',NULL,'1122334455667788',NULL,NULL,NULL,16,1,'0x38 error'),(17,NULL,20,'2014-06-17 00:58:45',NULL,'1122334455667788',NULL,NULL,NULL,16,0,'0x38 OK'),(18,NULL,NULL,'2014-06-17 17:22:00',NULL,'1122334455667788',1234,13,NULL,17,1,'0x37 OK : 2'),(19,NULL,NULL,'2014-06-17 17:22:18',NULL,'1122334455667788',1234,13,NULL,17,1,'0x37 OK : 2'),(20,NULL,0,'2014-06-18 13:12:58',NULL,NULL,NULL,NULL,NULL,18,1,'0x41 error'),(21,NULL,25,'2014-06-18 13:14:10',NULL,NULL,NULL,NULL,NULL,18,1,'0x41 error'),(22,NULL,25,'2014-06-18 13:15:14',NULL,NULL,NULL,NULL,NULL,18,0,'0x41 OK'),(23,NULL,25,'2014-06-18 13:26:42',NULL,NULL,NULL,NULL,NULL,18,0,'0x42 OK : 125'),(24,NULL,25,'2014-06-18 13:28:46',NULL,NULL,NULL,NULL,NULL,18,0,'0x41 OK : 1'),(25,NULL,25,'2014-06-18 21:06:40',NULL,NULL,NULL,NULL,NULL,19,2,'0x50 error'),(26,NULL,25,'2014-06-18 21:10:04',NULL,NULL,NULL,NULL,NULL,19,1,'0x50 OK : accepted'),(27,NULL,26,'2014-06-18 21:19:06',NULL,NULL,NULL,NULL,NULL,19,1,'0x50 OK : rejected'),(28,NULL,25,'2014-06-19 12:16:47',NULL,NULL,NULL,NULL,NULL,19,0,'0x51 OK'),(29,NULL,17,'2014-06-19 15:47:32',NULL,NULL,NULL,NULL,NULL,19,1,'0x52 error'),(30,NULL,17,'2014-06-19 15:48:19',NULL,NULL,NULL,NULL,NULL,19,0,'0x52 OK'),(31,NULL,17,'2014-06-19 16:36:08',NULL,NULL,NULL,NULL,NULL,19,0,'0x52 OK : 1'),(32,NULL,37,'2014-06-19 16:43:50',NULL,NULL,NULL,NULL,NULL,19,1,'0x53 error'),(33,NULL,37,'2014-06-19 16:45:12',NULL,NULL,NULL,NULL,NULL,19,0,'0x53 OK : -1'),(34,NULL,37,'2014-06-19 16:56:22',NULL,NULL,NULL,NULL,NULL,19,0,'0x55 OK : 0'),(35,NULL,27,'2014-06-20 00:42:28',NULL,NULL,NULL,NULL,NULL,19,0,'0x52 OK : 27'),(36,NULL,25,'2014-06-20 00:46:11',NULL,NULL,NULL,NULL,NULL,19,0,'0x56 OK : 0'),(37,NULL,0,'2014-11-28 17:54:41',NULL,NULL,NULL,NULL,NULL,13,1,'0x35 OK'),(38,NULL,0,'2014-11-28 18:03:12',NULL,NULL,NULL,NULL,NULL,13,1,'0x35 OK'),(39,NULL,0,'2014-11-29 04:09:18',NULL,NULL,NULL,NULL,NULL,13,1,'0x35 OK');
/*!40000 ALTER TABLE `alarms_zigbee` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_alarms_zigbee` AFTER INSERT ON `alarms_zigbee`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_alarms_zigbee IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_zigbee'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_alarms_zigbee` AFTER UPDATE ON `alarms_zigbee`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_zigbee IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_zigbee';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_alarms_zigbee` AFTER DELETE ON `alarms_zigbee`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_zigbee IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_zigbee';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `asemp`
--

DROP TABLE IF EXISTS `asemp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asemp` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) NOT NULL DEFAULT '0',
  `parameter` varchar(50) NOT NULL,
  `value` int(11) DEFAULT NULL,
  `default_` int(11) NOT NULL DEFAULT '0',
  `description` varchar(200) DEFAULT NULL,
  `type_` tinyint(4) NOT NULL DEFAULT '0',
  `units` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=569 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asemp`
--

LOCK TABLES `asemp` WRITE;
/*!40000 ALTER TABLE `asemp` DISABLE KEYS */;
INSERT INTO `asemp` VALUES (1,0,'occu_pir',0,0,'Occupied PIR Trigger Enable',0,NULL),(2,0,'unoccu_pir',1,1,'Unoccupied PIR Trigger Enable',0,NULL),(3,0,'occu_rep',120,120,'Occupied Reporting Period',1,'seconds'),(4,0,'unoccu_rep',360,360,'Unoccupied Reporting Period\r\n',1,'seconds'),(5,0,'min_rep_int',60,60,'Minimum Time Interval Between Consecutive Unsolicited Reports',1,'seconds'),(6,0,'bat_stat_thr',10,10,'Battery Status Trigger Value Threshold',1,NULL),(7,0,'ac_curr_thr',0,0,'AC current upper threshold trigger',1,'Ampere'),(8,0,'up_temp_tr',35,35,'Upper Temperature Value Report Trigger\r\n',1,'degree C'),(9,0,'lo_temp_tr',5,5,'Lower Temperature Value Report Trigger\r\n',1,'degree C'),(10,0,'up_hum_tr',60,60,'Upper Humidity Value Report Trigger',1,'% RH'),(11,0,'lo_hum_tr',30,30,'Lower Humidity Value Report Trigger',1,'% RH'),(12,0,'mcu_sleep',0,0,'MCU sleep timer. CC2530 wakeup sleep timer',1,'sec'),(13,0,'max_retry',3,3,'ASEMP Max Retry Count',1,NULL),(14,0,'max_wait',60,60,'ASEMP MAX Wait Timer',1,'seconds'),(15,0,'up_co_tr',0,0,'Upper CO Value Trigger Report',1,'ppm'),(16,0,'up_co2_tr',1000,1000,'Upper CO2 Value Trigger Report\r\n',1,'ppm'),(17,0,'aud_alarm',1,1,'Audible Alarm Enable',0,NULL),(18,0,'led_alarm',1,1,'LED Alarm Enable',0,NULL),(19,0,'name',0,0,'Default ASEMP Profile',2,NULL),(474,4,'aud_alarm',1,1,'aud_alarm',0,''),(475,4,'bat_stat_thr',10,10,'bat_stat_thr',0,''),(476,4,'led_alarm',1,1,'led_alarm',0,''),(477,4,'lo_hum_tr',30,30,'lo_hum_tr',0,''),(478,4,'lo_temp_tr',5,5,'lo_temp_tr',0,''),(479,4,'lux_sl_tr',1,1,'lux_sl_tr',0,''),(480,4,'max_retry',3,3,'max_retry',0,''),(481,4,'max_wait',60,60,'max_wait',0,''),(482,4,'min_rep_int',60,60,'min_rep_int',0,''),(483,4,'occu_pir',0,0,'occu_pir',0,''),(484,4,'occu_rep',120,120,'occu_rep',0,''),(485,4,'temp_sl_tr',0,0,'temp_sl_tr',0,''),(486,4,'unoccu_pir',1,1,'unoccu_pir',0,''),(487,4,'unoccu_rep',360,360,'unoccu_rep',0,''),(488,4,'up_co2_tr',1000,1000,'up_co2_tr',0,''),(489,4,'up_co_tr',0,0,'up_co_tr',0,''),(490,4,'up_hum_tr',60,60,'up_hum_tr',0,''),(491,4,'up_temp_tr',35,35,'up_temp_tr',0,''),(492,4,'name',0,0,'User Defined ASEMP Profile 4',2,''),(531,3,'aud_alarm',0,0,'aud_alarm',0,''),(532,3,'bat_stat_thr',13,13,'bat_stat_thr',0,''),(533,3,'led_alarm',0,0,'led_alarm',0,''),(534,3,'lo_hum_tr',13,13,'lo_hum_tr',0,''),(535,3,'lo_temp_tr',13,13,'lo_temp_tr',0,''),(536,3,'lux_sl_tr',13,13,'lux_sl_tr',0,''),(537,3,'max_retry',13,13,'max_retry',0,''),(538,3,'max_wait',13,13,'max_wait',0,''),(539,3,'min_rep_int',13,13,'min_rep_int',0,''),(540,3,'occu_pir',1,1,'occu_pir',0,''),(541,3,'occu_rep',11,11,'occu_rep',0,''),(542,3,'temp_sl_tr',13,13,'temp_sl_tr',0,''),(543,3,'unoccu_pir',1,1,'unoccu_pir',0,''),(544,3,'unoccu_rep',11,11,'unoccu_rep',0,''),(545,3,'up_co2_tr',13,13,'up_co2_tr',0,''),(546,3,'up_co_tr',13,13,'up_co_tr',0,''),(547,3,'up_hum_tr',13,13,'up_hum_tr',0,''),(548,3,'up_temp_tr',13,13,'up_temp_tr',0,''),(549,3,'name',0,0,'User Defined ASEMP Profile 3',2,''),(550,2,'aud_alarm',1,1,'aud_alarm',0,''),(551,2,'bat_stat_thr',10,10,'bat_stat_thr',0,''),(552,2,'led_alarm',1,1,'led_alarm',0,''),(553,2,'lo_hum_tr',30,30,'lo_hum_tr',0,''),(554,2,'lo_temp_tr',5,5,'lo_temp_tr',0,''),(555,2,'lux_sl_tr',0,0,'lux_sl_tr',0,''),(556,2,'max_retry',3,3,'max_retry',0,''),(557,2,'max_wait',60,60,'max_wait',0,''),(558,2,'min_rep_int',60,60,'min_rep_int',0,''),(559,2,'occu_pir',0,0,'occu_pir',0,''),(560,2,'occu_rep',122,122,'occu_rep',0,''),(561,2,'temp_sl_tr',0,0,'temp_sl_tr',0,''),(562,2,'unoccu_pir',1,1,'unoccu_pir',0,''),(563,2,'unoccu_rep',360,360,'unoccu_rep',0,''),(564,2,'up_co2_tr',1000,1000,'up_co2_tr',0,''),(565,2,'up_co_tr',0,0,'up_co_tr',0,''),(566,2,'up_hum_tr',60,60,'up_hum_tr',0,''),(567,2,'up_temp_tr',35,35,'up_temp_tr',0,''),(568,2,'name',0,0,'User Defined ASEMP Profile 2',2,'');
/*!40000 ALTER TABLE `asemp` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_asemp` AFTER INSERT ON `asemp`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_asemp IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'asemp'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_asemp` AFTER UPDATE ON `asemp`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_asemp IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'asemp';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_asemp` AFTER DELETE ON `asemp`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_asemp IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'asemp';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `bypass`
--

DROP TABLE IF EXISTS `bypass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bypass` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `updated` datetime DEFAULT NULL,
  `type_` int(11) DEFAULT '0',
  `status` int(11) DEFAULT '0',
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bypass`
--

LOCK TABLES `bypass` WRITE;
/*!40000 ALTER TABLE `bypass` DISABLE KEYS */;
INSERT INTO `bypass` VALUES (1,'2014-04-06 01:01:01',0,0,'test switch toggle'),(2,'2014-04-06 02:02:02',1,0,'test switch toggle 2'),(3,'2014-05-16 20:35:22',2,1,'Toggle from mobile app'),(4,'2014-05-16 20:35:23',2,0,'Toggle from mobile app'),(5,'2014-05-16 20:35:44',2,1,'Toggle from mobile app'),(6,'2014-05-16 20:41:14',2,0,'Toggle from mobile app'),(7,'2014-05-16 20:41:17',2,1,'Toggle from mobile app'),(8,'2014-05-16 20:41:18',2,0,'Toggle from mobile app'),(9,'2014-05-16 20:41:20',2,1,'Toggle from mobile app'),(10,'2014-05-16 20:41:22',2,0,'Toggle from mobile app'),(11,'2014-05-19 13:07:26',2,1,'Toggle from mobile app'),(12,'2014-05-19 13:07:28',2,0,'Toggle from mobile app'),(13,'2014-05-19 13:10:07',2,1,'Toggle from mobile app'),(14,'2014-05-19 13:10:28',2,0,'Toggle from mobile app'),(15,'2014-10-22 02:13:21',0,1,NULL),(16,'2014-10-27 23:55:10',2,0,'Toggle from mobile app'),(17,'2014-11-25 02:25:42',1,0,'Toggle from webui'),(18,'2014-11-25 02:26:07',1,1,'Toggle from webui'),(19,'2014-12-23 01:07:24',2,0,'Toggle from mobile app'),(20,'2014-12-23 01:07:28',2,1,'Toggle from mobile app'),(21,'2014-12-23 01:07:29',2,0,'Toggle from mobile app');
/*!40000 ALTER TABLE `bypass` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_bypass` AFTER INSERT ON `bypass`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_bypass IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'bypass'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_bypass` AFTER UPDATE ON `bypass`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_bypass IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'bypass';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_bypass` AFTER DELETE ON `bypass`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_bypass IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'bypass';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `commands`
--

DROP TABLE IF EXISTS `commands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` datetime NOT NULL,
  `command` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  `device_id` int(11) DEFAULT NULL,
  `type_` int(11) DEFAULT NULL,
  `parameters` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=542 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commands`
--

LOCK TABLES `commands` WRITE;
/*!40000 ALTER TABLE `commands` DISABLE KEYS */;
INSERT INTO `commands` VALUES (185,'2014-11-03 15:39:55',116,0,0,NULL,NULL,'13'),(186,'2014-11-03 15:39:55',118,0,0,NULL,NULL,'13'),(187,'2014-11-03 15:43:31',115,0,0,NULL,NULL,'13'),(188,'2014-11-05 01:18:51',116,0,0,NULL,NULL,'14'),(189,'2014-11-05 01:18:51',118,0,0,NULL,NULL,'14'),(190,'2014-11-05 01:18:51',120,0,0,NULL,NULL,'14'),(191,'2014-11-05 01:18:51',119,0,0,NULL,NULL,'14'),(192,'2014-11-05 01:19:08',115,0,0,NULL,NULL,'14'),(193,'2014-11-05 01:19:27',116,0,0,NULL,NULL,'14'),(194,'2014-11-05 01:22:34',38,0,0,NULL,NULL,NULL),(195,'2014-11-05 01:32:07',116,0,0,NULL,NULL,'15'),(196,'2014-11-05 01:32:07',118,0,0,NULL,NULL,'15'),(197,'2014-11-05 01:32:07',120,0,0,NULL,NULL,'15'),(198,'2014-11-05 01:32:07',119,0,0,NULL,NULL,'15'),(199,'2014-11-12 23:57:44',126,0,0,NULL,NULL,'$unixtime'),(200,'2014-11-12 23:59:23',126,0,0,NULL,NULL,'$unixtime'),(201,'2014-11-13 00:01:05',126,0,0,NULL,NULL,'$unixtime'),(202,'2014-11-13 14:36:46',126,0,0,NULL,NULL,'1415882160'),(203,'2014-11-13 23:19:32',126,0,0,NULL,NULL,'1415906340'),(204,'2014-11-24 20:16:50',53,0,0,NULL,NULL,'1'),(205,'2014-11-24 20:17:00',53,0,0,NULL,NULL,'0'),(206,'2014-11-24 20:24:07',80,0,0,3,NULL,NULL),(207,'2014-11-24 20:24:08',80,0,0,26,NULL,NULL),(208,'2014-11-24 20:24:09',54,0,0,NULL,NULL,NULL),(209,'2014-11-24 20:24:10',80,0,0,NULL,NULL,NULL),(210,'2014-11-24 20:24:11',80,0,0,NULL,NULL,NULL),(211,'2014-11-24 20:28:57',80,0,0,3,NULL,NULL),(212,'2014-11-24 20:44:00',80,0,0,NULL,NULL,NULL),(213,'2014-11-24 20:51:59',80,0,0,NULL,NULL,NULL),(214,'2014-11-24 20:51:59',54,0,0,NULL,NULL,'2'),(215,'2014-11-24 20:54:31',80,0,0,27,NULL,NULL),(216,'2014-11-24 20:56:18',57,0,0,28,NULL,NULL),(217,'2014-11-24 20:56:18',80,0,0,28,NULL,NULL),(218,'2014-11-24 20:56:44',53,0,0,NULL,NULL,'1'),(219,'2014-11-24 21:18:34',117,0,0,NULL,5,'0'),(220,'2014-11-24 21:18:34',117,0,0,NULL,5,'1'),(221,'2014-11-24 21:18:34',117,0,0,NULL,5,'2'),(222,'2014-11-24 21:18:34',117,0,0,NULL,5,'3'),(223,'2014-11-24 21:18:34',117,0,0,NULL,5,'5 1'),(224,'2014-11-24 21:18:34',117,0,0,NULL,5,'5 2'),(225,'2014-11-24 21:18:34',117,0,0,NULL,5,'5 3'),(226,'2014-11-24 21:18:34',117,0,0,NULL,5,'5 4'),(227,'2014-11-25 00:49:08',116,0,0,NULL,NULL,'15'),(228,'2014-11-25 00:49:08',118,0,0,NULL,NULL,'15'),(229,'2014-11-25 00:49:08',120,0,0,NULL,NULL,'15'),(230,'2014-11-25 00:49:08',119,0,0,NULL,NULL,'15'),(231,'2014-11-25 00:49:51',116,0,0,NULL,NULL,'16'),(232,'2014-11-25 00:49:51',118,0,0,NULL,NULL,'16'),(233,'2014-11-25 00:49:51',120,0,0,NULL,NULL,'16'),(234,'2014-11-25 00:49:51',119,0,0,NULL,NULL,'16'),(235,'2014-11-25 00:50:08',116,0,0,NULL,NULL,'17'),(236,'2014-11-25 00:50:08',118,0,0,NULL,NULL,'17'),(237,'2014-11-25 00:50:08',120,0,0,NULL,NULL,'17'),(238,'2014-11-25 00:50:08',119,0,0,NULL,NULL,'17'),(239,'2014-11-25 00:50:47',116,0,0,NULL,NULL,'18'),(240,'2014-11-25 00:50:47',118,0,0,NULL,NULL,'18'),(241,'2014-11-25 00:50:47',120,0,0,NULL,NULL,'18'),(242,'2014-11-25 00:50:47',119,0,0,NULL,NULL,'18'),(243,'2014-11-25 00:53:50',116,0,0,NULL,NULL,'19'),(244,'2014-11-25 00:53:50',118,0,0,NULL,NULL,'19'),(245,'2014-11-25 00:53:50',120,0,0,NULL,NULL,'19'),(246,'2014-11-25 00:53:50',119,0,0,NULL,NULL,'19'),(247,'2014-11-25 01:03:10',116,0,0,NULL,NULL,'20'),(248,'2014-11-25 01:03:10',118,0,0,NULL,NULL,'20'),(249,'2014-11-25 01:03:10',120,0,0,NULL,NULL,'20'),(250,'2014-11-25 01:03:10',119,0,0,NULL,NULL,'20'),(251,'2014-11-25 01:21:59',116,0,0,NULL,NULL,'21'),(252,'2014-11-25 01:21:59',118,0,0,NULL,NULL,'21'),(253,'2014-11-25 19:43:23',116,0,0,NULL,NULL,'8'),(254,'2014-11-25 19:43:23',118,0,0,NULL,NULL,'8'),(255,'2014-11-27 20:46:34',117,0,0,NULL,5,'0'),(256,'2014-11-27 20:46:34',117,0,0,NULL,5,'1'),(257,'2014-11-27 20:46:34',117,0,0,NULL,5,'2'),(258,'2014-11-27 20:46:34',117,0,0,NULL,5,'3'),(259,'2014-11-27 20:46:34',117,0,0,NULL,5,'5 1'),(260,'2014-11-27 20:46:34',117,0,0,NULL,5,'5 2'),(261,'2014-11-27 20:46:34',117,0,0,NULL,5,'5 3'),(262,'2014-11-27 20:46:34',117,0,0,NULL,5,'5 4'),(263,'2014-11-28 17:35:11',53,0,0,NULL,NULL,'0'),(264,'2014-11-28 17:35:13',53,0,0,NULL,NULL,'1'),(265,'2014-11-28 17:48:53',53,0,0,NULL,NULL,'0'),(266,'2014-11-28 17:48:54',53,0,0,NULL,NULL,'1'),(267,'2014-11-28 17:50:45',53,0,0,NULL,NULL,'0'),(268,'2014-11-28 17:50:46',53,0,0,NULL,NULL,'1 120'),(269,'2014-11-28 17:59:09',53,0,0,NULL,NULL,'1 1440'),(270,'2014-11-28 17:59:18',53,0,0,NULL,NULL,'1 0'),(271,'2014-11-28 17:59:20',53,0,0,NULL,NULL,'0'),(272,'2014-11-28 17:59:21',53,0,0,NULL,NULL,'1 0'),(273,'2014-11-28 18:01:09',53,0,0,NULL,NULL,'1 15'),(274,'2014-11-28 18:09:31',53,0,0,NULL,NULL,'1 120'),(275,'2014-11-28 18:09:36',53,0,0,NULL,NULL,'1 60'),(276,'2014-11-28 18:09:39',53,0,0,NULL,NULL,'1 1440'),(277,'2014-11-28 18:09:47',53,0,0,NULL,NULL,'1 5'),(278,'2014-11-28 18:09:57',53,0,0,NULL,NULL,'1 30'),(279,'2014-11-28 18:17:01',53,0,0,NULL,NULL,'1 5'),(280,'2014-11-28 18:17:03',53,0,0,NULL,NULL,'1 15'),(281,'2014-11-28 18:17:05',53,0,0,NULL,NULL,'1 0'),(282,'2014-11-28 18:17:08',53,0,0,NULL,NULL,'1 1440'),(283,'2014-11-28 18:17:12',53,0,0,NULL,NULL,'1 30'),(284,'2014-11-28 18:18:49',53,0,0,NULL,NULL,'1 60'),(285,'2014-11-29 02:39:59',57,0,0,NULL,NULL,'30'),(286,'2014-11-29 02:40:06',57,0,0,NULL,NULL,'30'),(287,'2014-11-29 02:43:46',57,0,0,NULL,NULL,'30'),(288,'2014-11-29 02:45:02',57,0,0,NULL,NULL,'30'),(289,'2014-11-29 03:18:22',57,0,0,NULL,NULL,'29'),(290,'2014-11-29 03:19:04',57,0,0,NULL,NULL,'29'),(291,'2014-11-29 03:19:20',57,0,0,NULL,NULL,'29'),(292,'2014-11-29 03:19:20',57,0,0,NULL,NULL,'30'),(293,'2014-11-29 03:19:30',57,0,0,NULL,NULL,'29'),(294,'2014-11-29 03:19:30',57,0,0,NULL,NULL,'30'),(295,'2014-11-29 03:19:36',57,0,0,NULL,NULL,'29'),(296,'2014-11-29 03:19:36',57,0,0,NULL,NULL,'30'),(297,'2014-11-29 03:29:19',57,0,0,NULL,NULL,'29'),(298,'2014-11-29 03:29:19',57,0,0,NULL,NULL,'30'),(299,'2014-11-29 03:30:40',57,0,0,NULL,NULL,'29'),(300,'2014-11-29 03:30:40',57,0,0,NULL,NULL,'30'),(301,'2014-11-29 03:30:48',57,0,0,NULL,NULL,'29'),(302,'2014-11-29 03:30:48',57,0,0,NULL,NULL,'30'),(303,'2014-11-29 03:32:29',57,0,0,NULL,NULL,'29'),(304,'2014-11-29 03:32:29',57,0,0,NULL,NULL,'29'),(305,'2014-11-29 03:32:29',57,0,0,NULL,NULL,'30'),(306,'2014-11-29 03:33:00',57,0,0,NULL,NULL,'29'),(307,'2014-11-29 03:33:00',57,0,0,NULL,NULL,'29'),(308,'2014-11-29 03:33:00',57,0,0,NULL,NULL,'30'),(309,'2014-11-29 03:33:00',57,0,0,NULL,NULL,'30'),(310,'2014-11-29 03:34:12',57,0,0,NULL,NULL,'30'),(311,'2014-11-29 03:34:25',57,0,0,NULL,NULL,'30'),(312,'2014-11-29 03:35:12',57,0,0,NULL,NULL,'29'),(313,'2014-11-29 03:35:12',57,0,0,NULL,NULL,'30'),(314,'2014-11-29 03:41:23',57,0,0,NULL,NULL,'29'),(315,'2014-11-29 03:41:29',57,0,0,NULL,NULL,'29'),(316,'2014-11-29 03:41:29',57,0,0,NULL,NULL,'30'),(317,'2014-11-29 04:07:44',53,0,0,NULL,NULL,'1 1440'),(318,'2014-11-29 04:07:48',53,0,0,NULL,NULL,'1 120'),(319,'2014-11-29 04:09:23',53,0,0,NULL,NULL,'1 30'),(320,'2014-11-29 04:09:26',53,0,0,NULL,NULL,'1 60'),(321,'2014-11-29 04:09:32',53,0,0,NULL,NULL,'1 5'),(322,'2014-11-29 04:09:34',53,0,0,NULL,NULL,'1 15'),(323,'2014-11-29 04:09:37',53,0,0,NULL,NULL,'0'),(324,'2014-11-29 04:09:39',53,0,0,NULL,NULL,'1 15'),(325,'2014-12-12 13:31:36',115,0,0,NULL,NULL,'3'),(326,'2014-12-12 13:54:26',115,0,0,NULL,NULL,'5'),(327,'2014-12-13 02:04:34',117,0,0,NULL,5,'0'),(328,'2014-12-13 02:04:34',117,0,0,NULL,5,'1'),(329,'2014-12-13 02:04:34',117,0,0,NULL,5,'2'),(330,'2014-12-13 02:04:34',117,0,0,NULL,5,'3'),(331,'2014-12-13 02:04:34',117,0,0,NULL,5,'5 1'),(332,'2014-12-13 02:04:34',117,0,0,NULL,5,'5 2'),(333,'2014-12-13 02:04:34',117,0,0,NULL,5,'5 3'),(334,'2014-12-13 02:04:34',117,0,0,NULL,5,'5 4'),(335,'2014-12-13 02:07:13',117,0,0,NULL,5,'0'),(336,'2014-12-13 02:07:13',117,0,0,NULL,5,'1'),(337,'2014-12-13 02:07:13',117,0,0,NULL,5,'2'),(338,'2014-12-13 02:07:13',117,0,0,NULL,5,'3'),(339,'2014-12-13 02:07:13',117,0,0,NULL,5,'5 1'),(340,'2014-12-13 02:07:13',117,0,0,NULL,5,'5 2'),(341,'2014-12-13 02:07:13',117,0,0,NULL,5,'5 3'),(342,'2014-12-13 02:07:13',117,0,0,NULL,5,'5 4'),(343,'2014-12-17 02:12:08',117,0,0,NULL,5,'0'),(344,'2014-12-17 02:12:08',117,0,0,NULL,5,'1'),(345,'2014-12-17 02:12:08',117,0,0,NULL,5,'2'),(346,'2014-12-17 02:12:08',117,0,0,NULL,5,'3'),(347,'2014-12-17 02:12:08',117,0,0,NULL,5,'5 1'),(348,'2014-12-17 02:12:08',117,0,0,NULL,5,'5 2'),(349,'2014-12-17 02:12:08',117,0,0,NULL,5,'5 3'),(350,'2014-12-17 02:12:08',117,0,0,NULL,5,'5 4'),(351,'2014-12-17 02:15:34',117,0,0,NULL,5,'0'),(352,'2014-12-17 02:15:34',117,0,0,NULL,5,'1'),(353,'2014-12-17 02:15:34',117,0,0,NULL,5,'2'),(354,'2014-12-17 02:15:34',117,0,0,NULL,5,'3'),(355,'2014-12-17 02:15:34',117,0,0,NULL,5,'5 1'),(356,'2014-12-17 02:15:34',117,0,0,NULL,5,'5 2'),(357,'2014-12-17 02:15:34',117,0,0,NULL,5,'5 3'),(358,'2014-12-17 02:15:34',117,0,0,NULL,5,'5 4'),(359,'2014-12-17 02:15:35',117,0,0,NULL,5,'0'),(360,'2014-12-17 02:15:35',117,0,0,NULL,5,'1'),(361,'2014-12-17 02:15:35',117,0,0,NULL,5,'2'),(362,'2014-12-17 02:15:35',117,0,0,NULL,5,'3'),(363,'2014-12-17 02:15:35',117,0,0,NULL,5,'5 1'),(364,'2014-12-17 02:15:35',117,0,0,NULL,5,'5 2'),(365,'2014-12-17 02:15:35',117,0,0,NULL,5,'5 3'),(366,'2014-12-17 02:15:35',117,0,0,NULL,5,'5 4'),(367,'2014-12-18 18:47:57',117,0,0,NULL,5,'0'),(368,'2014-12-18 18:47:57',117,0,0,NULL,5,'1'),(369,'2014-12-18 18:47:57',117,0,0,NULL,5,'2'),(370,'2014-12-18 18:47:57',117,0,0,NULL,5,'3'),(371,'2014-12-18 18:47:57',117,0,0,NULL,5,'5 1'),(372,'2014-12-18 18:47:57',117,0,0,NULL,5,'5 2'),(373,'2014-12-18 18:47:57',117,0,0,NULL,5,'5 3'),(374,'2014-12-18 18:47:57',117,0,0,NULL,5,'5 4'),(375,'2014-12-18 18:47:57',117,0,0,NULL,5,'4 1121212'),(376,'2014-12-18 18:50:51',117,0,0,NULL,5,'0'),(377,'2014-12-18 18:50:51',117,0,0,NULL,5,'1'),(378,'2014-12-18 18:50:51',117,0,0,NULL,5,'2'),(379,'2014-12-18 18:50:51',117,0,0,NULL,5,'3'),(380,'2014-12-18 18:50:51',117,0,0,NULL,5,'5 1'),(381,'2014-12-18 18:50:51',117,0,0,NULL,5,'5 2'),(382,'2014-12-18 18:50:51',117,0,0,NULL,5,'5 3'),(383,'2014-12-18 18:50:51',117,0,0,NULL,5,'5 4'),(384,'2014-12-18 18:50:51',117,0,0,NULL,5,'4 1121212'),(385,'2014-12-22 21:20:07',19,0,0,NULL,10,'1'),(386,'2014-12-22 21:20:07',20,0,0,NULL,11,'9'),(387,'2014-12-22 21:20:07',19,0,0,NULL,10,'1'),(388,'2014-12-22 21:20:07',20,0,0,NULL,11,'9'),(389,'2014-12-22 21:20:09',19,0,0,NULL,10,'3'),(390,'2014-12-22 21:20:09',20,0,0,NULL,11,'11'),(391,'2014-12-22 21:20:09',19,0,0,NULL,10,'3'),(392,'2014-12-22 21:20:09',20,0,0,NULL,11,'11'),(393,'2014-12-22 21:20:15',19,0,0,NULL,10,'0'),(394,'2014-12-22 21:20:15',19,0,0,NULL,10,'0'),(395,'2014-12-22 21:21:05',20,0,0,NULL,11,'1'),(396,'2014-12-22 21:21:05',20,0,0,NULL,11,'9'),(397,'2014-12-22 21:21:05',20,0,0,NULL,11,'1'),(398,'2014-12-22 21:21:05',20,0,0,NULL,11,'9'),(399,'2014-12-22 21:21:06',20,0,0,NULL,11,'2'),(400,'2014-12-22 21:21:06',20,0,0,NULL,11,'10'),(401,'2014-12-22 21:21:06',20,0,0,NULL,11,'2'),(402,'2014-12-22 21:21:06',20,0,0,NULL,11,'10'),(403,'2014-12-22 21:21:06',20,0,0,NULL,11,'3'),(404,'2014-12-22 21:21:06',20,0,0,NULL,11,'11'),(405,'2014-12-22 21:21:06',20,0,0,NULL,11,'3'),(406,'2014-12-22 21:21:06',20,0,0,NULL,11,'11'),(407,'2014-12-22 21:21:07',20,0,0,NULL,11,'5'),(408,'2014-12-22 21:21:07',20,0,0,NULL,11,'13'),(409,'2014-12-22 21:21:07',20,0,0,NULL,11,'5'),(410,'2014-12-22 21:21:07',20,0,0,NULL,11,'13'),(411,'2014-12-22 21:21:08',20,0,0,NULL,11,'6'),(412,'2014-12-22 21:21:08',20,0,0,NULL,11,'14'),(413,'2014-12-22 21:21:08',20,0,0,NULL,11,'6'),(414,'2014-12-22 21:21:08',20,0,0,NULL,11,'14'),(415,'2014-12-22 21:21:08',20,0,0,NULL,11,'0'),(416,'2014-12-22 21:21:08',20,0,0,NULL,11,'0'),(417,'2014-12-22 21:21:28',19,0,0,NULL,10,'1'),(418,'2014-12-22 21:21:28',20,0,0,NULL,11,'9'),(419,'2014-12-22 21:21:28',19,0,0,NULL,10,'1'),(420,'2014-12-22 21:21:28',20,0,0,NULL,11,'9'),(421,'2014-12-22 21:21:29',19,0,0,NULL,10,'2'),(422,'2014-12-22 21:21:29',20,0,0,NULL,11,'10'),(423,'2014-12-22 21:21:29',19,0,0,NULL,10,'2'),(424,'2014-12-22 21:21:29',20,0,0,NULL,11,'10'),(425,'2014-12-22 21:21:29',19,0,0,NULL,10,'3'),(426,'2014-12-22 21:21:29',20,0,0,NULL,11,'11'),(427,'2014-12-22 21:21:29',19,0,0,NULL,10,'3'),(428,'2014-12-22 21:21:29',20,0,0,NULL,11,'11'),(429,'2014-12-22 21:21:30',19,0,0,NULL,10,'4'),(430,'2014-12-22 21:21:30',20,0,0,NULL,11,'12'),(431,'2014-12-22 21:21:30',19,0,0,NULL,10,'4'),(432,'2014-12-22 21:21:30',20,0,0,NULL,11,'12'),(433,'2014-12-22 21:21:30',19,0,0,NULL,10,'5'),(434,'2014-12-22 21:21:30',20,0,0,NULL,11,'13'),(435,'2014-12-22 21:21:30',19,0,0,NULL,10,'5'),(436,'2014-12-22 21:21:30',20,0,0,NULL,11,'13'),(437,'2014-12-22 21:21:31',19,0,0,NULL,10,'6'),(438,'2014-12-22 21:21:31',20,0,0,NULL,11,'14'),(439,'2014-12-22 21:21:31',19,0,0,NULL,10,'6'),(440,'2014-12-22 21:21:31',20,0,0,NULL,11,'14'),(441,'2014-12-22 21:21:31',19,0,0,NULL,10,'7'),(442,'2014-12-22 21:21:31',19,0,0,NULL,10,'15'),(443,'2014-12-22 21:21:31',19,0,0,NULL,10,'7'),(444,'2014-12-22 21:21:31',19,0,0,NULL,10,'15'),(445,'2014-12-22 21:21:32',19,0,0,NULL,10,'0'),(446,'2014-12-22 21:21:32',19,0,0,NULL,10,'0'),(447,'2014-12-22 21:21:32',19,0,0,NULL,10,'8'),(448,'2014-12-22 21:21:32',19,0,0,NULL,10,'8'),(449,'2014-12-22 21:21:51',20,0,0,NULL,11,'2'),(450,'2014-12-22 21:21:51',20,0,0,NULL,11,'10'),(451,'2014-12-22 21:21:51',20,0,0,NULL,11,'2'),(452,'2014-12-22 21:21:51',20,0,0,NULL,11,'10'),(453,'2014-12-22 21:21:51',20,0,0,NULL,11,'4'),(454,'2014-12-22 21:21:51',20,0,0,NULL,11,'12'),(455,'2014-12-22 21:21:51',20,0,0,NULL,11,'4'),(456,'2014-12-22 21:21:51',20,0,0,NULL,11,'12'),(457,'2014-12-22 21:21:56',20,0,0,NULL,11,'0'),(458,'2014-12-22 21:21:56',20,0,0,NULL,11,'0'),(459,'2014-12-22 21:21:58',20,0,0,NULL,11,'5'),(460,'2014-12-22 21:21:58',20,0,0,NULL,11,'13'),(461,'2014-12-22 21:21:58',20,0,0,NULL,11,'5'),(462,'2014-12-22 21:21:58',20,0,0,NULL,11,'13'),(463,'2014-12-23 03:42:06',20,0,0,NULL,11,'3'),(464,'2014-12-23 03:42:06',20,0,0,NULL,11,'11'),(465,'2014-12-23 03:42:06',20,0,0,NULL,11,'3'),(466,'2014-12-23 03:42:06',20,0,0,NULL,11,'11'),(467,'2014-12-23 03:42:23',19,0,0,NULL,10,'2'),(468,'2014-12-23 03:42:23',20,0,0,NULL,11,'10'),(469,'2014-12-23 03:42:23',19,0,0,NULL,10,'2'),(470,'2014-12-23 03:42:23',20,0,0,NULL,11,'10'),(471,'2014-12-23 03:42:24',19,0,0,NULL,10,'3'),(472,'2014-12-23 03:42:24',20,0,0,NULL,11,'11'),(473,'2014-12-23 03:42:24',19,0,0,NULL,10,'3'),(474,'2014-12-23 03:42:24',20,0,0,NULL,11,'11'),(475,'2014-12-23 17:57:32',117,0,0,NULL,5,'0'),(476,'2014-12-23 17:57:32',117,0,0,NULL,5,'1'),(477,'2014-12-23 17:57:32',117,0,0,NULL,5,'2'),(478,'2014-12-23 17:57:32',117,0,0,NULL,5,'3'),(479,'2014-12-23 17:57:32',117,0,0,NULL,5,'5 1'),(480,'2014-12-23 17:57:32',117,0,0,NULL,5,'5 2'),(481,'2014-12-23 17:57:32',117,0,0,NULL,5,'5 3'),(482,'2014-12-23 17:57:32',117,0,0,NULL,5,'5 4'),(483,'2014-12-23 17:57:32',117,0,0,NULL,5,'4 1121212'),(484,'2014-12-23 18:13:43',19,0,0,NULL,10,'0'),(485,'2014-12-23 18:13:43',19,0,0,NULL,10,'0'),(486,'2014-12-23 18:15:39',20,0,0,NULL,11,'21'),(487,'2014-12-23 18:15:39',20,0,0,NULL,11,'21'),(488,'2015-01-06 23:14:37',117,0,0,NULL,5,'0'),(489,'2015-01-06 23:14:37',117,0,0,NULL,5,'1'),(490,'2015-01-06 23:14:37',117,0,0,NULL,5,'2'),(491,'2015-01-06 23:14:37',117,0,0,NULL,5,'3'),(492,'2015-01-06 23:14:37',117,0,0,NULL,5,'5 1'),(493,'2015-01-06 23:14:37',117,0,0,NULL,5,'5 2'),(494,'2015-01-06 23:14:37',117,0,0,NULL,5,'5 3'),(495,'2015-01-06 23:14:37',117,0,0,NULL,5,'5 4'),(496,'2015-01-06 23:14:37',117,0,0,NULL,5,'4 1121212'),(497,'2015-01-07 00:11:39',117,0,0,NULL,5,'0'),(498,'2015-01-07 00:11:39',117,0,0,NULL,5,'1'),(499,'2015-01-07 00:11:39',117,0,0,NULL,5,'2'),(500,'2015-01-07 00:11:39',117,0,0,NULL,5,'3'),(501,'2015-01-07 00:11:39',117,0,0,NULL,5,'5 1'),(502,'2015-01-07 00:11:39',117,0,0,NULL,5,'5 2'),(503,'2015-01-07 00:11:39',117,0,0,NULL,5,'5 3'),(504,'2015-01-07 00:11:39',117,0,0,NULL,5,'5 4'),(505,'2015-01-07 00:11:39',117,0,0,NULL,5,'4 1121212'),(506,'2015-01-07 00:14:34',117,0,0,NULL,5,'0'),(507,'2015-01-07 00:14:34',117,0,0,NULL,5,'1'),(508,'2015-01-07 00:14:34',117,0,0,NULL,5,'2'),(509,'2015-01-07 00:14:34',117,0,0,NULL,5,'3'),(510,'2015-01-07 00:14:34',117,0,0,NULL,5,'5 1'),(511,'2015-01-07 00:14:34',117,0,0,NULL,5,'5 2'),(512,'2015-01-07 00:14:34',117,0,0,NULL,5,'5 3'),(513,'2015-01-07 00:14:34',117,0,0,NULL,5,'5 4'),(514,'2015-01-07 00:14:34',117,0,0,NULL,5,'4 1121212'),(515,'2015-01-07 00:17:21',117,0,0,NULL,5,'0'),(516,'2015-01-07 00:17:21',117,0,0,NULL,5,'1'),(517,'2015-01-07 00:17:21',117,0,0,NULL,5,'2'),(518,'2015-01-07 00:17:21',117,0,0,NULL,5,'3'),(519,'2015-01-07 00:17:21',117,0,0,NULL,5,'5 1'),(520,'2015-01-07 00:17:21',117,0,0,NULL,5,'5 2'),(521,'2015-01-07 00:17:21',117,0,0,NULL,5,'5 3'),(522,'2015-01-07 00:17:21',117,0,0,NULL,5,'5 4'),(523,'2015-01-07 00:17:21',117,0,0,NULL,5,'4 1121212'),(524,'2015-01-07 00:17:25',117,0,0,NULL,5,'0'),(525,'2015-01-07 00:17:25',117,0,0,NULL,5,'1'),(526,'2015-01-07 00:17:25',117,0,0,NULL,5,'2'),(527,'2015-01-07 00:17:25',117,0,0,NULL,5,'3'),(528,'2015-01-07 00:17:25',117,0,0,NULL,5,'5 1'),(529,'2015-01-07 00:17:25',117,0,0,NULL,5,'5 2'),(530,'2015-01-07 00:17:25',117,0,0,NULL,5,'5 3'),(531,'2015-01-07 00:17:25',117,0,0,NULL,5,'5 4'),(532,'2015-01-07 00:17:25',117,0,0,NULL,5,'4 1121212'),(533,'2015-01-07 00:28:43',117,0,0,NULL,5,'0'),(534,'2015-01-07 00:28:43',117,0,0,NULL,5,'1'),(535,'2015-01-07 00:28:43',117,0,0,NULL,5,'2'),(536,'2015-01-07 00:28:43',117,0,0,NULL,5,'3'),(537,'2015-01-07 00:28:43',117,0,0,NULL,5,'5 1'),(538,'2015-01-07 00:28:43',117,0,0,NULL,5,'5 2'),(539,'2015-01-07 00:28:43',117,0,0,NULL,5,'5 3'),(540,'2015-01-07 00:28:43',117,0,0,NULL,5,'5 4'),(541,'2015-01-07 00:28:43',117,0,0,NULL,5,'4 1121212');
/*!40000 ALTER TABLE `commands` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER commands_actions
	AFTER INSERT
	ON commands
	FOR EACH ROW
BEGIN
  SET @ref_table = 'commands';
  SET @priority = 0;
  SET @rec_type = 0;
  INSERT INTO actions VALUES (0, @ref_table, NEW.id, @rec_type, @priority);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cots_data`
--

DROP TABLE IF EXISTS `cots_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cots_data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cots_id` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `name_` varchar(50) DEFAULT NULL,
  `value_` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=507 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cots_data`
--

LOCK TABLES `cots_data` WRITE;
/*!40000 ALTER TABLE `cots_data` DISABLE KEYS */;
INSERT INTO `cots_data` VALUES (1,1,'2014-11-19 02:24:40','humidity','25'),(2,1,'2014-11-19 02:24:40','has_fan','false'),(3,1,'2014-11-19 02:24:40','name','Office'),(4,1,'2014-11-19 02:24:40','can_heat','true'),(5,1,'2014-11-19 02:24:40','can_cool','true'),(6,1,'2014-11-19 02:24:40','hvac_mode','heat'),(7,1,'2014-11-19 02:24:40','target_temperature_c','16.0'),(8,1,'2014-11-19 02:24:40','target_temperature_f','61'),(9,1,'2014-11-19 02:24:40','target_temperature_high_c','25.0'),(10,1,'2014-11-19 02:24:40','target_temperature_high_f','77'),(11,1,'2014-11-19 02:24:40','target_temperature_low_c','18.0'),(12,1,'2014-11-19 02:24:40','target_temperature_low_f','65'),(13,1,'2014-11-19 02:24:40','ambient_temperature_c','21.0'),(14,1,'2014-11-19 02:24:40','ambient_temperature_f','70'),(15,1,'2014-11-19 02:24:40','away_temperature_high_c','29.0'),(16,1,'2014-11-19 02:24:40','away_temperature_high_f','84'),(17,1,'2014-11-19 02:24:40','away_temperature_low_c','16.0'),(18,1,'2014-11-19 02:24:40','away_temperature_low_f','61'),(19,1,'2014-11-19 02:24:40','is_online','false'),(20,1,'2014-11-19 02:24:40','last_connection','2014-11-19T00:14:25.947Z'),(21,1,'2014-11-19 02:24:40','name','Home'),(22,1,'2014-11-19 02:24:40','country_code','CA'),(23,1,'2014-11-19 02:24:40','away','home'),(24,1,'2014-11-19 02:25:21','humidity','25'),(25,1,'2014-11-19 02:25:21','has_fan','false'),(26,1,'2014-11-19 02:25:21','name','Office'),(27,1,'2014-11-19 02:25:21','can_heat','true'),(28,1,'2014-11-19 02:25:21','can_cool','true'),(29,1,'2014-11-19 02:25:21','hvac_mode','heat'),(30,1,'2014-11-19 02:25:21','target_temperature_c','16.0'),(31,1,'2014-11-19 02:25:21','target_temperature_f','61'),(32,1,'2014-11-19 02:25:21','target_temperature_high_c','25.0'),(33,1,'2014-11-19 02:25:21','target_temperature_high_f','77'),(34,1,'2014-11-19 02:25:21','target_temperature_low_c','18.0'),(35,1,'2014-11-19 02:25:21','target_temperature_low_f','65'),(36,1,'2014-11-19 02:25:21','ambient_temperature_c','21.0'),(37,1,'2014-11-19 02:25:21','ambient_temperature_f','70'),(38,1,'2014-11-19 02:25:21','away_temperature_high_c','29.0'),(39,1,'2014-11-19 02:25:21','away_temperature_high_f','84'),(40,1,'2014-11-19 02:25:21','away_temperature_low_c','16.0'),(41,1,'2014-11-19 02:25:21','away_temperature_low_f','61'),(42,1,'2014-11-19 02:25:21','is_online','true'),(43,1,'2014-11-19 02:25:21','last_connection','2014-11-19T00:25:21.270Z'),(44,1,'2014-11-19 02:25:21','name','Home'),(45,1,'2014-11-19 02:25:21','country_code','CA'),(46,1,'2014-11-19 02:25:21','away','home'),(47,1,'2014-11-19 02:25:21','humidity','25'),(48,1,'2014-11-19 02:25:21','has_fan','false'),(49,1,'2014-11-19 02:25:21','name','Office'),(50,1,'2014-11-19 02:25:21','can_heat','true'),(51,1,'2014-11-19 02:25:21','can_cool','true'),(52,1,'2014-11-19 02:25:21','hvac_mode','heat'),(53,1,'2014-11-19 02:25:21','target_temperature_c','16.0'),(54,1,'2014-11-19 02:25:21','target_temperature_f','61'),(55,1,'2014-11-19 02:25:21','target_temperature_high_c','25.0'),(56,1,'2014-11-19 02:25:21','target_temperature_high_f','77'),(57,1,'2014-11-19 02:25:21','target_temperature_low_c','18.0'),(58,1,'2014-11-19 02:25:21','target_temperature_low_f','65'),(59,1,'2014-11-19 02:25:21','ambient_temperature_c','20.5'),(60,1,'2014-11-19 02:25:21','ambient_temperature_f','70'),(61,1,'2014-11-19 02:25:21','away_temperature_high_c','29.0'),(62,1,'2014-11-19 02:25:21','away_temperature_high_f','84'),(63,1,'2014-11-19 02:25:21','away_temperature_low_c','16.0'),(64,1,'2014-11-19 02:25:21','away_temperature_low_f','61'),(65,1,'2014-11-19 02:25:21','is_online','true'),(66,1,'2014-11-19 02:25:21','last_connection','2014-11-19T00:25:21.270Z'),(67,1,'2014-11-19 02:25:21','name','Home'),(68,1,'2014-11-19 02:25:21','country_code','CA'),(69,1,'2014-11-19 02:25:21','away','home'),(70,1,'2014-11-19 02:25:23','humidity','25'),(71,1,'2014-11-19 02:25:23','has_fan','false'),(72,1,'2014-11-19 02:25:23','name','Office'),(73,1,'2014-11-19 02:25:23','can_heat','true'),(74,1,'2014-11-19 02:25:23','can_cool','true'),(75,1,'2014-11-19 02:25:23','hvac_mode','heat'),(76,1,'2014-11-19 02:25:23','target_temperature_c','16.0'),(77,1,'2014-11-19 02:25:23','target_temperature_f','61'),(78,1,'2014-11-19 02:25:23','target_temperature_high_c','25.0'),(79,1,'2014-11-19 02:25:23','target_temperature_high_f','77'),(80,1,'2014-11-19 02:25:23','target_temperature_low_c','18.0'),(81,1,'2014-11-19 02:25:23','target_temperature_low_f','65'),(82,1,'2014-11-19 02:25:23','ambient_temperature_c','20.5'),(83,1,'2014-11-19 02:25:23','ambient_temperature_f','70'),(84,1,'2014-11-19 02:25:23','away_temperature_high_c','29.0'),(85,1,'2014-11-19 02:25:23','away_temperature_high_f','84'),(86,1,'2014-11-19 02:25:23','away_temperature_low_c','16.0'),(87,1,'2014-11-19 02:25:23','away_temperature_low_f','61'),(88,1,'2014-11-19 02:25:23','is_online','true'),(89,1,'2014-11-19 02:25:23','last_connection','2014-11-19T00:25:22.704Z'),(90,1,'2014-11-19 02:25:23','name','Home'),(91,1,'2014-11-19 02:25:23','country_code','CA'),(92,1,'2014-11-19 02:25:23','away','home'),(93,1,'2014-11-19 02:25:23','humidity','25'),(94,1,'2014-11-19 02:25:23','has_fan','false'),(95,1,'2014-11-19 02:25:23','name','Office'),(96,1,'2014-11-19 02:25:23','can_heat','true'),(97,1,'2014-11-19 02:25:23','can_cool','true'),(98,1,'2014-11-19 02:25:23','hvac_mode','heat'),(99,1,'2014-11-19 02:25:23','target_temperature_c','16.5'),(100,1,'2014-11-19 02:25:23','target_temperature_f','62'),(101,1,'2014-11-19 02:25:23','target_temperature_high_c','25.0'),(102,1,'2014-11-19 02:25:23','target_temperature_high_f','77'),(103,1,'2014-11-19 02:25:23','target_temperature_low_c','18.0'),(104,1,'2014-11-19 02:25:23','target_temperature_low_f','65'),(105,1,'2014-11-19 02:25:23','ambient_temperature_c','20.5'),(106,1,'2014-11-19 02:25:23','ambient_temperature_f','70'),(107,1,'2014-11-19 02:25:23','away_temperature_high_c','29.0'),(108,1,'2014-11-19 02:25:23','away_temperature_high_f','84'),(109,1,'2014-11-19 02:25:23','away_temperature_low_c','16.0'),(110,1,'2014-11-19 02:25:23','away_temperature_low_f','61'),(111,1,'2014-11-19 02:25:23','is_online','true'),(112,1,'2014-11-19 02:25:23','last_connection','2014-11-19T00:25:22.704Z'),(113,1,'2014-11-19 02:25:23','name','Home'),(114,1,'2014-11-19 02:25:23','country_code','CA'),(115,1,'2014-11-19 02:25:23','away','home'),(116,1,'2014-11-19 02:25:24','humidity','25'),(117,1,'2014-11-19 02:25:24','has_fan','false'),(118,1,'2014-11-19 02:25:24','name','Office'),(119,1,'2014-11-19 02:25:24','can_heat','true'),(120,1,'2014-11-19 02:25:24','can_cool','true'),(121,1,'2014-11-19 02:25:24','hvac_mode','heat'),(122,1,'2014-11-19 02:25:24','target_temperature_c','16.5'),(123,1,'2014-11-19 02:25:24','target_temperature_f','62'),(124,1,'2014-11-19 02:25:24','target_temperature_high_c','25.0'),(125,1,'2014-11-19 02:25:24','target_temperature_high_f','77'),(126,1,'2014-11-19 02:25:24','target_temperature_low_c','18.0'),(127,1,'2014-11-19 02:25:24','target_temperature_low_f','65'),(128,1,'2014-11-19 02:25:24','ambient_temperature_c','20.5'),(129,1,'2014-11-19 02:25:24','ambient_temperature_f','70'),(130,1,'2014-11-19 02:25:24','away_temperature_high_c','29.0'),(131,1,'2014-11-19 02:25:24','away_temperature_high_f','84'),(132,1,'2014-11-19 02:25:24','away_temperature_low_c','16.0'),(133,1,'2014-11-19 02:25:24','away_temperature_low_f','61'),(134,1,'2014-11-19 02:25:24','is_online','true'),(135,1,'2014-11-19 02:25:24','last_connection','2014-11-19T00:25:23.933Z'),(136,1,'2014-11-19 02:25:24','name','Home'),(137,1,'2014-11-19 02:25:24','country_code','CA'),(138,1,'2014-11-19 02:25:24','away','home'),(139,1,'2014-11-19 02:25:24','humidity','25'),(140,1,'2014-11-19 02:25:24','has_fan','false'),(141,1,'2014-11-19 02:25:24','name','Office'),(142,1,'2014-11-19 02:25:24','can_heat','true'),(143,1,'2014-11-19 02:25:24','can_cool','true'),(144,1,'2014-11-19 02:25:24','hvac_mode','heat'),(145,1,'2014-11-19 02:25:24','target_temperature_c','17.0'),(146,1,'2014-11-19 02:25:24','target_temperature_f','63'),(147,1,'2014-11-19 02:25:24','target_temperature_high_c','25.0'),(148,1,'2014-11-19 02:25:24','target_temperature_high_f','77'),(149,1,'2014-11-19 02:25:24','target_temperature_low_c','18.0'),(150,1,'2014-11-19 02:25:24','target_temperature_low_f','65'),(151,1,'2014-11-19 02:25:24','ambient_temperature_c','20.5'),(152,1,'2014-11-19 02:25:24','ambient_temperature_f','70'),(153,1,'2014-11-19 02:25:24','away_temperature_high_c','29.0'),(154,1,'2014-11-19 02:25:24','away_temperature_high_f','84'),(155,1,'2014-11-19 02:25:24','away_temperature_low_c','16.0'),(156,1,'2014-11-19 02:25:24','away_temperature_low_f','61'),(157,1,'2014-11-19 02:25:24','is_online','true'),(158,1,'2014-11-19 02:25:24','last_connection','2014-11-19T00:25:23.933Z'),(159,1,'2014-11-19 02:25:24','name','Home'),(160,1,'2014-11-19 02:25:24','country_code','CA'),(161,1,'2014-11-19 02:25:24','away','home'),(162,1,'2014-11-19 02:53:40','humidity','25'),(163,1,'2014-11-19 02:53:40','has_fan','false'),(164,1,'2014-11-19 02:53:40','name','Office'),(165,1,'2014-11-19 02:53:40','can_heat','true'),(166,1,'2014-11-19 02:53:40','can_cool','true'),(167,1,'2014-11-19 02:53:40','hvac_mode','heat'),(168,1,'2014-11-19 02:53:40','target_temperature_c','17.5'),(169,1,'2014-11-19 02:53:40','target_temperature_f','64'),(170,1,'2014-11-19 02:53:40','target_temperature_high_c','25.0'),(171,1,'2014-11-19 02:53:40','target_temperature_high_f','77'),(172,1,'2014-11-19 02:53:40','target_temperature_low_c','18.0'),(173,1,'2014-11-19 02:53:40','target_temperature_low_f','65'),(174,1,'2014-11-19 02:53:40','ambient_temperature_c','21.0'),(175,1,'2014-11-19 02:53:40','ambient_temperature_f','70'),(176,1,'2014-11-19 02:53:40','away_temperature_high_c','29.0'),(177,1,'2014-11-19 02:53:40','away_temperature_high_f','84'),(178,1,'2014-11-19 02:53:40','away_temperature_low_c','16.0'),(179,1,'2014-11-19 02:53:40','away_temperature_low_f','61'),(180,1,'2014-11-19 02:53:40','is_online','true'),(181,1,'2014-11-19 02:53:40','last_connection','2014-11-19T00:41:57.837Z'),(182,1,'2014-11-19 02:53:40','name','Home'),(183,1,'2014-11-19 02:53:40','country_code','CA'),(184,1,'2014-11-19 02:53:40','away','home'),(185,1,'2014-11-19 02:54:43','humidity','25'),(186,1,'2014-11-19 02:54:43','has_fan','false'),(187,1,'2014-11-19 02:54:43','name','Office'),(188,1,'2014-11-19 02:54:43','can_heat','true'),(189,1,'2014-11-19 02:54:43','can_cool','true'),(190,1,'2014-11-19 02:54:43','hvac_mode','heat'),(191,1,'2014-11-19 02:54:43','target_temperature_c','18.0'),(192,1,'2014-11-19 02:54:43','target_temperature_f','64'),(193,1,'2014-11-19 02:54:43','target_temperature_high_c','25.0'),(194,1,'2014-11-19 02:54:43','target_temperature_high_f','77'),(195,1,'2014-11-19 02:54:43','target_temperature_low_c','18.0'),(196,1,'2014-11-19 02:54:43','target_temperature_low_f','65'),(197,1,'2014-11-19 02:54:43','ambient_temperature_c','21.0'),(198,1,'2014-11-19 02:54:43','ambient_temperature_f','70'),(199,1,'2014-11-19 02:54:43','away_temperature_high_c','29.0'),(200,1,'2014-11-19 02:54:43','away_temperature_high_f','84'),(201,1,'2014-11-19 02:54:43','away_temperature_low_c','16.0'),(202,1,'2014-11-19 02:54:44','away_temperature_low_f','61'),(203,1,'2014-11-19 02:54:44','is_online','true'),(204,1,'2014-11-19 02:54:44','last_connection','2014-11-19T00:41:57.837Z'),(205,1,'2014-11-19 02:54:44','name','Home'),(206,1,'2014-11-19 02:54:44','country_code','CA'),(207,1,'2014-11-19 02:54:44','away','home'),(208,1,'2014-11-19 02:54:44','humidity','25'),(209,1,'2014-11-19 02:54:44','has_fan','false'),(210,1,'2014-11-19 02:54:44','name','Office'),(211,1,'2014-11-19 02:54:44','can_heat','true'),(212,1,'2014-11-19 02:54:44','can_cool','true'),(213,1,'2014-11-19 02:54:44','hvac_mode','heat'),(214,1,'2014-11-19 02:54:44','target_temperature_c','18.0'),(215,1,'2014-11-19 02:54:45','target_temperature_f','64'),(216,1,'2014-11-19 02:54:45','target_temperature_high_c','25.0'),(217,1,'2014-11-19 02:54:45','target_temperature_high_f','77'),(218,1,'2014-11-19 02:54:45','target_temperature_low_c','18.0'),(219,1,'2014-11-19 02:54:45','target_temperature_low_f','65'),(220,1,'2014-11-19 02:54:45','ambient_temperature_c','21.0'),(221,1,'2014-11-19 02:54:45','ambient_temperature_f','70'),(222,1,'2014-11-19 02:54:45','away_temperature_high_c','29.0'),(223,1,'2014-11-19 02:54:45','away_temperature_high_f','84'),(224,1,'2014-11-19 02:54:45','away_temperature_low_c','16.0'),(225,1,'2014-11-19 02:54:45','away_temperature_low_f','61'),(226,1,'2014-11-19 02:54:45','is_online','true'),(227,1,'2014-11-19 02:54:45','last_connection','2014-11-19T00:54:44.204Z'),(228,1,'2014-11-19 02:54:45','name','Home'),(229,1,'2014-11-19 02:54:45','country_code','CA'),(230,1,'2014-11-19 02:54:45','away','home'),(231,1,'2014-11-19 02:54:45','humidity','25'),(232,1,'2014-11-19 02:54:45','has_fan','false'),(233,1,'2014-11-19 02:54:45','name','Office'),(234,1,'2014-11-19 02:54:45','can_heat','true'),(235,1,'2014-11-19 02:54:45','can_cool','true'),(236,1,'2014-11-19 02:54:45','hvac_mode','heat'),(237,1,'2014-11-19 02:54:46','target_temperature_c','18.0'),(238,1,'2014-11-19 02:54:46','target_temperature_f','64'),(239,1,'2014-11-19 02:54:46','target_temperature_high_c','25.0'),(240,1,'2014-11-19 02:54:46','target_temperature_high_f','77'),(241,1,'2014-11-19 02:54:46','target_temperature_low_c','18.0'),(242,1,'2014-11-19 02:54:46','target_temperature_low_f','65'),(243,1,'2014-11-19 02:54:46','ambient_temperature_c','21.0'),(244,1,'2014-11-19 02:54:46','ambient_temperature_f','70'),(245,1,'2014-11-19 02:54:46','away_temperature_high_c','29.0'),(246,1,'2014-11-19 02:54:46','away_temperature_high_f','84'),(247,1,'2014-11-19 02:54:46','away_temperature_low_c','16.0'),(248,1,'2014-11-19 02:54:46','away_temperature_low_f','61'),(249,1,'2014-11-19 02:54:46','is_online','true'),(250,1,'2014-11-19 02:54:46','last_connection','2014-11-19T00:54:45.233Z'),(251,1,'2014-11-19 02:54:46','name','Home'),(252,1,'2014-11-19 02:54:46','country_code','CA'),(253,1,'2014-11-19 02:54:46','away','home'),(254,1,'2014-11-19 02:54:46','humidity','25'),(255,1,'2014-11-19 02:54:46','has_fan','false'),(256,1,'2014-11-19 02:54:46','name','Office'),(257,1,'2014-11-19 02:54:46','can_heat','true'),(258,1,'2014-11-19 02:54:46','can_cool','true'),(259,1,'2014-11-19 02:54:46','hvac_mode','heat'),(260,1,'2014-11-19 02:54:46','target_temperature_c','18.0'),(261,1,'2014-11-19 02:54:46','target_temperature_f','64'),(262,1,'2014-11-19 02:54:46','target_temperature_high_c','25.0'),(263,1,'2014-11-19 02:54:46','target_temperature_high_f','77'),(264,1,'2014-11-19 02:54:46','target_temperature_low_c','18.0'),(265,1,'2014-11-19 02:54:46','target_temperature_low_f','65'),(266,1,'2014-11-19 02:54:46','ambient_temperature_c','20.5'),(267,1,'2014-11-19 02:54:46','ambient_temperature_f','70'),(268,1,'2014-11-19 02:54:46','away_temperature_high_c','29.0'),(269,1,'2014-11-19 02:54:46','away_temperature_high_f','84'),(270,1,'2014-11-19 02:54:46','away_temperature_low_c','16.0'),(271,1,'2014-11-19 02:54:46','away_temperature_low_f','61'),(272,1,'2014-11-19 02:54:46','is_online','true'),(273,1,'2014-11-19 02:54:46','last_connection','2014-11-19T00:54:45.233Z'),(274,1,'2014-11-19 02:54:46','name','Home'),(275,1,'2014-11-19 02:54:46','country_code','CA'),(276,1,'2014-11-19 02:54:46','away','home'),(277,1,'2014-11-19 02:54:46','humidity','25'),(278,1,'2014-11-19 02:54:46','has_fan','false'),(279,1,'2014-11-19 02:54:46','name','Office'),(280,1,'2014-11-19 02:54:46','can_heat','true'),(281,1,'2014-11-19 02:54:46','can_cool','true'),(282,1,'2014-11-19 02:54:47','hvac_mode','heat'),(283,1,'2014-11-19 02:54:47','target_temperature_c','18.0'),(284,1,'2014-11-19 02:54:47','target_temperature_f','64'),(285,1,'2014-11-19 02:54:47','target_temperature_high_c','25.0'),(286,1,'2014-11-19 02:54:47','target_temperature_high_f','77'),(287,1,'2014-11-19 02:54:47','target_temperature_low_c','18.0'),(288,1,'2014-11-19 02:54:47','target_temperature_low_f','65'),(289,1,'2014-11-19 02:54:47','ambient_temperature_c','20.5'),(290,1,'2014-11-19 02:54:47','ambient_temperature_f','70'),(291,1,'2014-11-19 02:54:47','away_temperature_high_c','29.0'),(292,1,'2014-11-19 02:54:47','away_temperature_high_f','84'),(293,1,'2014-11-19 02:54:47','away_temperature_low_c','16.0'),(294,1,'2014-11-19 02:54:47','away_temperature_low_f','61'),(295,1,'2014-11-19 02:54:47','is_online','true'),(296,1,'2014-11-19 02:54:47','last_connection','2014-11-19T00:54:46.250Z'),(297,1,'2014-11-19 02:54:47','name','Home'),(298,1,'2014-11-19 02:54:47','country_code','CA'),(299,1,'2014-11-19 02:54:47','away','home'),(300,1,'2014-11-19 02:54:47','humidity','25'),(301,1,'2014-11-19 02:54:47','has_fan','false'),(302,1,'2014-11-19 02:54:47','name','Office'),(303,1,'2014-11-19 02:54:47','can_heat','true'),(304,1,'2014-11-19 02:54:47','can_cool','true'),(305,1,'2014-11-19 02:54:47','hvac_mode','heat'),(306,1,'2014-11-19 02:54:47','target_temperature_c','18.0'),(307,1,'2014-11-19 02:54:47','target_temperature_f','64'),(308,1,'2014-11-19 02:54:47','target_temperature_high_c','25.0'),(309,1,'2014-11-19 02:54:47','target_temperature_high_f','77'),(310,1,'2014-11-19 02:54:47','target_temperature_low_c','18.0'),(311,1,'2014-11-19 02:54:47','target_temperature_low_f','65'),(312,1,'2014-11-19 02:54:47','ambient_temperature_c','20.5'),(313,1,'2014-11-19 02:54:47','ambient_temperature_f','70'),(314,1,'2014-11-19 02:54:47','away_temperature_high_c','29.0'),(315,1,'2014-11-19 02:54:47','away_temperature_high_f','84'),(316,1,'2014-11-19 02:54:47','away_temperature_low_c','16.0'),(317,1,'2014-11-19 02:54:47','away_temperature_low_f','61'),(318,1,'2014-11-19 02:54:47','is_online','true'),(319,1,'2014-11-19 02:54:47','last_connection','2014-11-19T00:54:46.251Z'),(320,1,'2014-11-19 02:54:47','name','Home'),(321,1,'2014-11-19 02:54:47','country_code','CA'),(322,1,'2014-11-19 02:54:47','away','home'),(323,1,'2014-11-19 02:54:49','humidity','25'),(324,1,'2014-11-19 02:54:49','has_fan','false'),(325,1,'2014-11-19 02:54:49','name','Office'),(326,1,'2014-11-19 02:54:49','can_heat','true'),(327,1,'2014-11-19 02:54:49','can_cool','true'),(328,1,'2014-11-19 02:54:49','hvac_mode','heat'),(329,1,'2014-11-19 02:54:49','target_temperature_c','18.0'),(330,1,'2014-11-19 02:54:49','target_temperature_f','64'),(331,1,'2014-11-19 02:54:49','target_temperature_high_c','25.0'),(332,1,'2014-11-19 02:54:49','target_temperature_high_f','77'),(333,1,'2014-11-19 02:54:49','target_temperature_low_c','18.0'),(334,1,'2014-11-19 02:54:49','target_temperature_low_f','65'),(335,1,'2014-11-19 02:54:49','ambient_temperature_c','20.5'),(336,1,'2014-11-19 02:54:49','ambient_temperature_f','70'),(337,1,'2014-11-19 02:54:49','away_temperature_high_c','29.0'),(338,1,'2014-11-19 02:54:49','away_temperature_high_f','84'),(339,1,'2014-11-19 02:54:49','away_temperature_low_c','16.0'),(340,1,'2014-11-19 02:54:49','away_temperature_low_f','61'),(341,1,'2014-11-19 02:54:49','is_online','true'),(342,1,'2014-11-19 02:54:49','last_connection','2014-11-19T00:54:48.712Z'),(343,1,'2014-11-19 02:54:49','name','Home'),(344,1,'2014-11-19 02:54:49','country_code','CA'),(345,1,'2014-11-19 02:54:49','away','home'),(346,1,'2014-11-19 02:54:49','humidity','25'),(347,1,'2014-11-19 02:54:49','has_fan','false'),(348,1,'2014-11-19 02:54:49','name','Office'),(349,1,'2014-11-19 02:54:49','can_heat','true'),(350,1,'2014-11-19 02:54:49','can_cool','true'),(351,1,'2014-11-19 02:54:49','hvac_mode','heat'),(352,1,'2014-11-19 02:54:49','target_temperature_c','18.0'),(353,1,'2014-11-19 02:54:49','target_temperature_f','64'),(354,1,'2014-11-19 02:54:49','target_temperature_high_c','25.0'),(355,1,'2014-11-19 02:54:49','target_temperature_high_f','77'),(356,1,'2014-11-19 02:54:49','target_temperature_low_c','18.0'),(357,1,'2014-11-19 02:54:49','target_temperature_low_f','65'),(358,1,'2014-11-19 02:54:49','ambient_temperature_c','20.5'),(359,1,'2014-11-19 02:54:49','ambient_temperature_f','70'),(360,1,'2014-11-19 02:54:49','away_temperature_high_c','29.0'),(361,1,'2014-11-19 02:54:49','away_temperature_high_f','84'),(362,1,'2014-11-19 02:54:49','away_temperature_low_c','16.0'),(363,1,'2014-11-19 02:54:49','away_temperature_low_f','61'),(364,1,'2014-11-19 02:54:49','is_online','true'),(365,1,'2014-11-19 02:54:49','last_connection','2014-11-19T00:54:48.712Z'),(366,1,'2014-11-19 02:54:49','name','Home'),(367,1,'2014-11-19 02:54:49','country_code','CA'),(368,1,'2014-11-19 02:54:49','away','home'),(369,1,'2014-11-20 01:29:34','humidity','25'),(370,1,'2014-11-20 01:29:34','has_fan','false'),(371,1,'2014-11-20 01:29:34','name','Office'),(372,1,'2014-11-20 01:29:34','can_heat','true'),(373,1,'2014-11-20 01:29:34','can_cool','true'),(374,1,'2014-11-20 01:29:34','hvac_mode','heat'),(375,1,'2014-11-20 01:29:34','target_temperature_c','16.0'),(376,1,'2014-11-20 01:29:34','target_temperature_f','61'),(377,1,'2014-11-20 01:29:34','target_temperature_high_c','24.0'),(378,1,'2014-11-20 01:29:34','target_temperature_high_f','75'),(379,1,'2014-11-20 01:29:34','target_temperature_low_c','20.0'),(380,1,'2014-11-20 01:29:34','target_temperature_low_f','68'),(381,1,'2014-11-20 01:29:34','ambient_temperature_c','22.0'),(382,1,'2014-11-20 01:29:34','ambient_temperature_f','72'),(383,1,'2014-11-20 01:29:34','away_temperature_high_c','29.0'),(384,1,'2014-11-20 01:29:34','away_temperature_high_f','84'),(385,1,'2014-11-20 01:29:34','away_temperature_low_c','16.0'),(386,1,'2014-11-20 01:29:34','away_temperature_low_f','61'),(387,1,'2014-11-20 01:29:34','is_online','false'),(388,1,'2014-11-20 01:29:34','last_connection','2014-11-19T23:20:45.978Z'),(389,1,'2014-11-20 01:29:34','name','Home'),(390,1,'2014-11-20 01:29:34','country_code','CA'),(391,1,'2014-11-20 01:29:34','away','home'),(392,1,'2014-11-20 02:30:36','name','Office'),(393,1,'2014-11-20 02:30:36','name','Home'),(394,1,'2014-11-20 17:05:20','humidity','25'),(395,1,'2014-11-20 17:05:20','has_fan','false'),(396,1,'2014-11-20 17:05:20','can_heat','true'),(397,1,'2014-11-20 17:05:20','can_cool','true'),(398,1,'2014-11-20 17:05:20','hvac_mode','heat'),(399,1,'2014-11-20 17:05:20','target_temperature_c','16.0'),(400,1,'2014-11-20 17:05:20','target_temperature_f','61'),(401,1,'2014-11-20 17:05:20','target_temperature_high_c','24.0'),(402,1,'2014-11-20 17:05:20','target_temperature_high_f','75'),(403,1,'2014-11-20 17:05:20','target_temperature_low_c','20.0'),(404,1,'2014-11-20 17:05:20','target_temperature_low_f','68'),(405,1,'2014-11-20 17:05:20','ambient_temperature_c','21.0'),(406,1,'2014-11-20 17:05:20','ambient_temperature_f','71'),(407,1,'2014-11-20 17:05:20','away_temperature_high_c','29.0'),(408,1,'2014-11-20 17:05:20','away_temperature_high_f','84'),(409,1,'2014-11-20 17:05:20','away_temperature_low_c','16.0'),(410,1,'2014-11-20 17:05:20','away_temperature_low_f','61'),(411,1,'2014-11-20 17:05:20','name_long','Office Thermostat (Table)'),(412,1,'2014-11-20 17:05:20','is_online','false'),(413,1,'2014-11-20 17:05:20','last_connection','2014-11-20T14:59:30.706Z'),(414,1,'2014-11-20 17:05:20','country_code','CA'),(415,1,'2014-11-20 17:05:20','away','home'),(416,1,'2014-11-20 17:08:17','humidity','25'),(417,1,'2014-11-20 17:08:17','has_fan','false'),(418,1,'2014-11-20 17:08:17','can_heat','true'),(419,1,'2014-11-20 17:08:17','can_cool','true'),(420,1,'2014-11-20 17:08:17','hvac_mode','heat'),(421,1,'2014-11-20 17:08:17','target_temperature_c','16.0'),(422,1,'2014-11-20 17:08:17','target_temperature_f','61'),(423,1,'2014-11-20 17:08:17','target_temperature_high_c','24.0'),(424,1,'2014-11-20 17:08:17','target_temperature_high_f','75'),(425,1,'2014-11-20 17:08:17','target_temperature_low_c','20.0'),(426,1,'2014-11-20 17:08:17','target_temperature_low_f','68'),(427,1,'2014-11-20 17:08:17','ambient_temperature_c','21.0'),(428,1,'2014-11-20 17:08:17','ambient_temperature_f','71'),(429,1,'2014-11-20 17:08:17','away_temperature_high_c','29.0'),(430,1,'2014-11-20 17:08:17','away_temperature_high_f','84'),(431,1,'2014-11-20 17:08:17','away_temperature_low_c','16.0'),(432,1,'2014-11-20 17:08:17','away_temperature_low_f','61'),(433,1,'2014-11-20 17:08:17','name_long','Office Thermostat (Table)'),(434,1,'2014-11-20 17:08:17','is_online','false'),(435,1,'2014-11-20 17:08:17','last_connection','2014-11-20T14:59:30.706Z'),(436,1,'2014-11-20 17:08:17','country_code','CA'),(437,1,'2014-11-20 17:08:17','away','home'),(438,1,'2014-11-20 17:10:25','humidity','25'),(439,1,'2014-11-20 17:10:25','has_fan','false'),(440,1,'2014-11-20 17:10:25','can_heat','true'),(441,1,'2014-11-20 17:10:25','can_cool','true'),(442,1,'2014-11-20 17:10:25','hvac_mode','heat'),(443,1,'2014-11-20 17:10:25','target_temperature_c','16.0'),(444,1,'2014-11-20 17:10:25','target_temperature_f','61'),(445,1,'2014-11-20 17:10:25','target_temperature_high_c','24.0'),(446,1,'2014-11-20 17:10:25','target_temperature_high_f','75'),(447,1,'2014-11-20 17:10:25','target_temperature_low_c','20.0'),(448,1,'2014-11-20 17:10:25','target_temperature_low_f','68'),(449,1,'2014-11-20 17:10:25','ambient_temperature_c','21.0'),(450,1,'2014-11-20 17:10:25','ambient_temperature_f','71'),(451,1,'2014-11-20 17:10:25','away_temperature_high_c','29.0'),(452,1,'2014-11-20 17:10:25','away_temperature_high_f','84'),(453,1,'2014-11-20 17:10:25','away_temperature_low_c','16.0'),(454,1,'2014-11-20 17:10:25','away_temperature_low_f','61'),(455,1,'2014-11-20 17:10:25','name_long','Office Thermostat (Table)'),(456,1,'2014-11-20 17:10:25','is_online','false'),(457,1,'2014-11-20 17:10:25','last_connection','2014-11-20T14:59:30.706Z'),(458,1,'2014-11-20 17:10:25','country_code','CA'),(459,1,'2014-11-20 17:10:25','away','home'),(460,1,'2014-11-20 17:12:07','humidity','25'),(461,1,'2014-11-20 17:12:07','has_fan','false'),(462,1,'2014-11-20 17:12:07','can_heat','true'),(463,1,'2014-11-20 17:12:07','can_cool','true'),(464,1,'2014-11-20 17:12:07','hvac_mode','heat'),(465,1,'2014-11-20 17:12:07','target_temperature_c','16.0'),(466,1,'2014-11-20 17:12:07','target_temperature_f','61'),(467,1,'2014-11-20 17:12:07','target_temperature_high_c','24.0'),(468,1,'2014-11-20 17:12:07','target_temperature_high_f','75'),(469,1,'2014-11-20 17:12:07','target_temperature_low_c','20.0'),(470,1,'2014-11-20 17:12:07','target_temperature_low_f','68'),(471,1,'2014-11-20 17:12:07','ambient_temperature_c','21.0'),(472,1,'2014-11-20 17:12:07','ambient_temperature_f','71'),(473,1,'2014-11-20 17:12:07','away_temperature_high_c','29.0'),(474,1,'2014-11-20 17:12:07','away_temperature_high_f','84'),(475,1,'2014-11-20 17:12:07','away_temperature_low_c','16.0'),(476,1,'2014-11-20 17:12:07','away_temperature_low_f','61'),(477,1,'2014-11-20 17:12:07','name_long','Office Thermostat (Table)'),(478,1,'2014-11-20 17:12:07','is_online','false'),(479,1,'2014-11-20 17:12:07','last_connection','2014-11-20T14:59:30.706Z'),(480,1,'2014-11-20 17:12:07','country_code','CA'),(481,1,'2014-11-20 17:12:07','away','home'),(482,1,'2014-11-20 17:26:48','humidity','25'),(483,1,'2014-11-20 17:26:48','has_fan','false'),(484,1,'2014-11-20 17:26:48','can_heat','true'),(485,1,'2014-11-20 17:26:48','can_cool','true'),(486,1,'2014-11-20 17:26:48','hvac_mode','heat'),(487,1,'2014-11-20 17:26:48','target_temperature_c','16.0'),(488,1,'2014-11-20 17:26:48','target_temperature_f','61'),(489,1,'2014-11-20 17:26:48','target_temperature_high_c','24.0'),(490,1,'2014-11-20 17:26:48','target_temperature_high_f','75'),(491,1,'2014-11-20 17:26:48','target_temperature_low_c','20.0'),(492,1,'2014-11-20 17:26:48','target_temperature_low_f','68'),(493,1,'2014-11-20 17:26:48','ambient_temperature_c','21.0'),(494,1,'2014-11-20 17:26:48','ambient_temperature_f','71'),(495,1,'2014-11-20 17:26:48','away_temperature_high_c','29.0'),(496,1,'2014-11-20 17:26:48','away_temperature_high_f','84'),(497,1,'2014-11-20 17:26:48','away_temperature_low_c','16.0'),(498,1,'2014-11-20 17:26:48','away_temperature_low_f','61'),(499,1,'2014-11-20 17:26:48','name_long','Office Thermostat (Table)'),(500,1,'2014-11-20 17:26:48','is_online','false'),(501,1,'2014-11-20 17:26:48','last_connection','2014-11-20T14:59:30.706Z'),(502,1,'2014-11-20 17:26:48','country_code','CA'),(503,1,'2014-11-20 17:26:48','away','home'),(504,1,'2014-11-20 17:27:38','error','307 Temporary Redirect\nCache'),(505,1,'2014-11-20 17:27:59','error','401 Unauthorized\nCache'),(506,1,'2014-11-20 17:29:41','error','401 Unauthorized');
/*!40000 ALTER TABLE `cots_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deviceadvanced`
--

DROP TABLE IF EXISTS `deviceadvanced`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deviceadvanced` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` int(11) NOT NULL,
  `type_` int(11) NOT NULL,
  `realvar1` double NOT NULL,
  `realvar2` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `device_id` (`device_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deviceadvanced`
--

LOCK TABLES `deviceadvanced` WRITE;
/*!40000 ALTER TABLE `deviceadvanced` DISABLE KEYS */;
INSERT INTO `deviceadvanced` VALUES (6,13,3,1,0),(5,13,2,1.2,0.2),(4,13,1,1.1,0.1);
/*!40000 ALTER TABLE `deviceadvanced` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_deviceadvanced` AFTER INSERT ON `deviceadvanced`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_deviceadvanced IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'deviceadvanced'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_deviceadvanced` AFTER UPDATE ON `deviceadvanced`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_deviceadvanced IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'deviceadvanced';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_deviceadvanced` AFTER DELETE ON `deviceadvanced`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_deviceadvanced IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'deviceadvanced';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `devices`
--

DROP TABLE IF EXISTS `devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zone_id` int(11) NOT NULL DEFAULT '1',
  `hardware_type` int(11) NOT NULL DEFAULT '0',
  `device_type` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `xbee_addr64` varchar(31) DEFAULT NULL,
  `asemp` int(11) NOT NULL DEFAULT '1',
  `serial` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `zone_id` (`zone_id`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices`
--

LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;
INSERT INTO `devices` VALUES (32,22,1,0,'ASE Louver','1122224455611766',0,''),(33,2,0,0,'ASE Sensor','1122334455611766',0,''),(34,1,0,80,'3rd Party Zigbee','1212121223112323',0,''),(31,1,0,80,'3rd Party Zigbee','1212121223232323',0,''),(30,1,0,0,'ASE Remotea','1122334455667788',3,''),(29,21,0,0,'ASE Remotezzz','1122334455667766',4,'');
/*!40000 ALTER TABLE `devices` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_devices` AFTER INSERT ON `devices`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_devices IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'devices'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_devices` AFTER UPDATE ON `devices`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_devices IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'devices';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_devices` AFTER DELETE ON `devices`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_devices IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'devices';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `devicesdyn`
--

DROP TABLE IF EXISTS `devicesdyn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devicesdyn` (
  `device_id` int(11) NOT NULL,
  `online` tinyint(1) DEFAULT NULL,
  `device_status` int(11) DEFAULT NULL,
  `updated_time` datetime DEFAULT NULL,
  `battery_charge` int(11) DEFAULT NULL,
  `remote_ack` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devicesdyn`
--

LOCK TABLES `devicesdyn` WRITE;
/*!40000 ALTER TABLE `devicesdyn` DISABLE KEYS */;
/*!40000 ALTER TABLE `devicesdyn` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_devicesdyn` AFTER INSERT ON `devicesdyn`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_devicesdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'devicesdyn'; 						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	
  INSERT INTO commands VALUES (NULL, NOW(), 57, 0, 0, NEW.device_id, NULL, NULL);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_devicesdyn` AFTER UPDATE ON `devicesdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_devicesdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'devicesdyn';						SET @pk_d_old = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; 
  IF (NEW.online != OLD.online) THEN
    INSERT INTO commands VALUES (NULL, NOW(), 57, 0, 0, NEW.device_id, NULL, NULL);
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_devicesdyn` AFTER DELETE ON `devicesdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_devicesdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'devicesdyn';						SET @pk_d = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `diagnostics`
--

DROP TABLE IF EXISTS `diagnostics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `diagnostics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` datetime DEFAULT NULL,
  `type_` int(11) DEFAULT '0',
  `event` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diagnostics`
--

LOCK TABLES `diagnostics` WRITE;
/*!40000 ALTER TABLE `diagnostics` DISABLE KEYS */;
INSERT INTO `diagnostics` VALUES (1,'2014-06-13 21:51:09',0,'ADC Probes test passed'),(2,'2014-06-13 21:52:26',1,'I2C Probes test failed');
/*!40000 ALTER TABLE `diagnostics` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_diagnostics` AFTER INSERT ON `diagnostics`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_diagnostics IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'diagnostics'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_diagnostics` AFTER UPDATE ON `diagnostics`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_diagnostics IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'diagnostics';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_diagnostics` AFTER DELETE ON `diagnostics`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_diagnostics IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'diagnostics';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type_` int(11) unsigned NOT NULL,
  `stages` int(11) unsigned NOT NULL,
  `maker` varchar(100) NOT NULL,
  `model` varchar(200) NOT NULL,
  `max_on` int(11) NOT NULL DEFAULT '0',
  `min_on` int(11) NOT NULL DEFAULT '0',
  `min_off` int(11) NOT NULL DEFAULT '0',
  `out_temp_cut` int(11) DEFAULT NULL,
  `cots_type` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_equipment` AFTER INSERT ON `equipment`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_equipment IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'equipment'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_equipment` AFTER UPDATE ON `equipment`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_equipment IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'equipment';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_equipment` AFTER DELETE ON `equipment`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_equipment IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'equipment';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `started` datetime NOT NULL,
  `ended` datetime DEFAULT NULL,
  `severity` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `description` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=83 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'2012-12-26 03:27:34',NULL,0,0,'Database init finished'),(2,'2012-12-28 03:46:18',NULL,3,2,'Dangerous CO2 (carbon dioxide) Level 6 ppm'),(0,'2013-01-10 19:17:31',NULL,3,2,'Dangerous CO (carbon monoxide) Level 2.000 ppm!'),(63,'2013-01-11 00:05:44',NULL,3,0,'Dangerous CO2 (carbon dioxide) Level 1007.000 ppm!'),(64,'2013-01-11 00:05:45',NULL,3,0,'Dangerous CO (carbon monoxide) Level 6.000 ppm!'),(65,'2013-01-11 00:08:14',NULL,3,2,'Dangerous CO2 (carbon dioxide) Level 1007.000 ppm!'),(66,'2013-01-11 00:08:14',NULL,3,2,'Dangerous CO (carbon monoxide) Level 6.000 ppm!'),(67,'2013-03-07 00:00:00',NULL,0,0,'UI version updated'),(68,'2013-03-11 17:00:00',NULL,0,2,'UI version updated'),(69,'2013-08-01 01:01:01',NULL,1,0,'Notification about something'),(70,'2013-08-01 01:02:03',NULL,2,0,'Low priority alarm about something'),(71,'2013-08-01 03:02:01',NULL,3,2,'Emergency! do something'),(72,'2013-09-23 01:01:01',NULL,3,2,'Test emergency event'),(73,'2013-09-23 02:02:02',NULL,3,0,'Another test emergency event'),(74,'2013-09-23 21:05:00',NULL,1,0,'Notification about new beta version to release'),(75,'2013-09-26 14:30:00',NULL,2,0,'Main page finished and tested'),(76,'2013-09-26 15:00:00',NULL,1,0,'lunch time!'),(77,'2013-11-29 17:47:50',NULL,1,0,'New simulation started'),(78,'2013-11-29 18:25:08',NULL,1,0,'New simulation started'),(79,'2013-11-29 18:26:10',NULL,1,0,'New simulation started'),(80,'2013-11-29 18:27:11',NULL,1,0,'New simulation started'),(81,'2013-11-29 18:28:12',NULL,1,0,'New simulation started'),(82,'2013-11-29 18:29:14',NULL,1,0,'New simulation started');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_events` AFTER INSERT ON `events`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_events IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'events'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_events` AFTER UPDATE ON `events`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_events IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'events';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_events` AFTER DELETE ON `events`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_events IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'events';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `history_store`
--

DROP TABLE IF EXISTS `history_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_store` (
  `timemark` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `table_name` tinytext NOT NULL,
  `pk_date_src` text NOT NULL,
  `pk_date_dest` text NOT NULL,
  `record_state` int(11) NOT NULL,
  PRIMARY KEY (`table_name`(100),`pk_date_dest`(100))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_store`
--

LOCK TABLES `history_store` WRITE;
/*!40000 ALTER TABLE `history_store` DISABLE KEYS */;
INSERT INTO `history_store` VALUES ('2014-05-20 15:53:26','smartstatus','<id>8</id>','<id>8</id>',2),('2014-12-23 22:42:50','users','<id>1</id>','<id>1</id>',2),('2014-05-22 16:51:46','hvac','<id>2224</id>','<id>2224</id>',2),('2014-06-20 18:05:55','zones','<id>17</id>','<id>17</id>',3),('2014-05-22 17:30:37','hvac','<id>2228</id>','<id>2228</id>',2),('2014-12-26 19:02:43','hvac','<id>118</id>','<id>118</id>',2),('2014-12-26 19:02:31','hvac','<id>1100</id>','<id>1178</id>',2),('2014-05-22 21:40:58','notifications','<id>3</id>','<id>3</id>',2),('2014-06-10 22:04:57','relays','<id>3</id>','<id>3</id>',1),('2014-06-10 22:05:47','relays','<id>4</id>','<id>4</id>',1),('2014-06-12 21:44:45','alarms_system','<id>3</id>','<id>3</id>',1),('2014-06-12 21:53:27','alarms_system','<id>4</id>','<id>4</id>',1),('2014-06-12 22:39:05','smartsensors','<id>5</id>','<id>5</id>',1),('2014-06-12 22:50:31','thermostat','<id>4</id>','<id>4</id>',1),('2014-06-12 22:59:07','smartsensors','<id>6</id>','<id>6</id>',1),('2014-06-12 23:05:32','smartsensors','<id>7</id>','<id>7</id>',1),('2014-06-13 18:15:18','smartsensorsraw','<id>4</id>','<id>4</id>',1),('2014-06-13 18:52:26','diagnostics','<id>2</id>','<id>2</id>',1),('2014-06-16 14:51:02','alarms_zigbee','<id>6</id>','<id>6</id>',1),('2014-06-16 14:50:16','alarms_zigbee','<id>7</id>','<id>7</id>',1),('2014-06-16 15:18:19','alarms_zigbee','<id>8</id>','<id>8</id>',1),('2014-06-16 15:45:49','alarms_zigbee','<id>9</id>','<id>9</id>',1),('2014-12-13 00:14:09','zigbee','<id>1</id>','<id>1</id>',2),('2014-06-16 16:05:28','alarms_zigbee','<id>10</id>','<id>10</id>',1),('2014-06-16 16:05:54','alarms_zigbee','<id>11</id>','<id>11</id>',1),('2014-06-16 16:13:31','alarms_zigbee','<id>12</id>','<id>12</id>',1),('2014-06-16 16:20:49','alarms_zigbee','<id>13</id>','<id>13</id>',1),('2014-06-16 16:41:17','alarms_zigbee','<id>14</id>','<id>14</id>',1),('2014-11-29 01:45:35','registrations','<id>12</id>','<id>12</id>',1),('2014-06-16 21:40:21','alarms_zigbee','<id>15</id>','<id>15</id>',1),('2014-06-16 21:56:35','alarms_zigbee','<id>16</id>','<id>16</id>',1),('2014-06-16 21:58:45','alarms_zigbee','<id>17</id>','<id>17</id>',1),('2014-06-17 14:22:00','alarms_zigbee','<id>18</id>','<id>18</id>',1),('2014-06-17 14:22:18','alarms_zigbee','<id>19</id>','<id>19</id>',1),('2014-11-29 01:45:35','zigbee_ha','<id>2</id>','<id>2</id>',1),('2014-11-29 00:23:12','registrations','<id>11</id>','<id>11</id>',1),('2014-11-29 01:33:00','devices','<id>30</id>','<id>30</id>',1),('2014-06-18 10:12:58','alarms_zigbee','<id>20</id>','<id>20</id>',1),('2014-06-18 10:14:10','alarms_zigbee','<id>21</id>','<id>21</id>',1),('2014-06-18 10:15:14','alarms_zigbee','<id>22</id>','<id>22</id>',1),('2014-06-18 10:26:42','alarms_zigbee','<id>23</id>','<id>23</id>',1),('2014-06-18 10:28:46','alarms_zigbee','<id>24</id>','<id>24</id>',1),('2014-06-19 15:22:54','smartplugsdyn','<device_id>25</device_id>','<device_id>25</device_id>',2),('2014-11-29 02:09:39','hvac','<id>120</id>','<id>120</id>',2),('2014-06-18 18:06:40','alarms_zigbee','<id>25</id>','<id>25</id>',1),('2014-06-18 18:10:04','alarms_zigbee','<id>26</id>','<id>26</id>',1),('2014-11-29 01:41:29','zigbee_ase','<id>4</id>','<id>4</id>',1),('2014-11-29 00:23:13','registrations','<id>10</id>','<id>10</id>',1),('2014-06-18 18:19:06','alarms_zigbee','<id>27</id>','<id>27</id>',1),('2014-06-19 09:16:47','alarms_zigbee','<id>28</id>','<id>28</id>',1),('2014-06-19 12:41:09','paramflapdyn','<device_id>17</device_id>','<device_id>17</device_id>',1),('2014-06-19 12:47:32','alarms_zigbee','<id>29</id>','<id>29</id>',1),('2014-06-19 12:48:19','alarms_zigbee','<id>30</id>','<id>30</id>',1),('2014-06-19 13:23:08','remotecontrol','<id>1</id>','<id>1</id>',1),('2014-06-19 13:23:22','remotecontrol','<id>3</id>','<id>3</id>',1),('2014-06-19 13:24:02','remotecontrol','<id>4</id>','<id>4</id>',1),('2014-06-19 13:36:08','alarms_zigbee','<id>31</id>','<id>31</id>',1),('2014-06-19 13:41:36','remotecontrol','<id>5</id>','<id>5</id>',1),('2014-06-19 13:43:50','alarms_zigbee','<id>32</id>','<id>32</id>',1),('2014-06-19 13:45:12','alarms_zigbee','<id>33</id>','<id>33</id>',1),('2014-06-19 13:56:22','alarms_zigbee','<id>34</id>','<id>34</id>',1),('2014-06-19 21:23:07','sensorsdyn','<id>1</id>','<id>1</id>',1),('2014-06-19 21:31:52','sensorsdyn','<id>2</id>','<id>2</id>',1),('2014-06-19 21:42:28','alarms_zigbee','<id>35</id>','<id>35</id>',1),('2014-06-19 21:46:11','alarms_zigbee','<id>36</id>','<id>36</id>',1),('2014-09-01 17:59:32','hvac','<id>3175</id>','<id>1185</id>',2),('2014-06-20 18:05:54','zonesdyn','<zone_id>14</zone_id>','<zone_id>14</zone_id>',3),('2014-06-20 18:05:54','zones','<id>14</id>','<id>14</id>',3),('2014-06-20 18:05:55','zonesdyn','<zone_id>17</zone_id>','<zone_id>17</zone_id>',3),('2014-06-20 18:05:56','zonesdyn','<zone_id>19</zone_id>','<zone_id>19</zone_id>',3),('2014-06-20 18:05:56','zones','<id>19</id>','<id>19</id>',3),('2014-09-01 22:58:43','devices','<id>18</id>','<id>18</id>',3),('2014-09-01 22:58:43','devices','<id>19</id>','<id>19</id>',3),('2014-09-01 22:58:43','devices','<id>20</id>','<id>20</id>',3),('2014-09-01 22:58:43','devices','<id>21</id>','<id>21</id>',3),('2014-07-01 14:58:02','relays','<id>5</id>','<id>5</id>',1),('2014-07-09 23:00:58','remotecontrol','<id>6</id>','<id>6</id>',1),('2014-07-14 09:32:49','asemp','<id>12</id>','<id>20</id>',1),('2014-07-14 09:32:46','asemp','<id>12</id>','<id>12</id>',3),('2014-07-14 09:34:40','asemp','<id>7</id>','<id>7</id>',2),('2014-11-25 00:26:07','hvac','<id>1210</id>','<id>1200</id>',2),('2014-07-14 16:57:51','sensorsdyn','<id>3</id>','<id>3</id>',1),('2014-12-12 11:43:14','smartdevices','<id>3</id>','<id>17</id>',1),('2014-09-15 21:31:13','smartdevices','<id>2</id>','<id>2</id>',3),('2014-12-12 13:57:06','hvac','<id>4</id>','<id>4</id>',2),('2014-07-30 10:45:13','zonesdyn','<zone_id>0</zone_id>','<zone_id>0</zone_id>',1),('2014-08-12 22:27:02','zones','<id>20</id>','<id>20</id>',1),('2014-07-30 10:52:47','zonesdyn','<zone_id>20</zone_id>','<zone_id>20</zone_id>',1),('2014-08-12 22:27:02','zones','<id>21</id>','<id>21</id>',1),('2014-07-30 13:21:27','zonesdyn','<zone_id>21</zone_id>','<zone_id>21</zone_id>',1),('2014-08-12 22:27:02','zones','<id>22</id>','<id>22</id>',1),('2014-07-30 13:21:40','zonesdyn','<zone_id>22</zone_id>','<zone_id>22</zone_id>',1),('2014-08-12 22:27:02','zones','<id>3</id>','<id>3</id>',2),('2014-12-15 23:41:36','networks','<id>1</id>','<id>1</id>',2),('2014-09-01 22:12:24','hvac','<id>1201</id>','<id>2230</id>',1),('2014-09-01 22:12:24','hvac','<id>1202</id>','<id>2231</id>',1),('2014-09-01 22:09:19','hvac','<id>2232</id>','<id>2232</id>',1),('2014-09-01 22:09:19','hvac','<id>2233</id>','<id>2233</id>',1),('2014-08-12 22:27:02','zones','<id>6</id>','<id>6</id>',2),('2014-08-12 22:27:02','zones','<id>4</id>','<id>4</id>',2),('2014-08-12 22:27:02','zones','<id>5</id>','<id>5</id>',2),('2014-08-25 09:42:26','hvac','<id>78</id>','<id>2234</id>',1),('2014-11-24 23:40:42','hvac','<id>1189</id>','<id>1192</id>',2),('2014-11-28 23:38:03','devices','<id>24</id>','<id>24</id>',3),('2014-11-29 00:43:16','zigbee_ase','<id>1</id>','<id>1</id>',3),('2014-11-28 22:43:38','registrations','<id>2</id>','<id>2</id>',3),('2014-11-29 01:45:13','devices','<id>29</id>','<id>29</id>',1),('2014-11-28 23:38:03','devices','<id>17</id>','<id>17</id>',3),('2014-09-01 15:49:01','devicesdyn','<device_id>16</device_id>','<device_id>16</device_id>',3),('2014-11-24 19:16:17','smartdevices','<id>1</id>','<id>1</id>',3),('2014-11-24 23:40:31','hvac','<id>1188</id>','<id>1191</id>',2),('2014-09-01 17:55:40','hvac','<id>3189</id>','<id>1189</id>',2),('2014-09-01 17:55:43','hvac','<id>3188</id>','<id>1188</id>',2),('2014-09-01 18:00:06','hvac','<id>3167</id>','<id>1187</id>',2),('2014-09-01 18:00:00','hvac','<id>3166</id>','<id>1186</id>',2),('2014-09-01 17:59:28','hvac','<id>3174</id>','<id>1184</id>',2),('2014-09-01 17:59:25','hvac','<id>3173</id>','<id>1183</id>',2),('2014-09-01 17:59:22','hvac','<id>3172</id>','<id>1182</id>',2),('2014-09-01 17:59:18','hvac','<id>3171</id>','<id>1181</id>',2),('2014-09-01 18:00:19','hvac','<id>3151</id>','<id>3207</id>',1),('2014-09-01 18:00:14','hvac','<id>3150</id>','<id>3208</id>',1),('2014-12-22 22:15:50','users','<id>2</id>','<id>2</id>',2),('2014-09-01 22:12:24','hvac','<id>1195</id>','<id>1195</id>',2),('2014-09-01 22:12:24','hvac','<id>1196</id>','<id>1196</id>',2),('2014-09-01 22:12:24','hvac','<id>1197</id>','<id>1197</id>',2),('2014-09-01 22:12:24','hvac','<id>1198</id>','<id>1198</id>',2),('2014-09-01 22:09:19','hvac','<id>107</id>','<id>107</id>',2),('2014-09-01 22:58:43','devices','<id>23</id>','<id>23</id>',3),('2014-09-01 22:58:43','devices','<id>22</id>','<id>22</id>',3),('2014-09-10 21:18:01','hvac','<id>1203</id>','<id>3209</id>',1),('2014-09-10 21:20:32','hvac','<id>3210</id>','<id>3210</id>',1),('2014-09-10 21:22:05','hvac','<id>3211</id>','<id>3211</id>',1),('2014-09-11 21:35:00','ui_menu','<id>57</id>','<id>57</id>',1),('2014-11-24 23:21:59','smartdevices','<id>21</id>','<id>21</id>',1),('2014-11-28 23:37:59','devicesdyn','<device_id>22</device_id>','<device_id>22</device_id>',3),('2014-09-17 10:59:04','relays','<id>6</id>','<id>6</id>',1),('2014-09-17 10:59:40','relays','<id>7</id>','<id>7</id>',1),('2014-09-17 11:02:35','relays','<id>8</id>','<id>8</id>',1),('2014-09-17 11:07:40','relays','<id>9</id>','<id>9</id>',1),('2014-09-17 11:08:21','relays','<id>10</id>','<id>10</id>',1),('2014-09-17 22:28:04','alarms_system','<id>5</id>','<id>5</id>',1),('2014-11-24 23:04:00','smartdevices','<id>6</id>','<id>20</id>',1),('2014-09-19 19:58:58','smartsensors','<id>8</id>','<id>8</id>',1),('2014-09-19 19:59:00','smartsensors','<id>9</id>','<id>9</id>',1),('2014-12-12 11:54:26','smartdevices','<id>5</id>','<id>18</id>',1),('2014-12-12 11:43:31','smartdevices','<id>4</id>','<id>19</id>',1),('2014-10-17 22:06:53','thermostat','<id>5</id>','<id>5</id>',1),('2014-10-17 22:07:03','thermostat','<id>6</id>','<id>6</id>',1),('2014-10-17 23:05:21','relays','<id>12</id>','<id>12</id>',1),('2014-10-17 23:12:21','smartsensors','<id>10</id>','<id>10</id>',1),('2014-10-18 00:03:40','relays','<id>13</id>','<id>13</id>',1),('2014-10-18 00:03:42','relays','<id>14</id>','<id>14</id>',1),('2014-10-18 00:03:53','relays','<id>15</id>','<id>15</id>',1),('2014-10-18 00:03:54','relays','<id>16</id>','<id>16</id>',1),('2014-10-18 00:03:55','relays','<id>17</id>','<id>17</id>',1),('2014-10-18 00:03:55','relays','<id>18</id>','<id>18</id>',1),('2014-10-18 00:03:56','relays','<id>19</id>','<id>19</id>',1),('2014-10-18 00:03:56','relays','<id>20</id>','<id>20</id>',1),('2014-10-18 00:03:57','relays','<id>21</id>','<id>21</id>',1),('2014-10-18 00:04:07','relays','<id>22</id>','<id>22</id>',1),('2014-10-18 00:04:08','relays','<id>23</id>','<id>23</id>',1),('2014-10-18 00:04:08','relays','<id>24</id>','<id>24</id>',1),('2014-10-18 00:04:09','relays','<id>25</id>','<id>25</id>',1),('2014-10-18 00:04:10','relays','<id>26</id>','<id>26</id>',1),('2014-10-18 00:04:11','relays','<id>27</id>','<id>27</id>',1),('2014-10-18 00:04:12','relays','<id>28</id>','<id>28</id>',1),('2014-10-18 00:04:13','relays','<id>29</id>','<id>29</id>',1),('2014-10-18 00:04:13','relays','<id>30</id>','<id>30</id>',1),('2014-10-18 00:04:14','relays','<id>31</id>','<id>31</id>',1),('2014-10-18 00:04:15','relays','<id>32</id>','<id>32</id>',1),('2014-10-18 00:04:18','relays','<id>33</id>','<id>33</id>',1),('2014-10-18 00:04:18','relays','<id>34</id>','<id>34</id>',1),('2014-10-20 12:02:03','smartsensors','<id>11</id>','<id>11</id>',1),('2014-10-20 18:06:35','relays','<id>35</id>','<id>35</id>',1),('2014-10-21 12:03:00','relays','<id>36</id>','<id>36</id>',1),('2014-10-21 12:03:19','relays','<id>37</id>','<id>37</id>',1),('2014-10-21 12:03:19','relays','<id>38</id>','<id>38</id>',1),('2014-10-21 22:49:54','thermostat','<id>7</id>','<id>7</id>',1),('2014-10-21 22:50:10','thermostat','<id>8</id>','<id>8</id>',1),('2014-10-21 23:13:21','bypass','<id>15</id>','<id>15</id>',1),('2014-10-21 23:17:11','thermostat','<id>9</id>','<id>9</id>',1),('2014-10-21 23:19:22','thermostat','<id>10</id>','<id>10</id>',1),('2014-10-21 23:23:10','thermostat','<id>11</id>','<id>11</id>',1),('2014-10-21 23:25:46','thermostat','<id>12</id>','<id>12</id>',1),('2014-10-21 23:27:49','thermostat','<id>13</id>','<id>13</id>',1),('2014-10-21 23:37:11','smartsensors','<id>12</id>','<id>12</id>',1),('2014-10-21 23:49:53','alarms_retrosave','<id>4</id>','<id>4</id>',1),('2014-10-21 23:52:04','alarms_retrosave','<id>5</id>','<id>5</id>',1),('2014-10-27 12:23:22','relays','<id>39</id>','<id>39</id>',1),('2014-10-27 12:23:24','relays','<id>40</id>','<id>40</id>',1),('2014-10-27 12:23:25','relays','<id>41</id>','<id>41</id>',1),('2014-10-27 12:24:41','relays','<id>42</id>','<id>42</id>',1),('2014-10-27 12:24:43','relays','<id>43</id>','<id>43</id>',1),('2014-10-27 12:24:44','relays','<id>44</id>','<id>44</id>',1),('2014-10-27 12:24:46','relays','<id>45</id>','<id>45</id>',1),('2014-10-27 12:24:47','relays','<id>46</id>','<id>46</id>',1),('2014-10-27 12:24:47','relays','<id>47</id>','<id>47</id>',1),('2014-10-27 21:55:10','bypass','<id>16</id>','<id>16</id>',1),('2014-10-27 22:08:43','alarms_types','<id>37</id>','<id>37</id>',1),('2014-10-27 22:09:46','alarms_types','<id>38</id>','<id>38</id>',1),('2014-10-27 22:09:47','alarms_types','<id>39</id>','<id>39</id>',1),('2014-10-27 22:09:48','alarms_types','<id>40</id>','<id>40</id>',1),('2014-10-27 22:09:50','alarms_types','<id>41</id>','<id>41</id>',1),('2014-10-27 22:09:59','alarms_types','<id>42</id>','<id>42</id>',1),('2014-10-27 22:10:21','alarms_types','<id>43</id>','<id>43</id>',1),('2014-10-27 22:10:36','alarms_types','<id>44</id>','<id>44</id>',1),('2014-10-27 22:10:46','alarms_types','<id>45</id>','<id>45</id>',1),('2014-10-27 22:10:58','alarms_types','<id>46</id>','<id>46</id>',1),('2014-10-27 22:11:07','alarms_types','<id>47</id>','<id>47</id>',1),('2014-10-27 22:11:15','alarms_types','<id>48</id>','<id>48</id>',1),('2014-10-27 22:11:23','alarms_types','<id>49</id>','<id>49</id>',1),('2014-10-27 22:11:41','alarms_types','<id>50</id>','<id>50</id>',1),('2014-10-27 22:11:52','alarms_types','<id>51</id>','<id>51</id>',1),('2014-10-27 22:13:50','alarms_types','<id>52</id>','<id>52</id>',1),('2014-10-27 22:14:04','alarms_types','<id>53</id>','<id>53</id>',1),('2014-10-27 22:14:16','alarms_types','<id>54</id>','<id>54</id>',1),('2014-10-27 22:14:27','alarms_types','<id>55</id>','<id>55</id>',1),('2014-10-27 22:14:37','alarms_types','<id>56</id>','<id>56</id>',1),('2014-10-27 22:14:48','alarms_types','<id>57</id>','<id>57</id>',1),('2014-10-27 22:15:03','alarms_types','<id>58</id>','<id>58</id>',1),('2014-10-27 22:15:13','alarms_types','<id>59</id>','<id>59</id>',1),('2014-10-27 22:15:24','alarms_types','<id>60</id>','<id>60</id>',1),('2014-10-27 22:16:20','alarms_types','<id>1</id>','<id>1</id>',2),('2014-10-27 22:16:27','alarms_types','<id>2</id>','<id>2</id>',2),('2014-10-27 22:16:38','alarms_types','<id>3</id>','<id>3</id>',2),('2014-10-27 22:17:00','alarms_types','<id>8</id>','<id>8</id>',2),('2014-10-27 22:17:07','alarms_types','<id>9</id>','<id>9</id>',2),('2014-10-27 22:17:20','alarms_types','<id>10</id>','<id>10</id>',2),('2014-10-27 22:17:32','alarms_types','<id>11</id>','<id>11</id>',2),('2014-10-27 22:17:42','alarms_types','<id>61</id>','<id>61</id>',1),('2014-10-27 22:17:51','alarms_types','<id>62</id>','<id>62</id>',1),('2014-10-27 22:18:02','alarms_types','<id>63</id>','<id>63</id>',1),('2014-10-27 22:18:14','alarms_types','<id>64</id>','<id>64</id>',1),('2014-10-27 22:18:26','alarms_types','<id>65</id>','<id>65</id>',1),('2014-10-27 22:20:00','alarms_types','<id>66</id>','<id>66</id>',1),('2014-12-23 16:15:26','hvac','<id>110</id>','<id>110</id>',2),('2014-10-27 23:07:17','hvac','<id>111</id>','<id>111</id>',2),('2014-12-13 00:04:15','ui_menu','<id>58</id>','<id>58</id>',1),('2014-10-29 18:55:23','smartsensorsraw','<id>5</id>','<id>5</id>',1),('2014-10-29 18:55:28','smartsensorsraw','<id>6</id>','<id>6</id>',1),('2015-01-06 23:43:55','hvac','<id>3212</id>','<id>3212</id>',1),('2014-11-24 22:54:39','smartdevices','<id>2</id>','<id>16</id>',1),('2014-11-24 22:54:39','smartdevices','<id>1</id>','<id>15</id>',1),('2014-11-04 21:50:05','ui_menu','<id>59</id>','<id>59</id>',1),('2014-12-17 00:37:26','hvac','<id>1194</id>','<id>3219</id>',1),('2014-12-26 19:02:42','hvac','<id>119</id>','<id>119</id>',2),('2014-11-19 16:49:12','hvac','<id>1179</id>','<id>1179</id>',2),('2014-11-19 16:49:16','hvac','<id>1180</id>','<id>1180</id>',2),('2014-11-20 00:44:59','hvac','<id>3213</id>','<id>3213</id>',1),('2014-11-19 17:32:29','hvac','<id>3214</id>','<id>3214</id>',1),('2014-11-19 18:08:13','hvac','<id>3215</id>','<id>3215</id>',1),('2014-11-19 18:08:13','hvac','<id>3216</id>','<id>3216</id>',1),('2014-11-19 18:54:11','hvac','<id>3217</id>','<id>3217</id>',1),('2014-11-19 19:00:14','hvac','<id>3218</id>','<id>3218</id>',1),('2014-11-24 15:38:20','ui_menu','<id>20</id>','<id>20</id>',2),('2014-11-24 15:39:02','ui_menu','<id>33</id>','<id>33</id>',2),('2014-11-24 15:39:08','ui_menu','<id>32</id>','<id>32</id>',2),('2014-11-24 15:39:50','ui_menu','<id>56</id>','<id>56</id>',2),('2014-11-24 15:57:28','ui_menu','<id>2</id>','<id>2</id>',2),('2014-11-24 15:57:35','ui_menu','<id>3</id>','<id>3</id>',2),('2014-11-28 22:43:38','registrations','<id>3</id>','<id>3</id>',3),('2014-11-28 22:43:38','registrations','<id>1</id>','<id>1</id>',3),('2015-01-06 22:59:31','registrations','<id>13</id>','<id>13</id>',1),('2015-01-06 23:00:29','zigbee_ha','<id>3</id>','<id>3</id>',1),('2014-11-28 23:38:03','devices','<id>16</id>','<id>16</id>',3),('2014-11-24 23:59:57','hvac','<id>1191</id>','<id>1193</id>',2),('2014-11-24 23:59:59','hvac','<id>1193</id>','<id>1194</id>',2),('2014-12-17 00:39:24','hvac','<id>1192</id>','<id>3220</id>',1),('2014-11-25 00:25:42','bypass','<id>17</id>','<id>17</id>',1),('2014-11-25 00:26:07','bypass','<id>18</id>','<id>18</id>',1),('2014-11-25 17:43:23','smartdevices','<id>8</id>','<id>8</id>',1),('2014-11-29 02:09:34','hvac','<id>121</id>','<id>3221</id>',1),('2014-11-28 15:54:41','alarms_zigbee','<id>37</id>','<id>37</id>',1),('2014-11-28 16:03:12','alarms_zigbee','<id>38</id>','<id>38</id>',1),('2014-11-29 01:45:35','devices','<id>31</id>','<id>31</id>',1),('2014-11-29 01:41:38','zigbee_ase','<id>3</id>','<id>3</id>',1),('2014-12-24 23:47:09','zigbee_ase','<id>5</id>','<id>5</id>',1),('2014-12-24 23:47:09','registrations','<id>14</id>','<id>14</id>',1),('2014-11-29 02:09:18','alarms_zigbee','<id>39</id>','<id>39</id>',1),('2014-12-02 16:57:36','zigbee_ase','<id>6</id>','<id>6</id>',1),('2014-12-02 16:57:36','registrations','<id>15</id>','<id>15</id>',1),('2014-12-25 00:12:17','devices','<id>32</id>','<id>32</id>',1),('2014-12-13 00:26:56','smartsensors','<id>13</id>','<id>13</id>',1),('2014-12-13 00:26:58','smartsensors','<id>14</id>','<id>14</id>',1),('2014-12-17 00:38:00','smartdevices','<id>7</id>','<id>7</id>',1),('2014-12-17 17:15:30','notifications','<id>30</id>','<id>30</id>',1),('2014-12-17 17:42:30','alarms_system','<id>6</id>','<id>6</id>',1),('2014-12-22 19:20:07','relays','<id>48</id>','<id>48</id>',1),('2014-12-22 19:20:09','relays','<id>49</id>','<id>49</id>',1),('2014-12-22 19:20:15','relays','<id>50</id>','<id>50</id>',1),('2014-12-22 19:21:05','relays','<id>51</id>','<id>51</id>',1),('2014-12-22 19:21:06','relays','<id>52</id>','<id>52</id>',1),('2014-12-22 19:21:06','relays','<id>53</id>','<id>53</id>',1),('2014-12-22 19:21:07','relays','<id>54</id>','<id>54</id>',1),('2014-12-22 19:21:08','relays','<id>55</id>','<id>55</id>',1),('2014-12-22 19:21:08','relays','<id>56</id>','<id>56</id>',1),('2014-12-22 19:21:28','relays','<id>57</id>','<id>57</id>',1),('2014-12-22 19:21:29','relays','<id>58</id>','<id>58</id>',1),('2014-12-22 19:21:29','relays','<id>59</id>','<id>59</id>',1),('2014-12-22 19:21:30','relays','<id>60</id>','<id>60</id>',1),('2014-12-22 19:21:30','relays','<id>61</id>','<id>61</id>',1),('2014-12-22 19:21:31','relays','<id>62</id>','<id>62</id>',1),('2014-12-22 19:21:31','relays','<id>63</id>','<id>63</id>',1),('2014-12-22 19:21:32','relays','<id>64</id>','<id>64</id>',1),('2014-12-22 19:21:32','relays','<id>65</id>','<id>65</id>',1),('2014-12-22 19:21:51','relays','<id>66</id>','<id>66</id>',1),('2014-12-22 19:21:51','relays','<id>67</id>','<id>67</id>',1),('2014-12-22 19:21:56','relays','<id>68</id>','<id>68</id>',1),('2014-12-22 19:21:58','relays','<id>69</id>','<id>69</id>',1),('2014-12-23 22:58:39','hvac','<id>3292</id>','<id>3292</id>',1),('2014-12-23 22:58:47','hvac','<id>3293</id>','<id>3293</id>',1),('2014-12-23 23:00:26','hvac','<id>3294</id>','<id>3294</id>',1),('2014-12-22 23:07:24','bypass','<id>19</id>','<id>19</id>',1),('2014-12-22 23:07:28','bypass','<id>20</id>','<id>20</id>',1),('2014-12-22 23:07:29','bypass','<id>21</id>','<id>21</id>',1),('2014-12-23 01:42:06','relays','<id>70</id>','<id>70</id>',1),('2014-12-23 01:42:23','relays','<id>71</id>','<id>71</id>',1),('2014-12-23 01:42:24','relays','<id>72</id>','<id>72</id>',1),('2014-12-23 16:13:43','relays','<id>73</id>','<id>73</id>',1),('2014-12-23 16:15:39','relays','<id>74</id>','<id>74</id>',1),('2014-12-25 00:12:36','hvac','<id>1102</id>','<id>3306</id>',1),('2014-12-25 00:12:36','devices','<id>33</id>','<id>33</id>',1),('2015-01-06 22:17:12','ui_menu','<id>60</id>','<id>60</id>',1),('2015-01-06 22:59:31','devices','<id>34</id>','<id>34</id>',1),('2015-01-06 23:05:07','zigbee_commands','<id>1</id>','<id>1</id>',1),('2015-01-06 23:05:22','zigbee_commands','<id>2</id>','<id>2</id>',1),('2015-01-06 23:05:54','zigbee_commands','<id>3</id>','<id>3</id>',1),('2015-01-06 23:11:09','zigbee_commands','<id>4</id>','<id>4</id>',1),('2015-01-06 23:32:35','zigbee_commands','<id>5</id>','<id>5</id>',1),('2015-01-06 23:32:37','zigbee_commands','<id>6</id>','<id>6</id>',1),('2015-01-06 23:32:40','zigbee_commands','<id>7</id>','<id>7</id>',1),('2015-01-06 23:32:41','zigbee_commands','<id>8</id>','<id>8</id>',1),('2015-01-06 23:34:00','zigbee_commands','<id>9</id>','<id>9</id>',1),('2015-01-06 23:34:18','zigbee_commands','<id>10</id>','<id>10</id>',1),('2015-01-06 23:40:41','zigbee_commands','<id>11</id>','<id>11</id>',1),('2015-01-06 23:40:55','zigbee_commands','<id>12</id>','<id>12</id>',1),('2015-01-06 23:42:15','zigbee_commands','<id>13</id>','<id>13</id>',1),('2015-01-06 23:43:13','zigbee_commands','<id>14</id>','<id>14</id>',1);
/*!40000 ALTER TABLE `history_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_store_old`
--

DROP TABLE IF EXISTS `history_store_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_store_old` (
  `timemark` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `table_name` tinytext,
  `pk_date_src` text NOT NULL,
  `pk_date_dest` text,
  `record_state` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_store_old`
--

LOCK TABLES `history_store_old` WRITE;
/*!40000 ALTER TABLE `history_store_old` DISABLE KEYS */;
INSERT INTO `history_store_old` VALUES ('2014-04-30 09:24:08','hvac','<id>4</id>','<id>4</id>',1),('2014-04-30 09:37:36','networks','<id>1</id>','<id>1</id>',2),('2014-04-30 12:55:53','notifications','<id>27</id>','<id>27</id>',1),('2014-04-30 15:24:32','users','<id>2</id>','<id>2</id>',2),('2014-04-30 15:47:26','notifications','<id>28</id>','<id>28</id>',1),('2014-04-30 15:49:07','notifications','<id>26</id>','<id>26</id>',2),('2014-04-30 15:59:54','notifications','<id>29</id>','<id>29</id>',1),('2014-04-30 16:08:49','notifications','<id>29</id>','<id>29</id>',2),('2014-04-30 16:08:49','notifications','<id>26</id>','<id>26</id>',2),('2014-04-30 19:15:43','networks','<id>1</id>','<id>1</id>',2),('2014-04-30 20:28:44','smartstatus','<id>2</id>','<id>2</id>',2),('2014-04-30 20:28:44','smartstatus','<id>1</id>','<id>1</id>',2),('2014-04-30 20:28:44','smartstatus','<id>3</id>','<id>3</id>',2),('2014-04-30 20:28:44','smartstatus','<id>4</id>','<id>4</id>',2),('2014-04-30 20:28:44','smartstatus','<id>5</id>','<id>5</id>',2),('2014-04-30 20:28:44','smartstatus','<id>6</id>','<id>6</id>',2),('2014-04-30 20:28:44','smartstatus','<id>7</id>','<id>7</id>',2),('2014-05-02 09:45:16','hvac','<id>3</id>','<id>3</id>',2),('2014-05-02 09:51:44','zigbee','<id>1</id>','<id>1</id>',2),('2014-05-02 09:55:35','zigbee','<id>1</id>','<id>1</id>',2),('2014-05-02 09:56:47','zigbee','<id>1</id>','<id>1</id>',2),('2014-05-02 09:57:02','zigbee','<id>1</id>','<id>1</id>',2),('2014-05-02 10:03:08','hvac','<id>3</id>','<id>3</id>',2),('2014-05-02 19:25:58','hvac','<id>120</id>','<id>120</id>',2),('2014-05-02 19:49:00','users','<id>2</id>','<id>2</id>',2),('2014-05-08 17:53:30','thermostat','<id>3</id>','<id>3</id>',1),('2014-05-08 17:17:26','ui_menu','<id>55</id>','<id>55</id>',1),('2014-05-12 20:21:10','hvac','<id>4</id>','<id>3</id>',2),('2014-05-08 18:18:48','hvac','<id>1200</id>','<id>78</id>',2),('2014-05-08 18:18:51','hvac','<id>1199</id>','<id>92</id>',2),('2014-05-08 18:18:55','hvac','<id>1198</id>','<id>91</id>',2),('2014-05-08 18:18:58','hvac','<id>1197</id>','<id>90</id>',2),('2014-05-08 18:19:02','hvac','<id>1196</id>','<id>89</id>',2),('2014-05-08 18:19:07','hvac','<id>1195</id>','<id>88</id>',2),('2014-05-08 18:24:41','hvac','<id>1194</id>','<id>87</id>',2),('2014-05-08 18:24:41','hvac','<id>1193</id>','<id>1248</id>',1),('2014-05-08 19:59:08','hvac','<id>3</id>','<id>4</id>',2),('2014-05-12 16:41:01','ui_menu','<id>20</id>','<id>20</id>',2),('2014-05-12 16:42:16','ui_menu','<id>56</id>','<id>56</id>',1),('2014-05-12 18:05:20','smartdevices','<id>1</id>','<id>1</id>',1),('2014-05-12 18:09:39','smartdevices','<id>2</id>','<id>2</id>',1);
/*!40000 ALTER TABLE `history_store_old` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hvac`
--

DROP TABLE IF EXISTS `hvac`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hvac` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `option_` varchar(50) NOT NULL,
  `description` varchar(200) NOT NULL,
  `submenu` int(11) NOT NULL DEFAULT '0',
  `value_` varchar(200) DEFAULT NULL,
  `type_` int(11) DEFAULT NULL,
  `selections` varchar(200) DEFAULT NULL,
  `dependence` varchar(200) DEFAULT NULL,
  `permissions` int(11) unsigned NOT NULL DEFAULT '0',
  `units` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `option_` (`option_`),
  UNIQUE KEY `option__2` (`option_`)
) ENGINE=MyISAM AUTO_INCREMENT=3307 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hvac`
--

LOCK TABLES `hvac` WRITE;
/*!40000 ALTER TABLE `hvac` DISABLE KEYS */;
INSERT INTO `hvac` VALUES (77,'furnace','Furnace',0,NULL,NULL,NULL,NULL,1,NULL),(79,'furnace.stages','Stages',77,'0',3,'0::Single Stage;;1::Dual Stage;;2::Modulating',NULL,1,NULL),(80,'furnace.dataport','Data Access Port',77,'NONE',1,'10',NULL,1,NULL),(81,'furnace.port_speed','Data Access Port Speed',77,'9600',1,'10',NULL,1,NULL),(82,'furnace.hc_trans','Heat/Cool Transformer Setup',77,'0',3,'0::Same;;1::Different',NULL,1,'bps'),(93,'furnace.model','Furnace Model',77,'',1,'25',NULL,1,NULL),(84,'furnace.bridge_rcrh','Bridge Rc Rh',77,'0',3,'0::No;;1::Yes',NULL,1,NULL),(85,'furnace.cent_hum','Central Humidifier Control',77,'0',3,'0::Disabled;;1::Enabled',NULL,1,NULL),(86,'furnace.max_on','Maximum ON Time',77,'3600',1,'5',NULL,1,'seconds'),(1193,'furnace.sup_t_probes','Supply Duct Temperature Probes Installed',77,'1',3,'0::No;;1::Yes',NULL,1,NULL),(1195,'furnace.t1_up','Supply Duct Temperature Threshold Upper Limit',77,'27.8',1,'5',NULL,1,'&deg;C'),(1196,'furnace.t1_low','Supply Duct Temperature Threshold Lower Limit',77,'15.6',1,'5',NULL,1,'&deg;C'),(1197,'furnace.t2_up','Return Duct Temperature Threshold Upper Limit',77,'26.1',1,'5',NULL,1,'&deg;C'),(1198,'furnace.t2_low','Return Duct Temperature Threshold Lower Limit',77,'16.1',1,'5',NULL,1,'&deg;C'),(1199,'furnace.sensor_poll','Smart Controller Onboard Sensors Polling Period',77,'60',1,'5',NULL,1,'seconds'),(1210,'furnace.mode','Operating Mode',77,'0',3,'0::Bypass;;1::RetroSAVE',NULL,1,NULL),(94,'fblower','Furnace Blower',0,NULL,NULL,NULL,NULL,1,NULL),(95,'fblower.min_on','Minimum ON Time',94,'120',1,'5',NULL,1,'seconds'),(96,'fblower.min_off','Minimum OFF Time',94,'60',1,'5',NULL,1,'seconds'),(97,'fblower.max_on','Maximum ON Time',94,'0',1,'5',NULL,1,'seconds'),(98,'fblower.heat_cycle','Heat Cycle Timer',94,'120',1,'5',NULL,1,'seconds'),(99,'fblower.cool_cycle','Cooling Cycle Timer',94,'360',1,'5',NULL,1,'seconds'),(100,'fblower.stat_pres','Static Pressure Threshold',94,'0',1,'5',NULL,1,'kpa'),(74,'system','System Settings',0,NULL,NULL,NULL,NULL,3,NULL),(75,'system.notifications_sms','Enable notifications by SMS',74,'1',1,NULL,NULL,3,NULL),(76,'system.notifications_email','Enable notifications by EMail',74,'1',1,NULL,NULL,3,NULL),(117,'thermostat','Customer Thermostat',0,NULL,NULL,NULL,NULL,1,NULL),(101,'acheat','A/C & Heat Pump',0,NULL,NULL,NULL,NULL,1,NULL),(102,'acheat.installed','Pump Installed',101,'0',3,'0::No;;1::Yes',NULL,1,NULL),(103,'acheat.stages','Stages',101,'0',3,'0::Single Stage;;1::Dual Stage',NULL,1,NULL),(104,'acheat.min_comp_on','Minimum Compressor ON Time',101,'0',1,'5',NULL,1,'seconds'),(105,'acheat.min_comp_off','Minimum Compressor OFF Time',101,'0',1,'5',NULL,1,'seconds'),(106,'acheat.max_comp_on','Maximum Compressor ON Time',101,'0',1,'5',NULL,1,'seconds'),(107,'acheat.out_temp_cut','Outside Temperature Cutoff',101,'-5.6',1,'5',NULL,1,'&deg;C'),(108,'acheat.ob_heat','O/B Heat Call',101,'0',3,'0::Floating (off);;1::Set to R (on)',NULL,1,NULL),(109,'hrverv','HRV/ERV Control',0,NULL,NULL,NULL,NULL,1,NULL),(110,'hrverv.installed','Installed',109,'1',3,'0::No;;1::Yes',NULL,1,NULL),(111,'hrverv.relay_id','Relay ID',109,'6',3,'1::Relay #1;;2::Relay #2;;3::Relay #3;;4::Relay #4;;5::Relay #5;;6::Relay #6',NULL,1,NULL),(112,'hrverv.sync','Synchronized With Furnace Blower',109,'0',3,'0::No;;1::Yes',NULL,1,NULL),(113,'hrverv.min_on','Minimum ON Time',109,'120',1,'5',NULL,1,'seconds'),(114,'hrverv.min_off','Minimum OFF Time',109,'60',1,'5',NULL,1,'seconds'),(115,'hrverv.max_on','Maximum ON Time',109,'0',1,'5',NULL,1,'seconds'),(116,'comfort','Comfort Level',0,NULL,NULL,NULL,NULL,1,NULL),(118,'thermostat.connected','Home Thermostat Connected',117,'0',3,'0::No;;1::Yes',NULL,1,NULL),(120,'system.regmode','New Remote Devices Registration Mode',74,'2',3,'0::Disabled;;1::AdHoc;;2::Manual',NULL,3,NULL),(119,'thermostat.type','Thermostat Type',117,'0',3,'0::Analog;;1::Smart','thermostat.connected::1',1,NULL),(1179,'thermostat.maker','Thermostat Maker',117,'Honeywell',1,'20','thermostat.type::0',1,NULL),(1180,'thermostat.model','Thermostat Model',117,'Prestige HD',1,'20','thermostat.type::0',1,NULL),(1,'system.serial','Smart Controller Serial Number',74,'ASESMART-00002',1,'20',NULL,3,NULL),(2,'system.house_id','Unique House ID',74,'00002',1,'5',NULL,3,NULL),(3171,'comfort.min_hum','Humidity Minimum Acceptable Level',116,'30',1,'5',NULL,1,'%'),(3172,'comfort.max_hum','Humidity Maximum Acceptable Level',116,'60',1,'5',NULL,1,'%'),(3173,'comfort.t_occ_win','Default Winter Occupied Temperature',116,'21',1,'5',NULL,1,'&deg;C'),(3174,'comfort.t_occ_sum','Default Summer Occupied Temperature',116,'24',1,'5',NULL,1,'&deg;C'),(3175,'comfort.slider_def','Default Slider Settings',116,'2',3,'0::Max Comfort;;2::Balanced;;4::Max Saving',NULL,1,NULL),(3166,'comfort.co2_up','CO2 Upper Limit',116,'1000',1,'5',NULL,1,'ppm'),(3167,'comfort.co_up','CO Upper Limit',116,'5',1,'5',NULL,1,'ppm'),(3188,'comfort.circ_on','Circulation Cycle ON Time',116,'300',1,'5',NULL,1,'seconds'),(3189,'comfort.circ_off','Circulation Cycle OFF Time',116,'25',1,'5',NULL,1,'minutes'),(4,'system.sw_version','System Software Version',74,'14.12.12p',1,'10',NULL,3,NULL),(1188,'system.max_days','Keep Statistics Data in DB for days',74,'14',1,'5',NULL,3,NULL),(1189,'system.max_storage','Maximum Storage Count Reach Actions',74,'0',3,'0::Delete oldest records;;1::Stop collecting stats',NULL,3,NULL),(3,'system.description','System Short Description',74,'Dmitry test PC',1,'50',NULL,3,NULL),(1191,'furnace.ret_t_probes','Return Duct Temperature Probes Installed',77,'1',3,'0::No;;1::Yes',NULL,1,NULL),(2223,'retrosave','RetroSAVE Operational Parameters',0,NULL,NULL,NULL,NULL,3,NULL),(2224,'retrosave.away_mode','Away mode',2223,'0',4,'0::Disabled;;1::Enabled',NULL,3,NULL),(2225,'retrosave.away_period','Set Away mode after period',2223,'24',1,'5',NULL,3,'hours'),(1100,'thermostat.mode','Thermostat Mode',117,'1',3,'0::Cold only;;1::Auto mode;;2::Heat only','thermostat.connected::0',1,NULL),(2227,'retrosave.comfort_t','Comfort temperature adjustment',2223,'1',1,'3',NULL,3,NULL),(2228,'retrosave.comfort_h','Comfort humidity adjustment',2223,'0',1,'3',NULL,3,NULL),(1200,'furnace.house_vents','Total number of house vents',77,'0',1,'3',NULL,1,' '),(1201,'furnace.rise_low_thr','Temperature rise low threshold',77,'35',1,'3',NULL,1,'&deg;C'),(1202,'furnace.rise_high_thr','Temperature rise high threshold',77,'75',1,'3',NULL,1,'&deg;C'),(2232,'acheat.dec_low_thr','Temperature decline low threshold',101,'17',1,'3',NULL,1,'&deg;C'),(2233,'acheat.dec_high_thr','Temperature decline high threshold',101,'20',1,'3',NULL,1,'&deg;C'),(78,'furnace.installed','Furnace Installed',77,'1',3,'0::No;;1::Yes',NULL,1,NULL),(3151,'comfort.co_present','CO Sensor Present',116,'1',3,'0::No;;1::Yes',NULL,1,NULL),(3150,'comfort.co2_present','CO2 Sensor Present',116,'1',3,'0::No;;1::Yes',NULL,1,NULL),(1203,'furnace.btus','BTUs',77,'0',1,'3',NULL,1,NULL),(3210,'fblower.cfm','CFM',94,'0',1,'3',NULL,1,NULL),(3211,'acheat.ton','Ton',101,'1',3,'1::1;;2::2;;3::3;;4::4;;5::5',NULL,1,NULL),(3212,'system.testrefresh','Sensors test page refresh interval',74,'0',1,'3',NULL,1,NULL),(3213,'thermostat.smart_model','Smart COTS Maker and Model',117,'1',3,'0::Other;;1::nest','thermostat.type::1',1,NULL),(3214,'thermostat.cots_nest','Nest COTS Status',117,NULL,6,'%%NEST','thermostat.smart_model::1',1,NULL),(3215,'thermostat.nest_clientid','nest Client ID',117,'a4bf6775-dcce-401f-b33b-03ac2c9c3aa0',1,'40','thermostat.smart_model::1',1,NULL),(3216,'thermostat.nest_secret','nest Client secret',117,'Xj7AVAd7vNMdfokVlhwjPg8HF',1,'40','thermostat.smart_model::1',1,NULL),(3217,'thermostat.nest_pincode','nest Pincode',117,'',1,'10','thermostat.smart_model::1',1,NULL),(3218,'thermostat.nest_token','nest Security token (readonly)',117,'c.y3eCY2DujKtdJRn5kj49fva7HxmrW31DPl2E5g9Yt25v6ENfGXjCEsAD3im0IjRC6vxGsJ5wdzg7Ce6OoJr9htOtPKXk0NAT6DppwNyJKECUn8U46pw9uOcPDE0ZvA3RnHYqFS483EPSpfPy',2,'40','thermostat.smart_model::1',1,NULL),(1194,'furnace.sup_t_probe_use','Temperature probe to use',77,'5',6,'%%PTLIST','furnace.sup_t_probes::1',1,NULL),(1192,'furnace.ret_t_probe_use','Temperature probe to use',77,'7',6,'%%PTLIST','furnace.ret_t_probes::1',1,NULL),(121,'system.reg_timeout','Opened registration timeout',74,'15',2,'4',NULL,1,NULL),(3292,'thermostat.target_t','Thermostat Target Temperature',117,'18',1,'5','thermostat.connected::0',1,'&deg;C'),(3293,'thermostat.target_h','Thermostat Target Humidity',117,'52',1,'5','thermostat.connected::0',1,'%'),(3294,'thermostat.fan_mode','Fan Mode',117,'1',3,'0::Auto;;1::ON','thermostat.connected::0',1,NULL),(1102,'thermostat.master_sensor','Master Sensor Selection',116,'33',6,'%%MASTER','thermostat.type::0',1,NULL);
/*!40000 ALTER TABLE `hvac` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_hvac` AFTER INSERT ON `hvac`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_hvac IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'hvac'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_hvac` AFTER UPDATE ON `hvac`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_hvac IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'hvac';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_hvac` AFTER DELETE ON `hvac`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_hvac IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'hvac';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `hvac_actions`
--

DROP TABLE IF EXISTS `hvac_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hvac_actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ref_table` varchar(200) DEFAULT NULL,
  `ref_id` int(11) DEFAULT NULL,
  `type_` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MEMORY DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hvac_actions`
--

LOCK TABLES `hvac_actions` WRITE;
/*!40000 ALTER TABLE `hvac_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `hvac_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `irdata`
--

DROP TABLE IF EXISTS `irdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `irdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device` varchar(255) DEFAULT NULL,
  `command` varchar(255) DEFAULT NULL,
  `parameters` varchar(255) DEFAULT NULL,
  `sequence` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `irdata`
--

LOCK TABLES `irdata` WRITE;
/*!40000 ALTER TABLE `irdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `irdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `networks`
--

DROP TABLE IF EXISTS `networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `networks` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dns1` varchar(20) NOT NULL,
  `dns2` varchar(20) DEFAULT NULL,
  `cloud1` varchar(20) NOT NULL,
  `cloud2` varchar(20) DEFAULT NULL,
  `ap_name` varchar(50) NOT NULL,
  `ap_channel` tinyint(4) NOT NULL DEFAULT '6',
  `ap_security` varchar(10) NOT NULL,
  `ap_protocol` int(11) DEFAULT '0',
  `lan_dhcp` tinyint(4) NOT NULL DEFAULT '1',
  `lan_ip` varchar(20) DEFAULT NULL,
  `lan_gateway` varchar(20) DEFAULT NULL,
  `lan_netmask` varchar(20) DEFAULT NULL,
  `lan_dns` varchar(20) DEFAULT NULL,
  `wan_ap_name` varchar(50) DEFAULT NULL,
  `wan_ap_key` varchar(50) DEFAULT NULL,
  `timeserver1` varchar(20) NOT NULL,
  `timeserver2` varchar(20) DEFAULT NULL,
  `cell_modem` tinyint(4) NOT NULL DEFAULT '0',
  `cell_type` varchar(100) DEFAULT NULL,
  `weather1` varchar(200) DEFAULT NULL,
  `weather2` varchar(200) DEFAULT NULL,
  `alarms` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `networks`
--

LOCK TABLES `networks` WRITE;
/*!40000 ALTER TABLE `networks` DISABLE KEYS */;
INSERT INTO `networks` VALUES (1,'0.0.0.0','0.0.0.0','cloud.ase-energy.ca','smartcloud.local','RetroSAVE',13,'retrosave',0,1,'1.1.1.1','0.0.0.0','0.0.0.0','192.168.1.1','WAN Client Disabled','somekey','129.6.15.30','96.226.242.9',0,'','openweathermap.org','',0);
/*!40000 ALTER TABLE `networks` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_networks` AFTER INSERT ON `networks`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_networks IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'networks'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_networks` AFTER UPDATE ON `networks`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_networks IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'networks';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_networks` AFTER DELETE ON `networks`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_networks IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'networks';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `severity` smallint(6) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (2,'dmitry@ase-energy.ca',NULL,6),(3,'dmitry@elutsk.com',NULL,3),(26,'','380503173500',3),(29,'','18001212121',2),(30,'swdevteam@ase-energy.ca','',7);
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_notifications` AFTER INSERT ON `notifications`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_notifications IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'notifications'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_notifications` AFTER UPDATE ON `notifications`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_notifications IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'notifications';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_notifications` AFTER DELETE ON `notifications`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_notifications IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'notifications';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `occupancy`
--

DROP TABLE IF EXISTS `occupancy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `occupancy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` datetime DEFAULT NULL,
  `zone_id` int(11) DEFAULT NULL,
  `device_id` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `occupancy`
--

LOCK TABLES `occupancy` WRITE;
/*!40000 ALTER TABLE `occupancy` DISABLE KEYS */;
/*!40000 ALTER TABLE `occupancy` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_occupancy` AFTER INSERT ON `occupancy`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_occupancy IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'occupancy'; 						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_occupancy` AFTER UPDATE ON `occupancy`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_occupancy IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'occupancy';						SET @pk_d_old = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_occupancy` AFTER DELETE ON `occupancy`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_occupancy IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'occupancy';						SET @pk_d = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `paramflapdyn`
--

DROP TABLE IF EXISTS `paramflapdyn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paramflapdyn` (
  `device_id` int(11) NOT NULL,
  `position` int(11) DEFAULT NULL,
  `temperature` double(15,3) DEFAULT NULL,
  `airflow` double(15,3) DEFAULT NULL,
  `dimmer` int(11) DEFAULT NULL,
  PRIMARY KEY (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paramflapdyn`
--

LOCK TABLES `paramflapdyn` WRITE;
/*!40000 ALTER TABLE `paramflapdyn` DISABLE KEYS */;
INSERT INTO `paramflapdyn` VALUES (17,59,30.000,NULL,NULL);
/*!40000 ALTER TABLE `paramflapdyn` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_paramflapdyn` AFTER INSERT ON `paramflapdyn`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_paramflapdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramflapdyn'; 						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_paramflapdyn` AFTER UPDATE ON `paramflapdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_paramflapdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramflapdyn';						SET @pk_d_old = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_paramflapdyn` AFTER DELETE ON `paramflapdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_paramflapdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramflapdyn';						SET @pk_d = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `paramgassensordyn`
--

DROP TABLE IF EXISTS `paramgassensordyn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paramgassensordyn` (
  `device_id` int(11) NOT NULL,
  `pir` int(11) DEFAULT NULL,
  `co2_ppm` int(11) DEFAULT NULL,
  `co_ppm` int(11) DEFAULT NULL,
  `temperature1` float(9,3) DEFAULT NULL,
  `temperature2` float(9,3) DEFAULT NULL,
  PRIMARY KEY (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paramgassensordyn`
--

LOCK TABLES `paramgassensordyn` WRITE;
/*!40000 ALTER TABLE `paramgassensordyn` DISABLE KEYS */;
/*!40000 ALTER TABLE `paramgassensordyn` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_paramgassensordyn` AFTER INSERT ON `paramgassensordyn`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_paramgassensordyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramgassensordyn'; 						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_paramgassensordyn` AFTER UPDATE ON `paramgassensordyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_paramgassensordyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramgassensordyn';						SET @pk_d_old = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_paramgassensordyn` AFTER DELETE ON `paramgassensordyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_paramgassensordyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramgassensordyn';						SET @pk_d = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `paramsensordyn`
--

DROP TABLE IF EXISTS `paramsensordyn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paramsensordyn` (
  `device_id` int(11) NOT NULL,
  `light` double DEFAULT NULL,
  `temperature` double DEFAULT NULL,
  `humidity` double DEFAULT NULL,
  `motion` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paramsensordyn`
--

LOCK TABLES `paramsensordyn` WRITE;
/*!40000 ALTER TABLE `paramsensordyn` DISABLE KEYS */;
INSERT INTO `paramsensordyn` VALUES (16,100,23,70,NULL),(18,339,19,65,NULL),(20,1100,22,63,NULL),(22,2400,17,78,NULL);
/*!40000 ALTER TABLE `paramsensordyn` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_paramsensordyn` AFTER INSERT ON `paramsensordyn`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_paramsensordyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramsensordyn'; 						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_paramsensordyn` AFTER UPDATE ON `paramsensordyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_paramsensordyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramsensordyn';						SET @pk_d_old = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_paramsensordyn` AFTER DELETE ON `paramsensordyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_paramsensordyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramsensordyn';						SET @pk_d = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `registrations`
--

DROP TABLE IF EXISTS `registrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registrations` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `updated` datetime DEFAULT NULL,
  `event_type` int(11) DEFAULT NULL,
  `device_type` int(11) DEFAULT NULL,
  `zigbee_short` int(11) DEFAULT NULL,
  `zigbee_addr64` varchar(32) DEFAULT NULL,
  `zigbee_mode` int(11) DEFAULT NULL,
  `panid` int(11) DEFAULT NULL,
  `channel` int(11) DEFAULT NULL,
  `rssi` int(11) DEFAULT NULL,
  `device_id` int(11) DEFAULT NULL,
  `device_desc` varchar(255) DEFAULT NULL,
  `zone_id` int(11) DEFAULT NULL,
  `zone_desc` varchar(255) DEFAULT NULL,
  `source` int(11) DEFAULT '0',
  `zigbee_hw` int(11) DEFAULT NULL,
  `zigbee_fw` int(11) DEFAULT NULL,
  `device_hw` int(11) DEFAULT NULL,
  `device_fw` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `asemp_id` int(11) DEFAULT NULL,
  `serial` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registrations`
--

LOCK TABLES `registrations` WRITE;
/*!40000 ALTER TABLE `registrations` DISABLE KEYS */;
INSERT INTO `registrations` VALUES (10,'2014-11-29 02:23:13',1,0,11223,'1122334455667788',2,NULL,NULL,NULL,30,NULL,1,NULL,0,10001,10002,NULL,10003,2,0,NULL),(11,'2014-11-29 02:23:12',1,0,11233,'1122334455667766',2,NULL,NULL,NULL,29,NULL,1,NULL,0,10001,10002,NULL,10003,2,0,NULL),(12,'2014-11-29 03:45:35',1,80,33221,'1212121223232323',2,NULL,NULL,NULL,31,NULL,1,NULL,0,NULL,NULL,NULL,NULL,2,0,NULL),(13,'2015-01-07 00:59:31',1,80,33121,'1212121223112323',2,NULL,NULL,NULL,34,NULL,1,NULL,0,NULL,NULL,NULL,NULL,2,0,NULL),(14,'2014-12-25 01:47:09',1,0,12233,'1122334455611766',2,NULL,NULL,NULL,33,NULL,1,NULL,0,10001,10002,NULL,10003,2,0,NULL),(15,'2014-12-02 18:57:36',1,0,12233,'1122224455611766',2,NULL,NULL,NULL,32,NULL,1,NULL,0,10001,10002,NULL,10003,2,0,NULL);
/*!40000 ALTER TABLE `registrations` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER a_i_registrations
	AFTER INSERT
	ON registrations
	FOR EACH ROW
BEGIN 					IF (@DISABLE_TRIGGER_registrations IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'registrations'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER a_u_registrations
	AFTER UPDATE
	ON registrations
	FOR EACH ROW
BEGIN
  IF (@DISABLE_TRIGGER_registrations IS NULL) THEN	
    SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND);
    SET @tbl_name = 'registrations';
    SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');
    SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');
    SET @rec_state = 2;
    SET @rs = 0;
    SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;
    IF @rs = 0 THEN
      INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );
    ELSE
      UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;
    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_registrations` AFTER DELETE ON `registrations`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_registrations IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'registrations';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `relays`
--

DROP TABLE IF EXISTS `relays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relays` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `updated` datetime NOT NULL,
  `R1` tinyint(4) DEFAULT NULL,
  `R2` tinyint(4) DEFAULT NULL,
  `R3` tinyint(4) DEFAULT NULL,
  `R4` tinyint(4) DEFAULT NULL,
  `R5` tinyint(4) DEFAULT NULL,
  `R6` tinyint(4) DEFAULT NULL,
  `Humidifier` tinyint(4) DEFAULT NULL,
  `W1` tinyint(4) DEFAULT NULL,
  `W2` tinyint(4) DEFAULT NULL,
  `Y1` tinyint(4) DEFAULT NULL,
  `Y2` tinyint(4) DEFAULT NULL,
  `G` tinyint(4) DEFAULT NULL,
  `OB` tinyint(4) DEFAULT NULL,
  `Aux` tinyint(4) DEFAULT NULL,
  `RcRh` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relays`
--

LOCK TABLES `relays` WRITE;
/*!40000 ALTER TABLE `relays` DISABLE KEYS */;
INSERT INTO `relays` VALUES (1,'2014-04-06 03:03:03',0,1,0,1,0,0,1,0,1,0,1,0,1,NULL,NULL),(2,'2014-05-16 01:39:16',0,0,0,0,0,0,1,1,1,0,1,0,0,NULL,NULL),(3,'2014-06-11 01:04:35',0,0,0,1,1,1,1,1,0,1,0,0,0,NULL,NULL),(4,'2014-06-11 01:05:25',0,0,0,0,0,1,1,1,1,0,1,0,1,NULL,NULL),(5,'2014-07-01 17:57:39',0,0,0,0,0,1,1,1,1,1,0,0,0,NULL,NULL),(6,'2014-09-17 13:59:04',0,1,1,1,0,0,1,0,0,0,0,1,1,NULL,NULL),(7,'2014-09-17 13:59:40',0,1,1,1,0,0,1,0,0,0,0,1,1,NULL,NULL),(8,'2014-09-17 14:02:35',0,1,1,1,0,0,1,0,0,0,0,1,1,NULL,NULL),(9,'2014-09-17 14:07:40',0,1,1,1,0,0,1,0,0,0,0,1,1,NULL,NULL),(10,'2014-09-17 14:08:21',0,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,'2014-10-18 02:05:15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0),(13,'2014-10-18 03:03:40',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(14,'2014-10-18 03:03:42',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL),(15,'2014-10-18 03:03:53',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,NULL),(16,'2014-10-18 03:03:54',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,NULL,NULL),(17,'2014-10-18 03:03:55',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,NULL,NULL,NULL),(18,'2014-10-18 03:03:55',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL),(19,'2014-10-18 03:03:56',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL),(20,'2014-10-18 03:03:56',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(21,'2014-10-18 03:03:57',NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(22,'2014-10-18 03:04:07',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(23,'2014-10-18 03:04:08',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(24,'2014-10-18 03:04:08',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(25,'2014-10-18 03:04:09',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(26,'2014-10-18 03:04:10',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(27,'2014-10-18 03:04:11',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(28,'2014-10-18 03:04:12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL),(29,'2014-10-18 03:04:13',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL),(30,'2014-10-18 03:04:13',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(31,'2014-10-18 03:04:14',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL),(32,'2014-10-18 03:04:15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL),(33,'2014-10-18 03:04:18',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(34,'2014-10-18 03:04:18',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(35,'2014-10-20 21:06:35',1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL),(36,'2014-10-21 15:03:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(37,'2014-10-21 15:03:19',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(38,'2014-10-21 15:03:19',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL),(39,'2014-10-27 14:23:22',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(40,'2014-10-27 14:23:24',NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(41,'2014-10-27 14:23:25',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(42,'2014-10-27 14:24:41',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(43,'2014-10-27 14:24:43',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(44,'2014-10-27 14:24:44',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(45,'2014-10-27 14:24:46',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(46,'2014-10-27 14:24:47',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(47,'2014-10-27 14:24:47',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(48,'2014-12-22 21:20:07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(49,'2014-12-22 21:20:09',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(50,'2014-12-22 21:20:15',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(51,'2014-12-22 21:21:05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(52,'2014-12-22 21:21:06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL),(53,'2014-12-22 21:21:06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL),(54,'2014-12-22 21:21:07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(55,'2014-12-22 21:21:08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL),(56,'2014-12-22 21:21:08',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(57,'2014-12-22 21:21:28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(58,'2014-12-22 21:21:29',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL),(59,'2014-12-22 21:21:29',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(60,'2014-12-22 21:21:30',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL),(61,'2014-12-22 21:21:30',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(62,'2014-12-22 21:21:31',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL),(63,'2014-12-22 21:21:31',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,NULL),(64,'2014-12-22 21:21:32',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(65,'2014-12-22 21:21:32',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(66,'2014-12-22 21:21:51',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL),(67,'2014-12-22 21:21:51',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL),(68,'2014-12-22 21:21:56',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(69,'2014-12-22 21:21:58',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(70,'2014-12-23 03:42:06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL),(71,'2014-12-23 03:42:23',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL),(72,'2014-12-23 03:42:24',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(73,'2014-12-23 18:13:43',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(74,'2014-12-23 18:15:39',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `relays` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER relays_commands
	BEFORE INSERT
	ON relays
	FOR EACH ROW
BEGIN
  -- Single mode relays here;
  IF (NEW.Humidifier IS NOT NULL) THEN
    IF (NEW.Humidifier = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 0);
    ELSEIF (NEW.Humidifier = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 0);
    END IF;
  END IF;
  IF (NEW.RcRh IS NOT NULL) THEN
    IF (NEW.RcRh = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 8);
    ELSEIF (NEW.RcRh = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 8);
    END IF;
  END IF;

  -- Double relays (with bypass) here;
  IF (NEW.W1 IS NOT NULL) THEN
    IF ((NEW.W1 & 1) = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 1);
    ELSEIF ((NEW.W1 & 1) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 1);
    END IF;
    IF ((NEW.W1 & 2) = 2) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 9);
    ELSEIF ((NEW.W1 & 2) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 9);
    END IF;
  END IF;
  IF (NEW.W2 IS NOT NULL) THEN
    IF ((NEW.W2 & 1) = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 2);
    ELSEIF ((NEW.W2 & 1) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 2);
    END IF;
    IF ((NEW.W2 & 2) = 2) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 10);
    ELSEIF ((NEW.W2 & 2) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 10);
    END IF;
  END IF;
  IF (NEW.Y1 IS NOT NULL) THEN
    IF ((NEW.Y1 & 1) = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 3);
    ELSEIF ((NEW.Y1 & 1) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 3);
    END IF;
    IF ((NEW.Y1 & 2) = 2) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 11);
    ELSEIF ((NEW.Y1 & 2) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 11);
    END IF;
  END IF;
  IF (NEW.Y2 IS NOT NULL) THEN
    IF ((NEW.Y2 & 1) = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 4);
    ELSEIF ((NEW.Y2 & 1) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 4);
    END IF;
    IF ((NEW.Y2 & 2) = 2) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 12);
    ELSEIF ((NEW.Y2 & 2) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 12);
    END IF;
  END IF;
  IF (NEW.G IS NOT NULL) THEN
    IF ((NEW.G & 1) = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 5);
    ELSEIF ((NEW.G & 1) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 5);
    END IF;
    IF ((NEW.G & 2) = 2) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 13);
    ELSEIF ((NEW.G & 2) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 13);
    END IF;
  END IF;
  IF (NEW.OB IS NOT NULL) THEN
    IF ((NEW.OB & 1) = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 6);
    ELSEIF ((NEW.OB & 1) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 6);
    END IF;
    IF ((NEW.OB & 2) = 2) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 14);
    ELSEIF ((NEW.OB & 2) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 14);
    END IF;
  END IF;
  IF (NEW.Aux IS NOT NULL) THEN
    IF ((NEW.Aux & 1) = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 7);
    ELSEIF ((NEW.Aux & 1) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 7);
    END IF;
    IF ((NEW.Aux & 2) = 2) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 15);
    ELSEIF ((NEW.Aux & 2) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 15);
    END IF;
  END IF;
  
  -- User-defined relays here;
  IF (NEW.R1 IS NOT NULL) THEN
    IF (NEW.R1 = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 16);
    ELSEIF (NEW.R1 = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 16);
    END IF;
  END IF;
  IF (NEW.R2 IS NOT NULL) THEN
    IF (NEW.R2 = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 17);
    ELSEIF (NEW.R2 = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 17);
    END IF;
  END IF;
  IF (NEW.R3 IS NOT NULL) THEN
    IF (NEW.R3 = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 18);
    ELSEIF (NEW.R3 = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 18);
    END IF;
  END IF;
  IF (NEW.R4 IS NOT NULL) THEN
    IF (NEW.R4 = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 19);
    ELSEIF (NEW.R4 = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 19);
    END IF;
  END IF;
  IF (NEW.R5 IS NOT NULL) THEN
    IF (NEW.R5 = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 20);
    ELSEIF (NEW.R5 = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 20);
    END IF;
  END IF;
  IF (NEW.R6 IS NOT NULL) THEN
    IF (NEW.R6 = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 21);
    ELSEIF (NEW.R6 = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 21);
    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER a_i_relays
	AFTER INSERT
	ON relays
	FOR EACH ROW
BEGIN 					
  IF (@DISABLE_TRIGGER_relays IS NULL) THEN	
    SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						
    SET @tbl_name = 'relays'; 						
    SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						
    SET @rec_state = 1;						
    DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						
    INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					
  END IF;	

-- Single mode relays here;
  IF (NEW.Humidifier IS NOT NULL) THEN
    IF (NEW.Humidifier = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 0);
    ELSEIF (NEW.Humidifier = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 0);
    END IF;
  END IF;
  IF (NEW.RcRh IS NOT NULL) THEN
    IF (NEW.RcRh = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 8);
    ELSEIF (NEW.RcRh = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 8);
    END IF;
  END IF;

  -- Double relays (with bypass) here;
  IF (NEW.W1 IS NOT NULL) THEN
    IF ((NEW.W1 & 1) = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 1);
    ELSEIF ((NEW.W1 & 1) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 1);
    END IF;
    IF ((NEW.W1 & 2) = 2) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 9);
    ELSEIF ((NEW.W1 & 2) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 9);
    END IF;
  END IF;
  IF (NEW.W2 IS NOT NULL) THEN
    IF ((NEW.W2 & 1) = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 2);
    ELSEIF ((NEW.W2 & 1) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 2);
    END IF;
    IF ((NEW.W2 & 2) = 2) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 10);
    ELSEIF ((NEW.W2 & 2) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 10);
    END IF;
  END IF;
  IF (NEW.Y1 IS NOT NULL) THEN
    IF ((NEW.Y1 & 1) = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 3);
    ELSEIF ((NEW.Y1 & 1) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 3);
    END IF;
    IF ((NEW.Y1 & 2) = 2) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 11);
    ELSEIF ((NEW.Y1 & 2) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 11);
    END IF;
  END IF;
  IF (NEW.Y2 IS NOT NULL) THEN
    IF ((NEW.Y2 & 1) = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 4);
    ELSEIF ((NEW.Y2 & 1) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 4);
    END IF;
    IF ((NEW.Y2 & 2) = 2) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 12);
    ELSEIF ((NEW.Y2 & 2) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 12);
    END IF;
  END IF;
  IF (NEW.G IS NOT NULL) THEN
    IF ((NEW.G & 1) = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 5);
    ELSEIF ((NEW.G & 1) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 5);
    END IF;
    IF ((NEW.G & 2) = 2) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 13);
    ELSEIF ((NEW.G & 2) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 13);
    END IF;
  END IF;
  IF (NEW.OB IS NOT NULL) THEN
    IF ((NEW.OB & 1) = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 6);
    ELSEIF ((NEW.OB & 1) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 6);
    END IF;
    IF ((NEW.OB & 2) = 2) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 14);
    ELSEIF ((NEW.OB & 2) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 14);
    END IF;
  END IF;
  IF (NEW.Aux IS NOT NULL) THEN
    IF ((NEW.Aux & 1) = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 7);
    ELSEIF ((NEW.Aux & 1) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 7);
    END IF;
    IF ((NEW.Aux & 2) = 2) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 15);
    ELSEIF ((NEW.Aux & 2) = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 15);
    END IF;
  END IF;
  
  -- User-defined relays here;
  IF (NEW.R1 IS NOT NULL) THEN
    IF (NEW.R1 = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 16);
    ELSEIF (NEW.R1 = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 16);
    END IF;
  END IF;
  IF (NEW.R2 IS NOT NULL) THEN
    IF (NEW.R2 = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 17);
    ELSEIF (NEW.R2 = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 17);
    END IF;
  END IF;
  IF (NEW.R3 IS NOT NULL) THEN
    IF (NEW.R3 = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 18);
    ELSEIF (NEW.R3 = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 18);
    END IF;
  END IF;
  IF (NEW.R4 IS NOT NULL) THEN
    IF (NEW.R4 = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 19);
    ELSEIF (NEW.R4 = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 19);
    END IF;
  END IF;
  IF (NEW.R5 IS NOT NULL) THEN
    IF (NEW.R5 = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 20);
    ELSEIF (NEW.R5 = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 20);
    END IF;
  END IF;
  IF (NEW.R6 IS NOT NULL) THEN
    IF (NEW.R6 = 1) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 19, 0, 0, NULL, 10, 21);
    ELSEIF (NEW.R6 = 0) THEN
      INSERT INTO commands VALUES (NULL, NOW(), 20, 0, 0, NULL, 11, 21);
    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_relays` AFTER UPDATE ON `relays`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_relays IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'relays';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_relays` AFTER DELETE ON `relays`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_relays IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'relays';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `remotecontrol`
--

DROP TABLE IF EXISTS `remotecontrol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remotecontrol` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` datetime DEFAULT NULL,
  `type_` int(11) NOT NULL DEFAULT '0',
  `device_id` int(11) NOT NULL,
  `louver_pos` int(11) DEFAULT NULL,
  `ac_enable` int(11) DEFAULT NULL,
  `time_enable` int(11) DEFAULT NULL,
  `dimmer` int(11) DEFAULT NULL,
  `remote_ack` int(11) NOT NULL DEFAULT '1',
  `rep_interval` int(11) DEFAULT NULL,
  `irdata_id` int(11) DEFAULT NULL,
  `alarm_aud` int(11) DEFAULT NULL,
  `alarm_led` int(11) DEFAULT NULL,
  `relay_id` int(11) DEFAULT NULL,
  `relay_set` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remotecontrol`
--

LOCK TABLES `remotecontrol` WRITE;
/*!40000 ALTER TABLE `remotecontrol` DISABLE KEYS */;
INSERT INTO `remotecontrol` VALUES (1,'2014-06-19 16:22:36',6,17,50,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL),(3,'2014-06-19 16:23:12',6,17,0,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL),(4,'2014-06-19 16:23:53',6,17,90,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL),(5,'2014-06-19 16:41:26',6,37,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL),(6,'2014-07-10 02:00:57',6,37,NULL,NULL,NULL,NULL,0,120,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `remotecontrol` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_remotecontrol` AFTER INSERT ON `remotecontrol`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_remotecontrol IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'remotecontrol'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_remotecontrol` AFTER UPDATE ON `remotecontrol`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_remotecontrol IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'remotecontrol';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_remotecontrol` AFTER DELETE ON `remotecontrol`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_remotecontrol IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'remotecontrol';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sensorsdyn`
--

DROP TABLE IF EXISTS `sensorsdyn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sensorsdyn` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` datetime DEFAULT NULL,
  `type_` int(11) NOT NULL DEFAULT '0',
  `device_id` int(11) NOT NULL,
  `temp_max` float(9,3) DEFAULT NULL,
  `temp_min` float(9,3) DEFAULT NULL,
  `temp_avg` float(9,3) DEFAULT NULL,
  `humid_max` float(9,3) DEFAULT NULL,
  `humid_min` float(9,3) DEFAULT NULL,
  `humid_avg` float(9,3) DEFAULT NULL,
  `lux_max` int(11) DEFAULT NULL,
  `lux_min` int(11) DEFAULT NULL,
  `co_max` int(11) DEFAULT NULL,
  `co_min` int(11) DEFAULT NULL,
  `co_avg` int(11) DEFAULT NULL,
  `co2_max` int(11) DEFAULT NULL,
  `co2_min` int(11) DEFAULT NULL,
  `co2_avg` int(11) DEFAULT NULL,
  `pir_count` int(11) DEFAULT NULL,
  `rssi` int(11) DEFAULT NULL,
  `battery` int(11) DEFAULT NULL,
  `remote_ack` int(11) DEFAULT NULL,
  `ac_current` float(9,3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensorsdyn`
--

LOCK TABLES `sensorsdyn` WRITE;
/*!40000 ALTER TABLE `sensorsdyn` DISABLE KEYS */;
INSERT INTO `sensorsdyn` VALUES (1,'2014-06-20 00:23:07',0,27,16.200,15.700,15.950,87.000,80.000,83.500,1234,1113,NULL,NULL,NULL,NULL,NULL,NULL,6,NULL,NULL,NULL,NULL),(2,'2014-06-20 00:31:52',0,27,16.200,15.700,15.950,87.000,80.000,83.500,1234,1113,NULL,NULL,NULL,NULL,NULL,NULL,6,71,88,0,NULL),(3,'2014-07-14 19:57:51',0,27,31.000,NULL,NULL,80.000,NULL,NULL,8975,NULL,2,NULL,NULL,321,NULL,NULL,2,55,33,NULL,0.000);
/*!40000 ALTER TABLE `sensorsdyn` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_sensorsdyn` AFTER INSERT ON `sensorsdyn`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_sensorsdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'sensorsdyn'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_sensorsdyn` AFTER UPDATE ON `sensorsdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_sensorsdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'sensorsdyn';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_sensorsdyn` AFTER DELETE ON `sensorsdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_sensorsdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'sensorsdyn';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id_session` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_client` int(11) NOT NULL,
  `hash` varchar(32) NOT NULL,
  `opened` datetime NOT NULL,
  `expires` datetime NOT NULL,
  `type` int(11) NOT NULL,
  `dbid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_session`),
  UNIQUE KEY `id_session` (`id_session`)
) ENGINE=MEMORY AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (1,2,'6bbbc21f60c9996beeb2b2828cad89ab','2014-12-12 16:02:20','2014-12-13 11:02:20',1,0),(2,2,'29423bc3a787015e39f1bc98db61c947','2014-12-13 02:04:26','2014-12-15 02:04:26',1,0),(3,2,'6bbbc21f60c9996beeb2b2828cad89ab','2014-12-15 20:12:00','2014-12-16 03:12:00',1,0),(4,2,'29423bc3a787015e39f1bc98db61c947','2014-12-16 01:37:54','2014-12-16 23:37:54',1,0),(5,2,'29423bc3a787015e39f1bc98db61c947','2014-12-17 02:02:16','2015-01-20 22:02:16',1,0),(6,1,'4eef6e0cee1d47199be4cf2eaa2577a5','2014-12-22 19:37:29','2014-12-23 17:46:40',0,0),(7,1,'4eef6e0cee1d47199be4cf2eaa2577a5','2014-12-22 19:37:33','2014-12-23 17:46:40',0,0),(8,1,'4eef6e0cee1d47199be4cf2eaa2577a5','2014-12-23 18:16:48','2014-12-23 17:46:40',0,0),(9,1,'4eef6e0cee1d47199be4cf2eaa2577a5','2014-12-23 18:43:44','2014-12-23 17:46:40',0,0),(10,1,'4eef6e0cee1d47199be4cf2eaa2577a5','2014-12-23 18:44:25','2014-12-23 17:46:40',0,0),(11,1,'4eef6e0cee1d47199be4cf2eaa2577a5','2014-12-23 18:46:53','2014-12-25 13:18:48',0,0),(12,1,'c432886957314e84a334460a528d699d','2014-12-23 21:17:24','2014-12-24 00:04:50',0,0),(13,1,'c432886957314e84a334460a528d699d','2014-12-23 23:30:00','2014-12-24 00:04:50',0,0),(14,1,'c432886957314e84a334460a528d699d','2014-12-24 01:06:23','2014-12-25 19:01:00',0,0),(15,2,'e70105b716dc41d6b6ba3f855aea576b','2014-12-24 01:08:19','2014-12-25 02:47:16',1,0);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smartdevices`
--

DROP TABLE IF EXISTS `smartdevices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smartdevices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` datetime DEFAULT NULL,
  `type_` int(11) DEFAULT NULL,
  `interface` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `period` int(11) DEFAULT '40',
  `lowthres` int(11) DEFAULT '0',
  `highthres` int(11) DEFAULT '0',
  `address` varchar(50) DEFAULT NULL,
  `relay` int(11) DEFAULT NULL,
  `speed` int(11) DEFAULT '0',
  `alarm` int(11) NOT NULL DEFAULT '0',
  `severity` int(11) DEFAULT NULL,
  `maker` varchar(200) DEFAULT NULL,
  `model` varchar(200) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smartdevices`
--

LOCK TABLES `smartdevices` WRITE;
/*!40000 ALTER TABLE `smartdevices` DISABLE KEYS */;
INSERT INTO `smartdevices` VALUES (1,'2014-11-25 16:50:46',1,0,1,40,0,0,'1',0,0,0,0,'ASE','RetroSAVE Smart Controller','ADC1 CO sensor'),(2,'2014-11-25 16:51:04',2,0,0,40,0,0,'2',0,0,0,0,'ASE','RetroSAVE Smart Controller','ADC2'),(3,'2014-11-25 16:51:19',2,0,0,40,0,0,'3',0,0,0,0,'ASE','RetroSAVE Smart Controller','ADC3'),(4,'2014-11-25 16:51:39',2,0,0,40,0,0,'4',0,0,0,0,'ASE','RetroSAVE Smart Controller','ADC4'),(5,'2014-11-25 16:52:12',2,1,1,40,0,0,'64',0,0,0,0,'ASE','RetroSAVE Smart Controller','HTU21 T sensor'),(6,'2014-11-25 16:52:32',3,1,1,40,0,0,'64',0,0,0,0,'ASE','RetroSAVE Smart Controller','HTU21 H sensor'),(7,'2014-12-17 02:38:00',4,2,1,40,0,0,'1121212',0,0,0,0,'','','test 1-wire T');
/*!40000 ALTER TABLE `smartdevices` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_smartdevices` AFTER INSERT ON `smartdevices`
	FOR EACH ROW
BEGIN
  IF (@DISABLE_TRIGGER_smartdevices IS NULL) THEN	
    SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND);
    SET @tbl_name = 'smartdevices';
    SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');
    SET @rec_state = 1;
    DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d;
    INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state);
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_smartdevices` AFTER UPDATE ON `smartdevices`
	FOR EACH ROW
BEGIN
  IF (@DISABLE_TRIGGER_smartdevices IS NULL) THEN
    SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND);
    SET @tbl_name = 'smartdevices';
    SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');
    SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');
    SET @rec_state = 2;
    SET @rs = 0;
    SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;
    IF @rs = 0 THEN
      INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );
    ELSE
      UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;
    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_smartdevices` AFTER DELETE ON `smartdevices`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartdevices IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartdevices';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `smartplugsdyn`
--

DROP TABLE IF EXISTS `smartplugsdyn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smartplugsdyn` (
  `device_id` int(11) NOT NULL,
  `state` int(11) DEFAULT NULL,
  `current` int(11) DEFAULT NULL,
  UNIQUE KEY `device_id` (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smartplugsdyn`
--

LOCK TABLES `smartplugsdyn` WRITE;
/*!40000 ALTER TABLE `smartplugsdyn` DISABLE KEYS */;
INSERT INTO `smartplugsdyn` VALUES (25,1,125);
/*!40000 ALTER TABLE `smartplugsdyn` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_smartplugsdyn` AFTER INSERT ON `smartplugsdyn`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_smartplugsdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartplugsdyn'; 						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_smartplugsdyn` AFTER UPDATE ON `smartplugsdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartplugsdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartplugsdyn';						SET @pk_d_old = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_smartplugsdyn` AFTER DELETE ON `smartplugsdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartplugsdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartplugsdyn';						SET @pk_d = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `smartsensors`
--

DROP TABLE IF EXISTS `smartsensors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smartsensors` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `updated` datetime NOT NULL,
  `type_` int(11) DEFAULT NULL,
  `froom_t` decimal(6,1) DEFAULT NULL,
  `froom_h` int(11) DEFAULT NULL,
  `co` int(11) DEFAULT NULL,
  `co2` int(11) DEFAULT NULL,
  `t_int` decimal(6,1) DEFAULT NULL,
  `t_supply_duct` decimal(6,1) DEFAULT NULL,
  `t_return_duct` decimal(6,1) DEFAULT NULL,
  `h_supply_duct` int(11) DEFAULT NULL,
  `h_return_duct` int(11) DEFAULT NULL,
  `htu` decimal(6,2) DEFAULT NULL,
  `air_vel` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smartsensors`
--

LOCK TABLES `smartsensors` WRITE;
/*!40000 ALTER TABLE `smartsensors` DISABLE KEYS */;
INSERT INTO `smartsensors` VALUES (1,'2014-04-06 01:01:01',0,25.0,70,2,333,35.0,NULL,NULL,NULL,NULL,NULL,NULL),(2,'2014-04-06 02:02:02',0,24.0,72,2,321,34.0,NULL,NULL,NULL,NULL,NULL,NULL),(3,'2014-04-07 01:01:01',0,26.0,71,1,321,36.0,14.0,23.0,55,67,NULL,NULL),(4,'2014-05-01 13:32:44',0,27.0,66,1,339,33.0,17.0,25.0,65,70,55.00,4),(5,'2014-06-13 01:39:05',0,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,'2014-06-13 01:59:07',0,NULL,NULL,NULL,223,NULL,NULL,22.5,NULL,77,NULL,NULL),(7,'2014-06-13 02:05:32',0,NULL,NULL,NULL,NULL,NULL,23.5,NULL,88,NULL,NULL,111),(8,'2014-09-19 22:58:58',0,NULL,NULL,NULL,NULL,NULL,NULL,20.0,NULL,60,NULL,NULL),(9,'2014-09-19 22:59:00',0,NULL,NULL,NULL,NULL,NULL,NULL,20.0,NULL,60,NULL,NULL),(10,'2014-10-18 02:12:05',0,28.0,78,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11,'2014-10-20 15:02:03',2,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,'2014-10-22 02:37:11',1,NULL,NULL,17,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(13,'2014-12-13 02:26:56',0,23.5,88,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,111),(14,'2014-12-13 02:26:58',0,23.5,88,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,111);
/*!40000 ALTER TABLE `smartsensors` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_smartsensors` AFTER INSERT ON `smartsensors`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_smartsensors IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartsensors'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_smartsensors` AFTER UPDATE ON `smartsensors`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartsensors IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartsensors';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_smartsensors` AFTER DELETE ON `smartsensors`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartsensors IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartsensors';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `smartsensorsraw`
--

DROP TABLE IF EXISTS `smartsensorsraw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smartsensorsraw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` datetime DEFAULT NULL,
  `source` int(11) NOT NULL DEFAULT '0',
  `type_` int(11) NOT NULL DEFAULT '0',
  `address` varchar(64) DEFAULT NULL,
  `value_` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smartsensorsraw`
--

LOCK TABLES `smartsensorsraw` WRITE;
/*!40000 ALTER TABLE `smartsensorsraw` DISABLE KEYS */;
INSERT INTO `smartsensorsraw` VALUES (1,'2014-06-13 18:24:56',0,0,'1','948'),(2,'2014-06-13 18:54:50',1,1,'1E','22.5'),(3,'2014-06-13 21:10:28',2,2,'1011121314151617','89'),(4,'2014-06-13 21:15:18',2,2,'1011121314151617','87'),(5,'2014-10-29 20:55:23',2,2,'1122334455','123'),(6,'2014-10-29 20:55:28',2,2,'11223344','321');
/*!40000 ALTER TABLE `smartsensorsraw` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_smartsensorsraw` AFTER INSERT ON `smartsensorsraw`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_smartsensorsraw IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartsensorsraw'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_smartsensorsraw` AFTER UPDATE ON `smartsensorsraw`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartsensorsraw IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartsensorsraw';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_smartsensorsraw` AFTER DELETE ON `smartsensorsraw`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartsensorsraw IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartsensorsraw';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `smartstatus`
--

DROP TABLE IF EXISTS `smartstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smartstatus` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `updated` datetime NOT NULL,
  `group_` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `value` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smartstatus`
--

LOCK TABLES `smartstatus` WRITE;
/*!40000 ALTER TABLE `smartstatus` DISABLE KEYS */;
INSERT INTO `smartstatus` VALUES (1,'2014-05-01 17:54:27','health','cpu','0.22, 0.33, 0.30'),(2,'2014-05-01 17:54:27','health','ram','232Mb used, 206Mb free'),(3,'2014-05-01 17:54:27','health','disk','2131Mb used, 1479Mb free'),(4,'2014-05-01 17:54:27','health','uptime','3 days, 18:20'),(5,'2014-05-01 17:54:27','network','ip_main','192.168.2.17'),(6,'2014-05-01 17:54:27','network','gateway','192.168.2.1'),(7,'2014-05-01 17:54:27','network','ip_wan','10.0.0.1'),(8,'2014-04-23 20:06:00','network','cloud','cloud.ase-energy.ca'),(9,'2014-05-01 17:09:34','network','ip_cwan',NULL),(10,'2014-05-01 17:10:05','network','gw_cwan',NULL),(11,'2014-05-01 17:54:27','network','list_wan','10.0.0.14,40:b0:fa:68:20:19;10.0.0.13,40:b0:fa:33:44:ac'),(12,'2014-05-01 17:54:27','network','dns','8.8.8.8;8.8.4.4;192.168.2.1'),(13,'2014-05-02 00:42:26','weather','location','Kiev'),(14,'2014-05-02 00:42:26','weather','temp','11.24'),(15,'2014-05-02 00:42:26','weather','humid','76'),(16,'2014-05-02 00:42:26','weather','wind','1.63 318.506'),(17,'2014-05-02 00:42:26','weather','air_pres','981.7545'),(18,'2014-05-02 00:42:26','weather','cond','Clouds, few clouds');
/*!40000 ALTER TABLE `smartstatus` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_smartstatus` AFTER INSERT ON `smartstatus`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_smartstatus IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartstatus'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_smartstatus` AFTER UPDATE ON `smartstatus`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartstatus IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartstatus';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_smartstatus` AFTER DELETE ON `smartstatus`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartstatus IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartstatus';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `statistics`
--

DROP TABLE IF EXISTS `statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `data` datetime NOT NULL,
  `sim_id` int(11) NOT NULL DEFAULT '0',
  `zone_id` int(11) NOT NULL,
  `device_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `report_type` tinyint(4) DEFAULT '0',
  `T` float(9,3) NOT NULL DEFAULT '0.000',
  `H` float(9,3) NOT NULL DEFAULT '0.000',
  `L` float(9,3) NOT NULL DEFAULT '0.000',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `sim_id` (`sim_id`),
  KEY `data` (`data`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics`
--

LOCK TABLES `statistics` WRITE;
/*!40000 ALTER TABLE `statistics` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistics` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_statistics` AFTER INSERT ON `statistics`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_statistics IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'statistics'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_statistics` AFTER UPDATE ON `statistics`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_statistics IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'statistics';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_statistics` AFTER DELETE ON `statistics`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_statistics IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'statistics';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `temperaturebreakout`
--

DROP TABLE IF EXISTS `temperaturebreakout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temperaturebreakout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `temperature_profile_id` int(11) NOT NULL,
  `dayofweek` int(11) NOT NULL,
  `timeframe` int(11) NOT NULL,
  `temperature` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temperaturebreakout`
--

LOCK TABLES `temperaturebreakout` WRITE;
/*!40000 ALTER TABLE `temperaturebreakout` DISABLE KEYS */;
INSERT INTO `temperaturebreakout` VALUES (1,1,0,0,20),(2,1,0,30,20),(3,1,0,100,20),(4,1,0,130,20),(5,1,0,200,20),(6,1,0,230,20),(7,1,0,300,20),(8,1,0,330,20),(9,1,0,400,20),(10,1,0,430,20),(11,1,0,500,20),(12,1,0,530,20),(13,1,0,600,20),(14,1,0,630,20),(15,1,0,700,20),(16,1,0,730,20),(17,1,0,800,20),(18,1,0,830,20),(19,1,0,900,20),(20,1,0,930,20),(21,1,0,1000,20),(22,1,0,1030,20),(23,1,0,1100,20),(24,1,0,1130,20),(25,1,0,1200,20),(26,1,0,1230,20),(27,1,0,1300,20),(28,1,0,1330,20),(29,1,0,1400,20),(30,1,0,1430,20),(31,1,0,1500,20),(32,1,0,1530,20),(33,1,0,1600,20),(34,1,0,1630,20),(35,1,0,1700,20),(36,1,0,1730,20),(37,1,0,1800,20),(38,1,0,1830,20),(39,1,0,1900,20),(40,1,0,1930,20),(41,1,0,2000,20),(42,1,0,2030,20),(43,1,0,2100,20),(44,1,0,2130,20),(45,1,0,2200,20),(46,1,0,2230,20),(47,1,0,2300,20),(48,1,0,2330,20);
/*!40000 ALTER TABLE `temperaturebreakout` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_temperaturebreakout` AFTER INSERT ON `temperaturebreakout`
	FOR EACH ROW BEGIN 
IF (@DISABLE_TRIGGER_temperaturebreakout IS NULL) THEN
	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 
	SET @tbl_name = 'temperaturebreakout'; 
	SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 
	SET @rec_state = 1;
	DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 
	INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 
	VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 
END IF;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_temperaturebreakout` AFTER UPDATE ON `temperaturebreakout`
	FOR EACH ROW BEGIN
IF (@DISABLE_TRIGGER_temperaturebreakout IS NULL) THEN
	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 
	SET @tbl_name = 'temperaturebreakout';
	SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');
	SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');
	SET @rec_state = 2;
	SET @rs = 0;
	SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;
	IF @rs = 0 THEN 
	INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );
	ELSE 
	UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;
	END IF; 
END IF;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_temperaturebreakout` AFTER DELETE ON `temperaturebreakout`
	FOR EACH ROW BEGIN
IF (@DISABLE_TRIGGER_temperaturebreakout IS NULL) THEN
	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 
	SET @tbl_name = 'temperaturebreakout';
	SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');
	SET @rec_state = 3;
	SET @rs = 0;
	SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;
	DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 
	IF @rs <> 1 THEN 
	INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 
	END IF; 
END IF;
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `temperatureprofile`
--

DROP TABLE IF EXISTS `temperatureprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temperatureprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `temperature` double NOT NULL,
  `humidity` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temperatureprofile`
--

LOCK TABLES `temperatureprofile` WRITE;
/*!40000 ALTER TABLE `temperatureprofile` DISABLE KEYS */;
INSERT INTO `temperatureprofile` VALUES (1,'Default',20,60),(2,'Make me hotter',22,70),(3,'Cool me down',18,50),(4,'Virtual zone',0,0);
/*!40000 ALTER TABLE `temperatureprofile` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_temperatureprofile` AFTER INSERT ON `temperatureprofile`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_temperatureprofile IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'temperatureprofile'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_temperatureprofile` AFTER UPDATE ON `temperatureprofile`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_temperatureprofile IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'temperatureprofile';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_temperatureprofile` AFTER DELETE ON `temperatureprofile`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_temperatureprofile IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'temperatureprofile';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `thermostat`
--

DROP TABLE IF EXISTS `thermostat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thermostat` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `updated` datetime NOT NULL,
  `W1` tinyint(4) DEFAULT NULL,
  `W2` tinyint(4) DEFAULT NULL,
  `Y1` tinyint(4) DEFAULT NULL,
  `Y2` tinyint(4) DEFAULT NULL,
  `G` tinyint(4) DEFAULT NULL,
  `OB` tinyint(4) DEFAULT NULL,
  `Aux` tinyint(4) DEFAULT NULL,
  `Rc` tinyint(4) DEFAULT NULL,
  `Rh` tinyint(4) DEFAULT NULL,
  `Hum` tinyint(4) DEFAULT NULL,
  `avg_t` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thermostat`
--

LOCK TABLES `thermostat` WRITE;
/*!40000 ALTER TABLE `thermostat` DISABLE KEYS */;
INSERT INTO `thermostat` VALUES (1,'2014-04-06 04:04:04',1,1,0,0,1,1,0,NULL,NULL,NULL,NULL),(2,'2014-04-06 05:05:05',0,0,1,1,0,1,0,NULL,NULL,NULL,NULL),(3,'2014-05-08 20:53:08',1,1,0,0,0,0,0,NULL,NULL,NULL,26.20),(4,'2014-06-13 01:50:31',1,1,0,0,0,0,0,NULL,NULL,NULL,NULL),(5,'2014-10-18 01:06:50',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,'2014-10-18 01:07:02',1,NULL,NULL,NULL,1,1,NULL,NULL,NULL,NULL,NULL),(7,'2014-10-22 01:49:48',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,NULL),(8,'2014-10-22 01:50:07',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(9,'2014-10-22 02:17:11',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,'2014-10-22 02:19:22',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL),(11,'2014-10-22 02:23:10',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,'2014-10-22 02:25:46',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL),(13,'2014-10-22 02:27:49',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL);
/*!40000 ALTER TABLE `thermostat` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_thermostat` AFTER INSERT ON `thermostat`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_thermostat IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'thermostat'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_thermostat` AFTER UPDATE ON `thermostat`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_thermostat IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'thermostat';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_thermostat` AFTER DELETE ON `thermostat`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_thermostat IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'thermostat';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `timers`
--

DROP TABLE IF EXISTS `timers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` datetime DEFAULT NULL,
  `expired` datetime DEFAULT NULL,
  `type_` int(11) DEFAULT NULL,
  `zone_id` int(11) DEFAULT NULL,
  `device_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MEMORY DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timers`
--

LOCK TABLES `timers` WRITE;
/*!40000 ALTER TABLE `timers` DISABLE KEYS */;
/*!40000 ALTER TABLE `timers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ui_menu`
--

DROP TABLE IF EXISTS `ui_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ui_menu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `menu` varchar(30) DEFAULT NULL,
  `submenu` varchar(20) NOT NULL,
  `description` varchar(200) NOT NULL,
  `access` tinyint(4) NOT NULL DEFAULT '0',
  `level` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ui_menu`
--

LOCK TABLES `ui_menu` WRITE;
/*!40000 ALTER TABLE `ui_menu` DISABLE KEYS */;
INSERT INTO `ui_menu` VALUES (1,'status','relays','Status',0,0),(2,'status','relays','Local Relays',0,1),(3,'status','onboard','Local Sensors',0,1),(4,'status','indoor','Indoor Sensors',0,1),(5,'status','outdoor','Outdoor Sensors',0,1),(6,'status','system','System Information',0,1),(7,'networks','ip','Networks',0,0),(8,'networks','ip','IP Network',0,1),(9,'networks','zigbee','Local Zigbee',0,1),(10,'networks','asemp','ASEMP Profile',0,1),(11,'hvac','furnace','HVAC',0,0),(12,'hvac','furnace','Furnace',0,1),(13,'hvac','fblower','Furnace Blower',0,1),(14,'hvac','acheat','A/C & Heat Pump',0,1),(15,'hvac','hrverv','HRV/ERV Control',0,1),(16,'hvac','comfort','Comfort Settings',0,1),(17,'hvac','thermostat','Customer Thermostat Control',0,1),(18,'smartgrid','peaksaver','Smart Grid',0,0),(20,'zonedev','zones','RetroSAVE<br>Management',0,0),(21,'events','events','Events<br>& Alarms',0,0),(22,'userinfo','details','Customer<br>Settings',0,0),(23,'userinfo','details','User Details',0,1),(24,'userinfo','alarms','Alarms & Events',0,1),(25,'userinfo','password','Password',0,1),(26,'system','update','System<br>Maintenance',0,0),(28,'system','update','Software Update',0,1),(29,'system','db','Database Maintenance',0,1),(32,'zonedev','zones','Zones',0,1),(33,'zonedev','devices','Remote Devices',0,1),(34,'zonedev','newdev','Add New Devices',0,1),(39,'events','events','Alarms & Events Viewer',0,1),(40,'events','alarms','RetroSAVE Alarms Management',0,1),(41,'status','networks','Network Connections',0,1),(43,'events','management','Networks Alarms Management',0,1),(44,'smartgrid','peaksaver','PeakSaver',0,1),(45,'smartgrid','smartmeter','SmartMeter',0,1),(46,'reports','occupancy','Reports',0,0),(47,'logout','logout','Logout',0,0),(48,'reports','occupancy','Statistical Occupancy Stats',0,1),(49,'reports','retrosave','RetroSAVE Runtime',0,1),(50,'reports','charts','Charts',0,1),(51,'reports','savings','Savings',0,1),(52,'reports','runtime','HVAC Runtime',0,1),(54,'status','zigbee','Zigbee',0,1),(55,'reports','cots','COTS Thermostat Stats',0,1),(56,'zonedev','smartdevices','Local Sensors',0,1),(57,'system','datetime','Date & Time',0,1),(58,'zonedev','sensorstest','Local Sensor Values',0,1),(59,'system','advanced','Advanced',0,1),(60,'zonedev','cluster','Cluster Command Page',0,1);
/*!40000 ALTER TABLE `ui_menu` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_ui_menu` AFTER INSERT ON `ui_menu`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_ui_menu IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'ui_menu'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_ui_menu` AFTER UPDATE ON `ui_menu`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_ui_menu IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'ui_menu';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_ui_menu` AFTER DELETE ON `ui_menu`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_ui_menu IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'ui_menu';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `name1` varchar(100) NOT NULL,
  `name2` varchar(100) DEFAULT NULL,
  `address1` varchar(200) DEFAULT NULL,
  `address2` varchar(200) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `province` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `postal` varchar(20) DEFAULT NULL,
  `phone1` varchar(20) NOT NULL,
  `phone2` varchar(20) DEFAULT NULL,
  `phone3` varchar(20) DEFAULT NULL,
  `email` varchar(200) NOT NULL,
  `timezone` smallint(6) NOT NULL DEFAULT '0',
  `comfort` tinyint(4) NOT NULL DEFAULT '0',
  `access` tinyint(4) NOT NULL DEFAULT '0',
  `t_display` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `login` (`login`),
  UNIQUE KEY `password` (`password`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'aseuser','aseuser','Dmitry','','','','','CAN-PE','Armenia','','380503173500','','','dmitry@ase-energy.ca',5,2,0,0),(2,'aseadmin','aseadmin','Dmitry','Ilchyshyn','Somewhere 3','','Lutsk','NONE','Ukraine','10000','380503173500','','','dmitry@ase-energy.ca',200,2,1,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_users` AFTER INSERT ON `users`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_users IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'users'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_users` AFTER UPDATE ON `users`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_users IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'users';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_users` AFTER DELETE ON `users`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_users IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'users';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `zigbee`
--

DROP TABLE IF EXISTS `zigbee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zigbee` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `channel` int(11) DEFAULT NULL,
  `panid` int(11) DEFAULT NULL,
  `panid_sel` tinyint(4) NOT NULL DEFAULT '1',
  `addr64` varchar(32) NOT NULL,
  `addr16` varchar(16) NOT NULL,
  `encryption` tinyint(4) DEFAULT '1',
  `sec_key` varchar(100) DEFAULT NULL,
  `mfc_id` varchar(100) DEFAULT NULL,
  `hw_version` varchar(100) DEFAULT NULL,
  `sw_version` varchar(100) DEFAULT NULL,
  `alarms` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zigbee`
--

LOCK TABLES `zigbee` WRITE;
/*!40000 ALTER TABLE `zigbee` DISABLE KEYS */;
INSERT INTO `zigbee` VALUES (1,44912640,123452,0,'1122334455667788','5678',1,'sometestkey2','XBP24BZ7PITB','XBEEPRO2','v1347',0);
/*!40000 ALTER TABLE `zigbee` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_zigbee` AFTER INSERT ON `zigbee`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_zigbee IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_zigbee` AFTER UPDATE ON `zigbee`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zigbee IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_zigbee` AFTER DELETE ON `zigbee`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zigbee IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `zigbee_ase`
--

DROP TABLE IF EXISTS `zigbee_ase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zigbee_ase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` int(11) DEFAULT NULL,
  `profile_id` int(11) DEFAULT NULL,
  `joined` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  `device_type` int(11) NOT NULL DEFAULT '0',
  `device_status` tinyint(4) NOT NULL DEFAULT '0',
  `device_state` tinyint(4) NOT NULL DEFAULT '2',
  `addr64` char(20) DEFAULT NULL,
  `addr16` int(11) DEFAULT NULL,
  `zigbee_hw` int(11) DEFAULT NULL,
  `zigbee_sw` int(11) DEFAULT NULL,
  `device_sw` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zigbee_ase`
--

LOCK TABLES `zigbee_ase` WRITE;
/*!40000 ALTER TABLE `zigbee_ase` DISABLE KEYS */;
INSERT INTO `zigbee_ase` VALUES (3,30,3,'2014-11-29 00:43:50','2014-11-29 03:41:38',1,2,1,'1122334455667788',11223,10001,10002,10003),(4,29,4,'2014-11-29 00:53:24','2014-11-29 03:41:29',7,1,2,'1122334455667766',11233,10001,10002,10003),(5,33,0,'2014-11-29 04:07:21','2014-12-25 01:47:09',3,1,1,'1122334455611766',12233,10001,10002,10003),(6,32,0,'2014-12-02 18:57:11','2014-12-02 18:57:36',128,1,1,'1122224455611766',12233,10001,10002,10003);
/*!40000 ALTER TABLE `zigbee_ase` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER a_i_zigbee_ase
	AFTER INSERT
	ON zigbee_ase
	FOR EACH ROW
BEGIN 					
  IF (@DISABLE_TRIGGER_zigbee_ase IS NULL) THEN	
    SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						
    SET @tbl_name = 'zigbee_ase'; 						
    SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						
    SET @rec_state = 1;						
    DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						
    INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					
  END IF;	

  SET @zigbeehw = NEW.zigbee_hw;
  SET @zigbeesw = NEW.zigbee_sw;
  SET @devicesw = NEW.device_sw;
  SET @macaddr = NEW.addr64;
  SET @shortaddr = NEW.addr16;
  INSERT INTO registrations (id, updated, event_type, device_type, zigbee_short, zigbee_addr64, zigbee_mode, zigbee_hw, zigbee_fw, device_fw, status) 
    VALUES (NULL, NOW(), 1, 0, @shortaddr, @macaddr, 2, @zigbeehw, @zigbeesw, @devicesw, 0);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_zigbee_ase` AFTER UPDATE ON `zigbee_ase`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zigbee_ase IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee_ase';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_zigbee_ase` AFTER DELETE ON `zigbee_ase`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zigbee_ase IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee_ase';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `zigbee_commands`
--

DROP TABLE IF EXISTS `zigbee_commands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zigbee_commands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` int(11) NOT NULL,
  `command` int(11) NOT NULL,
  `updated` datetime NOT NULL,
  `return_code` int(11) DEFAULT NULL,
  `result_string` varchar(255) DEFAULT NULL,
  `return_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zigbee_commands`
--

LOCK TABLES `zigbee_commands` WRITE;
/*!40000 ALTER TABLE `zigbee_commands` DISABLE KEYS */;
INSERT INTO `zigbee_commands` VALUES (1,2,6,'2015-01-07 01:05:07',NULL,NULL,1),(2,31,6,'2015-01-07 01:05:22',NULL,NULL,1),(3,32,1794,'2015-01-07 01:05:54',NULL,NULL,111),(4,34,1794,'2015-01-07 01:11:09',NULL,NULL,111),(5,34,6,'2015-01-07 01:32:35',NULL,NULL,NULL),(6,31,6,'2015-01-07 01:32:37',NULL,NULL,NULL),(7,34,6,'2015-01-07 01:32:40',NULL,NULL,NULL),(8,31,6,'2015-01-07 01:32:41',NULL,NULL,NULL),(9,34,6,'2015-01-07 01:34:00',NULL,NULL,NULL),(10,31,6,'2015-01-07 01:34:18',NULL,NULL,NULL),(11,32,1794,'2015-01-07 01:40:41',1,NULL,111),(12,34,6,'2015-01-07 01:40:55',NULL,NULL,NULL),(13,34,1794,'2015-01-07 01:42:15',NULL,NULL,NULL),(14,34,1794,'2015-01-07 01:43:13',NULL,NULL,NULL);
/*!40000 ALTER TABLE `zigbee_commands` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_zigbee_commands` AFTER INSERT ON `zigbee_commands`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_zigbee_commands IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee_commands'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_zigbee_commands` AFTER UPDATE ON `zigbee_commands`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zigbee_commands IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee_commands';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_zigbee_commands` AFTER DELETE ON `zigbee_commands`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zigbee_commands IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee_commands';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `zigbee_ha`
--

DROP TABLE IF EXISTS `zigbee_ha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zigbee_ha` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` int(11) DEFAULT NULL,
  `cluster_id` int(11) DEFAULT NULL,
  `endpoint_id` int(11) DEFAULT NULL,
  `profile_id` int(11) DEFAULT NULL,
  `joined` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  `device_status` int(11) DEFAULT NULL,
  `addr64` char(20) DEFAULT NULL,
  `addr16` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zigbee_ha`
--

LOCK TABLES `zigbee_ha` WRITE;
/*!40000 ALTER TABLE `zigbee_ha` DISABLE KEYS */;
INSERT INTO `zigbee_ha` VALUES (1,NULL,6,NULL,NULL,'2014-11-26 23:52:37',NULL,NULL,'1122334455667700',32211),(2,31,6,NULL,260,'2014-11-29 01:29:45','2014-11-29 03:45:35',1,'1212121223232323',33221),(3,34,1794,NULL,260,'2014-11-29 04:07:03','2015-01-07 00:59:31',1,'1212121223112323',33121);
/*!40000 ALTER TABLE `zigbee_ha` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER a_i_zigbee_ha
	AFTER INSERT
	ON zigbee_ha
	FOR EACH ROW
BEGIN 					
  IF (@DISABLE_TRIGGER_zigbee_ha IS NULL) THEN	
    SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						
    SET @tbl_name = 'zigbee_ha'; 						
    SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						
    SET @rec_state = 1;						
    DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						
    INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state);
  END IF;	

  SET @macaddr = NEW.addr64;
  SET @shortaddr = NEW.addr16;
  INSERT INTO registrations (id, updated, event_type, device_type, zigbee_short, zigbee_addr64, zigbee_mode, status) 
    VALUES (NULL, NOW(), 1, 80, @shortaddr, @macaddr, 2, 0);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_zigbee_ha` AFTER UPDATE ON `zigbee_ha`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zigbee_ha IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee_ha';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_zigbee_ha` AFTER DELETE ON `zigbee_ha`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zigbee_ha IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee_ha';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `zoneadvanced`
--

DROP TABLE IF EXISTS `zoneadvanced`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zoneadvanced` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zone_id` int(11) NOT NULL,
  `type_` int(11) NOT NULL,
  `realvar1` float(9,3) DEFAULT NULL,
  `realvar2` float(9,3) DEFAULT NULL,
  `realvar3` float(9,3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `zone_id` (`zone_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zoneadvanced`
--

LOCK TABLES `zoneadvanced` WRITE;
/*!40000 ALTER TABLE `zoneadvanced` DISABLE KEYS */;
/*!40000 ALTER TABLE `zoneadvanced` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_zoneadvanced` AFTER INSERT ON `zoneadvanced`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_zoneadvanced IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zoneadvanced'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_zoneadvanced` AFTER UPDATE ON `zoneadvanced`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zoneadvanced IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zoneadvanced';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_zoneadvanced` AFTER DELETE ON `zoneadvanced`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zoneadvanced IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zoneadvanced';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `zones`
--

DROP TABLE IF EXISTS `zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `temperature_profile_id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `volume` double DEFAULT NULL,
  `sleep_area` int(11) NOT NULL DEFAULT '0',
  `level` int(11) DEFAULT '0',
  `orientation` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `temperature_profile_id` (`temperature_profile_id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zones`
--

LOCK TABLES `zones` WRITE;
/*!40000 ALTER TABLE `zones` DISABLE KEYS */;
INSERT INTO `zones` VALUES (2,0,'Master zone',0,0,0,0),(1,0,'Temporary zone',0,0,0,0),(3,1,'Living room',40,0,1,1),(4,1,'Kitchen',30,0,0,1),(6,0,'Outdoor area',0,0,2,2),(5,1,'Hall is biig',50,0,0,2),(20,1,'Bedroom #1',1,1,1,3),(21,1,'Bedroom #2',1,1,1,3),(22,1,'Closet',1,0,0,4);
/*!40000 ALTER TABLE `zones` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_zones` AFTER INSERT ON `zones`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_zones IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zones'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_zones` AFTER UPDATE ON `zones`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zones IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zones';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_zones` AFTER DELETE ON `zones`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zones IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zones';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `zonesdyn`
--

DROP TABLE IF EXISTS `zonesdyn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zonesdyn` (
  `zone_id` int(11) NOT NULL,
  `occupation` int(11) DEFAULT '0',
  `state` int(11) DEFAULT '0',
  `timer_on` int(11) DEFAULT '0',
  `timer_off` int(11) DEFAULT '0',
  `priority` int(11) DEFAULT '0',
  PRIMARY KEY (`zone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zonesdyn`
--

LOCK TABLES `zonesdyn` WRITE;
/*!40000 ALTER TABLE `zonesdyn` DISABLE KEYS */;
INSERT INTO `zonesdyn` VALUES (0,0,0,0,0,0),(3,2,0,0,0,0),(4,0,0,0,0,0),(5,1,0,0,0,0),(20,0,0,0,0,0),(21,0,0,0,0,0),(22,0,0,0,0,0);
/*!40000 ALTER TABLE `zonesdyn` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_zonesdyn` AFTER INSERT ON `zonesdyn`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_zonesdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zonesdyn'; 						SET @pk_d = CONCAT('<zone_id>',NEW.`zone_id`,'</zone_id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_zonesdyn` AFTER UPDATE ON `zonesdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zonesdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zonesdyn';						SET @pk_d_old = CONCAT('<zone_id>',OLD.`zone_id`,'</zone_id>');						SET @pk_d = CONCAT('<zone_id>',NEW.`zone_id`,'</zone_id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_zonesdyn` AFTER DELETE ON `zonesdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zonesdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zonesdyn';						SET @pk_d = CONCAT('<zone_id>',OLD.`zone_id`,'</zone_id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-01-07  1:47:27
