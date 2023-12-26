DROP TRIGGER IF EXISTS action_notify_MuxDemux;
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
