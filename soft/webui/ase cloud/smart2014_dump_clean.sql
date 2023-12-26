SET autocommit=0;

DROP TRIGGER IF EXISTS `action_notify_MuxDemux`;
DROP TRIGGER IF EXISTS `commands_actions`;

DROP TABLE IF EXISTS `actions`;
CREATE TABLE `actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ref_table` varchar(200) DEFAULT NULL,
  `ref_id` int(11) DEFAULT NULL,
  `type_` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MEMORY;

DROP TABLE IF EXISTS `alarms_networks`;
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

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_alarms_networks` AFTER INSERT ON `alarms_networks`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_alarms_networks IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_networks'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_alarms_networks` AFTER UPDATE ON `alarms_networks`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_networks IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_networks';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_alarms_networks` AFTER DELETE ON `alarms_networks`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_networks IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_networks';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `alarms_pressure`;
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

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_alarms_pressure` AFTER INSERT ON `alarms_pressure`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_alarms_pressure IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_pressure'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_alarms_pressure` AFTER UPDATE ON `alarms_pressure`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_pressure IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_pressure';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_alarms_pressure` AFTER DELETE ON `alarms_pressure`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_pressure IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_pressure';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `alarms_retrosave`;
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

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_alarms_retrosave` AFTER INSERT ON `alarms_retrosave`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_alarms_retrosave IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_retrosave'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_alarms_retrosave` AFTER UPDATE ON `alarms_retrosave`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_retrosave IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_retrosave';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_alarms_retrosave` AFTER DELETE ON `alarms_retrosave`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_retrosave IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_retrosave';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `alarms_system`;
CREATE TABLE `alarms_system` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `updated` datetime DEFAULT NULL,
  `type_` int(11) DEFAULT NULL,
  `severity` int(11) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_alarms_system` AFTER INSERT ON `alarms_system`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_alarms_system IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_system'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_alarms_system` AFTER UPDATE ON `alarms_system`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_system IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_system';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_alarms_system` AFTER DELETE ON `alarms_system`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_system IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_system';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `alarms_types`;
