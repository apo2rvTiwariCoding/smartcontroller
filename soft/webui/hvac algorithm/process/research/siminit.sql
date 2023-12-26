-- sim_emu	- storing simulation startup values

DROP TABLE IF EXISTS `sim_emu`;
CREATE TABLE `sim_emu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` int(11) NOT NULL,
  `status_in` int(11) NOT NULL,
  `status_out` int(11) NOT NULL,
  `light_in` float(9,3) NOT NULL,
  `light_out` float(9,3) NOT NULL,
  `temperature_in` float(9,3) NOT NULL,
  `temperature_out` float(9,3) NOT NULL,
  `humidity_in` float(9,3) NOT NULL,
  `humidity_out` float(9,3) NOT NULL,
  `device_type` int(11) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `device_id` (`device_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- basic data for zone simulation

DROP TABLE IF EXISTS `sim_zone`;
CREATE TABLE `sim_zone` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `delay` int(11) NOT NULL,
  `duration` int(11) NOT NULL,
  `breakout` int(11) NOT NULL DEFAULT '1',
  `weekday` int(11) NOT NULL,
  `daytime` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `outdoor_in` decimal(6,1) NOT NULL DEFAULT '20.0',
  `outdoor_out` decimal(6,1) NOT NULL DEFAULT '20.0',
  `description` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- advanced data for zone simulation

DROP TABLE IF EXISTS `sim_zoneadv`;
CREATE TABLE `sim_zoneadv` (
  `zone_id` int(11) NOT NULL DEFAULT '0',
  `gain` decimal(6,1) NOT NULL DEFAULT '0.0',
  `loose` decimal(6,1) NOT NULL DEFAULT '0.0',
  `tmin` decimal(6,1) NOT NULL DEFAULT '0.0',
  `tmax` decimal(6,1) NOT NULL DEFAULT '0.0',
  PRIMARY KEY (`zone_id`),
  UNIQUE KEY `zone_id` (`zone_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- table to pass data from simulation to ASE processing

DROP TABLE IF EXISTS `sim_triggers`;
CREATE TABLE `sim_triggers` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `start` datetime DEFAULT NULL,
  `type_` int(11) DEFAULT NULL,
  `value_` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
