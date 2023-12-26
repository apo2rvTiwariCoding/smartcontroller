DROP TRIGGER IF EXISTS a_u_registrations;
DELIMITER ;;
CREATE 
	DEFINER = 'root'@'localhost'
TRIGGER smart2014.a_u_registrations
	AFTER UPDATE
	ON smart2014.registrations
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
END;;
DELIMITER ;