CREATE TABLE `alarms_types` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `alarm_id` int(11) NOT NULL DEFAULT '0',
  `type_` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `severity` tinyint(4) NOT NULL DEFAULT '0',
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `alarms_types` VALUES
(1,0,0,0,0,'Time based triggered period'),
(2,1,0,1,1,'PIR triggered report'),
(3,2,0,1,2,'Battery Level triggered report'),
(4,3,0,1,2,'Upper Temperature Value Report Trigger'),
(5,4,0,1,2,'Lower Temperature Value Report Trigger'),
(6,5,0,1,1,'Upper Humidity Value Report Trigger'),
(7,6,0,0,0,'Lower Humidity Value Report Trigger'),
(8,7,0,0,0,'Upper CO Value Trigger Report'),
(9,8,0,1,1,'Upper CO2 Value Trigger Report'),
(10,9,0,1,2,'ASEMP Central Command Request'),
(11,10,0,1,2,'Board power-up or reset triggered'),
(12,0,1,0,0,'Zigbee Device Connected to Smart Controller Network'),
(13,1,1,1,1,'Loss of Communication with Remote Device'),
(14,2,1,1,2,'PAN ID Conflict'),
(15,3,1,1,1,'PAN ID Resolution'),
(16,4,1,1,0,'RF Interference'),
(17,5,1,0,0,'RF Interference Resolution'),
(18,0,2,1,0,'System Update Initiated by Admin'),
(19,1,2,1,2,'DB Max Storage Level Reached'),
(20,0,3,0,0,'Connection Was Successful'),
(21,1,3,1,1,'First Failed Attempt to Connect to ISP Name Server'),
(22,2,3,1,2,'Consecutive Failed Attempts to Connect to ISP Name Server'),
(23,0,4,0,1,'Calculated Static Pressure Below Threshold'),
(24,1,4,1,1,'Calculated Static Pressure Exceeded Threshold for the First Time'),
(25,2,4,1,1,'Consecutive Calculated Static Pressure Values Exceeded Threshold'),
(26,0,5,0,0,'Deletion of a Previously Added Zigbee Device'),
(27,1,5,1,1,'Addition of a New Zigbee Device to the Smart Controller DB'),
(28,2,5,0,0,'Update the ASEMP Profile of the Remote Device'),
(29,3,5,0,0,'Update the Status of the Remote Device'),
(30,4,5,0,0,'Update the Zigbee Short Address of the Remote Device'),
(31,-1,0,0,0,'RetroSAVE Alarms'),
(32,-1,1,0,0,'Zigbee Alarms'),
(33,-1,2,0,0,'System Alarms'),
(34,-1,3,0,0,'IP Network Alarms'),
(35,-1,4,0,0,'Pressure Alarms'),
(36,-1,5,0,0,'Registration Events'),
(37,6,1,1,0,'Radio module unsuccessful restart'),
(38,7,1,1,0,'Radio module successful restart'),
(39,8,1,1,0,'Unable to create new zigbee network with passed parameters'),
(40,9,1,1,0,'New Zigbee network successfully created'),
(41,10,1,1,0,'Existing Zigbee network parameters change error'),
(42,11,1,1,0,'Existing Zigbee network parameters successful change'),
(43,12,1,1,0,'Unable to change configuration mode'),
(44,13,1,1,0,'Configuration mode successfully enabled'),
(45,14,1,1,0,'Configuration mode successfully disabled'),
(46,15,1,1,0,'Network discovery result'),
(47,16,1,1,0,'Ping remote device result'),
(48,17,1,1,0,'Route discovery result'),
(49,18,1,1,0,'non-ASE device command status'),
(50,19,1,1,0,'ASEMP device command status'),
(51,20,1,1,0,'Unable to set ZED enable or disable status'),
(52,2,2,1,0,'Smart controller board unsuccessful restart'),
(53,3,2,1,0,'Smart controller diagnostics result'),
(54,4,2,1,0,'Set relays status error'),
(55,5,2,1,0,'Onboard sensor read error'),
(56,6,2,1,0,'Thermostat wires read error'),
(57,7,2,1,0,'Unable to set RTC value'),
(58,8,2,1,0,'Date and time received from RTC'),
(59,9,2,1,0,'Unable to get RTC value'),
(60,10,2,1,0,'Local sensor set status error'),
(61,11,0,1,0,'AC current Upper threshold triggered'),
(62,12,0,1,0,'ADC2 threshold triggered'),
(63,13,0,1,0,'ADC3 threshold triggered'),
(64,14,0,1,0,'ADC4 threshold triggered'),
(65,15,0,1,0,'CO_Aout ADC1 threshold triggered'),
(66,5,5,1,0,'Registration request from new device'),
(67,11,2,0,0,'RetroSAVE modules restart'),
(68,12,2,0,0,'Smart controller system reset'),
(69,13,2,0,0,'Smart controller shutdown');

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_alarms_types` AFTER INSERT ON `alarms_types`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_alarms_types IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_types'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_alarms_types` AFTER UPDATE ON `alarms_types`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_types IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_types';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_alarms_types` AFTER DELETE ON `alarms_types`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_types IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_types';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `alarms_zigbee`;
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

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_alarms_zigbee` AFTER INSERT ON `alarms_zigbee`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_alarms_zigbee IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_zigbee'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_alarms_zigbee` AFTER UPDATE ON `alarms_zigbee`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_zigbee IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_zigbee';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_alarms_zigbee` AFTER DELETE ON `alarms_zigbee`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_alarms_zigbee IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_zigbee';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `asemp`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `asemp` VALUES
(1,0,'occu_pir',0,0,'Occupied PIR Trigger Enable',0,NULL),
(2,0,'unoccu_pir',1,1,'Unoccupied PIR Trigger Enable',0,NULL),
(3,0,'occu_rep',120,120,'Occupied Reporting Period',1,'seconds'),
(4,0,'unoccu_rep',360,360,'Unoccupied Reporting Period\r\n',1,'seconds'),
(5,0,'min_rep_int',60,60,'Minimum Time Interval Between Consecutive Unsolicited Reports',1,'seconds'),
(6,0,'bat_stat_thr',10,10,'Battery Status Trigger Value Threshold',1,NULL),
(7,0,'ac_curr_thr',0,0,'AC current upper threshold trigger',1,'Ampere'),
(8,0,'up_temp_tr',35,35,'Upper Temperature Value Report Trigger\r\n',1,'degree C'),
(9,0,'lo_temp_tr',5,5,'Lower Temperature Value Report Trigger\r\n',1,'degree C'),
(10,0,'up_hum_tr',60,60,'Upper Humidity Value Report Trigger',1,'% RH'),
(11,0,'lo_hum_tr',30,30,'Lower Humidity Value Report Trigger',1,'% RH'),
(12,0,'mcu_sleep',0,0,'MCU sleep timer. CC2530 wakeup sleep timer',1,'sec'),
(13,0,'max_retry',3,3,'ASEMP Max Retry Count',1,NULL),
(14,0,'max_wait',60,60,'ASEMP MAX Wait Timer',1,'seconds'),
(15,0,'up_co_tr',0,0,'Upper CO Value Trigger Report',1,'ppm'),
(16,0,'up_co2_tr',1000,1000,'Upper CO2 Value Trigger Report\r\n',1,'ppm'),
(17,0,'aud_alarm',1,1,'Audible Alarm Enable',0,NULL),
(18,0,'led_alarm',1,1,'LED Alarm Enable',0,NULL),
(19,0,'name',0,0,'Default ASEMP Profile',2,NULL);

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_asemp` AFTER INSERT ON `asemp`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_asemp IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'asemp'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_asemp` AFTER UPDATE ON `asemp`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_asemp IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'asemp';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_asemp` AFTER DELETE ON `asemp`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_asemp IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'asemp';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `bypass`;
CREATE TABLE `bypass` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `updated` datetime DEFAULT NULL,
  `type_` int(11) DEFAULT '0',
  `status` int(11) DEFAULT '0',
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_bypass` AFTER INSERT ON `bypass`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_bypass IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'bypass'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_bypass` AFTER UPDATE ON `bypass`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_bypass IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'bypass';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_bypass` AFTER DELETE ON `bypass`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_bypass IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'bypass';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `commands`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `deviceadvanced`;
CREATE TABLE `deviceadvanced` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` int(11) NOT NULL,
  `type_` int(11) NOT NULL,
  `realvar1` double NOT NULL,
  `realvar2` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `device_id` (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_deviceadvanced` AFTER INSERT ON `deviceadvanced`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_deviceadvanced IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'deviceadvanced'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_deviceadvanced` AFTER UPDATE ON `deviceadvanced`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_deviceadvanced IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'deviceadvanced';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_deviceadvanced` AFTER DELETE ON `deviceadvanced`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_deviceadvanced IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'deviceadvanced';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `devices`;
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

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_devices` AFTER INSERT ON `devices`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_devices IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'devices'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_devices` AFTER UPDATE ON `devices`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_devices IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'devices';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_devices` AFTER DELETE ON `devices`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_devices IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'devices';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `devicesdyn`;
CREATE TABLE `devicesdyn` (
  `device_id` int(11) NOT NULL,
  `online` tinyint(1) DEFAULT NULL,
  `device_status` int(11) DEFAULT NULL,
  `updated_time` datetime DEFAULT NULL,
  `battery_charge` int(11) DEFAULT NULL,
  `remote_ack` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_devicesdyn` AFTER INSERT ON `devicesdyn`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_devicesdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'devicesdyn'; 						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	
  INSERT INTO commands VALUES (NULL, NOW(), 57, 0, 0, NEW.device_id, NULL, NULL);
END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_devicesdyn` AFTER UPDATE ON `devicesdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_devicesdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'devicesdyn';						SET @pk_d_old = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; 
  IF (NEW.online != OLD.online) THEN
    INSERT INTO commands VALUES (NULL, NOW(), 57, 0, 0, NEW.device_id, NULL, NULL);
  END IF;
