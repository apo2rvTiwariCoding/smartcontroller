-- MySQL dump 10.13  Distrib 5.5.38, for debian-linux-gnu (armv7l)
--
-- Host: localhost    Database: smart2014
-- ------------------------------------------------------
-- Server version	5.5.38-0+wheezy1

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
) ENGINE=MEMORY AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
INSERT INTO `actions` VALUES (1,'commands',1,0,0),(2,'commands',2,0,0),(3,'commands',3,0,0),(4,'commands',4,0,0),(5,'commands',5,0,0),(6,'commands',6,0,0),(7,'commands',7,0,0),(8,'commands',8,0,0),(9,'commands',9,0,0),(10,'commands',10,0,0),(11,'commands',11,0,0),(12,'commands',12,0,0),(13,'commands',13,0,0),(14,'commands',14,0,0),(15,'commands',15,0,0),(16,'commands',16,0,0),(17,'commands',17,0,0),(18,'commands',18,0,0),(19,'commands',19,0,0),(20,'commands',20,0,0),(21,'commands',21,0,0),(22,'commands',22,0,0),(23,'commands',23,0,0),(24,'commands',24,0,0),(25,'commands',25,0,0);
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `action_notify_MuxDemux`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarms_networks`
--

LOCK TABLES `alarms_networks` WRITE;
/*!40000 ALTER TABLE `alarms_networks` DISABLE KEYS */;
/*!40000 ALTER TABLE `alarms_networks` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_alarms_networks` AFTER INSERT ON `alarms_networks`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_alarms_networks IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_networks'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_alarms_networks` AFTER UPDATE ON `alarms_networks`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_networks IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_networks';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_alarms_networks` AFTER DELETE ON `alarms_networks`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_networks IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_networks';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarms_pressure`
--

