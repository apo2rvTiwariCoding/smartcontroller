SET autocommit=0;

SET @DISABLE_TRIGGER_ui_menu=1;
INSERT INTO `ui_menu` VALUES 
(57,'system','datetime','Date & Time',0,1),
(58,'zonedev','sensorstest','Local Sensor Values',0,1),
(59,'system','advanced','Advanced',0,1),
(60,'zonedev','cluster','Cluster Command Page',0,1);
SET @DISABLE_TRIGGER_ui_menu=NULL;

DROP TABLE IF EXISTS `hvac_actions`;
CREATE TABLE `hvac_actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ref_table` varchar(200) DEFAULT NULL,
  `ref_id` int(11) DEFAULT NULL,
  `type_` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MEMORY;

DROP TRIGGER IF EXISTS `action_notify_HVAC`;
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

DROP TRIGGER IF EXISTS `action_notify_MuxDemux`;
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

DROP TRIGGER IF EXISTS `commands_actions`;
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

DROP TRIGGER IF EXISTS `zbcommands_actions`;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER zbcommands_actions
	AFTER INSERT
	ON zigbee_commands
	FOR EACH ROW
BEGIN
  SET @ref_table = 'zigbee_commands';
  SET @priority = 0;
  SET @rec_type = 0;
  INSERT INTO actions VALUES
(0, @ref_table, NEW.id, @rec_type, @priority);
END */;;
DELIMITER ;

DROP TRIGGER IF EXISTS `a_i_bypass`;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_bypass` AFTER INSERT ON `bypass`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_bypass IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'bypass'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	
INSERT INTO hvac_actions VALUES (NULL, 'bypass', NEW.id, 6, 0);
END */;;
DELIMITER ;

DROP TRIGGER IF EXISTS `a_i_alarms_networks`;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_alarms_networks` AFTER INSERT ON `alarms_networks`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_alarms_networks IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_networks'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	
INSERT INTO hvac_actions VALUES (NULL, 'alarms_networks', NEW.id, 5, 0);
END */;;
DELIMITER ;

DROP TRIGGER IF EXISTS `a_i_alarms_pressure`;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_alarms_pressure` AFTER INSERT ON `alarms_pressure`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_alarms_pressure IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_pressure'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	
INSERT INTO hvac_actions VALUES (NULL, 'alarms_pressure', NEW.id, 5, 0);
END */;;
DELIMITER ;

DROP TRIGGER IF EXISTS `a_i_alarms_retrosave`;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_alarms_retrosave` AFTER INSERT ON `alarms_retrosave`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_alarms_retrosave IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_retrosave'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	
INSERT INTO hvac_actions VALUES (NULL, 'alarms_retrosave', NEW.id, 5, 0);
END */;;
DELIMITER ;

DROP TRIGGER IF EXISTS `a_i_alarms_system`;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_alarms_system` AFTER INSERT ON `alarms_system`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_alarms_system IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_system'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	
INSERT INTO hvac_actions VALUES (NULL, 'alarms_system', NEW.id, 5, 0);
END */;;
DELIMITER ;

DROP TRIGGER IF EXISTS `a_i_alarms_zigbee`;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_alarms_zigbee` AFTER INSERT ON `alarms_zigbee`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_alarms_zigbee IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'alarms_zigbee'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	
INSERT INTO hvac_actions VALUES (NULL, 'alarms_zigbee', NEW.id, 5, 0);
END */;;
DELIMITER ;

DROP TRIGGER IF EXISTS `a_i_registrations`;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `a_i_registrations` AFTER INSERT ON `registrations`						FOR EACH ROW BEGIN 					IF (@DISABLE_TRIGGER_registrations IS NULL) THEN	SET @time_mark = DATE_ADD(NOW(), INTERVAL 0 SECOND); 						SET @tbl_name = 'registrations'; 						SET @pk_d = CONCAT('<id>',NEW.`id`,'</id>'); 						SET @rec_state = 1;						DELETE FROM `history_store` WHERE `table_name` = @tbl_name AND `pk_date_src` = @pk_d; 						INSERT INTO `history_store`( `timemark`, `table_name`, `pk_date_src`,`pk_date_dest`,`record_state` ) 						VALUES
(@time_mark, @tbl_name, @pk_d, @pk_d, @rec_state); 					END IF;	
INSERT INTO hvac_actions VALUES (NULL, 'registrations', NEW.id, 5, 0);
END */;;
DELIMITER ;

DROP TRIGGER IF EXISTS `a_u_registrations`;
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

DROP TRIGGER IF EXISTS `a_i_relays`;
DELIMITER ;;
CREATE 
	DEFINER = 'root'@'localhost' TRIGGER `a_i_relays` AFTER INSERT ON `relays`
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
END;;
DELIMITER ;

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
END;;
DELIMITER ;


DROP TRIGGER IF EXISTS `a_i_zigbee_ase`;
DELIMITER ;;
CREATE 
	DEFINER = 'root'@'localhost' TRIGGER `a_i_zigbee_ase` AFTER INSERT ON `zigbee_ase`
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
END;;
DELIMITER ;


DROP TRIGGER IF EXISTS `a_i_zigbee_ha`;
DELIMITER ;;
CREATE 
	DEFINER = 'root'@'localhost' TRIGGER `a_i_zigbee_ha` AFTER INSERT ON `zigbee_ha`
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
END;;
DELIMITER ;

COMMIT;