END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_devicesdyn` AFTER DELETE ON `devicesdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_devicesdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'devicesdyn';						SET @pk_d = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `diagnostics`;
CREATE TABLE `diagnostics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` datetime DEFAULT NULL,
  `type_` int(11) DEFAULT '0',
  `event` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_diagnostics` AFTER INSERT ON `diagnostics`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_diagnostics IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'diagnostics'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_diagnostics` AFTER UPDATE ON `diagnostics`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_diagnostics IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'diagnostics';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_diagnostics` AFTER DELETE ON `diagnostics`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_diagnostics IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'diagnostics';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `equipment`;
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

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_equipment` AFTER INSERT ON `equipment`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_equipment IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'equipment'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_equipment` AFTER UPDATE ON `equipment`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_equipment IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'equipment';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_equipment` AFTER DELETE ON `equipment`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_equipment IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'equipment';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `events`;
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

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_events` AFTER INSERT ON `events`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_events IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'events'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_events` AFTER UPDATE ON `events`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_events IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'events';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_events` AFTER DELETE ON `events`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_events IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'events';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `history_store`;
CREATE TABLE `history_store` (
  `timemark` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `table_name` tinytext NOT NULL,
  `pk_date_src` text NOT NULL,
  `pk_date_dest` text NOT NULL,
  `record_state` int(11) NOT NULL,
  PRIMARY KEY (`table_name`(100),`pk_date_dest`(100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `history_store_old`;
CREATE TABLE `history_store_old` (
  `timemark` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `table_name` tinytext,
  `pk_date_src` text NOT NULL,
  `pk_date_dest` text,
  `record_state` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `hvac`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `hvac` VALUES
(1,'system.serial','Smart Controller Serial Number',74,'',1,'20',NULL,3,NULL),
(2,'system.house_id','Unique House ID',74,'',1,'5',NULL,3,NULL),
(3,'system.description','System Short Description',74,'',1,'50',NULL,3,NULL),
(4,'system.sw_version','System Software Version',74,'14.12.12p',1,'10',NULL,3,NULL),
(74,'system','System Settings',0,NULL,NULL,NULL,NULL,3,NULL),
(75,'system.notifications_sms','Enable notifications by SMS',74,'1',1,NULL,NULL,3,NULL),
(76,'system.notifications_email','Enable notifications by EMail',74,'1',1,NULL,NULL,3,NULL),
(77,'furnace','Furnace',0,NULL,NULL,NULL,NULL,1,NULL),
(78,'furnace.installed','Furnace Installed',77,'1',3,'0::No;;1::Yes',NULL,1,NULL),
(79,'furnace.stages','Stages',77,'0',3,'0::Single Stage;;1::Dual Stage;;2::Modulating',NULL,1,NULL),
(80,'furnace.dataport','Data Access Port',77,'NONE',1,'10',NULL,1,NULL),
(81,'furnace.port_speed','Data Access Port Speed',77,'9600',1,'10',NULL,1,NULL),
(82,'furnace.hc_trans','Heat/Cool Transformer Setup',77,'0',3,'0::Same;;1::Different',NULL,1,'bps'),
(84,'furnace.bridge_rcrh','Bridge Rc Rh',77,'0',3,'0::No;;1::Yes',NULL,1,NULL),
(85,'furnace.cent_hum','Central Humidifier Control',77,'0',3,'0::Disabled;;1::Enabled',NULL,1,NULL),
(86,'furnace.max_on','Maximum ON Time',77,'3600',1,'5',NULL,1,'seconds'),
(93,'furnace.model','Furnace Model',77,'',1,'25',NULL,1,NULL),
(94,'fblower','Furnace Blower',0,NULL,NULL,NULL,NULL,1,NULL),
(95,'fblower.min_on','Minimum ON Time',94,'120',1,'5',NULL,1,'seconds'),
(96,'fblower.min_off','Minimum OFF Time',94,'60',1,'5',NULL,1,'seconds'),
(97,'fblower.max_on','Maximum ON Time',94,'0',1,'5',NULL,1,'seconds'),
(98,'fblower.heat_cycle','Heat Cycle Timer',94,'120',1,'5',NULL,1,'seconds'),
(99,'fblower.cool_cycle','Cooling Cycle Timer',94,'360',1,'5',NULL,1,'seconds'),
(100,'fblower.stat_pres','Static Pressure Threshold',94,'0',1,'5',NULL,1,'kpa'),
(101,'acheat','A/C & Heat Pump',0,NULL,NULL,NULL,NULL,1,NULL),
(102,'acheat.installed','Pump Installed',101,'0',3,'0::No;;1::Yes',NULL,1,NULL),
(103,'acheat.stages','Stages',101,'0',3,'0::Single Stage;;1::Dual Stage',NULL,1,NULL),
(104,'acheat.min_comp_on','Minimum Compressor ON Time',101,'0',1,'5',NULL,1,'seconds'),
(105,'acheat.min_comp_off','Minimum Compressor OFF Time',101,'0',1,'5',NULL,1,'seconds'),
(106,'acheat.max_comp_on','Maximum Compressor ON Time',101,'0',1,'5',NULL,1,'seconds'),
(107,'acheat.out_temp_cut','Outside Temperature Cutoff',101,'-5',1,'5',NULL,1,'&deg;C'),
(108,'acheat.ob_heat','O/B Heat Call',101,'0',3,'0::Floating (off);;1::Set to R (on)',NULL,1,NULL),
(109,'hrverv','HRV/ERV Control',0,NULL,NULL,NULL,NULL,1,NULL),
(110,'hrverv.installed','Installed',109,'0',3,'0::No;;1::Yes',NULL,1,NULL),
(111,'hrverv.relay_id','Relay ID',109,'6',3,'1::Relay #1;;2::Relay #2;;3::Relay #3;;4::Relay #4;;5::Relay #5;;6::Relay #6',NULL,1,NULL),
(112,'hrverv.sync','Synchronized With Furnace Blower',109,'0',3,'0::No;;1::Yes',NULL,1,NULL),
(113,'hrverv.min_on','Minimum ON Time',109,'120',1,'5',NULL,1,'seconds'),
(114,'hrverv.min_off','Minimum OFF Time',109,'60',1,'5',NULL,1,'seconds'),
(115,'hrverv.max_on','Maximum ON Time',109,'0',1,'5',NULL,1,'seconds'),
(116,'comfort','Comfort Level',0,NULL,NULL,NULL,NULL,1,NULL),
(117,'thermostat','Customer Thermostat',0,NULL,NULL,NULL,NULL,1,NULL),
(118,'thermostat.connected','Home Thermostat Connected',117,'1',3,'0::No;;1::Yes',NULL,1,NULL),
(119,'thermostat.type','Thermostat Type',117,'0',3,'0::Analog;;1::Smart','thermostat.connected::1',1,NULL),
(120,'system.regmode','New Remote Devices Registration Mode',74,'2',3,'0::Disabled;;1::AdHoc;;2::Manual',NULL,3,NULL),
(121,'system.reg_timeout','Opened registration timeout',74,'120',2,'4',NULL,1,NULL),
(1100,'thermostat.mode','Thermostat Mode',117,'1',3,'0::Cold only;;1::Auto mode;;2::Heat only','thermostat.connected::0',1,NULL),
(1102,'thermostat.master_sensor','Master Sensor Selection',116,NULL,6,'%%MASTER','thermostat.type::0',1,NULL),
(1179,'thermostat.maker','Thermostat Maker',117,'',1,'20','thermostat.type::0',1,NULL),
(1180,'thermostat.model','Thermostat Model',117,'',1,'20','thermostat.type::0',1,NULL),
(1188,'system.max_days','Keep Statistics Data in DB for days',74,'14',1,'5',NULL,3,NULL),
(1189,'system.max_storage','Maximum Storage Count Reach Actions',74,'0',3,'0::Delete oldest records;;1::Stop collecting stats',NULL,3,NULL),
(1191,'furnace.ret_t_probes','Return Duct Temperature Probes Installed',77,'1',3,'0::No;;1::Yes',NULL,1,NULL),
(1192,'furnace.ret_t_probe_use','Temperature probe to use',77,'4',6,'%%PTLIST','furnace.ret_t_probes::1',1,NULL),
(1193,'furnace.sup_t_probes','Supply Duct Temperature Probes Installed',77,'1',3,'0::No;;1::Yes',NULL,1,NULL),
(1194,'furnace.sup_t_probe_use','Temperature probe to use',77,'21',6,'%%PTLIST','furnace.sup_t_probes::1',1,NULL),
(1195,'furnace.t1_up','Supply Duct Temperature Threshold Upper Limit',77,'28',1,'5',NULL,1,'&deg;C'),
(1196,'furnace.t1_low','Supply Duct Temperature Threshold Lower Limit',77,'16',1,'5',NULL,1,'&deg;C'),
(1197,'furnace.t2_up','Return Duct Temperature Threshold Upper Limit',77,'26',1,'5',NULL,1,'&deg;C'),
(1198,'furnace.t2_low','Return Duct Temperature Threshold Lower Limit',77,'16',1,'5',NULL,1,'&deg;C'),
(1199,'furnace.sensor_poll','Smart Controller Onboard Sensors Polling Period',77,'60',1,'5',NULL,1,'seconds'),
(1200,'furnace.house_vents','Total number of house vents',77,'0',1,'3',NULL,1,' '),
(1201,'furnace.rise_low_thr','Temperature rise low threshold',77,'35',1,'3',NULL,1,'&deg;C'),
(1202,'furnace.rise_high_thr','Temperature rise high threshold',77,'75',1,'3',NULL,1,'&deg;C'),
(1203,'furnace.btus','BTUs',77,'0',1,'3',NULL,1,NULL),
(1210,'furnace.mode','Operating Mode',77,'0',3,'0::Bypass;;1::RetroSAVE',NULL,1,NULL),
(2223,'retrosave','RetroSAVE Operational Parameters',0,NULL,NULL,NULL,NULL,3,NULL),
(2224,'retrosave.away_mode','Away mode',2223,'0',4,'0::Disabled;;1::Enabled',NULL,3,NULL),
(2225,'retrosave.away_period','Set Away mode after period',2223,'24',1,'5',NULL,3,'hours'),
(2227,'retrosave.comfort_t','Comfort temperature adjustment',2223,'1',1,'3',NULL,3,NULL),
(2228,'retrosave.comfort_h','Comfort humidity adjustment',2223,'0',1,'3',NULL,3,NULL),
(2232,'acheat.dec_low_thr','Temperature decline low threshold',101,'17',1,'3',NULL,1,'&deg;C'),
(2233,'acheat.dec_high_thr','Temperature decline high threshold',101,'20',1,'3',NULL,1,'&deg;C'),
(3150,'comfort.co2_present','CO2 Sensor Present',116,'1',3,'0::No;;1::Yes',NULL,1,NULL),
(3151,'comfort.co_present','CO Sensor Present',116,'1',3,'0::No;;1::Yes',NULL,1,NULL),
(3166,'comfort.co2_up','CO2 Upper Limit',116,'1000',1,'5',NULL,1,'ppm'),
(3167,'comfort.co_up','CO Upper Limit',116,'5',1,'5',NULL,1,'ppm'),
(3171,'comfort.min_hum','Humidity Minimum Acceptable Level',116,'30',1,'5',NULL,1,'%'),
(3172,'comfort.max_hum','Humidity Maximum Acceptable Level',116,'60',1,'5',NULL,1,'%'),
(3173,'comfort.t_occ_win','Default Winter Occupied Temperature',116,'21',1,'5',NULL,1,'&deg;C'),
(3174,'comfort.t_occ_sum','Default Summer Occupied Temperature',116,'24',1,'5',NULL,1,'&deg;C'),
(3175,'comfort.slider_def','Default Slider Settings',116,'2',3,'0::Max Comfort;;2::Balanced;;4::Max Saving',NULL,1,NULL),
(3188,'comfort.circ_on','Circulation Cycle ON Time',116,'300',1,'5',NULL,1,'seconds'),
(3189,'comfort.circ_off','Circulation Cycle OFF Time',116,'25',1,'5',NULL,1,'minutes'),
(3210,'fblower.cfm','CFM',94,'0',1,'3',NULL,1,NULL),
(3211,'acheat.ton','Ton',101,'1',3,'1::1;;2::2;;3::3;;4::4;;5::5',NULL,1,NULL),
(3212,'system.testrefresh','Sensors test page refresh interval',74,'0',1,'3',NULL,1,NULL),
(3213,'thermostat.smart_model','Smart Thermostat Maker and Model',117,'1',3,'0::Other;;1::nest','thermostat.type::1',1,NULL),
(3214,'thermostat.cots_nest','Nest Thermostat Status',117,NULL,6,'%%NEST','thermostat.smart_model::1',1,NULL),
(3215,'thermostat.nest_clientid','nest Client ID',117,'',1,'40','thermostat.smart_model::1',1,NULL),
(3216,'thermostat.nest_secret','nest Client secret',117,'',1,'40','thermostat.smart_model::1',1,NULL),
(3217,'thermostat.nest_pincode','nest Pincode',117,'',1,'10','thermostat.smart_model::1',1,NULL),
(3218,'thermostat.nest_token','nest Security token (readonly)',117,'',2,'40','thermostat.smart_model::1',1,NULL),
(3292,'thermostat.target_t','Thermostat Target Temperature',117,'18',1,'5','thermostat.connected::0',1,'&deg;C'),
(3293,'thermostat.target_h','Thermostat Target Humidity',117,'52',1,'5','thermostat.connected::0',1,'%'),
(3294,'thermostat.fan_mode','Fan Mode',117,'1',3,'0::Auto;;1::ON','thermostat.connected::0',1,NULL);

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_hvac` AFTER INSERT ON `hvac`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_hvac IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'hvac'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_hvac` AFTER UPDATE ON `hvac`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_hvac IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'hvac';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_hvac` AFTER DELETE ON `hvac`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_hvac IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'hvac';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `irdata`;
CREATE TABLE `irdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device` varchar(255) DEFAULT NULL,
  `command` varchar(255) DEFAULT NULL,
  `parameters` varchar(255) DEFAULT NULL,
  `sequence` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_irdata` AFTER INSERT ON `irdata`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_irdata IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'irdata'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_irdata` AFTER UPDATE ON `irdata`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_irdata IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'irdata';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_irdata` AFTER DELETE ON `irdata`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_irdata IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'irdata';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `occupancy`;
CREATE TABLE `occupancy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` datetime DEFAULT NULL,
  `zone_id` int(11) DEFAULT NULL,
  `device_id` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_occupancy` AFTER INSERT ON `occupancy`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_occupancy IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'occupancy'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_occupancy` AFTER UPDATE ON `occupancy`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_occupancy IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'occupancy';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_occupancy` AFTER DELETE ON `occupancy`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_occupancy IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'occupancy';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `networks`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `networks` VALUES