LOCK TABLES `alarms_pressure` WRITE;
/*!40000 ALTER TABLE `alarms_pressure` DISABLE KEYS */;
/*!40000 ALTER TABLE `alarms_pressure` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_alarms_pressure` AFTER INSERT ON `alarms_pressure`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_alarms_pressure IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_pressure'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_alarms_pressure` AFTER UPDATE ON `alarms_pressure`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_pressure IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_pressure';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_alarms_pressure` AFTER DELETE ON `alarms_pressure`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_pressure IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_pressure';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarms_retrosave`
--

LOCK TABLES `alarms_retrosave` WRITE;
/*!40000 ALTER TABLE `alarms_retrosave` DISABLE KEYS */;
/*!40000 ALTER TABLE `alarms_retrosave` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_alarms_retrosave` AFTER INSERT ON `alarms_retrosave`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_alarms_retrosave IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_retrosave'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_alarms_retrosave` AFTER UPDATE ON `alarms_retrosave`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_retrosave IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_retrosave';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_alarms_retrosave` AFTER DELETE ON `alarms_retrosave`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_retrosave IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_retrosave';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarms_system`
--

LOCK TABLES `alarms_system` WRITE;
/*!40000 ALTER TABLE `alarms_system` DISABLE KEYS */;
/*!40000 ALTER TABLE `alarms_system` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_alarms_system` AFTER INSERT ON `alarms_system`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_alarms_system IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_system'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_alarms_system` AFTER UPDATE ON `alarms_system`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_system IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_system';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_alarms_system` AFTER DELETE ON `alarms_system`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_system IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_system';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_alarms_types` AFTER INSERT ON `alarms_types`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_alarms_types IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_types'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_alarms_types` AFTER UPDATE ON `alarms_types`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_types IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_types';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_alarms_types` AFTER DELETE ON `alarms_types`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_types IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_types';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarms_zigbee`
--

LOCK TABLES `alarms_zigbee` WRITE;
/*!40000 ALTER TABLE `alarms_zigbee` DISABLE KEYS */;
/*!40000 ALTER TABLE `alarms_zigbee` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_alarms_zigbee` AFTER INSERT ON `alarms_zigbee`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_alarms_zigbee IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_zigbee'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_alarms_zigbee` AFTER UPDATE ON `alarms_zigbee`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_zigbee IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_zigbee';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_alarms_zigbee` AFTER DELETE ON `alarms_zigbee`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_zigbee IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_zigbee';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asemp`
--

LOCK TABLES `asemp` WRITE;
/*!40000 ALTER TABLE `asemp` DISABLE KEYS */;
INSERT INTO `asemp` VALUES (1,0,'occu_pir',0,0,'Occupied PIR Trigger Enable',0,NULL),(2,0,'unoccu_pir',1,1,'Unoccupied PIR Trigger Enable',0,NULL),(3,0,'occu_rep',120,120,'Occupied Reporting Period',1,'seconds'),(4,0,'unoccu_rep',360,360,'Unoccupied Reporting Period\r\n',1,'seconds'),(5,0,'min_rep_int',60,60,'Minimum Time Interval Between Consecutive Unsolicited Reports',1,'seconds'),(6,0,'bat_stat_thr',10,10,'Battery Status Trigger Value Threshold',1,NULL),(7,0,'ac_curr_thr',0,0,'AC current upper threshold trigger',1,'Ampere'),(8,0,'up_temp_tr',35,35,'Upper Temperature Value Report Trigger\r\n',1,'degree C'),(9,0,'lo_temp_tr',5,5,'Lower Temperature Value Report Trigger\r\n',1,'degree C'),(10,0,'up_hum_tr',60,60,'Upper Humidity Value Report Trigger',1,'% RH'),(11,0,'lo_hum_tr',30,30,'Lower Humidity Value Report Trigger',1,'% RH'),(12,0,'mcu_sleep',0,0,'MCU sleep timer. CC2530 wakeup sleep timer',1,'sec'),(13,0,'max_retry',3,3,'ASEMP Max Retry Count',1,NULL),(14,0,'max_wait',60,60,'ASEMP MAX Wait Timer',1,'seconds'),(15,0,'up_co_tr',0,0,'Upper CO Value Trigger Report',1,'ppm'),(16,0,'up_co2_tr',1000,1000,'Upper CO2 Value Trigger Report\r\n',1,'ppm'),(17,0,'aud_alarm',1,1,'Audible Alarm Enable',0,NULL),(18,0,'led_alarm',1,1,'LED Alarm Enable',0,NULL),(19,0,'name',0,0,'Default ASEMP Profile',2,NULL);
/*!40000 ALTER TABLE `asemp` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_asemp` AFTER INSERT ON `asemp`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_asemp IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'asemp'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_asemp` AFTER UPDATE ON `asemp`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_asemp IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'asemp';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_asemp` AFTER DELETE ON `asemp`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_asemp IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'asemp';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bypass`
--

LOCK TABLES `bypass` WRITE;
/*!40000 ALTER TABLE `bypass` DISABLE KEYS */;
INSERT INTO `bypass` VALUES (1,'2014-11-25 16:55:21',1,0,'Toggle from webui'),(2,'2014-11-25 16:55:31',1,1,'Toggle from webui'),(3,'2014-11-25 16:55:40',1,0,'Toggle from webui');
/*!40000 ALTER TABLE `bypass` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_bypass` AFTER INSERT ON `bypass`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_bypass IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'bypass'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_bypass` AFTER UPDATE ON `bypass`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_bypass IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'bypass';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_bypass` AFTER DELETE ON `bypass`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_bypass IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'bypass';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commands`
--

LOCK TABLES `commands` WRITE;
/*!40000 ALTER TABLE `commands` DISABLE KEYS */;
INSERT INTO `commands` VALUES (1,'2014-11-25 16:50:22',53,0,0,NULL,NULL,'0'),(2,'2014-11-25 16:50:25',53,0,0,NULL,NULL,'1'),(3,'2014-11-25 16:50:27',53,0,0,NULL,NULL,'0'),(4,'2014-11-25 16:50:46',116,0,0,NULL,NULL,'1'),(5,'2014-11-25 16:50:46',118,0,0,NULL,NULL,'1'),(6,'2014-11-25 16:50:46',120,0,0,NULL,NULL,'1'),(7,'2014-11-25 16:50:46',119,0,0,NULL,NULL,'1'),(8,'2014-11-25 16:51:04',116,0,0,NULL,NULL,'2'),(9,'2014-11-25 16:51:04',118,0,0,NULL,NULL,'2'),(10,'2014-11-25 16:51:04',120,0,0,NULL,NULL,'2'),(11,'2014-11-25 16:51:04',119,0,0,NULL,NULL,'2'),(12,'2014-11-25 16:51:19',116,0,0,NULL,NULL,'3'),(13,'2014-11-25 16:51:19',118,0,0,NULL,NULL,'3'),(14,'2014-11-25 16:51:19',120,0,0,NULL,NULL,'3'),(15,'2014-11-25 16:51:19',119,0,0,NULL,NULL,'3'),(16,'2014-11-25 16:51:39',116,0,0,NULL,NULL,'4'),(17,'2014-11-25 16:51:39',118,0,0,NULL,NULL,'4'),(18,'2014-11-25 16:51:39',120,0,0,NULL,NULL,'4'),(19,'2014-11-25 16:51:39',119,0,0,NULL,NULL,'4'),(20,'2014-11-25 16:52:12',116,0,0,NULL,NULL,'5'),(21,'2014-11-25 16:52:12',118,0,0,NULL,NULL,'5'),(22,'2014-11-25 16:52:32',116,0,0,NULL,NULL,'6'),(23,'2014-11-25 16:52:32',118,0,0,NULL,NULL,'6'),(24,'2014-11-25 16:57:04',116,0,0,NULL,NULL,'7'),(25,'2014-11-25 16:57:04',118,0,0,NULL,NULL,'7');
/*!40000 ALTER TABLE `commands` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER commands_actions
	AFTER INSERT
	ON commands
	FOR EACH ROW
BEGIN
  SET @ref_table = 'commands';
  SET @priority = 0;
  SET @rec_type = 0;
  INSERT INTO actions VALUES
(0, @ref_table, NEW.id, @rec_type, @priority);
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
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cots_id` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `name_` varchar(50) DEFAULT NULL,
  `value_` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cots_data`
--

LOCK TABLES `cots_data` WRITE;
/*!40000 ALTER TABLE `cots_data` DISABLE KEYS */;
INSERT INTO `cots_data` VALUES (1,1,'2014-11-25 16:46:00','error','307 Temporary Redirect'),(2,1,'2014-11-25 16:46:01','humidity','25'),(3,1,'2014-11-25 16:46:01','has_fan','false'),(4,1,'2014-11-25 16:46:02','can_heat','true'),(5,1,'2014-11-25 16:46:02','can_cool','true'),(6,1,'2014-11-25 16:46:02','hvac_mode','heat'),(7,1,'2014-11-25 16:46:02','target_temperature_c','15.0'),(8,1,'2014-11-25 16:46:02','target_temperature_f','59'),(9,1,'2014-11-25 16:46:02','target_temperature_high_c','24.0'),(10,1,'2014-11-25 16:46:02','target_temperature_high_f','75'),(11,1,'2014-11-25 16:46:02','target_temperature_low_c','20.0'),(12,1,'2014-11-25 16:46:02','target_temperature_low_f','68'),(13,1,'2014-11-25 16:46:02','ambient_temperature_c','19.5'),(14,1,'2014-11-25 16:46:02','ambient_temperature_f','68'),(15,1,'2014-11-25 16:46:02','away_temperature_high_c','29.0'),(16,1,'2014-11-25 16:46:02','away_temperature_high_f','84'),(17,1,'2014-11-25 16:46:02','away_temperature_low_c','16.0'),(18,1,'2014-11-25 16:46:02','away_temperature_low_f','61'),(19,1,'2014-11-25 16:46:03','name_long','Office Thermostat (Table)'),(20,1,'2014-11-25 16:46:03','is_online','true'),(21,1,'2014-11-25 16:46:03','last_connection','2014-11-25T16:37:42.967Z'),(22,1,'2014-11-25 16:46:03','country_code','CA'),(23,1,'2014-11-25 16:46:03','away','home'),(24,1,'2014-11-25 16:49:07','last_connection','2014-11-25T16:49:07.212Z'),(25,1,'2014-11-25 16:49:07','last_connection','2014-11-25T16:49:07.213Z'),(26,1,'2014-11-25 16:51:15','is_online','false'),(27,1,'2014-11-25 16:53:07','is_online','true'),(28,1,'2014-11-25 16:53:07','last_connection','2014-11-25T16:53:07.647Z'),(29,1,'2014-11-25 16:53:08','ambient_temperature_c','20.0'),(30,1,'2014-11-25 16:53:09','last_connection','2014-11-25T16:53:09.698Z'),(31,1,'2014-11-25 16:53:10','last_connection','2014-11-25T16:53:09.699Z'),(32,1,'2014-11-25 16:55:23','last_connection','2014-11-25T16:55:23.023Z'),(33,1,'2014-11-25 16:55:23','ambient_temperature_c','19.5'),(34,1,'2014-11-25 17:03:42','last_connection','2014-11-25T17:03:42.283Z'),(35,1,'2014-11-25 17:03:42','ambient_temperature_c','20.0'),(36,1,'2014-11-25 17:04:11','last_connection','2014-11-25T17:04:11.616Z'),(37,1,'2014-11-25 17:04:12','ambient_temperature_c','19.5');
/*!40000 ALTER TABLE `cots_data` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_cots_data` AFTER INSERT ON `cots_data`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_cots_data IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'cots_data'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_cots_data` AFTER UPDATE ON `cots_data`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_cots_data IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'cots_data';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_cots_data` AFTER DELETE ON `cots_data`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_cots_data IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'cots_data';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deviceadvanced`
--

LOCK TABLES `deviceadvanced` WRITE;
/*!40000 ALTER TABLE `deviceadvanced` DISABLE KEYS */;
/*!40000 ALTER TABLE `deviceadvanced` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_deviceadvanced` AFTER INSERT ON `deviceadvanced`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_deviceadvanced IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'deviceadvanced'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_deviceadvanced` AFTER UPDATE ON `deviceadvanced`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_deviceadvanced IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'deviceadvanced';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_deviceadvanced` AFTER DELETE ON `deviceadvanced`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_deviceadvanced IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'deviceadvanced';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices`
--

LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `devices` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_devices` AFTER INSERT ON `devices`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_devices IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'devices'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_devices` AFTER UPDATE ON `devices`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_devices IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'devices';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_devices` AFTER DELETE ON `devices`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_devices IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'devices';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_devicesdyn` AFTER DELETE ON `devicesdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_devicesdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'devicesdyn';						SET @pk_d = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diagnostics`
--

LOCK TABLES `diagnostics` WRITE;
/*!40000 ALTER TABLE `diagnostics` DISABLE KEYS */;
/*!40000 ALTER TABLE `diagnostics` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_diagnostics` AFTER INSERT ON `diagnostics`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_diagnostics IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'diagnostics'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_diagnostics` AFTER UPDATE ON `diagnostics`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_diagnostics IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'diagnostics';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_diagnostics` AFTER DELETE ON `diagnostics`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_diagnostics IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'diagnostics';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_equipment` AFTER INSERT ON `equipment`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_equipment IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'equipment'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_equipment` AFTER UPDATE ON `equipment`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_equipment IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'equipment';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_equipment` AFTER DELETE ON `equipment`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_equipment IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'equipment';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_events` AFTER INSERT ON `events`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_events IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'events'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_events` AFTER UPDATE ON `events`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_events IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'events';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_events` AFTER DELETE ON `events`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_events IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'events';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_store`
--

LOCK TABLES `history_store` WRITE;
/*!40000 ALTER TABLE `history_store` DISABLE KEYS */;
INSERT INTO `history_store` VALUES ('2014-11-25 16:55:21','bypass','<id>1</id>','<id>1</id>',1),('2014-11-25 16:55:31','bypass','<id>2</id>','<id>2</id>',1),('2014-11-25 16:55:40','bypass','<id>3</id>','<id>3</id>',1),('2014-11-25 16:46:02','cots_data','<id>10</id>','<id>10</id>',1),('2014-11-25 16:46:02','cots_data','<id>11</id>','<id>11</id>',1),('2014-11-25 16:46:02','cots_data','<id>12</id>','<id>12</id>',1),('2014-11-25 16:46:02','cots_data','<id>13</id>','<id>13</id>',1),('2014-11-25 16:46:02','cots_data','<id>14</id>','<id>14</id>',1),('2014-11-25 16:46:02','cots_data','<id>15</id>','<id>15</id>',1),('2014-11-25 16:46:02','cots_data','<id>16</id>','<id>16</id>',1),('2014-11-25 16:46:02','cots_data','<id>17</id>','<id>17</id>',1),('2014-11-25 16:46:02','cots_data','<id>18</id>','<id>18</id>',1),('2014-11-25 16:46:03','cots_data','<id>19</id>','<id>19</id>',1),('2014-11-25 16:46:00','cots_data','<id>1</id>','<id>1</id>',1),('2014-11-25 16:46:03','cots_data','<id>20</id>','<id>20</id>',1),('2014-11-25 16:46:03','cots_data','<id>21</id>','<id>21</id>',1),('2014-11-25 16:46:03','cots_data','<id>22</id>','<id>22</id>',1),('2014-11-25 16:46:03','cots_data','<id>23</id>','<id>23</id>',1),('2014-11-25 16:49:07','cots_data','<id>24</id>','<id>24</id>',1),('2014-11-25 16:49:07','cots_data','<id>25</id>','<id>25</id>',1),('2014-11-25 16:51:15','cots_data','<id>26</id>','<id>26</id>',1),('2014-11-25 16:53:07','cots_data','<id>27</id>','<id>27</id>',1),('2014-11-25 16:53:07','cots_data','<id>28</id>','<id>28</id>',1),('2014-11-25 16:53:08','cots_data','<id>29</id>','<id>29</id>',1),('2014-11-25 16:46:01','cots_data','<id>2</id>','<id>2</id>',1),('2014-11-25 16:53:09','cots_data','<id>30</id>','<id>30</id>',1),('2014-11-25 16:53:10','cots_data','<id>31</id>','<id>31</id>',1),('2014-11-25 16:55:23','cots_data','<id>32</id>','<id>32</id>',1),('2014-11-25 16:55:23','cots_data','<id>33</id>','<id>33</id>',1),('2014-11-25 17:03:42','cots_data','<id>34</id>','<id>34</id>',1),('2014-11-25 17:03:42','cots_data','<id>35</id>','<id>35</id>',1),('2014-11-25 17:04:11','cots_data','<id>36</id>','<id>36</id>',1),('2014-11-25 17:04:12','cots_data','<id>37</id>','<id>37</id>',1),('2014-11-25 16:46:01','cots_data','<id>3</id>','<id>3</id>',1),('2014-11-25 16:46:02','cots_data','<id>4</id>','<id>4</id>',1),('2014-11-25 16:46:02','cots_data','<id>5</id>','<id>5</id>',1),('2014-11-25 16:46:02','cots_data','<id>6</id>','<id>6</id>',1),('2014-11-25 16:46:02','cots_data','<id>7</id>','<id>7</id>',1),('2014-11-25 16:46:02','cots_data','<id>8</id>','<id>8</id>',1),('2014-11-25 16:46:02','cots_data','<id>9</id>','<id>9</id>',1),('2014-11-25 16:52:43','hvac','<id>1191</id>','<id>1191</id>',2),('2014-11-25 16:52:48','hvac','<id>1192</id>','<id>1192</id>',2),('2014-11-25 16:52:51','hvac','<id>1193</id>','<id>1193</id>',2),('2014-11-25 16:52:54','hvac','<id>1194</id>','<id>1194</id>',2),('2014-11-25 16:50:27','hvac','<id>120</id>','<id>120</id>',2),('2014-11-25 16:55:40','hvac','<id>1210</id>','<id>1210</id>',2),('2014-11-25 16:50:46','smartdevices','<id>1</id>','<id>1</id>',1),('2014-11-25 16:51:04','smartdevices','<id>2</id>','<id>2</id>',1),('2014-11-25 16:51:19','smartdevices','<id>3</id>','<id>3</id>',1),('2014-11-25 16:51:39','smartdevices','<id>4</id>','<id>4</id>',1),('2014-11-25 16:52:12','smartdevices','<id>5</id>','<id>5</id>',1),('2014-11-25 16:52:32','smartdevices','<id>6</id>','<id>6</id>',1),('2014-11-25 16:57:04','smartdevices','<id>7</id>','<id>7</id>',1),('2014-11-25 16:44:20','smartstatus','<id>10</id>','<id>10</id>',2),('2014-11-25 16:44:21','smartstatus','<id>11</id>','<id>11</id>',2),('2014-11-25 16:44:20','smartstatus','<id>12</id>','<id>12</id>',2),('2014-11-25 16:39:13','smartstatus','<id>13</id>','<id>13</id>',2),('2014-11-25 16:39:14','smartstatus','<id>14</id>','<id>14</id>',2),('2014-11-25 16:39:14','smartstatus','<id>15</id>','<id>15</id>',2),('2014-11-25 16:39:14','smartstatus','<id>16</id>','<id>16</id>',2),('2014-11-25 16:39:14','smartstatus','<id>17</id>','<id>17</id>',2),('2014-11-25 16:39:14','smartstatus','<id>18</id>','<id>18</id>',2),('2014-11-25 16:44:21','smartstatus','<id>19</id>','<id>19</id>',2),('2014-11-25 16:44:20','smartstatus','<id>1</id>','<id>1</id>',2),('2014-11-25 16:44:20','smartstatus','<id>2</id>','<id>2</id>',2),('2014-11-25 16:44:20','smartstatus','<id>3</id>','<id>3</id>',2),('2014-11-25 16:44:20','smartstatus','<id>4</id>','<id>4</id>',2),('2014-11-25 16:44:20','smartstatus','<id>5</id>','<id>5</id>',2),('2014-11-25 16:44:20','smartstatus','<id>6</id>','<id>6</id>',2),('2014-11-25 16:44:20','smartstatus','<id>7</id>','<id>7</id>',2),('2014-11-25 16:37:53','smartstatus','<id>8</id>','<id>8</id>',2),('2014-11-25 16:44:20','smartstatus','<id>9</id>','<id>9</id>',2),('2014-11-25 16:39:25','ui_menu','<id>57</id>','<id>57</id>',1),('2014-11-25 16:39:25','ui_menu','<id>58</id>','<id>58</id>',1),('2014-11-25 16:39:25','ui_menu','<id>59</id>','<id>59</id>',1),('2014-11-25 16:53:35','zones','<id>3</id>','<id>3</id>',1),('2014-11-25 16:53:35','zonesdyn','<zone_id>3</zone_id>','<zone_id>3</zone_id>',1);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_store_old`
--

LOCK TABLES `history_store_old` WRITE;
/*!40000 ALTER TABLE `history_store_old` DISABLE KEYS */;
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
) ENGINE=MyISAM AUTO_INCREMENT=3221 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hvac`
--

