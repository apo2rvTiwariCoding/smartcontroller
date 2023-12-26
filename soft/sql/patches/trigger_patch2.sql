DROP TRIGGER IF EXISTS commands_actions;
DELIMITER ;;
CREATE 
	DEFINER = 'root'@'localhost'
TRIGGER smart2014.commands_actions
	AFTER INSERT
	ON smart2014.commands
	FOR EACH ROW
BEGIN
  SET @ref_table = 'commands';
  SET @priority = 0;
  SET @rec_type = 0;
  INSERT INTO actions VALUES (0, @ref_table, NEW.id, @rec_type, @priority);
END;;
DELIMITER ;
