
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
INSERT INTO `smartdevices` VALUES 
(1,'2014-11-25 16:50:46',1,0,0,40,0,0,'1',0,0,0,0,'','','ADC1 CO sensor'),
(2,'2014-11-25 16:51:04',2,0,0,40,0,0,'2',0,0,0,0,'','','ADC2'),
(3,'2014-11-25 16:51:19',2,0,0,40,0,0,'3',0,0,0,0,'','','ADC3'),
(4,'2014-11-25 16:51:39',2,0,0,40,0,0,'4',0,0,0,0,'','','ADC4'),
(5,'2014-11-25 16:52:12',2,1,0,40,0,0,'64',0,0,0,0,'','','HTU21 T sensor'),
(6,'2014-11-25 16:52:32',3,1,0,40,0,0,'64',0,0,0,0,'','','HTU21 H sensor');
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