LOCK TABLES `hvac` WRITE;
/*!40000 ALTER TABLE `hvac` DISABLE KEYS */;
INSERT INTO `hvac` VALUES (77,'furnace','Furnace',0,NULL,NULL,NULL,NULL,1,NULL),(79,'furnace.stages','Stages',77,'0',3,'0::Single Stage;;1::Dual Stage;;2::Modulating',NULL,1,NULL),(80,'furnace.dataport','Data Access Port',77,'NONE',1,'10',NULL,1,NULL),(81,'furnace.port_speed','Data Access Port Speed',77,'9600',1,'10',NULL,1,NULL),(82,'furnace.hc_trans','Heat/Cool Transformer Setup',77,'0',3,'0::Same;;1::Different',NULL,1,'bps'),(93,'furnace.model','Furnace Model',77,'',1,'25',NULL,1,NULL),(84,'furnace.bridge_rcrh','Bridge Rc Rh',77,'0',3,'0::No;;1::Yes',NULL,1,NULL),(85,'furnace.cent_hum','Central Humidifier Control',77,'0',3,'0::Disabled;;1::Enabled',NULL,1,NULL),(86,'furnace.max_on','Maximum ON Time',77,'3600',1,'5',NULL,1,'seconds'),(1193,'furnace.sup_t_probes','Supply Duct Temperature Probes Installed',77,'1',3,'0::No;;1::Yes',NULL,1,NULL),(1195,'furnace.t1_up','Supply Duct Temperature Threshold Upper Limit',77,'27.8',1,'5',NULL,1,'&deg;C'),(1196,'furnace.t1_low','Supply Duct Temperature Threshold Lower Limit',77,'15.6',1,'5',NULL,1,'&deg;C'),(1197,'furnace.t2_up','Return Duct Temperature Threshold Upper Limit',77,'26.1',1,'5',NULL,1,'&deg;C'),(1198,'furnace.t2_low','Return Duct Temperature Threshold Lower Limit',77,'16.1',1,'5',NULL,1,'&deg;C'),(1199,'furnace.sensor_poll','Smart Controller Onboard Sensors Polling Period',77,'60',1,'5',NULL,1,'seconds'),(1210,'furnace.mode','Operating Mode',77,'1',3,'0::Bypass;;1::RetroSAVE',NULL,1,NULL),(94,'fblower','Furnace Blower',0,NULL,NULL,NULL,NULL,1,NULL),(95,'fblower.min_on','Minimum ON Time',94,'120',1,'5',NULL,1,'seconds'),(96,'fblower.min_off','Minimum OFF Time',94,'60',1,'5',NULL,1,'seconds'),(97,'fblower.max_on','Maximum ON Time',94,'0',1,'5',NULL,1,'seconds'),(98,'fblower.heat_cycle','Heat Cycle Timer',94,'120',1,'5',NULL,1,'seconds'),(99,'fblower.cool_cycle','Cooling Cycle Timer',94,'360',1,'5',NULL,1,'seconds'),(100,'fblower.stat_pres','Static Pressure Threshold',94,'0',1,'5',NULL,1,'kpa'),(74,'system','System Settings',0,NULL,NULL,NULL,NULL,3,NULL),(75,'system.notifications_sms','Enable notifications by SMS',74,'1',1,NULL,NULL,3,NULL),(76,'system.notifications_email','Enable notifications by EMail',74,'1',1,NULL,NULL,3,NULL),(117,'thermostat','Customer Thermostat',0,NULL,NULL,NULL,NULL,1,NULL),(101,'acheat','A/C & Heat Pump',0,NULL,NULL,NULL,NULL,1,NULL),(102,'acheat.installed','Pump Installed',101,'0',3,'0::No;;1::Yes',NULL,1,NULL),(103,'acheat.stages','Stages',101,'0',3,'0::Single Stage;;1::Dual Stage',NULL,1,NULL),(104,'acheat.min_comp_on','Minimum Compressor ON Time',101,'0',1,'5',NULL,1,'seconds'),(105,'acheat.min_comp_off','Minimum Compressor OFF Time',101,'0',1,'5',NULL,1,'seconds'),(106,'acheat.max_comp_on','Maximum Compressor ON Time',101,'0',1,'5',NULL,1,'seconds'),(107,'acheat.out_temp_cut','Outside Temperature Cutoff',101,'-5.6',1,'5',NULL,1,'&deg;C'),(108,'acheat.ob_heat','O/B Heat Call',101,'0',3,'0::Floating (off);;1::Set to R (on)',NULL,1,NULL),(109,'hrverv','HRV/ERV Control',0,NULL,NULL,NULL,NULL,1,NULL),(110,'hrverv.installed','Installed',109,'0',3,'0::No;;1::Yes',NULL,1,NULL),(111,'hrverv.relay_id','Relay ID',109,'6',3,'1::Relay #1;;2::Relay #2;;3::Relay #3;;4::Relay #4;;5::Relay #5;;6::Relay #6',NULL,1,NULL),(112,'hrverv.sync','Synchronized With Furnace Blower',109,'0',3,'0::No;;1::Yes',NULL,1,NULL),(113,'hrverv.min_on','Minimum ON Time',109,'120',1,'5',NULL,1,'seconds'),(114,'hrverv.min_off','Minimum OFF Time',109,'60',1,'5',NULL,1,'seconds'),(115,'hrverv.max_on','Maximum ON Time',109,'0',1,'5',NULL,1,'seconds'),(116,'comfort','Comfort Level',0,NULL,NULL,NULL,NULL,1,NULL),(118,'thermostat.connected','COTS Connected',117,'1',3,'0::No;;1::Yes',NULL,1,NULL),(120,'system.regmode','New Remote Devices Registration Mode',74,'0',3,'0::Disabled;;1::AdHoc;;2::Manual',NULL,3,NULL),(119,'thermostat.type','Thermostat Type',117,'1',3,'0::Analog;;1::Smart',NULL,1,NULL),(1179,'thermostat.maker','Thermostat Maker',117,'Honeywell',1,'20','thermostat.type::0',1,NULL),(1180,'thermostat.model','Thermostat Model',117,'Prestige HD',1,'20','thermostat.type::0',1,NULL),(1,'system.serial','Smart Controller Serial Number',74,'ASESMART-00002',1,'20',NULL,3,NULL),(2,'system.house_id','Unique House ID',74,'00002',1,'5',NULL,3,NULL),(3171,'comfort.min_hum','Humidity Minimum Acceptable Level',116,'30',1,'5',NULL,1,'%'),(3172,'comfort.max_hum','Humidity Maximum Acceptable Level',116,'60',1,'5',NULL,1,'%'),(3173,'comfort.t_occ_win','Default Winter Occupied Temperature',116,'21',1,'5',NULL,1,'&deg;C'),(3174,'comfort.t_occ_sum','Default Summer Occupied Temperature',116,'24',1,'5',NULL,1,'&deg;C'),(3175,'comfort.slider_def','Default Slider Settings',116,'2',3,'0::Max Comfort;;2::Balanced;;4::Max Saving',NULL,1,NULL),(3166,'comfort.co2_up','CO2 Upper Limit',116,'1000',1,'5',NULL,1,'ppm'),(3167,'comfort.co_up','CO Upper Limit',116,'5',1,'5',NULL,1,'ppm'),(3188,'comfort.circ_on','Circulation Cycle ON Time',116,'300',1,'5',NULL,1,'seconds'),(3189,'comfort.circ_off','Circulation Cycle OFF Time',116,'25',1,'5',NULL,1,'minutes'),(4,'system.sw_version','System Software Version',74,'14.8.25p',1,'10',NULL,3,NULL),(1188,'system.max_days','Keep Statistics Data in DB for days',74,'14',1,'5',NULL,3,NULL),(1189,'system.max_storage','Maximum Storage Count Reach Actions',74,'0',3,'0::Delete oldest records;;1::Stop collecting stats',NULL,3,NULL),(3,'system.description','System Short Description',74,'Dmitry test PC',1,'50',NULL,3,NULL),(1191,'furnace.ret_t_probes','Return Duct Temperature Probes Installed',77,'1',3,'0::No;;1::Yes',NULL,1,NULL),(2223,'retrosave','RetroSAVE Operational Parameters',0,NULL,NULL,NULL,NULL,3,NULL),(2224,'retrosave.away_mode','Away mode',2223,'0',4,'0::Disabled;;1::Enabled',NULL,3,NULL),(2225,'retrosave.away_period','Set Away mode after period',2223,'24',1,'5',NULL,3,'hours'),(1178,'thermostat.mode','Thermostat Mode',117,'1',3,'0::Cold only;;1::Auto mode;;2::Heat only','thermostat.type::0',1,NULL),(2227,'retrosave.comfort_t','Comfort temperature adjustment',2223,'1',1,'3',NULL,3,NULL),(2228,'retrosave.comfort_h','Comfort humidity adjustment',2223,'0',1,'3',NULL,3,NULL),(1200,'furnace.house_vents','Total number of house vents',77,'0',1,'3',NULL,1,' '),(1201,'furnace.rise_low_thr','Temperature rise low threshold',77,'35',1,'3',NULL,1,'&deg;C'),(1202,'furnace.rise_high_thr','Temperature rise high threshold',77,'75',1,'3',NULL,1,'&deg;C'),(2232,'acheat.dec_low_thr','Temperature decline low threshold',101,'17',1,'3',NULL,1,'&deg;C'),(2233,'acheat.dec_high_thr','Temperature decline high threshold',101,'20',1,'3',NULL,1,'&deg;C'),(78,'furnace.installed','Furnace Installed',77,'1',3,'0::No;;1::Yes',NULL,1,NULL),(3151,'comfort.co_present','CO Sensor Present',116,'1',3,'0::No;;1::Yes',NULL,1,NULL),(3150,'comfort.co2_present','CO2 Sensor Present',116,'1',3,'0::No;;1::Yes',NULL,1,NULL),(1203,'furnace.btus','BTUs',77,'0',1,'3',NULL,1,NULL),(3210,'fblower.cfm','CFM',94,'0',1,'3',NULL,1,NULL),(3211,'acheat.ton','Ton',101,'1',3,'1::1;;2::2;;3::3;;4::4;;5::5',NULL,1,NULL),(3212,'system.testrefresh','Sensors test page refresh interval',74,'0',1,'3',NULL,1,NULL),(3213,'thermostat.smart_model','Smart COTS Maker and Model',117,'1',3,'0::Other;;1::nest','thermostat.type::1',1,NULL),(3214,'thermostat.cots_nest','Nest COTS Status',117,NULL,6,'%%NEST','thermostat.smart_model::1',1,NULL),(3215,'thermostat.nest_clientid','nest Client ID',117,'a4bf6775-dcce-401f-b33b-03ac2c9c3aa0',1,'40','thermostat.smart_model::1',1,NULL),(3216,'thermostat.nest_secret','nest Client secret',117,'Xj7AVAd7vNMdfokVlhwjPg8HF',1,'40','thermostat.smart_model::1',1,NULL),(3217,'thermostat.nest_pincode','nest Pincode',117,'',1,'10','thermostat.smart_model::1',1,NULL),(3218,'thermostat.nest_token','nest Security token (readonly)',117,'c.y3eCY2DujKtdJRn5kj49fva7HxmrW31DPl2E5g9Yt25v6ENfGXjCEsAD3im0IjRC6vxGsJ5wdzg7Ce6OoJr9htOtPKXk0NAT6DppwNyJKECUn8U46pw9uOcPDE0ZvA3RnHYqFS483EPSpfPy',2,'40','thermostat.smart_model::1',1,NULL),(1194,'furnace.sup_t_probe_use','Temperature probe to use',77,'5',6,'%%PTLIST','furnace.sup_t_probes::1',1,NULL),(1192,'furnace.ret_t_probe_use','Temperature probe to use',77,'2',6,'%%PTLIST','furnace.ret_t_probes::1',1,NULL);
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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `action_notify_HVAC`
	AFTER INSERT
	ON hvac_actions
	FOR EACH ROW
