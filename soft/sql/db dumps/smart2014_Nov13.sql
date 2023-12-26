-- MySQL dump 10.13  Distrib 5.5.25, for Win64 (x86)
--
-- Host: localhost    Database: smart2014
-- ------------------------------------------------------
-- Server version	5.5.25-log

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
) ENGINE=MEMORY AUTO_INCREMENT=133 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
INSERT INTO `actions` VALUES (115,'commands',185,0,0),(116,'commands',186,0,0),(117,'commands',187,0,0),(118,'commands',188,0,0),(119,'commands',189,0,0),(120,'commands',190,0,0),(121,'commands',191,0,0),(122,'commands',192,0,0),(123,'commands',193,0,0),(124,'commands',194,0,0),(125,'commands',195,0,0),(126,'commands',196,0,0),(127,'commands',197,0,0),(128,'commands',198,0,0),(129,'commands',199,0,0),(130,'commands',200,0,0),(131,'commands',201,0,0),(132,'commands',202,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarms_system`
--

LOCK TABLES `alarms_system` WRITE;
/*!40000 ALTER TABLE `alarms_system` DISABLE KEYS */;
INSERT INTO `alarms_system` VALUES (1,'2014-05-17 00:43:59',0,0,'Completed'),(2,'2014-05-18 00:44:14',0,0,'Update completed'),(3,'2014-06-13 00:44:45',2,2,''),(4,'2014-06-13 00:53:27',2,2,'0x00 error'),(5,'2014-09-18 01:28:04',10,1,'0x73 error');
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alarms_zigbee`
--

LOCK TABLES `alarms_zigbee` WRITE;
/*!40000 ALTER TABLE `alarms_zigbee` DISABLE KEYS */;
INSERT INTO `alarms_zigbee` VALUES (1,1,1,'2014-05-18 00:45:02',1111,'1111',1111,11,11,1,1,'signal loss'),(2,2,2,'2014-05-18 00:45:33',2222,'2222',2222,22,1,4,2,'interferecence'),(3,3,3,'2014-05-18 00:46:16',3333,'3333',3333,3,3,5,1,'all ok'),(4,1,1,'2014-05-19 23:25:50',1111,'111',111,11,11,1,0,'signal loss'),(5,2,2,'2014-05-19 23:26:15',1111,'111',111,11,11,1,0,'signal loss'),(6,NULL,0,'2014-06-16 13:54:51',NULL,'1122334455667788',NULL,NULL,NULL,6,2,'0x30 error'),(7,NULL,0,'2014-06-16 17:50:16',NULL,'',12345,NULL,NULL,7,1,'0x30 OK'),(8,NULL,0,'2014-06-16 18:18:19',NULL,NULL,NULL,NULL,NULL,8,2,'0x31 error'),(9,NULL,0,'2014-06-16 18:45:49',1234,'1122334455667788',5678,NULL,13,9,2,'0x31 OK'),(10,NULL,0,'2014-06-16 19:05:28',1234,NULL,NULL,NULL,NULL,11,2,'0x32 OK'),(11,NULL,0,'2014-06-16 19:05:54',NULL,NULL,NULL,NULL,NULL,10,2,'0x32 error'),(12,NULL,0,'2014-06-16 19:13:31',NULL,NULL,NULL,NULL,13,11,1,'0x33 OK'),(13,NULL,0,'2014-06-16 19:20:49',NULL,NULL,NULL,NULL,NULL,11,1,'0x34 OK'),(14,NULL,0,'2014-06-16 19:41:17',NULL,NULL,NULL,NULL,NULL,13,1,'0x35 OK'),(15,NULL,NULL,'2014-06-17 00:40:21',1234,'2233445566778899',5678,11,13,15,0,'0x37 OK'),(16,NULL,20,'2014-06-17 00:56:35',NULL,'1122334455667788',NULL,NULL,NULL,16,1,'0x38 error'),(17,NULL,20,'2014-06-17 00:58:45',NULL,'1122334455667788',NULL,NULL,NULL,16,0,'0x38 OK'),(18,NULL,NULL,'2014-06-17 17:22:00',NULL,'1122334455667788',1234,13,NULL,17,1,'0x37 OK : 2'),(19,NULL,NULL,'2014-06-17 17:22:18',NULL,'1122334455667788',1234,13,NULL,17,1,'0x37 OK : 2'),(20,NULL,0,'2014-06-18 13:12:58',NULL,NULL,NULL,NULL,NULL,18,1,'0x41 error'),(21,NULL,25,'2014-06-18 13:14:10',NULL,NULL,NULL,NULL,NULL,18,1,'0x41 error'),(22,NULL,25,'2014-06-18 13:15:14',NULL,NULL,NULL,NULL,NULL,18,0,'0x41 OK'),(23,NULL,25,'2014-06-18 13:26:42',NULL,NULL,NULL,NULL,NULL,18,0,'0x42 OK : 125'),(24,NULL,25,'2014-06-18 13:28:46',NULL,NULL,NULL,NULL,NULL,18,0,'0x41 OK : 1'),(25,NULL,25,'2014-06-18 21:06:40',NULL,NULL,NULL,NULL,NULL,19,2,'0x50 error'),(26,NULL,25,'2014-06-18 21:10:04',NULL,NULL,NULL,NULL,NULL,19,1,'0x50 OK : accepted'),(27,NULL,26,'2014-06-18 21:19:06',NULL,NULL,NULL,NULL,NULL,19,1,'0x50 OK : rejected'),(28,NULL,25,'2014-06-19 12:16:47',NULL,NULL,NULL,NULL,NULL,19,0,'0x51 OK'),(29,NULL,17,'2014-06-19 15:47:32',NULL,NULL,NULL,NULL,NULL,19,1,'0x52 error'),(30,NULL,17,'2014-06-19 15:48:19',NULL,NULL,NULL,NULL,NULL,19,0,'0x52 OK'),(31,NULL,17,'2014-06-19 16:36:08',NULL,NULL,NULL,NULL,NULL,19,0,'0x52 OK : 1'),(32,NULL,37,'2014-06-19 16:43:50',NULL,NULL,NULL,NULL,NULL,19,1,'0x53 error'),(33,NULL,37,'2014-06-19 16:45:12',NULL,NULL,NULL,NULL,NULL,19,0,'0x53 OK : -1'),(34,NULL,37,'2014-06-19 16:56:22',NULL,NULL,NULL,NULL,NULL,19,0,'0x55 OK : 0'),(35,NULL,27,'2014-06-20 00:42:28',NULL,NULL,NULL,NULL,NULL,19,0,'0x52 OK : 27'),(36,NULL,25,'2014-06-20 00:46:11',NULL,NULL,NULL,NULL,NULL,19,0,'0x56 OK : 0');
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bypass`
--

LOCK TABLES `bypass` WRITE;
/*!40000 ALTER TABLE `bypass` DISABLE KEYS */;
INSERT INTO `bypass` VALUES (1,'2014-04-06 01:01:01',0,0,'test switch toggle'),(2,'2014-04-06 02:02:02',1,0,'test switch toggle 2'),(3,'2014-05-16 20:35:22',2,1,'Toggle from mobile app'),(4,'2014-05-16 20:35:23',2,0,'Toggle from mobile app'),(5,'2014-05-16 20:35:44',2,1,'Toggle from mobile app'),(6,'2014-05-16 20:41:14',2,0,'Toggle from mobile app'),(7,'2014-05-16 20:41:17',2,1,'Toggle from mobile app'),(8,'2014-05-16 20:41:18',2,0,'Toggle from mobile app'),(9,'2014-05-16 20:41:20',2,1,'Toggle from mobile app'),(10,'2014-05-16 20:41:22',2,0,'Toggle from mobile app'),(11,'2014-05-19 13:07:26',2,1,'Toggle from mobile app'),(12,'2014-05-19 13:07:28',2,0,'Toggle from mobile app'),(13,'2014-05-19 13:10:07',2,1,'Toggle from mobile app'),(14,'2014-05-19 13:10:28',2,0,'Toggle from mobile app'),(15,'2014-10-22 02:13:21',0,1,NULL),(16,'2014-10-27 23:55:10',2,0,'Toggle from mobile app');
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
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commands`
--

LOCK TABLES `commands` WRITE;
/*!40000 ALTER TABLE `commands` DISABLE KEYS */;
INSERT INTO `commands` VALUES (185,'2014-11-03 15:39:55',116,0,0,NULL,NULL,'13'),(186,'2014-11-03 15:39:55',118,0,0,NULL,NULL,'13'),(187,'2014-11-03 15:43:31',115,0,0,NULL,NULL,'13'),(188,'2014-11-05 01:18:51',116,0,0,NULL,NULL,'14'),(189,'2014-11-05 01:18:51',118,0,0,NULL,NULL,'14'),(190,'2014-11-05 01:18:51',120,0,0,NULL,NULL,'14'),(191,'2014-11-05 01:18:51',119,0,0,NULL,NULL,'14'),(192,'2014-11-05 01:19:08',115,0,0,NULL,NULL,'14'),(193,'2014-11-05 01:19:27',116,0,0,NULL,NULL,'14'),(194,'2014-11-05 01:22:34',38,0,0,NULL,NULL,NULL),(195,'2014-11-05 01:32:07',116,0,0,NULL,NULL,'15'),(196,'2014-11-05 01:32:07',118,0,0,NULL,NULL,'15'),(197,'2014-11-05 01:32:07',120,0,0,NULL,NULL,'15'),(198,'2014-11-05 01:32:07',119,0,0,NULL,NULL,'15'),(199,'2014-11-12 23:57:44',126,0,0,NULL,NULL,'$unixtime'),(200,'2014-11-12 23:59:23',126,0,0,NULL,NULL,'$unixtime'),(201,'2014-11-13 00:01:05',126,0,0,NULL,NULL,'$unixtime'),(202,'2014-11-13 14:36:46',126,0,0,NULL,NULL,'1415882160');
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
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices`
--

LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;
INSERT INTO `devices` VALUES (16,5,0,1,'Hall main sensor','1122334455667788',2,NULL),(17,5,0,2,'Hall louver','1122334455667789',0,NULL),(24,2,0,2,'Louver Complete','1122334455667799',0,''),(25,2,0,80,'Smart plug 1','1122331122331122',0,NULL),(26,20,0,0,'ASE Outdoor Sensor','1122334455667792',0,'');
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
INSERT INTO `devicesdyn` VALUES (17,1,NULL,'2014-09-16 02:47:48',NULL,1),(22,1,NULL,NULL,NULL,1),(25,1,NULL,'2014-09-16 02:46:03',NULL,1),(26,1,NULL,'2014-09-16 02:47:21',NULL,1);
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
INSERT INTO `history_store` VALUES ('2014-05-20 15:53:26','smartstatus','<id>8</id>','<id>8</id>',2),('2014-05-21 21:02:12','users','<id>1</id>','<id>1</id>',2),('2014-05-22 16:51:46','hvac','<id>2224</id>','<id>2224</id>',2),('2014-06-20 18:05:55','zones','<id>17</id>','<id>17</id>',3),('2014-05-22 17:30:37','hvac','<id>2228</id>','<id>2228</id>',2),('2014-10-27 21:50:31','hvac','<id>118</id>','<id>118</id>',2),('2014-05-22 17:30:43','hvac','<id>1178</id>','<id>1178</id>',2),('2014-05-22 21:40:58','notifications','<id>3</id>','<id>3</id>',2),('2014-06-10 22:04:57','relays','<id>3</id>','<id>3</id>',1),('2014-06-10 22:05:47','relays','<id>4</id>','<id>4</id>',1),('2014-06-12 21:44:45','alarms_system','<id>3</id>','<id>3</id>',1),('2014-06-12 21:53:27','alarms_system','<id>4</id>','<id>4</id>',1),('2014-06-12 22:39:05','smartsensors','<id>5</id>','<id>5</id>',1),('2014-06-12 22:50:31','thermostat','<id>4</id>','<id>4</id>',1),('2014-06-12 22:59:07','smartsensors','<id>6</id>','<id>6</id>',1),('2014-06-12 23:05:32','smartsensors','<id>7</id>','<id>7</id>',1),('2014-06-13 18:15:18','smartsensorsraw','<id>4</id>','<id>4</id>',1),('2014-06-13 18:52:26','diagnostics','<id>2</id>','<id>2</id>',1),('2014-06-16 14:51:02','alarms_zigbee','<id>6</id>','<id>6</id>',1),('2014-06-16 14:50:16','alarms_zigbee','<id>7</id>','<id>7</id>',1),('2014-06-16 15:18:19','alarms_zigbee','<id>8</id>','<id>8</id>',1),('2014-06-16 15:45:49','alarms_zigbee','<id>9</id>','<id>9</id>',1),('2014-06-16 16:13:52','zigbee','<id>1</id>','<id>1</id>',2),('2014-06-16 16:05:28','alarms_zigbee','<id>10</id>','<id>10</id>',1),('2014-06-16 16:05:54','alarms_zigbee','<id>11</id>','<id>11</id>',1),('2014-06-16 16:13:31','alarms_zigbee','<id>12</id>','<id>12</id>',1),('2014-06-16 16:20:49','alarms_zigbee','<id>13</id>','<id>13</id>',1),('2014-06-16 16:41:17','alarms_zigbee','<id>14</id>','<id>14</id>',1),('2014-06-16 21:11:48','registrations','<id>4</id>','<id>4</id>',1),('2014-06-16 21:40:21','alarms_zigbee','<id>15</id>','<id>15</id>',1),('2014-06-16 21:56:35','alarms_zigbee','<id>16</id>','<id>16</id>',1),('2014-06-16 21:58:45','alarms_zigbee','<id>17</id>','<id>17</id>',1),('2014-06-17 14:22:00','alarms_zigbee','<id>18</id>','<id>18</id>',1),('2014-06-17 14:22:18','alarms_zigbee','<id>19</id>','<id>19</id>',1),('2014-06-17 15:29:33','registrations','<id>5</id>','<id>5</id>',1),('2014-06-17 21:25:24','registrations','<id>6</id>','<id>6</id>',1),('2014-09-01 14:10:38','devices','<id>25</id>','<id>25</id>',1),('2014-06-18 10:12:58','alarms_zigbee','<id>20</id>','<id>20</id>',1),('2014-06-18 10:14:10','alarms_zigbee','<id>21</id>','<id>21</id>',1),('2014-06-18 10:15:14','alarms_zigbee','<id>22</id>','<id>22</id>',1),('2014-06-18 10:26:42','alarms_zigbee','<id>23</id>','<id>23</id>',1),('2014-06-18 10:28:46','alarms_zigbee','<id>24</id>','<id>24</id>',1),('2014-06-19 15:22:54','smartplugsdyn','<device_id>25</device_id>','<device_id>25</device_id>',2),('2014-09-01 14:39:58','hvac','<id>120</id>','<id>120</id>',2),('2014-06-18 18:06:40','alarms_zigbee','<id>25</id>','<id>25</id>',1),('2014-06-18 18:10:04','alarms_zigbee','<id>26</id>','<id>26</id>',1),('2014-06-18 18:16:42','registrations','<id>7</id>','<id>7</id>',1),('2014-06-18 18:19:06','registrations','<id>8</id>','<id>8</id>',1),('2014-06-18 18:19:06','alarms_zigbee','<id>27</id>','<id>27</id>',1),('2014-06-19 09:16:47','alarms_zigbee','<id>28</id>','<id>28</id>',1),('2014-06-19 12:41:09','paramflapdyn','<device_id>17</device_id>','<device_id>17</device_id>',1),('2014-06-19 12:47:32','alarms_zigbee','<id>29</id>','<id>29</id>',1),('2014-06-19 12:48:19','alarms_zigbee','<id>30</id>','<id>30</id>',1),('2014-06-19 13:23:08','remotecontrol','<id>1</id>','<id>1</id>',1),('2014-06-19 13:23:22','remotecontrol','<id>3</id>','<id>3</id>',1),('2014-06-19 13:24:02','remotecontrol','<id>4</id>','<id>4</id>',1),('2014-06-19 13:36:08','alarms_zigbee','<id>31</id>','<id>31</id>',1),('2014-06-19 13:41:36','remotecontrol','<id>5</id>','<id>5</id>',1),('2014-06-19 13:43:50','alarms_zigbee','<id>32</id>','<id>32</id>',1),('2014-06-19 13:45:12','alarms_zigbee','<id>33</id>','<id>33</id>',1),('2014-06-19 13:56:22','alarms_zigbee','<id>34</id>','<id>34</id>',1),('2014-06-19 21:23:07','sensorsdyn','<id>1</id>','<id>1</id>',1),('2014-06-19 21:31:52','sensorsdyn','<id>2</id>','<id>2</id>',1),('2014-06-19 21:42:28','alarms_zigbee','<id>35</id>','<id>35</id>',1),('2014-06-19 21:46:11','alarms_zigbee','<id>36</id>','<id>36</id>',1),('2014-09-01 17:59:32','hvac','<id>3175</id>','<id>1185</id>',2),('2014-06-20 18:05:54','zonesdyn','<zone_id>14</zone_id>','<zone_id>14</zone_id>',3),('2014-06-20 18:05:54','zones','<id>14</id>','<id>14</id>',3),('2014-06-20 18:05:55','zonesdyn','<zone_id>17</zone_id>','<zone_id>17</zone_id>',3),('2014-06-20 18:05:56','zonesdyn','<zone_id>19</zone_id>','<zone_id>19</zone_id>',3),('2014-06-20 18:05:56','zones','<id>19</id>','<id>19</id>',3),('2014-09-01 22:58:43','devices','<id>18</id>','<id>18</id>',3),('2014-09-01 22:58:43','devices','<id>19</id>','<id>19</id>',3),('2014-09-01 22:58:43','devices','<id>20</id>','<id>20</id>',3),('2014-09-01 22:58:43','devices','<id>21</id>','<id>21</id>',3),('2014-07-01 14:58:02','relays','<id>5</id>','<id>5</id>',1),('2014-07-09 23:00:58','remotecontrol','<id>6</id>','<id>6</id>',1),('2014-07-14 09:32:49','asemp','<id>12</id>','<id>20</id>',1),('2014-07-14 09:32:46','asemp','<id>12</id>','<id>12</id>',3),('2014-07-14 09:34:40','asemp','<id>7</id>','<id>7</id>',2),('2014-08-24 21:40:43','hvac','<id>1210</id>','<id>1200</id>',2),('2014-07-14 16:57:51','sensorsdyn','<id>3</id>','<id>3</id>',1),('2014-07-22 22:39:27','smartdevices','<id>3</id>','<id>3</id>',1),('2014-09-15 21:31:13','smartdevices','<id>2</id>','<id>2</id>',3),('2014-08-25 09:45:26','hvac','<id>4</id>','<id>4</id>',2),('2014-07-30 10:45:13','zonesdyn','<zone_id>0</zone_id>','<zone_id>0</zone_id>',1),('2014-08-12 22:27:02','zones','<id>20</id>','<id>20</id>',1),('2014-07-30 10:52:47','zonesdyn','<zone_id>20</zone_id>','<zone_id>20</zone_id>',1),('2014-08-12 22:27:02','zones','<id>21</id>','<id>21</id>',1),('2014-07-30 13:21:27','zonesdyn','<zone_id>21</zone_id>','<zone_id>21</zone_id>',1),('2014-08-12 22:27:02','zones','<id>22</id>','<id>22</id>',1),('2014-07-30 13:21:40','zonesdyn','<zone_id>22</zone_id>','<zone_id>22</zone_id>',1),('2014-08-12 22:27:02','zones','<id>3</id>','<id>3</id>',2),('2014-11-11 00:12:44','networks','<id>1</id>','<id>1</id>',2),('2014-09-01 22:12:24','hvac','<id>1201</id>','<id>2230</id>',1),('2014-09-01 22:12:24','hvac','<id>1202</id>','<id>2231</id>',1),('2014-09-01 22:09:19','hvac','<id>2232</id>','<id>2232</id>',1),('2014-09-01 22:09:19','hvac','<id>2233</id>','<id>2233</id>',1),('2014-08-12 22:27:02','zones','<id>6</id>','<id>6</id>',2),('2014-08-12 22:27:02','zones','<id>4</id>','<id>4</id>',2),('2014-08-12 22:27:02','zones','<id>5</id>','<id>5</id>',2),('2014-08-25 09:42:26','hvac','<id>78</id>','<id>2234</id>',1),('2014-09-01 17:40:27','smartdevices','<id>4</id>','<id>4</id>',1),('2014-08-29 18:08:30','devices','<id>24</id>','<id>24</id>',2),('2014-09-15 23:46:03','devicesdyn','<device_id>25</device_id>','<device_id>25</device_id>',1),('2014-09-01 14:40:10','registrations','<id>2</id>','<id>2</id>',2),('2014-09-15 23:47:11','devices','<id>26</id>','<id>26</id>',1),('2014-09-15 23:47:21','devicesdyn','<device_id>26</device_id>','<device_id>26</device_id>',1),('2014-09-01 15:49:01','devicesdyn','<device_id>16</device_id>','<device_id>16</device_id>',3),('2014-09-15 22:06:33','smartdevices','<id>1</id>','<id>1</id>',2),('2014-09-12 10:19:57','smartdevices','<id>5</id>','<id>5</id>',1),('2014-09-01 17:55:40','hvac','<id>3189</id>','<id>1189</id>',2),('2014-09-01 17:55:43','hvac','<id>3188</id>','<id>1188</id>',2),('2014-09-01 18:00:06','hvac','<id>3167</id>','<id>1187</id>',2),('2014-09-01 18:00:00','hvac','<id>3166</id>','<id>1186</id>',2),('2014-09-01 17:59:28','hvac','<id>3174</id>','<id>1184</id>',2),('2014-09-01 17:59:25','hvac','<id>3173</id>','<id>1183</id>',2),('2014-09-01 17:59:22','hvac','<id>3172</id>','<id>1182</id>',2),('2014-09-01 17:59:18','hvac','<id>3171</id>','<id>1181</id>',2),('2014-09-01 18:00:19','hvac','<id>3151</id>','<id>3207</id>',1),('2014-09-01 18:00:14','hvac','<id>3150</id>','<id>3208</id>',1),('2014-11-13 00:12:35','users','<id>2</id>','<id>2</id>',2),('2014-09-01 22:12:24','hvac','<id>1195</id>','<id>1195</id>',2),('2014-09-01 22:12:24','hvac','<id>1196</id>','<id>1196</id>',2),('2014-09-01 22:12:24','hvac','<id>1197</id>','<id>1197</id>',2),('2014-09-01 22:12:24','hvac','<id>1198</id>','<id>1198</id>',2),('2014-09-01 22:09:19','hvac','<id>107</id>','<id>107</id>',2),('2014-09-01 22:58:43','devices','<id>23</id>','<id>23</id>',3),('2014-09-01 22:58:43','devices','<id>22</id>','<id>22</id>',3),('2014-09-10 21:18:01','hvac','<id>1203</id>','<id>3209</id>',1),('2014-09-10 21:20:32','hvac','<id>3210</id>','<id>3210</id>',1),('2014-09-10 21:22:05','hvac','<id>3211</id>','<id>3211</id>',1),('2014-09-11 21:35:00','ui_menu','<id>57</id>','<id>57</id>',1),('2014-10-10 22:18:38','smartdevices','<id>6</id>','<id>6</id>',1),('2014-09-15 23:47:48','devicesdyn','<device_id>17</device_id>','<device_id>17</device_id>',1),('2014-09-17 10:59:04','relays','<id>6</id>','<id>6</id>',1),('2014-09-17 10:59:40','relays','<id>7</id>','<id>7</id>',1),('2014-09-17 11:02:35','relays','<id>8</id>','<id>8</id>',1),('2014-09-17 11:07:40','relays','<id>9</id>','<id>9</id>',1),('2014-09-17 11:08:21','relays','<id>10</id>','<id>10</id>',1),('2014-09-17 22:28:04','alarms_system','<id>5</id>','<id>5</id>',1),('2014-09-17 23:34:34','smartdevices','<id>8</id>','<id>8</id>',1),('2014-09-19 19:58:58','smartsensors','<id>8</id>','<id>8</id>',1),('2014-09-19 19:59:00','smartsensors','<id>9</id>','<id>9</id>',1),('2014-10-10 21:41:03','smartdevices','<id>9</id>','<id>9</id>',1),('2014-10-10 21:52:53','smartdevices','<id>10</id>','<id>10</id>',1),('2014-10-29 22:47:35','smartdevices','<id>11</id>','<id>11</id>',1),('2014-10-17 22:06:53','thermostat','<id>5</id>','<id>5</id>',1),('2014-10-17 22:07:03','thermostat','<id>6</id>','<id>6</id>',1),('2014-10-17 23:05:21','relays','<id>12</id>','<id>12</id>',1),('2014-10-17 23:12:21','smartsensors','<id>10</id>','<id>10</id>',1),('2014-10-18 00:03:40','relays','<id>13</id>','<id>13</id>',1),('2014-10-18 00:03:42','relays','<id>14</id>','<id>14</id>',1),('2014-10-18 00:03:53','relays','<id>15</id>','<id>15</id>',1),('2014-10-18 00:03:54','relays','<id>16</id>','<id>16</id>',1),('2014-10-18 00:03:55','relays','<id>17</id>','<id>17</id>',1),('2014-10-18 00:03:55','relays','<id>18</id>','<id>18</id>',1),('2014-10-18 00:03:56','relays','<id>19</id>','<id>19</id>',1),('2014-10-18 00:03:56','relays','<id>20</id>','<id>20</id>',1),('2014-10-18 00:03:57','relays','<id>21</id>','<id>21</id>',1),('2014-10-18 00:04:07','relays','<id>22</id>','<id>22</id>',1),('2014-10-18 00:04:08','relays','<id>23</id>','<id>23</id>',1),('2014-10-18 00:04:08','relays','<id>24</id>','<id>24</id>',1),('2014-10-18 00:04:09','relays','<id>25</id>','<id>25</id>',1),('2014-10-18 00:04:10','relays','<id>26</id>','<id>26</id>',1),('2014-10-18 00:04:11','relays','<id>27</id>','<id>27</id>',1),('2014-10-18 00:04:12','relays','<id>28</id>','<id>28</id>',1),('2014-10-18 00:04:13','relays','<id>29</id>','<id>29</id>',1),('2014-10-18 00:04:13','relays','<id>30</id>','<id>30</id>',1),('2014-10-18 00:04:14','relays','<id>31</id>','<id>31</id>',1),('2014-10-18 00:04:15','relays','<id>32</id>','<id>32</id>',1),('2014-10-18 00:04:18','relays','<id>33</id>','<id>33</id>',1),('2014-10-18 00:04:18','relays','<id>34</id>','<id>34</id>',1),('2014-10-20 12:02:03','smartsensors','<id>11</id>','<id>11</id>',1),('2014-10-20 18:06:35','relays','<id>35</id>','<id>35</id>',1),('2014-10-21 12:03:00','relays','<id>36</id>','<id>36</id>',1),('2014-10-21 12:03:19','relays','<id>37</id>','<id>37</id>',1),('2014-10-21 12:03:19','relays','<id>38</id>','<id>38</id>',1),('2014-10-21 22:49:54','thermostat','<id>7</id>','<id>7</id>',1),('2014-10-21 22:50:10','thermostat','<id>8</id>','<id>8</id>',1),('2014-10-21 23:13:21','bypass','<id>15</id>','<id>15</id>',1),('2014-10-21 23:17:11','thermostat','<id>9</id>','<id>9</id>',1),('2014-10-21 23:19:22','thermostat','<id>10</id>','<id>10</id>',1),('2014-10-21 23:23:10','thermostat','<id>11</id>','<id>11</id>',1),('2014-10-21 23:25:46','thermostat','<id>12</id>','<id>12</id>',1),('2014-10-21 23:27:49','thermostat','<id>13</id>','<id>13</id>',1),('2014-10-21 23:37:11','smartsensors','<id>12</id>','<id>12</id>',1),('2014-10-21 23:49:53','alarms_retrosave','<id>4</id>','<id>4</id>',1),('2014-10-21 23:52:04','alarms_retrosave','<id>5</id>','<id>5</id>',1),('2014-10-27 12:23:22','relays','<id>39</id>','<id>39</id>',1),('2014-10-27 12:23:24','relays','<id>40</id>','<id>40</id>',1),('2014-10-27 12:23:25','relays','<id>41</id>','<id>41</id>',1),('2014-10-27 12:24:41','relays','<id>42</id>','<id>42</id>',1),('2014-10-27 12:24:43','relays','<id>43</id>','<id>43</id>',1),('2014-10-27 12:24:44','relays','<id>44</id>','<id>44</id>',1),('2014-10-27 12:24:46','relays','<id>45</id>','<id>45</id>',1),('2014-10-27 12:24:47','relays','<id>46</id>','<id>46</id>',1),('2014-10-27 12:24:47','relays','<id>47</id>','<id>47</id>',1),('2014-10-27 21:55:10','bypass','<id>16</id>','<id>16</id>',1),('2014-10-27 22:08:43','alarms_types','<id>37</id>','<id>37</id>',1),('2014-10-27 22:09:46','alarms_types','<id>38</id>','<id>38</id>',1),('2014-10-27 22:09:47','alarms_types','<id>39</id>','<id>39</id>',1),('2014-10-27 22:09:48','alarms_types','<id>40</id>','<id>40</id>',1),('2014-10-27 22:09:50','alarms_types','<id>41</id>','<id>41</id>',1),('2014-10-27 22:09:59','alarms_types','<id>42</id>','<id>42</id>',1),('2014-10-27 22:10:21','alarms_types','<id>43</id>','<id>43</id>',1),('2014-10-27 22:10:36','alarms_types','<id>44</id>','<id>44</id>',1),('2014-10-27 22:10:46','alarms_types','<id>45</id>','<id>45</id>',1),('2014-10-27 22:10:58','alarms_types','<id>46</id>','<id>46</id>',1),('2014-10-27 22:11:07','alarms_types','<id>47</id>','<id>47</id>',1),('2014-10-27 22:11:15','alarms_types','<id>48</id>','<id>48</id>',1),('2014-10-27 22:11:23','alarms_types','<id>49</id>','<id>49</id>',1),('2014-10-27 22:11:41','alarms_types','<id>50</id>','<id>50</id>',1),('2014-10-27 22:11:52','alarms_types','<id>51</id>','<id>51</id>',1),('2014-10-27 22:13:50','alarms_types','<id>52</id>','<id>52</id>',1),('2014-10-27 22:14:04','alarms_types','<id>53</id>','<id>53</id>',1),('2014-10-27 22:14:16','alarms_types','<id>54</id>','<id>54</id>',1),('2014-10-27 22:14:27','alarms_types','<id>55</id>','<id>55</id>',1),('2014-10-27 22:14:37','alarms_types','<id>56</id>','<id>56</id>',1),('2014-10-27 22:14:48','alarms_types','<id>57</id>','<id>57</id>',1),('2014-10-27 22:15:03','alarms_types','<id>58</id>','<id>58</id>',1),('2014-10-27 22:15:13','alarms_types','<id>59</id>','<id>59</id>',1),('2014-10-27 22:15:24','alarms_types','<id>60</id>','<id>60</id>',1),('2014-10-27 22:16:20','alarms_types','<id>1</id>','<id>1</id>',2),('2014-10-27 22:16:27','alarms_types','<id>2</id>','<id>2</id>',2),('2014-10-27 22:16:38','alarms_types','<id>3</id>','<id>3</id>',2),('2014-10-27 22:17:00','alarms_types','<id>8</id>','<id>8</id>',2),('2014-10-27 22:17:07','alarms_types','<id>9</id>','<id>9</id>',2),('2014-10-27 22:17:20','alarms_types','<id>10</id>','<id>10</id>',2),('2014-10-27 22:17:32','alarms_types','<id>11</id>','<id>11</id>',2),('2014-10-27 22:17:42','alarms_types','<id>61</id>','<id>61</id>',1),('2014-10-27 22:17:51','alarms_types','<id>62</id>','<id>62</id>',1),('2014-10-27 22:18:02','alarms_types','<id>63</id>','<id>63</id>',1),('2014-10-27 22:18:14','alarms_types','<id>64</id>','<id>64</id>',1),('2014-10-27 22:18:26','alarms_types','<id>65</id>','<id>65</id>',1),('2014-10-27 22:20:00','alarms_types','<id>66</id>','<id>66</id>',1),('2014-10-27 23:07:17','hvac','<id>110</id>','<id>110</id>',2),('2014-10-27 23:07:17','hvac','<id>111</id>','<id>111</id>',2),('2014-10-29 16:21:47','ui_menu','<id>58</id>','<id>58</id>',1),('2014-10-29 18:55:23','smartsensorsraw','<id>5</id>','<id>5</id>',1),('2014-10-29 18:55:28','smartsensorsraw','<id>6</id>','<id>6</id>',1),('2014-10-29 22:32:50','hvac','<id>3212</id>','<id>3212</id>',1),('2014-10-29 22:45:42','smartdevices','<id>12</id>','<id>12</id>',1),('2014-11-03 13:43:31','smartdevices','<id>13</id>','<id>13</id>',1),('2014-11-04 21:50:05','ui_menu','<id>59</id>','<id>59</id>',1),('2014-11-04 23:19:30','smartdevices','<id>14</id>','<id>14</id>',1);
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
  `value_` varchar(100) DEFAULT NULL,
  `type_` int(11) DEFAULT NULL,
  `selections` varchar(200) DEFAULT NULL,
  `dependence` varchar(200) DEFAULT NULL,
  `permissions` int(11) unsigned NOT NULL DEFAULT '0',
  `units` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `option_` (`option_`),
  UNIQUE KEY `option__2` (`option_`)
) ENGINE=MyISAM AUTO_INCREMENT=3213 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hvac`
--

LOCK TABLES `hvac` WRITE;
/*!40000 ALTER TABLE `hvac` DISABLE KEYS */;
INSERT INTO `hvac` VALUES (77,'furnace','Furnace',0,NULL,NULL,NULL,NULL,1,NULL),(79,'furnace.stages','Stages',77,'0',3,'0::Single Stage;;1::Dual Stage;;2::Modulating',NULL,1,NULL),(80,'furnace.dataport','Data Access Port',77,'NONE',1,'10',NULL,1,NULL),(81,'furnace.port_speed','Data Access Port Speed',77,'9600',1,'10',NULL,1,NULL),(82,'furnace.hc_trans','Heat/Cool Transformer Setup',77,'0',3,'0::Same;;1::Different',NULL,1,'bps'),(93,'furnace.model','Furnace Model',77,'',1,'25',NULL,1,NULL),(84,'furnace.bridge_rcrh','Bridge Rc Rh',77,'0',3,'0::No;;1::Yes',NULL,1,NULL),(85,'furnace.cent_hum','Central Humidifier Control',77,'0',3,'0::Disabled;;1::Enabled',NULL,1,NULL),(86,'furnace.max_on','Maximum ON Time',77,'3600',1,'5',NULL,1,'seconds'),(1194,'furnace.sup_t_probes','Supply Duct Temperature Probes Installed',77,'1',3,'0::No;;1::Yes',NULL,1,NULL),(1195,'furnace.t1_up','Supply Duct Temperature Threshold Upper Limit',77,'27.8',1,'5',NULL,1,'&deg;C'),(1196,'furnace.t1_low','Supply Duct Temperature Threshold Lower Limit',77,'15.6',1,'5',NULL,1,'&deg;C'),(1197,'furnace.t2_up','Return Duct Temperature Threshold Upper Limit',77,'26.1',1,'5',NULL,1,'&deg;C'),(1198,'furnace.t2_low','Return Duct Temperature Threshold Lower Limit',77,'16.1',1,'5',NULL,1,'&deg;C'),(1199,'furnace.sensor_poll','Smart Controller Onboard Sensors Polling Period',77,'60',1,'5',NULL,1,'seconds'),(1210,'furnace.mode','Operating Mode',77,'0',3,'0::Bypass;;1::RetroSAVE',NULL,1,NULL),(94,'fblower','Furnace Blower',0,NULL,NULL,NULL,NULL,1,NULL),(95,'fblower.min_on','Minimum ON Time',94,'120',1,'5',NULL,1,'seconds'),(96,'fblower.min_off','Minimum OFF Time',94,'60',1,'5',NULL,1,'seconds'),(97,'fblower.max_on','Maximum ON Time',94,'0',1,'5',NULL,1,'seconds'),(98,'fblower.heat_cycle','Heat Cycle Timer',94,'120',1,'5',NULL,1,'seconds'),(99,'fblower.cool_cycle','Cooling Cycle Timer',94,'360',1,'5',NULL,1,'seconds'),(100,'fblower.stat_pres','Static Pressure Threshold',94,'0',1,'5',NULL,1,'kpa'),(74,'system','System Settings',0,NULL,NULL,NULL,NULL,3,NULL),(75,'system.notifications_sms','Enable notifications by SMS',74,'1',1,NULL,NULL,3,NULL),(76,'system.notifications_email','Enable notifications by EMail',74,'1',1,NULL,NULL,3,NULL),(117,'thermostat','Customer Thermostat',0,NULL,NULL,NULL,NULL,1,NULL),(101,'acheat','A/C & Heat Pump',0,NULL,NULL,NULL,NULL,1,NULL),(102,'acheat.installed','Pump Installed',101,'0',3,'0::No;;1::Yes',NULL,1,NULL),(103,'acheat.stages','Stages',101,'0',3,'0::Single Stage;;1::Dual Stage',NULL,1,NULL),(104,'acheat.min_comp_on','Minimum Compressor ON Time',101,'0',1,'5',NULL,1,'seconds'),(105,'acheat.min_comp_off','Minimum Compressor OFF Time',101,'0',1,'5',NULL,1,'seconds'),(106,'acheat.max_comp_on','Maximum Compressor ON Time',101,'0',1,'5',NULL,1,'seconds'),(107,'acheat.out_temp_cut','Outside Temperature Cutoff',101,'-5.6',1,'5',NULL,1,'&deg;C'),(108,'acheat.ob_heat','O/B Heat Call',101,'0',3,'0::Floating (off);;1::Set to R (on)',NULL,1,NULL),(109,'hrverv','HRV/ERV Control',0,NULL,NULL,NULL,NULL,1,NULL),(110,'hrverv.installed','Installed',109,'0',3,'0::No;;1::Yes',NULL,1,NULL),(111,'hrverv.relay_id','Relay ID',109,'6',3,'1::Relay #1;;2::Relay #2;;3::Relay #3;;4::Relay #4;;5::Relay #5;;6::Relay #6',NULL,1,NULL),(112,'hrverv.sync','Synchronized With Furnace Blower',109,'0',3,'0::No;;1::Yes',NULL,1,NULL),(113,'hrverv.min_on','Minimum ON Time',109,'120',1,'5',NULL,1,'seconds'),(114,'hrverv.min_off','Minimum OFF Time',109,'60',1,'5',NULL,1,'seconds'),(115,'hrverv.max_on','Maximum ON Time',109,'0',1,'5',NULL,1,'seconds'),(116,'comfort','Comfort Level',0,NULL,NULL,NULL,NULL,1,NULL),(118,'thermostat.connected','COTS Connected',117,'1',3,'0::No;;1::Yes',NULL,1,NULL),(120,'system.regmode','New Remote Devices Registration Mode',74,'2',3,'0::Disabled;;1::AdHoc;;2::Manual',NULL,3,NULL),(119,'thermostat.type','Thermostat Type',117,'0',3,'0::Analog;;1::Smart',NULL,1,NULL),(1179,'thermostat.maker','Thermostat Maker',117,'Honeywell',1,'20',NULL,1,NULL),(1180,'thermostat.model','Thermostat Model',117,'Prestige HD',1,'20',NULL,1,NULL),(1,'system.serial','Smart Controller Serial Number',74,'ASESMART-00002',1,'20',NULL,3,NULL),(2,'system.house_id','Unique House ID',74,'00002',1,'5',NULL,3,NULL),(3171,'comfort.min_hum','Humidity Minimum Acceptable Level',116,'30',1,'5',NULL,1,'%'),(3172,'comfort.max_hum','Humidity Maximum Acceptable Level',116,'60',1,'5',NULL,1,'%'),(3173,'comfort.t_occ_win','Default Winter Occupied Temperature',116,'21',1,'5',NULL,1,'&deg;C'),(3174,'comfort.t_occ_sum','Default Summer Occupied Temperature',116,'24',1,'5',NULL,1,'&deg;C'),(3175,'comfort.slider_def','Default Slider Settings',116,'2',3,'0::Max Comfort;;2::Balanced;;4::Max Saving',NULL,1,NULL),(3166,'comfort.co2_up','CO2 Upper Limit',116,'1000',1,'5',NULL,1,'ppm'),(3167,'comfort.co_up','CO Upper Limit',116,'5',1,'5',NULL,1,'ppm'),(3188,'comfort.circ_on','Circulation Cycle ON Time',116,'300',1,'5',NULL,1,'seconds'),(3189,'comfort.circ_off','Circulation Cycle OFF Time',116,'25',1,'5',NULL,1,'minutes'),(4,'system.sw_version','System Software Version',74,'14.8.25p',1,'10',NULL,3,NULL),(1191,'system.max_days','Keep Statistics Data in DB for days',74,'14',1,'5',NULL,3,NULL),(1192,'system.max_storage','Maximum Storage Count Reach Actions',74,'0',3,'0::Delete oldest records;;1::Stop collecting stats',NULL,3,NULL),(3,'system.description','System Short Description',74,'Dmitry test PC',1,'50',NULL,3,NULL),(1193,'furnace.ret_t_probes','Return Duct Temperature Probes Installed',77,'0',3,'0::No;;1::Yes',NULL,1,NULL),(2223,'retrosave','RetroSAVE Operational Parameters',0,NULL,NULL,NULL,NULL,3,NULL),(2224,'retrosave.away_mode','Away mode',2223,'0',4,'0::Disabled;;1::Enabled',NULL,3,NULL),(2225,'retrosave.away_period','Set Away mode after period',2223,'24',1,'5',NULL,3,'hours'),(1178,'thermostat.mode','Thermostat Mode',117,'1',3,'0::Cold only;;1::Auto mode;;2::Heat only',NULL,1,NULL),(2227,'retrosave.comfort_t','Comfort temperature adjustment',2223,'1',1,'3',NULL,3,NULL),(2228,'retrosave.comfort_h','Comfort humidity adjustment',2223,'0',1,'3',NULL,3,NULL),(1200,'furnace.house_vents','Total number of house vents',77,'0',1,'3',NULL,1,' '),(1201,'furnace.rise_low_thr','Temperature rise low threshold',77,'35',1,'3',NULL,1,'&deg;C'),(1202,'furnace.rise_high_thr','Temperature rise high threshold',77,'75',1,'3',NULL,1,'&deg;C'),(2232,'acheat.dec_low_thr','Temperature decline low threshold',101,'17',1,'3',NULL,1,'&deg;C'),(2233,'acheat.dec_high_thr','Temperature decline high threshold',101,'20',1,'3',NULL,1,'&deg;C'),(78,'furnace.installed','Furnace Installed',77,'1',3,'0::No;;1::Yes',NULL,1,NULL),(3151,'comfort.co_present','CO Sensor Present',116,'1',3,'0::No;;1::Yes',NULL,1,NULL),(3150,'comfort.co2_present','CO2 Sensor Present',116,'1',3,'0::No;;1::Yes',NULL,1,NULL),(1203,'furnace.btus','BTUs',77,'0',1,'3',NULL,1,NULL),(3210,'fblower.cfm','CFM',94,'0',1,'3',NULL,1,NULL),(3211,'acheat.ton','Ton',101,'1',3,'1::1;;2::2;;3::3;;4::4;;5::5',NULL,1,NULL),(3212,'system.testrefresh','Sensors test page refresh interval',74,'0',1,'3',NULL,1,NULL);
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
INSERT INTO `networks` VALUES (1,'0.0.0.0','0.0.0.0','cloud.ase-energy.ca','smartcloud.local','RetroSAVE',13,'retrosave',0,1,'1.1.1.1','0.0.0.0','0.0.0.0','192.168.1.1','Ch.11: aaaaaaaa','somekey','129.6.15.30','96.226.242.9',0,'','openweathermap.org','',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (2,'dmitry@ase-energy.ca',NULL,6),(3,'dmitry@elutsk.com',NULL,3),(26,'','380503173500',3),(29,'','18001212121',2);
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registrations`
--

LOCK TABLES `registrations` WRITE;
/*!40000 ALTER TABLE `registrations` DISABLE KEYS */;
INSERT INTO `registrations` VALUES (1,'2014-04-10 01:01:01',1,1,0,'1122334455667788',2,NULL,NULL,NULL,NULL,NULL,4,NULL,0,NULL,NULL,NULL,NULL,2,NULL,NULL),(2,'2014-04-10 02:02:02',1,0,0,'1122334455667792',2,NULL,NULL,NULL,NULL,NULL,1,NULL,0,NULL,NULL,NULL,NULL,2,NULL,NULL),(3,'2014-04-10 03:03:03',1,2,0,'1122334455667799',2,NULL,NULL,NULL,NULL,NULL,5,NULL,0,NULL,NULL,NULL,NULL,2,NULL,NULL),(4,'2014-06-17 00:02:03',0,1,1234,'1122334455667788',2,NULL,NULL,NULL,NULL,NULL,1,NULL,0,NULL,NULL,NULL,NULL,4,NULL,NULL),(5,'2014-06-17 18:29:33',5,1,NULL,NULL,NULL,NULL,NULL,18,NULL,NULL,NULL,NULL,0,1030,8013,10000,10000,0,NULL,NULL),(6,'2014-06-18 00:25:24',5,80,NULL,NULL,NULL,NULL,NULL,23,NULL,NULL,NULL,NULL,0,1234,5678,NULL,NULL,0,NULL,NULL),(7,'2014-06-18 21:16:42',1,1,NULL,'1122334455667788',NULL,NULL,NULL,NULL,3,NULL,4,NULL,0,NULL,NULL,NULL,NULL,2,0,NULL),(8,'2014-06-18 21:19:06',1,1,NULL,'1122334455667788',NULL,NULL,NULL,NULL,26,NULL,4,NULL,0,NULL,NULL,NULL,NULL,3,0,NULL);
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_registrations` AFTER INSERT ON `registrations`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_registrations IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'registrations'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
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
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relays`
--

LOCK TABLES `relays` WRITE;
/*!40000 ALTER TABLE `relays` DISABLE KEYS */;
INSERT INTO `relays` VALUES (1,'2014-04-06 03:03:03',0,1,0,1,0,0,1,0,1,0,1,0,1,NULL,NULL),(2,'2014-05-16 01:39:16',0,0,0,0,0,0,1,1,1,0,1,0,0,NULL,NULL),(3,'2014-06-11 01:04:35',0,0,0,1,1,1,1,1,0,1,0,0,0,NULL,NULL),(4,'2014-06-11 01:05:25',0,0,0,0,0,1,1,1,1,0,1,0,1,NULL,NULL),(5,'2014-07-01 17:57:39',0,0,0,0,0,1,1,1,1,1,0,0,0,NULL,NULL),(6,'2014-09-17 13:59:04',0,1,1,1,0,0,1,0,0,0,0,1,1,NULL,NULL),(7,'2014-09-17 13:59:40',0,1,1,1,0,0,1,0,0,0,0,1,1,NULL,NULL),(8,'2014-09-17 14:02:35',0,1,1,1,0,0,1,0,0,0,0,1,1,NULL,NULL),(9,'2014-09-17 14:07:40',0,1,1,1,0,0,1,0,0,0,0,1,1,NULL,NULL),(10,'2014-09-17 14:08:21',0,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,'2014-10-18 02:05:15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0),(13,'2014-10-18 03:03:40',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(14,'2014-10-18 03:03:42',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL),(15,'2014-10-18 03:03:53',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,NULL),(16,'2014-10-18 03:03:54',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,NULL,NULL),(17,'2014-10-18 03:03:55',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,NULL,NULL,NULL),(18,'2014-10-18 03:03:55',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL),(19,'2014-10-18 03:03:56',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL),(20,'2014-10-18 03:03:56',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL),(21,'2014-10-18 03:03:57',NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(22,'2014-10-18 03:04:07',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(23,'2014-10-18 03:04:08',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(24,'2014-10-18 03:04:08',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(25,'2014-10-18 03:04:09',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(26,'2014-10-18 03:04:10',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(27,'2014-10-18 03:04:11',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(28,'2014-10-18 03:04:12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL),(29,'2014-10-18 03:04:13',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL),(30,'2014-10-18 03:04:13',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),(31,'2014-10-18 03:04:14',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL),(32,'2014-10-18 03:04:15',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL),(33,'2014-10-18 03:04:18',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL),(34,'2014-10-18 03:04:18',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(35,'2014-10-20 21:06:35',1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL),(36,'2014-10-21 15:03:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(37,'2014-10-21 15:03:19',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(38,'2014-10-21 15:03:19',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL),(39,'2014-10-27 14:23:22',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(40,'2014-10-27 14:23:24',NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(41,'2014-10-27 14:23:25',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(42,'2014-10-27 14:24:41',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(43,'2014-10-27 14:24:43',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(44,'2014-10-27 14:24:44',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(45,'2014-10-27 14:24:46',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(46,'2014-10-27 14:24:47',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(47,'2014-10-27 14:24:47',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_relays` AFTER INSERT ON `relays`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_relays IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'relays'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES (@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
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
) ENGINE=MEMORY AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (1,2,'29423bc3a787015e39f1bc98db61c947','2014-10-24 22:53:36','2014-10-25 00:53:36',1,0),(2,2,'29423bc3a787015e39f1bc98db61c947','2014-10-25 02:27:25','2014-10-25 04:27:25',1,0),(3,2,'29423bc3a787015e39f1bc98db61c947','2014-10-27 14:23:20','2014-11-25 15:23:20',1,0),(4,1,'4eef6e0cee1d47199be4cf2eaa2577a5','2014-10-27 23:54:14','2014-10-29 01:17:03',0,0),(5,1,'c432886957314e84a334460a528d699d','2014-10-28 01:24:57','2014-10-29 01:48:20',0,0),(6,2,'bff4cfb78cee334e291bc8e69a816c2b','2014-11-04 17:16:57','2014-11-06 02:16:57',1,0),(7,2,'bff4cfb78cee334e291bc8e69a816c2b','2014-11-11 23:26:53','2014-11-13 13:26:53',1,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smartdevices`
--

LOCK TABLES `smartdevices` WRITE;
/*!40000 ALTER TABLE `smartdevices` DISABLE KEYS */;
INSERT INTO `smartdevices` VALUES (1,'2014-09-09 01:49:28',0,2,0,60,0,0,'11223344',0,0,1,1,'Test manufacturer','Test model','Some test device'),(3,'2014-07-23 01:39:27',1,1,0,40,0,0,'111',0,19200,0,0,'Some','Some','tank test device'),(4,'2014-09-01 20:40:27',0,5,1,40,0,0,'',2,0,0,0,'','','relay test'),(5,'2014-09-12 13:19:57',0,2,1,40,0,0,'1122334455',0,0,1,0,'Pepsi','Drink em up','Vending machine'),(6,'2014-10-11 01:18:38',82,0,0,40,0,0,'11223344',0,0,0,0,'','',''),(8,'2014-09-18 02:34:34',0,0,1,70,500,600,'',0,0,0,0,'','','test trigger'),(9,'2014-10-11 00:41:03',2,0,1,40,0,0,'',0,0,0,0,'','',''),(10,'2014-10-11 00:52:53',1,0,0,40,0,0,'',0,0,0,0,'','',''),(11,'2014-10-30 00:47:35',2,2,1,40,0,0,'',0,0,0,0,'','','test local'),(12,'2014-10-30 00:45:42',0,0,1,40,0,0,'',0,0,0,0,'','',''),(13,'2014-11-03 15:43:31',0,2,1,40,0,0,'12121212121',0,0,0,0,'','',''),(14,'2014-11-05 01:19:30',0,0,0,40,0,0,'',0,0,0,0,'','','aaaa');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER a_i_smartdevices
	AFTER INSERT
	ON smartdevices
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
      INSERT INTO commands (id, updated, command, parameters) VALUES (NULL, NOW(), 117, NEW.id);
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
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER a_u_smartdevices
	AFTER UPDATE
	ON smartdevices
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
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_smartdevices` AFTER DELETE ON `smartdevices`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartdevices IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartdevices';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES (@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smartsensors`
--

LOCK TABLES `smartsensors` WRITE;
/*!40000 ALTER TABLE `smartsensors` DISABLE KEYS */;
INSERT INTO `smartsensors` VALUES (1,'2014-04-06 01:01:01',0,25.0,70,2,333,35.0,NULL,NULL,NULL,NULL,NULL,NULL),(2,'2014-04-06 02:02:02',0,24.0,72,2,321,34.0,NULL,NULL,NULL,NULL,NULL,NULL),(3,'2014-04-07 01:01:01',0,26.0,71,1,321,36.0,14.0,23.0,55,67,NULL,NULL),(4,'2014-05-01 13:32:44',0,27.0,66,1,339,33.0,17.0,25.0,65,70,55.00,4),(5,'2014-06-13 01:39:05',0,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,'2014-06-13 01:59:07',0,NULL,NULL,NULL,223,NULL,NULL,22.5,NULL,77,NULL,NULL),(7,'2014-06-13 02:05:32',0,NULL,NULL,NULL,NULL,NULL,23.5,NULL,88,NULL,NULL,111),(8,'2014-09-19 22:58:58',0,NULL,NULL,NULL,NULL,NULL,NULL,20.0,NULL,60,NULL,NULL),(9,'2014-09-19 22:59:00',0,NULL,NULL,NULL,NULL,NULL,NULL,20.0,NULL,60,NULL,NULL),(10,'2014-10-18 02:12:05',0,28.0,78,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11,'2014-10-20 15:02:03',2,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,'2014-10-22 02:37:11',1,NULL,NULL,17,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=latin1 PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ui_menu`
--

LOCK TABLES `ui_menu` WRITE;
/*!40000 ALTER TABLE `ui_menu` DISABLE KEYS */;
INSERT INTO `ui_menu` VALUES (1,'status','relays','Status',0,0),(2,'status','relays','Smart Controller',0,1),(3,'status','onboard','Onboard Sensors',0,1),(4,'status','indoor','Indoor Sensors',0,1),(5,'status','outdoor','Outdoor Sensors',0,1),(6,'status','system','System Information',0,1),(7,'networks','ip','Networks',0,0),(8,'networks','ip','IP Network',0,1),(9,'networks','zigbee','Local Zigbee',0,1),(10,'networks','asemp','ASEMP Profile',0,1),(11,'hvac','furnace','HVAC',0,0),(12,'hvac','furnace','Furnace',0,1),(13,'hvac','fblower','Furnace Blower',0,1),(14,'hvac','acheat','A/C & Heat Pump',0,1),(15,'hvac','hrverv','HRV/ERV Control',0,1),(16,'hvac','comfort','Comfort Settings',0,1),(17,'hvac','thermostat','Customer Thermostat Control',0,1),(18,'smartgrid','peaksaver','Smart Grid',0,0),(20,'zonedev','zones','Devices Config<br>& Management',0,0),(21,'events','events','Events<br>& Alarms',0,0),(22,'userinfo','details','Customer<br>Settings',0,0),(23,'userinfo','details','User Details',0,1),(24,'userinfo','alarms','Alarms & Events',0,1),(25,'userinfo','password','Password',0,1),(26,'system','update','System<br>Maintenance',0,0),(28,'system','update','Software Update',0,1),(29,'system','db','Database Maintenance',0,1),(32,'zonedev','zones','Zones Management',0,1),(33,'zonedev','devices','Remote Device Config',0,1),(34,'zonedev','newdev','Add New Devices',0,1),(39,'events','events','Alarms & Events Viewer',0,1),(40,'events','alarms','RetroSAVE Alarms Management',0,1),(41,'status','networks','Network Connections',0,1),(43,'events','management','Networks Alarms Management',0,1),(44,'smartgrid','peaksaver','PeakSaver',0,1),(45,'smartgrid','smartmeter','SmartMeter',0,1),(46,'reports','occupancy','Reports',0,0),(47,'logout','logout','Logout',0,0),(48,'reports','occupancy','Statistical Occupancy Stats',0,1),(49,'reports','retrosave','RetroSAVE Runtime',0,1),(50,'reports','charts','Charts',0,1),(51,'reports','savings','Savings',0,1),(52,'reports','runtime','HVAC Runtime',0,1),(54,'status','zigbee','Zigbee',0,1),(55,'reports','cots','COTS Thermostat Stats',0,1),(56,'zonedev','smartdevices','Smart Controller Local Sensors & Controls',0,1),(57,'system','datetime','Date & Time',0,1),(58,'zonedev','sensorstest','Sensors Test',0,1),(59,'system','advanced','Advanced',0,1);
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
INSERT INTO `zigbee` VALUES (1,13,12345,1,'1122334455667788','5678',1,'sometestkey2','XBP24BZ7PITB','XBEEPRO2','v1347',0);
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

-- Dump completed on 2014-11-13 16:03:42