(1,'8.8.8.8','8.8.4.4','cloud.ase-energy.ca','smartcloud.local','RetroSAVE',10,'retrosave',0,1,'192.168.2.113','192.168.2.1','255.255.255.0','192.168.1.1','','','129.6.15.30','96.226.242.9',0,'','openweathermap.org','',0);

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_networks` AFTER INSERT ON `networks`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_networks IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'networks'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_networks` AFTER UPDATE ON `networks`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_networks IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'networks';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_networks` AFTER DELETE ON `networks`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_networks IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'networks';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `severity` smallint(6) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_notifications` AFTER INSERT ON `notifications`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_notifications IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'notifications'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_notifications` AFTER UPDATE ON `notifications`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_notifications IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'notifications';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_notifications` AFTER DELETE ON `notifications`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_notifications IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'notifications';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `paramflapdyn`;
CREATE TABLE `paramflapdyn` (
  `device_id` int(11) NOT NULL,
  `position` int(11) DEFAULT NULL,
  `temperature` double(15,3) DEFAULT NULL,
  `airflow` double(15,3) DEFAULT NULL,
  `dimmer` int(11) DEFAULT NULL,
  PRIMARY KEY (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_paramflapdyn` AFTER INSERT ON `paramflapdyn`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_paramflapdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramflapdyn'; 						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_paramflapdyn` AFTER UPDATE ON `paramflapdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_paramflapdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramflapdyn';						SET @pk_d_old = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_paramflapdyn` AFTER DELETE ON `paramflapdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_paramflapdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramflapdyn';						SET @pk_d = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `paramgassensordyn`;
CREATE TABLE `paramgassensordyn` (
  `device_id` int(11) NOT NULL,
  `pir` int(11) DEFAULT NULL,
  `co2_ppm` int(11) DEFAULT NULL,
  `co_ppm` int(11) DEFAULT NULL,
  `temperature1` float(9,3) DEFAULT NULL,
  `temperature2` float(9,3) DEFAULT NULL,
  PRIMARY KEY (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_paramgassensordyn` AFTER INSERT ON `paramgassensordyn`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_paramgassensordyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramgassensordyn'; 						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_paramgassensordyn` AFTER UPDATE ON `paramgassensordyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_paramgassensordyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramgassensordyn';						SET @pk_d_old = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_paramgassensordyn` AFTER DELETE ON `paramgassensordyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_paramgassensordyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramgassensordyn';						SET @pk_d = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `paramsensordyn`;
CREATE TABLE `paramsensordyn` (
  `device_id` int(11) NOT NULL,
  `light` double DEFAULT NULL,
  `temperature` double DEFAULT NULL,
  `humidity` double DEFAULT NULL,
  `motion` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_paramsensordyn` AFTER INSERT ON `paramsensordyn`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_paramsensordyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramsensordyn'; 						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_paramsensordyn` AFTER UPDATE ON `paramsensordyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_paramsensordyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramsensordyn';						SET @pk_d_old = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_paramsensordyn` AFTER DELETE ON `paramsensordyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_paramsensordyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'paramsensordyn';						SET @pk_d = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `registrations`;
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

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_registrations` AFTER INSERT ON `registrations`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_registrations IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'registrations'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DROP TRIGGER IF EXISTS `a_u_registrations`;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_registrations` AFTER DELETE ON `registrations`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_registrations IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'registrations';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `relays`;
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

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_relays` AFTER INSERT ON `relays`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_relays IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'relays'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_relays` AFTER UPDATE ON `relays`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_relays IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'relays';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_relays` AFTER DELETE ON `relays`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_relays IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'relays';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;

DROP TRIGGER IF EXISTS `relays_commands`;


DROP TABLE IF EXISTS `remotecontrol`;
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

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_remotecontrol` AFTER INSERT ON `remotecontrol`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_remotecontrol IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'remotecontrol'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_remotecontrol` AFTER UPDATE ON `remotecontrol`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_remotecontrol IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'remotecontrol';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_remotecontrol` AFTER DELETE ON `remotecontrol`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_remotecontrol IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'remotecontrol';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `sensorsdyn`;
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

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_sensorsdyn` AFTER INSERT ON `sensorsdyn`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_sensorsdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'sensorsdyn'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_sensorsdyn` AFTER UPDATE ON `sensorsdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_sensorsdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'sensorsdyn';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_sensorsdyn` AFTER DELETE ON `sensorsdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_sensorsdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'sensorsdyn';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `sessions`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `smartdevices`;
CREATE TABLE `smartdevices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` datetime DEFAULT NULL,
  `type_` int(11) DEFAULT NULL,
  `interface` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  `period` int(11) DEFAULT 40,
  `lowthres` int(11) DEFAULT 0,
  `highthres` int(11) DEFAULT 0,
  `address` varchar(50) DEFAULT NULL,
  `relay` int(11) DEFAULT NULL,
  `speed` int(11) DEFAULT '0',
  `alarm` int(11) NOT NULL DEFAULT '0',
  `severity` int(11) DEFAULT NULL,
  `maker` varchar(200) DEFAULT NULL,
  `model` varchar(200) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `smartdevices` VALUES 
(1,'2014-11-25 16:50:46',1,0,1,40,0,0,'1',0,0,0,0,'ASE','RetroSAVE Smart Controller','ADC1 CO sensor'),
(2,'2014-11-25 16:51:04',2,0,0,40,0,0,'2',0,0,0,0,'ASE','RetroSAVE Smart Controller','ADC2'),
(3,'2014-11-25 16:51:19',2,0,0,40,0,0,'3',0,0,0,0,'ASE','RetroSAVE Smart Controller','ADC3'),
(4,'2014-11-25 16:51:39',2,0,0,40,0,0,'4',0,0,0,0,'ASE','RetroSAVE Smart Controller','ADC4'),
(5,'2014-11-25 16:52:12',2,1,1,40,0,0,'64',0,0,0,0,'ASE','RetroSAVE Smart Controller','HTU21 T sensor'),
(6,'2014-11-25 16:52:32',3,1,1,40,0,0,'64',0,0,0,0,'ASE','RetroSAVE Smart Controller','HTU21 H sensor');

DROP TRIGGER IF EXISTS `a_i_smartdevices`;
DELIMITER ;;
CREATE 
	DEFINER = 'root'@'localhost' TRIGGER `a_i_smartdevices` AFTER INSERT ON `smartdevices`
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
END;;
DELIMITER ;

DROP TRIGGER IF EXISTS `a_u_smartdevices`;
DELIMITER ;;
CREATE
	DEFINER = 'root'@'localhost' TRIGGER `a_u_smartdevices` AFTER UPDATE ON `smartdevices`
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
END;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_smartdevices` AFTER DELETE ON `smartdevices`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartdevices IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartdevices';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `smartplugsdyn`;
CREATE TABLE `smartplugsdyn` (
  `device_id` int(11) NOT NULL,
  `state` int(11) DEFAULT NULL,
  `current` int(11) DEFAULT NULL,
  UNIQUE KEY `device_id` (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_smartplugsdyn` AFTER INSERT ON `smartplugsdyn`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_smartplugsdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartplugsdyn'; 						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_smartplugsdyn` AFTER UPDATE ON `smartplugsdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartplugsdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartplugsdyn';						SET @pk_d_old = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @pk_d = CONCAT('<device_id>',NEW.`device_id`,'</device_id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_smartplugsdyn` AFTER DELETE ON `smartplugsdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartplugsdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartplugsdyn';						SET @pk_d = CONCAT('<device_id>',OLD.`device_id`,'</device_id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `smartsensors`;
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

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_smartsensors` AFTER INSERT ON `smartsensors`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_smartsensors IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartsensors'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_smartsensors` AFTER UPDATE ON `smartsensors`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartsensors IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartsensors';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_smartsensors` AFTER DELETE ON `smartsensors`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartsensors IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartsensors';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `smartsensorsraw`;
CREATE TABLE `smartsensorsraw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` datetime DEFAULT NULL,
  `source` int(11) NOT NULL DEFAULT '0',
  `type_` int(11) NOT NULL DEFAULT '0',
  `address` varchar(64) DEFAULT NULL,
  `value_` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_smartsensorsraw` AFTER INSERT ON `smartsensorsraw`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_smartsensorsraw IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartsensorsraw'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_smartsensorsraw` AFTER UPDATE ON `smartsensorsraw`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartsensorsraw IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartsensorsraw';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_smartsensorsraw` AFTER DELETE ON `smartsensorsraw`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartsensorsraw IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartsensorsraw';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `smartstatus`;
CREATE TABLE `smartstatus` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `updated` datetime NOT NULL,
  `group_` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `value` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `smartstatus` VALUES
(1,NOW(),'health','cpu',''),
(2,NOW(),'health','ram',''),
(3,NOW(),'health','disk',''),
(4,NOW(),'health','uptime',''),
(5,NOW(),'network','ip_main',''),
(6,NOW(),'network','gateway',''),
(7,NOW(),'network','ip_wan',''),
(8,NOW(),'network','cloud',''),
(9,NOW(),'network','ip_cwan',NULL),
(10,NOW(),'network','gw_cwan',NULL),
(11,NOW(),'network','list_wan',''),
(12,NOW(),'network','dns',''),
(13,NOW(),'weather','location',''),
(14,NOW(),'weather','temp',''),
(15,NOW(),'weather','humid',''),
(16,NOW(),'weather','wind',''),
(17,NOW(),'weather','air_pres',''),
(18,NOW(),'weather','cond',''),
(19,NOW(),'network','mac','');

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_smartstatus` AFTER INSERT ON `smartstatus`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_smartstatus IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartstatus'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_smartstatus` AFTER UPDATE ON `smartstatus`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartstatus IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartstatus';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_smartstatus` AFTER DELETE ON `smartstatus`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_smartstatus IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'smartstatus';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `statistics`;
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

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_statistics` AFTER INSERT ON `statistics`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_statistics IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'statistics'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_statistics` AFTER UPDATE ON `statistics`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_statistics IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'statistics';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_statistics` AFTER DELETE ON `statistics`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_statistics IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'statistics';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;

DROP TABLE IF EXISTS `temperaturebreakout`;
CREATE TABLE `temperaturebreakout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `temperature_profile_id` int(11) NOT NULL,
  `dayofweek` int(11) NOT NULL,
  `timeframe` int(11) NOT NULL,
  `temperature` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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


DROP TABLE IF EXISTS `temperatureprofile`;
CREATE TABLE `temperatureprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `temperature` double NOT NULL,
  `humidity` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `temperatureprofile` VALUES
(1,'Default',20,60);

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_temperatureprofile` AFTER INSERT ON `temperatureprofile`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_temperatureprofile IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'temperatureprofile'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_temperatureprofile` AFTER UPDATE ON `temperatureprofile`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_temperatureprofile IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'temperatureprofile';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_temperatureprofile` AFTER DELETE ON `temperatureprofile`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_temperatureprofile IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'temperatureprofile';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `thermostat`;
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
  `avg_t` decimal(6, 2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_thermostat` AFTER INSERT ON `thermostat`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_thermostat IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'thermostat'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_thermostat` AFTER UPDATE ON `thermostat`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_thermostat IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'thermostat';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_thermostat` AFTER DELETE ON `thermostat`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_thermostat IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'thermostat';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `timers`;
CREATE TABLE `timers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` datetime DEFAULT NULL,
  `expired` datetime DEFAULT NULL,
  `type_` int(11) DEFAULT NULL,
  `zone_id` int(11) DEFAULT NULL,
  `device_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MEMORY;


DROP TABLE IF EXISTS `ui_menu`;
CREATE TABLE `ui_menu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `menu` varchar(30) DEFAULT NULL,
  `submenu` varchar(20) NOT NULL,
  `description` varchar(200) NOT NULL,
  `access` tinyint(4) NOT NULL DEFAULT '0',
  `level` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `ui_menu` VALUES
(1,'status','relays','Status',0,0),
(2,'status','relays','Local Relays',0,1),
(3,'status','onboard','Local Sensors',0,1),
(4,'status','indoor','Indoor Sensors',0,1),
(5,'status','outdoor','Outdoor Sensors',0,1),
(6,'status','system','System Information',0,1),
(7,'networks','ip','Networks',0,0),
(8,'networks','ip','IP Network',0,1),
(9,'networks','zigbee','Local Zigbee',0,1),
(10,'networks','asemp','ASEMP Profile',0,1),
(11,'hvac','furnace','HVAC',0,0),
(12,'hvac','furnace','Furnace',0,1),
(13,'hvac','fblower','Furnace Blower',0,1),
(14,'hvac','acheat','A/C & Heat Pump',0,1),
(15,'hvac','hrverv','HRV/ERV Control',0,1),
(16,'hvac','comfort','Comfort Settings',0,1),
(17,'hvac','thermostat','Customer Thermostat Control',0,1),
(18,'smartgrid','peaksaver','Smart Grid',0,0),
(20,'zonedev','zones','RetroSAVE<br>Management',0,0),
(21,'events','events','Events<br>& Alarms',0,0),
(22,'userinfo','details','Customer<br>Settings',0,0),
(23,'userinfo','details','User Details',0,1),
(24,'userinfo','alarms','Alarms & Events',0,1),
(25,'userinfo','password','Password',0,1),
(26,'system','update','System<br>Maintenance',0,0),
(28,'system','update','Software Update',0,1),
(29,'system','db','Database Maintenance',0,1),
(32,'zonedev','zones','Zones',0,1),
(33,'zonedev','devices','Remote Devices',0,1),
(34,'zonedev','newdev','Add New Devices',0,1),
(39,'events','events','Alarms & Events Viewer',0,1),
(40,'events','alarms','RetroSAVE Alarms Management',0,1),
(41,'status','networks','Network Connections',0,1),
(43,'events','management','Networks Alarms Management',0,1),
(44,'smartgrid','peaksaver','PeakSaver',0,1),
(45,'smartgrid','smartmeter','SmartMeter',0,1),
(46,'reports','occupancy','Reports',0,0),
(47,'logout','logout','Logout',0,0),
(48,'reports','occupancy','Statistical Occupancy Stats',0,1),
(49,'reports','retrosave','RetroSAVE Runtime',0,1),
(50,'reports','charts','Charts',0,1),
(51,'reports','savings','Savings',0,1),
(52,'reports','runtime','HVAC Runtime',0,1),
(54,'status','zigbee','Zigbee',0,1),
(55,'reports','cots','Home Thermostat Stats',0,1),
(56,'zonedev','smartdevices','Local Sensors',0,1);

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_ui_menu` AFTER INSERT ON `ui_menu`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_ui_menu IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'ui_menu'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_ui_menu` AFTER UPDATE ON `ui_menu`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_ui_menu IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'ui_menu';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_ui_menu` AFTER DELETE ON `ui_menu`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_ui_menu IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'ui_menu';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `users`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `users` VALUES
(1,'aseuser','aseuser','','','','','','','','','1800-ASE-SAVE','','','support@ase-energy.ca',0,2,0,0),
(2,'aseadmin','aseadmin','','','','','Ottawa','','Canada','','1800-ASE-SAVE','','','support@ase-energy.ca',0,2,1,0);

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_users` AFTER INSERT ON `users`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_users IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'users'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_users` AFTER UPDATE ON `users`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_users IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'users';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_users` AFTER DELETE ON `users`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_users IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'users';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `zigbee`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `zigbee` VALUES
(1,13,0,1,'0000000000000000','0000',0,'','','','',0);

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_zigbee` AFTER INSERT ON `zigbee`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_zigbee IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_zigbee` AFTER UPDATE ON `zigbee`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zigbee IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_zigbee` AFTER DELETE ON `zigbee`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zigbee IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `zoneadvanced`;
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

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_zoneadvanced` AFTER INSERT ON `zoneadvanced`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_zoneadvanced IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zoneadvanced'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_zoneadvanced` AFTER UPDATE ON `zoneadvanced`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zoneadvanced IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zoneadvanced';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_zoneadvanced` AFTER DELETE ON `zoneadvanced`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zoneadvanced IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zoneadvanced';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `zones`;
CREATE TABLE `zones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `temperature_profile_id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `volume` double DEFAULT NULL,
  `sleep_area` int(11) NOT NULL DEFAULT '0',
  `level` int(11) DEFAULT 0,
  `orientation` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `temperature_profile_id` (`temperature_profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `zones` VALUES
(2,0,'Master zone',0,0,0,0),
(1,0,'Temporary zone',0,0,0,0);

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_zones` AFTER INSERT ON `zones`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_zones IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zones'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_zones` AFTER UPDATE ON `zones`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zones IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zones';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_zones` AFTER DELETE ON `zones`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zones IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zones';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `zonesdyn`;
CREATE TABLE `zonesdyn` (
  `zone_id` int(11) NOT NULL,
  `occupation` int(11) DEFAULT '0',
  `state` int(11) DEFAULT '0',
  `timer_on` int(11) DEFAULT '0',
  `timer_off` int(11) DEFAULT '0',
  `priority` int(11) DEFAULT '0',
  PRIMARY KEY (`zone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_zonesdyn` AFTER INSERT ON `zonesdyn`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_zonesdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zonesdyn'; 						SET @pk_d = CONCAT('<zone_id>',NEW.`zone_id`,'</zone_id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_zonesdyn` AFTER UPDATE ON `zonesdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zonesdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zonesdyn';						SET @pk_d_old = CONCAT('<zone_id>',OLD.`zone_id`,'</zone_id>');						SET @pk_d = CONCAT('<zone_id>',NEW.`zone_id`,'</zone_id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_zonesdyn` AFTER DELETE ON `zonesdyn`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zonesdyn IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zonesdyn';						SET @pk_d = CONCAT('<zone_id>',OLD.`zone_id`,'</zone_id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;

DROP TABLE IF EXISTS `zigbee_ase`;
CREATE TABLE `zigbee_ase` (
  id int(11) NOT NULL AUTO_INCREMENT,
  device_id int(11) DEFAULT NULL,
  profile_id int(11) DEFAULT NULL,
  joined datetime NOT NULL,
  updated datetime DEFAULT NULL,
  device_type int(11) NOT NULL DEFAULT 0,
  device_status tinyint(4) NOT NULL DEFAULT 0,
  device_state tinyint(4) NOT NULL DEFAULT 2,
  addr64 char(20) DEFAULT NULL,
  addr16 int(11) DEFAULT NULL,
  zigbee_hw int(11) DEFAULT NULL,
  zigbee_sw int(11) DEFAULT NULL,
  device_sw int(11) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_zigbee_ase` AFTER INSERT ON `zigbee_ase`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_zigbee_ase IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee_ase'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_zigbee_ase` AFTER UPDATE ON `zigbee_ase`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zigbee_ase IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee_ase';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_zigbee_ase` AFTER DELETE ON `zigbee_ase`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zigbee_ase IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee_ase';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `zigbee_ha`;
CREATE TABLE `zigbee_ha` (
  id int(11) NOT NULL AUTO_INCREMENT,
  device_id int(11) DEFAULT NULL,
  cluster_id int(11) DEFAULT NULL,
  endpoint_id int(11) DEFAULT NULL,
  profile_id int(11) DEFAULT NULL,
  joined datetime NOT NULL,
  updated datetime DEFAULT NULL,
  device_status int(11) DEFAULT NULL,
  addr64 char(20) DEFAULT NULL,
  addr16 int(11) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_zigbee_ha` AFTER INSERT ON `zigbee_ha`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_zigbee_ha IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee_ha'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_zigbee_ha` AFTER UPDATE ON `zigbee_ha`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zigbee_ha IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee_ha';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_zigbee_ha` AFTER DELETE ON `zigbee_ha`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_zigbee_ha IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'zigbee_ha';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;


DROP TABLE IF EXISTS `zigbee_commands`;
CREATE TABLE `zigbee_commands` (
  id int(11) NOT NULL AUTO_INCREMENT,
  device_id int(11) NOT NULL,
  command int(11) NOT NULL,
  updated datetime NOT NULL,
  return_code int(11) DEFAULT NULL,
  result_string varchar(255) DEFAULT NULL,
  return_value int(11) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



DROP TABLE IF EXISTS `cots_data`;
CREATE TABLE `cots_data` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cots_id` int(11) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `name_` varchar(50) DEFAULT NULL,
  `value_` varchar(100) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 PACK_KEYS=0;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_cots_data` AFTER INSERT ON `cots_data`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_cots_data IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'cots_data'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_u_cots_data` AFTER UPDATE ON `cots_data`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_cots_data IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'cots_data';						SET @pk_d_old = CONCAT('<id>',OLD.`id`,'</id>');						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>');						SET @rec_state = 2;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						IF @rs = 0 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d_old, @rec_state );						ELSE 						UPDATE `history_store` SET `timemark` = @time_mark, `pk_date_src` = @pk_d WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d_old;						END IF; END IF; END */;;
DELIMITER ;

DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_d_cots_data` AFTER DELETE ON `cots_data`						FOR EACH ROW BEGIN					IF (@DISABLE_TRIGGER_cots_data IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'cots_data';						SET @pk_d = CONCAT('<id>',OLD.`id`,'</id>');						SET @rec_state = 3;						SET @rs = 0;						SELECT `record_state` INTO @rs FROM `history_store` WHERE  `table_name` = @tbl_name AND `pk_date_src` = @pk_d;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						IF @rs <> 1 THEN 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`, `record_state` ) VALUES
(@time_mark, @tbl_name, @pk_d,@pk_d, @rec_state ); 						END IF; END IF; END */;;
DELIMITER ;

COMMIT;