BEGIN
  DECLARE notResult VARCHAR(50);
  IF (1 = 1) THEN
    SELECT socketOpen("/tmp/hvac-action", "action\n") INTO 'notResult';
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `irdata`
--

LOCK TABLES `irdata` WRITE;
/*!40000 ALTER TABLE `irdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `irdata` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_irdata` AFTER INSERT ON `irdata`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_irdata IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'irdata'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_irdata` AFTER UPDATE ON `irdata`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_irdata IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'irdata';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_irdata` AFTER DELETE ON `irdata`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_irdata IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'irdata';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `networks`
--

LOCK TABLES `networks` WRITE;
/*!40000 ALTER TABLE `networks` DISABLE KEYS */;
INSERT INTO `networks` VALUES (1,'8.8.8.8','8.8.4.4','cloud.ase-energy.ca','smartcloud.local','RetroSAVE',10,'retrosave',0,1,'192.168.2.113','192.168.2.1','255.255.255.0','192.168.1.1','','','129.6.15.30','96.226.242.9',0,'','openweathermap.org','',0);
/*!40000 ALTER TABLE `networks` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_networks` AFTER INSERT ON `networks`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_networks IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'networks'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_networks` AFTER UPDATE ON `networks`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_networks IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'networks';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_networks` AFTER DELETE ON `networks`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_networks IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'networks';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_notifications` AFTER INSERT ON `notifications`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_notifications IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'notifications'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_notifications` AFTER UPDATE ON `notifications`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_notifications IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'notifications';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_notifications` AFTER DELETE ON `notifications`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_notifications IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'notifications';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_occupancy` AFTER INSERT ON `occupancy`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_occupancy IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'occupancy'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_occupancy` AFTER UPDATE ON `occupancy`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_occupancy IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'occupancy';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_occupancy` AFTER DELETE ON `occupancy`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_occupancy IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'occupancy';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
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
/*!40000 ALTER TABLE `paramflapdyn` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_paramflapdyn` AFTER INSERT ON `paramflapdyn`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_paramflapdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramflapdyn'; 						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_paramflapdyn` AFTER UPDATE ON `paramflapdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_paramflapdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramflapdyn';						SET @pk_d_old = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_paramflapdyn` AFTER DELETE ON `paramflapdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_paramflapdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramflapdyn';						SET @pk_d = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_paramgassensordyn` AFTER INSERT ON `paramgassensordyn`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_paramgassensordyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramgassensordyn'; 						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_paramgassensordyn` AFTER UPDATE ON `paramgassensordyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_paramgassensordyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramgassensordyn';						SET @pk_d_old = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_paramgassensordyn` AFTER DELETE ON `paramgassensordyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_paramgassensordyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramgassensordyn';						SET @pk_d = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
/*!40000 ALTER TABLE `paramsensordyn` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_paramsensordyn` AFTER INSERT ON `paramsensordyn`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_paramsensordyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramsensordyn'; 						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_paramsensordyn` AFTER UPDATE ON `paramsensordyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_paramsensordyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramsensordyn';						SET @pk_d_old = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_paramsensordyn` AFTER DELETE ON `paramsensordyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_paramsensordyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramsensordyn';						SET @pk_d = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registrations`
--

LOCK TABLES `registrations` WRITE;
/*!40000 ALTER TABLE `registrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `registrations` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_registrations` AFTER INSERT ON `registrations`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_registrations IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'registrations'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
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

  IF (NEW.status = 2) THEN
    INSERT INTO commands VALUES (NULL, NOW(), 80, 0, 0, NEW.device_id, NULL, NULL);
  ELSEIF (NEW.status = 3) THEN
    INSERT INTO commands VALUES (NULL, NOW(), 80, 0, 0, NEW.device_id, NULL, NULL);
  ELSEIF (NEW.status = 4) THEN
    INSERT INTO commands VALUES (NULL, NOW(), 54, 0, 0, OLD.device_id, NULL, NULL);
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_registrations` AFTER DELETE ON `registrations`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_registrations IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'registrations';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relays`
--

LOCK TABLES `relays` WRITE;
/*!40000 ALTER TABLE `relays` DISABLE KEYS */;
/*!40000 ALTER TABLE `relays` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `relays_commands` BEFORE INSERT ON `relays`
	FOR EACH ROW
BEGIN
  
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_relays` AFTER INSERT ON `relays`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_relays IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'relays'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_relays` AFTER UPDATE ON `relays`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_relays IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'relays';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_relays` AFTER DELETE ON `relays`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_relays IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'relays';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remotecontrol`
--

LOCK TABLES `remotecontrol` WRITE;
/*!40000 ALTER TABLE `remotecontrol` DISABLE KEYS */;
/*!40000 ALTER TABLE `remotecontrol` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_remotecontrol` AFTER INSERT ON `remotecontrol`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_remotecontrol IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'remotecontrol'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_remotecontrol` AFTER UPDATE ON `remotecontrol`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_remotecontrol IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'remotecontrol';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_remotecontrol` AFTER DELETE ON `remotecontrol`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_remotecontrol IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'remotecontrol';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensorsdyn`
--

LOCK TABLES `sensorsdyn` WRITE;
/*!40000 ALTER TABLE `sensorsdyn` DISABLE KEYS */;
/*!40000 ALTER TABLE `sensorsdyn` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_sensorsdyn` AFTER INSERT ON `sensorsdyn`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_sensorsdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'sensorsdyn'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_sensorsdyn` AFTER UPDATE ON `sensorsdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_sensorsdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'sensorsdyn';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_sensorsdyn` AFTER DELETE ON `sensorsdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_sensorsdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'sensorsdyn';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (1,2,'cd0c5aea76e95c975be2e7320b59c132','2014-11-25 16:46:25','2014-11-28 22:46:25',1,0);
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
INSERT INTO `smartdevices` VALUES (1,'2014-11-25 16:50:46',1,0,0,40,0,0,'1',0,0,0,0,'','','ADC1 CO'),(2,'2014-11-25 16:51:04',2,0,0,40,0,0,'2',0,0,0,0,'','','ADC2'),(3,'2014-11-25 16:51:19',2,0,0,40,0,0,'3',0,0,0,0,'','','ADC3'),(4,'2014-11-25 16:51:39',2,0,0,40,0,0,'4',0,0,0,0,'','','ADC4'),(5,'2014-11-25 16:52:12',2,1,0,40,0,0,'64',0,0,0,0,'','','HTU21 T'),(6,'2014-11-25 16:52:32',3,1,0,40,0,0,'64',0,0,0,0,'','','HTU21 H'),(7,'2014-11-25 16:57:04',4,2,0,40,0,0,'1122334455667788',0,0,0,0,'','','1-wire T sensor');
/*!40000 ALTER TABLE `smartdevices` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
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

  IF (NEW.interface BETWEEN 0 AND 2) THEN
    IF (NEW.status = 0) THEN
      INSERT INTO commands (id, updated, command, parameters) VALUES (NULL, NOW(), 116, NEW.id);
    ELSEIF (NEW.status = 1) THEN
      INSERT INTO commands (id, updated, command, parameters) VALUES (NULL, NOW(), 115, NEW.id);
    END IF;

    IF (NEW.period IS NOT NULL) THEN
      INSERT INTO commands (id, updated, command, parameters) VALUES (NULL, NOW(), 118, NEW.id);
    END IF;

    IF ((NEW.interface = 0) AND (NEW.lowthres IS NOT NULL)) THEN
      INSERT INTO commands (id, updated, command, parameters) VALUES (NULL, NOW(), 120, NEW.id);
    END IF;

    IF ((NEW.interface = 0) AND (NEW.highthres IS NOT NULL)) THEN
      INSERT INTO commands (id, updated, command, parameters) VALUES (NULL, NOW(), 119, NEW.id);
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
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

  IF (NEW.status != OLD.status) THEN
    IF (NEW.status = 0) THEN
      INSERT INTO commands (id, updated, command, parameters) VALUES (NULL, NOW(), 116, NEW.id);
    ELSEIF (NEW.status = 1) THEN
      INSERT INTO commands (id, updated, command, parameters) VALUES (NULL, NOW(), 115, NEW.id);
    END IF;
  END IF;

  IF (NEW.period != OLD.period) THEN
    INSERT INTO commands (id, updated, command, parameters) VALUES (NULL, NOW(), 118, NEW.id);
  END IF;

  IF (NEW.lowthres != OLD.lowthres) THEN
    INSERT INTO commands (id, updated, command, parameters) VALUES (NULL, NOW(), 120, NEW.id);
  END IF;

  IF (NEW.lowthres != OLD.highthres) THEN
    INSERT INTO commands (id, updated, command, parameters) VALUES (NULL, NOW(), 119, NEW.id);
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smartplugsdyn`
--

LOCK TABLES `smartplugsdyn` WRITE;
/*!40000 ALTER TABLE `smartplugsdyn` DISABLE KEYS */;
/*!40000 ALTER TABLE `smartplugsdyn` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_smartplugsdyn` AFTER INSERT ON `smartplugsdyn`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_smartplugsdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartplugsdyn'; 						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_smartplugsdyn` AFTER UPDATE ON `smartplugsdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartplugsdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartplugsdyn';						SET @pk_d_old = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_smartplugsdyn` AFTER DELETE ON `smartplugsdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartplugsdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartplugsdyn';						SET @pk_d = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smartsensors`
--

LOCK TABLES `smartsensors` WRITE;
/*!40000 ALTER TABLE `smartsensors` DISABLE KEYS */;
/*!40000 ALTER TABLE `smartsensors` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_smartsensors` AFTER INSERT ON `smartsensors`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_smartsensors IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartsensors'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_smartsensors` AFTER UPDATE ON `smartsensors`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartsensors IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartsensors';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_smartsensors` AFTER DELETE ON `smartsensors`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartsensors IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartsensors';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smartsensorsraw`
--

LOCK TABLES `smartsensorsraw` WRITE;
/*!40000 ALTER TABLE `smartsensorsraw` DISABLE KEYS */;
/*!40000 ALTER TABLE `smartsensorsraw` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_smartsensorsraw` AFTER INSERT ON `smartsensorsraw`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_smartsensorsraw IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartsensorsraw'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_smartsensorsraw` AFTER UPDATE ON `smartsensorsraw`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartsensorsraw IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartsensorsraw';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_smartsensorsraw` AFTER DELETE ON `smartsensorsraw`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartsensorsraw IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartsensorsraw';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smartstatus`
--

LOCK TABLES `smartstatus` WRITE;
/*!40000 ALTER TABLE `smartstatus` DISABLE KEYS */;
INSERT INTO `smartstatus` VALUES (1,'2014-11-25 16:44:20','health','cpu','6.75, 5.86, 4.22'),(2,'2014-11-25 16:44:20','health','ram','344Mb used, 92Mb free'),(3,'2014-11-25 16:44:20','health','disk','4344Mb used, 1179Mb free'),(4,'2014-11-25 16:44:20','health','uptime','2 days, 22:09'),(5,'2014-11-25 16:44:20','network','ip_main','192.168.0.248'),(6,'2014-11-25 16:44:20','network','gateway','192.168.0.1'),(7,'2014-11-25 16:44:20','network','ip_wan',''),(8,'2014-11-25 16:38:06','network','cloud',''),(9,'2014-11-25 16:44:20','network','ip_cwan','192.168.0.25'),(10,'2014-11-25 16:44:20','network','gw_cwan','192.168.0.1'),(11,'2014-11-25 16:44:21','network','list_wan',''),(12,'2014-11-25 16:44:20','network','dns','192.168.0.1'),(13,'2014-11-25 16:39:13','weather','location','Ottawa'),(14,'2014-11-25 16:39:14','weather','temp','4.87'),(15,'2014-11-25 16:39:14','weather','humid','60'),(16,'2014-11-25 16:39:14','weather','wind','7.7 230'),(17,'2014-11-25 16:39:14','weather','air_pres','1008'),(18,'2014-11-25 16:39:14','weather','cond','Clouds, overcast clouds'),(19,'2014-11-25 16:44:21','network','mac','B827EB4EB268');
/*!40000 ALTER TABLE `smartstatus` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_smartstatus` AFTER INSERT ON `smartstatus`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_smartstatus IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartstatus'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_smartstatus` AFTER UPDATE ON `smartstatus`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartstatus IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartstatus';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_smartstatus` AFTER DELETE ON `smartstatus`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartstatus IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartstatus';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_statistics` AFTER INSERT ON `statistics`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_statistics IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'statistics'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_statistics` AFTER UPDATE ON `statistics`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_statistics IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'statistics';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_statistics` AFTER DELETE ON `statistics`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_statistics IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'statistics';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temperaturebreakout`
--

LOCK TABLES `temperaturebreakout` WRITE;
/*!40000 ALTER TABLE `temperaturebreakout` DISABLE KEYS */;
/*!40000 ALTER TABLE `temperaturebreakout` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_temperaturebreakout` AFTER INSERT ON `temperaturebreakout`
FOR EACH ROW BEGIN 
	IF (@DISABLE_TRIGGER_temperaturebreakout IS NULL) THEN
	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 
	SET @tbl_name = 'temperaturebreakout'; 
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temperatureprofile`
--

LOCK TABLES `temperatureprofile` WRITE;
/*!40000 ALTER TABLE `temperatureprofile` DISABLE KEYS */;
INSERT INTO `temperatureprofile` VALUES (1,'Default',20,60);
/*!40000 ALTER TABLE `temperatureprofile` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_temperatureprofile` AFTER INSERT ON `temperatureprofile`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_temperatureprofile IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'temperatureprofile'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_temperatureprofile` AFTER UPDATE ON `temperatureprofile`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_temperatureprofile IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'temperatureprofile';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_temperatureprofile` AFTER DELETE ON `temperatureprofile`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_temperatureprofile IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'temperatureprofile';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thermostat`
--

LOCK TABLES `thermostat` WRITE;
/*!40000 ALTER TABLE `thermostat` DISABLE KEYS */;
/*!40000 ALTER TABLE `thermostat` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_thermostat` AFTER INSERT ON `thermostat`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_thermostat IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'thermostat'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_thermostat` AFTER UPDATE ON `thermostat`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_thermostat IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'thermostat';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_thermostat` AFTER DELETE ON `thermostat`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_thermostat IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'thermostat';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ui_menu`
--

LOCK TABLES `ui_menu` WRITE;
/*!40000 ALTER TABLE `ui_menu` DISABLE KEYS */;
INSERT INTO `ui_menu` VALUES (1,'status','relays','Status',0,0),(2,'status','relays','Local Relays',0,1),(3,'status','onboard','Local Sensors',0,1),(4,'status','indoor','Indoor Sensors',0,1),(5,'status','outdoor','Outdoor Sensors',0,1),(6,'status','system','System Information',0,1),(7,'networks','ip','Networks',0,0),(8,'networks','ip','IP Network',0,1),(9,'networks','zigbee','Local Zigbee',0,1),(10,'networks','asemp','ASEMP Profile',0,1),(11,'hvac','furnace','HVAC',0,0),(12,'hvac','furnace','Furnace',0,1),(13,'hvac','fblower','Furnace Blower',0,1),(14,'hvac','acheat','A/C & Heat Pump',0,1),(15,'hvac','hrverv','HRV/ERV Control',0,1),(16,'hvac','comfort','Comfort Settings',0,1),(17,'hvac','thermostat','Customer Thermostat Control',0,1),(18,'smartgrid','peaksaver','Smart Grid',0,0),(20,'zonedev','zones','RetroSAVE<br>Management',0,0),(21,'events','events','Events<br>& Alarms',0,0),(22,'userinfo','details','Customer<br>Settings',0,0),(23,'userinfo','details','User Details',0,1),(24,'userinfo','alarms','Alarms & Events',0,1),(25,'userinfo','password','Password',0,1),(26,'system','update','System<br>Maintenance',0,0),(28,'system','update','Software Update',0,1),(29,'system','db','Database Maintenance',0,1),(32,'zonedev','zones','Zones',0,1),(33,'zonedev','devices','Remote Devices',0,1),(34,'zonedev','newdev','Add New Devices',0,1),(39,'events','events','Alarms & Events Viewer',0,1),(40,'events','alarms','RetroSAVE Alarms Management',0,1),(41,'status','networks','Network Connections',0,1),(43,'events','management','Networks Alarms Management',0,1),(44,'smartgrid','peaksaver','PeakSaver',0,1),(45,'smartgrid','smartmeter','SmartMeter',0,1),(46,'reports','occupancy','Reports',0,0),(47,'logout','logout','Logout',0,0),(48,'reports','occupancy','Statistical Occupancy Stats',0,1),(49,'reports','retrosave','RetroSAVE Runtime',0,1),(50,'reports','charts','Charts',0,1),(51,'reports','savings','Savings',0,1),(52,'reports','runtime','HVAC Runtime',0,1),(54,'status','zigbee','Zigbee',0,1),(55,'reports','cots','COTS Thermostat Stats',0,1),(56,'zonedev','smartdevices','Local Sensors',0,1),(57,'system','datetime','Date & Time',0,1),(58,'zonedev','sensorstest','Sensors Test',0,1),(59,'system','advanced','Advanced',0,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'aseuser','aseuser','','','','','','','','','1800-ASE-SAVE','','','support@ase-energy.ca',0,2,0,0),(2,'aseadmin','aseadmin','','','','','Ottawa','','Canada','','1800-ASE-SAVE','','','support@ase-energy.ca',0,2,1,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_users` AFTER INSERT ON `users`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_users IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'users'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_users` AFTER UPDATE ON `users`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_users IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'users';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_users` AFTER DELETE ON `users`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_users IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'users';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zigbee`
--

LOCK TABLES `zigbee` WRITE;
/*!40000 ALTER TABLE `zigbee` DISABLE KEYS */;
INSERT INTO `zigbee` VALUES (1,13,0,1,'0000000000000000','0000',0,'','','','',0);
/*!40000 ALTER TABLE `zigbee` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_zigbee` AFTER INSERT ON `zigbee`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_zigbee IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_zigbee` AFTER UPDATE ON `zigbee`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zigbee IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_zigbee` AFTER DELETE ON `zigbee`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zigbee IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zigbee_ase`
--

LOCK TABLES `zigbee_ase` WRITE;
/*!40000 ALTER TABLE `zigbee_ase` DISABLE KEYS */;
/*!40000 ALTER TABLE `zigbee_ase` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_zigbee_ase` AFTER INSERT ON `zigbee_ase`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_zigbee_ase IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee_ase'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zigbee_commands`
--

LOCK TABLES `zigbee_commands` WRITE;
/*!40000 ALTER TABLE `zigbee_commands` DISABLE KEYS */;
/*!40000 ALTER TABLE `zigbee_commands` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zigbee_ha`
--

LOCK TABLES `zigbee_ha` WRITE;
/*!40000 ALTER TABLE `zigbee_ha` DISABLE KEYS */;
/*!40000 ALTER TABLE `zigbee_ha` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_zigbee_ha` AFTER INSERT ON `zigbee_ha`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_zigbee_ha IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee_ha'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_zoneadvanced` AFTER INSERT ON `zoneadvanced`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_zoneadvanced IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zoneadvanced'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_zoneadvanced` AFTER UPDATE ON `zoneadvanced`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zoneadvanced IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zoneadvanced';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_zoneadvanced` AFTER DELETE ON `zoneadvanced`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zoneadvanced IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zoneadvanced';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zones`
--

LOCK TABLES `zones` WRITE;
/*!40000 ALTER TABLE `zones` DISABLE KEYS */;
INSERT INTO `zones` VALUES (1,0,'Temporary zone',0,0,0,0),(2,0,'Master zone',0,0,0,0),(3,1,'Office',1,0,0,0);
/*!40000 ALTER TABLE `zones` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_zones` AFTER INSERT ON `zones`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_zones IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zones'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_zones` AFTER UPDATE ON `zones`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zones IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zones';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_zones` AFTER DELETE ON `zones`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zones IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zones';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
INSERT INTO `zonesdyn` VALUES (3,0,0,0,0,0);
/*!40000 ALTER TABLE `zonesdyn` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_zonesdyn` AFTER INSERT ON `zonesdyn`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_zonesdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zonesdyn'; 						SET @pk_d = CONCAT('<zone_id>',NEW.`zone_id`,'</zone_id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_zonesdyn` AFTER UPDATE ON `zonesdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zonesdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zonesdyn';						SET @pk_d_old = CONCAT('<zone_id>',OLD.`zone_id`,'</zone_id>');						SET @pk_d = CONCAT('<zone_id>',NEW.`zone_id`,'</zone_id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_zonesdyn` AFTER DELETE ON `zonesdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zonesdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zonesdyn';						SET @pk_d = CONCAT('<zone_id>',OLD.`zone_id`,'</zone_id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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

-- Dump completed on 2014-11-25 17:06:28
