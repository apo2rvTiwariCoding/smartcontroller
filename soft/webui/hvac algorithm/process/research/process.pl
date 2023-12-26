#!c:/perl/bin/perl.exe
#!c:/xampp/perl/bin/perl.exe
#!/usr/bin/perl

use DBI;
use POSIX;
use strict;

# read config

my $debug = "";
my $msgtxt = "";
my $selfpath = $ENV{'PATH_TRANSLATED'};
$selfpath =~ s/\\[^\\]*$/\\/;
if ($selfpath eq "") {
	$selfpath = $ENV{'SCRIPT_FILENAME'};
	$selfpath =~ s/\/[^\/]*$/\//;
}
my %config = ();
my $confile = $selfpath."settings.cnf";
if (-e $confile) {
	open(INF,$confile);
	while(<INF>) {
		my $inline = $_;
		chomp($inline);
		if ($inline =~ m/^[a-zA-Z]+/) {
			my ($name,$value) = split(/\=/,$inline);
			$name =~ s/^[\s\t]*//;
			$value =~ s/^[\s\t]*//;
			$name =~ s/[\s\t]*$//;
			$value =~ s/[\s\t]*$//;
			$config{lc($name)} = $value;
		}
	}
	close(INF);
}
my $version = (exists $config{version})?$config{version}:"13.11.29.18";
my $sysid = (exists $config{sysid})?$config{sysid}:0;			# hardlocked system ID here
my $logfile = (exists $config{logfile})?$config{logfile}:"process.log";
my $logonly = (exists $config{logonly})?$config{logonly}:0;

# connect to mysql

my $dsn = 'DBI:mysql:'.$config{dbname}.":".$config{dbhost};
my $db_user_name = $config{dbuser};
my $db_password = $config{dbpass};
my $db = DBI->connect($dsn, $db_user_name, $db_password);
$db->do("SET SQL_MODE = \"NO_AUTO_VALUE_ON_ZERO\";");			# small fix to allow 0 values for autoincrement

# tables definition

my $dbpref = "";		# db prefix to run on cloud server, empty for local run
my ($tabstatistics, $tabzoneadvanced, $tabtemperaturebreakout, $tabtemperatureprofile, $tabzones, $tabdevices, $tabdeviceadvanced, $tabcontrol, $tabhvac, $tabevents, $tabsettings) = ($dbpref."statistics", $dbpref."zoneadvanced", $dbpref."temperaturebreakout", $dbpref."temperatureprofile", $dbpref."zones", $dbpref."devices", $dbpref."deviceadvanced", $dbpref."control", $dbpref."hvac", $dbpref."events", $dbpref."settings");
my ($tabzonesdyn, $tabdevicesdyn, $tabparamsensordyn, $tabparamflapdyn) = ($dbpref."zonesdyn", $dbpref."devicesdyn", $dbpref."paramsensordyn", $dbpref."paramflapdyn");
my ($tabsimtriggers) = ($dbpref."sim_triggers");		# table used for simulation only!

# processing infinite loop

prdate("Starting ASE Processes version $version");
my $isdata = 1;
my $break = 1;		# default time breakout = 1 minute
my $debug = "";
my %HVAC = ();
my %settings = ();
while ($isdata) {
	my ($trid, $trstart, $trtype, $trvalue) = $db->selectrow_array("SELECT id,UNIX_TIMESTAMP(start),type_,value_ FROM $tabsimtriggers ORDER BY id ASC LIMIT 1");	# parallel processing
	if (($trid > 0) && ($trstart > 0)) {
		$db->do("DELETE FROM $tabsimtriggers WHERE id = $trid");
		if ($trtype == 0) {		# end processing
			$isdata = 0;
			prdate("Exit by zero event");
		} elsif ($trtype == 1) {	# set time breakout
			$break = $trvalue;
		} elsif ($trtype == 2) {	# reserved
		} elsif ($trtype == 3) {	# single event processing with given datatime and sim ID
			{
				my $all = $db->selectall_arrayref("SELECT option_,value_ FROM $tabhvac WHERE submenu > 0");
				foreach my $row (@$all) {
					my ($opt, $val) = @$row;
					$HVAC{$opt} = $val;				# read HVAC config
				}
			}
			{
				my $all = $db->selectall_arrayref("SELECT description,value_ FROM $tabsettings");
				foreach my $row (@$all) {
					my ($opt, $val) = @$row;
					$settings{$opt} = $val;				# read global settings
				}
			}
			unless ($HVAC{"installer.allownew"} == 1) {
				$debug .= ase($trstart, $trvalue, $break);	# run processing
				if ($debug ne "") {
					prdate("$debug");
					$debug = "";
				} else {
					prdate(".");
				}
			}
		}
	} else {
		prdate("waiting for data");
		sleep(1);
	}
}

# endofworld

$db->disconnect;
exit;

# ase processes

sub ase {
	my $acurmin = $_[0];
	my $aresim = $_[1];
	my $abreak = $_[2];
	my $debug = "";
	my $hystf = 0.5;		# T hysteresis. 0.5 for winter, -0.5 for summer
	my $hysth = 10;			# humidity hysteresis, 10% - experimental
	my $deltat = 3.5;		# deltaT for non-occupied zone

	# hardware inventory
	my %tprof = ();
	my %dzone = ();		# simplified device types and events types :
	my %dtype = ();		# 2 - THL sensor, 3 - gas/pir sensor
	my %donli = ();		# 10 - target TH event, 11 - occupancy event, 
	my %ozone = ();		# 0 - diff return, 1 - diff forward
	my $all = $db->selectall_arrayref("SELECT $tabdevices.id,$tabdevices.zone_id,$tabdevices.hardware_type,$tabdevices.device_type,$tabdevicesdyn.online,$tabzones.temperature_profile_id,$tabzonesdyn.occupation,$tabtemperatureprofile.temperature FROM $tabdevices LEFT JOIN $tabdevicesdyn ON $tabdevicesdyn.device_id = $tabdevices.id LEFT JOIN $tabzones ON $tabzones.id = $tabdevices.zone_id LEFT JOIN $tabtemperatureprofile ON $tabtemperatureprofile.id = $tabzones.temperature_profile_id LEFT JOIN $tabzonesdyn ON $tabzonesdyn.zone_id = $tabdevices.zone_id WHERE $tabdevices.zone_id > -1");
	foreach my $row (@$all) {
		my ($devid, $zoneid, $hwtype, $devtype, $devon, $ztpro, $toccu, $zttemp) = @$row;
		if ($zttemp == 0) {			# virtual zone. exclude from processing
		} else {				# normal zone
			$dzone{$devid} = $zoneid;
			$tprof{$zoneid} = $ztpro;
			$donli{$devid} = $devon;
			if ($devtype == 0) {			# sensor
				if ($hwtype == 1) {		# pir sensor
					$dtype{$devid} = 3;					
				} elsif (($hwtype == 2) || ($hwtype == 3) || ($hwtype == 4)) {		# THL sensor
					$dtype{$devid} = 2;
				}
			} elsif ($devtype == 1) {		# flap fw
				$dtype{$devid} = 1;
			} elsif ($devtype == 2) {		# flap ret
				$dtype{$devid} = 0;
			}
			$ozone{$zoneid} = $toccu;
		}
	}
	undef $all;

	# get deltaT correction factors
	my ($mazone) = $db->selectrow_array("SELECT id FROM $tabzones ORDER BY volume DESC LIMIT 1");				# main zone is one with bigger volume
	my (%dtcorf, %dtcort) = ((), ());
	my $maincorf = 0.3;			# default recovery factor
	my $all = $db->selectall_arrayref("SELECT zone_id, realvar1, realvar2 FROM $tabzoneadvanced WHERE type_ = 1");	# 1 - correction. var1 = recover factor, var2 = off timer
	foreach my $row (@$all) {
		my ($zoneid, $corf, $cort) = @$row;
		$dtcorf{$zoneid} = $corf;
		$dtcort{$zoneid} = $cort;
		if ($zoneid == $mazone) {
			$maincorf = $corf;
		}
	}
	undef $all;

	# comfort targets except virtual (outdoor) zone	
	my ($wday, $wtime, $simid, $cdate) = $db->selectrow_array("SELECT DATE_FORMAT(FROM_UNIXTIME($acurmin),'%w'), DATE_FORMAT(FROM_UNIXTIME($acurmin),'%k%i'), $aresim, FROM_UNIXTIME($acurmin)");
	my ($tartem, $tarhum) = (20, 55);
	my %ttem = ();
	my %thum = ();
	foreach my $zoneid (keys %tprof) {
		my $ztpro = $tprof{$zoneid};

		my $zdeltat = $deltat;				# apply deltaT correction factor
		if (exists $dtcort{$zoneid}) {
			if ($dtcorf{$zoneid} > 0) {
				if ($dtcorf{$zoneid} > $maincorf) {
					$zdeltat = $deltat * (1 - ($dtcorf{$zoneid} / $maincorf));
				} else {
					$zdeltat = $deltat * (1 + ($dtcorf{$zoneid} / $maincorf));
				}
			}
			if (($dtcort{$zoneid} > 0) && ($zoneid == $mazone)) {
				if ($maincorf < 0.3) {
					$zdeltat = $deltat - 0.5;
				} elsif ($maincorf > 0.3) {
					$zdeltat = $deltat + 0.5;
				}
			}
		}

		($tartem, $tarhum) = $db->selectrow_array("SELECT temperature, humidity FROM $tabtemperatureprofile WHERE id = $ztpro");
		my $wtime = (($wtime - (floor($wtime / 100) * 100)) >= 30)?(floor($wtime / 100) * 100 + 30):(floor($wtime / 100) * 100);
		my ($ttartem) = $db->selectrow_array("SELECT temperature FROM $tabtemperaturebreakout WHERE temperature_profile_id = $ztpro AND dayofweek = $wday AND timeframe = $wtime");
		$ttartem += 0;
		$tartem = ($ttartem > 0)?$ttartem:$tartem;
		unless ($settings{awaymode} == 0) {		# away mode T correction
			$tartem -= $zdeltat;
		} else {
			unless ($settings{zonetemp} == 0) {	# comfort zone T correction
				$tartem += $settings{zonetemp};
			}
		}
		$db->do("INSERT INTO $tabstatistics VALUES (NULL, '$cdate', $simid, $zoneid, -1, 10, $tartem, $tarhum, -1)");		# manually insert target changes
		$ttem{$zoneid} = $tartem;
		$thum{$zoneid} = $tarhum;

		# occupancy states
		my $noccu = $ozone{$zoneid};
		if ($ozone{$zoneid} == 0) {		# unoccupied zone
			my ($minpir, $maxpir, $cntpir) = $db->selectrow_array("SELECT MIN(L),MAX(L),COUNT(L) FROM $tabstatistics WHERE data BETWEEN FROM_UNIXTIME($acurmin - ($abreak * 3 * 60)) AND FROM_UNIXTIME($acurmin) AND zone_id = $zoneid AND type = 3");
			if (($minpir == 1) && ($maxpir == 1) && ($cntpir >= 3)) {
				$noccu = 1;
			}
		} elsif ($ozone{$zoneid} == 1) {	# occupied zone
			my ($minpir, $maxpir, $cntpir) = $db->selectrow_array("SELECT MIN(L),MAX(L),COUNT(L) FROM $tabstatistics WHERE data BETWEEN FROM_UNIXTIME($acurmin - ($abreak * 3 * 60)) AND FROM_UNIXTIME($acurmin) AND zone_id = $zoneid AND type = 3");
			if (($minpir == 0) && ($maxpir == 0) && ($cntpir >= 3)) {
				my ($co2cur, $co2dev) = (-500, 0);
				my $all = $db->selectall_arrayref("SELECT T FROM $tabstatistics WHERE data BETWEEN FROM_UNIXTIME($acurmin - ($abreak * 10 * 60)) AND FROM_UNIXTIME($acurmin) AND zone_id = $zoneid AND type = 3 ORDER BY id");
				foreach my $row (@$all) {
					my ($co2val) = @$row;
					$co2dev += ($co2cur == -500)?0:($co2val - $co2cur);		# CO2 increasing?
					$co2cur = $co2val;
				}
				undef $all;
				$noccu = ($co2dev > 0)?1:2;
			}
		} elsif ($ozone{$zoneid} == 2) {	# semi-occupied zone
			my ($minpir, $maxpir, $cntpir) = $db->selectrow_array("SELECT MIN(T),MAX(T),COUNT(T) FROM $tabstatistics WHERE data BETWEEN FROM_UNIXTIME($acurmin - ($abreak * 60 * 60)) AND FROM_UNIXTIME($acurmin) AND zone_id = $zoneid AND type = 11");
			if (($minpir == 2) && ($maxpir == 2) && ($cntpir >= 60)) {
				$noccu = 0;
			}
			($minpir, $maxpir, $cntpir) = $db->selectrow_array("SELECT MIN(L),MAX(L),COUNT(L) FROM $tabstatistics WHERE data BETWEEN FROM_UNIXTIME($acurmin - ($abreak * 3 * 60)) AND FROM_UNIXTIME($acurmin) AND zone_id = $zoneid AND type = 3");
			if (($minpir == 1) && ($maxpir == 1) && ($cntpir >= 3)) {
				$noccu = 1;
			}
		}
		unless ($ozone{$zoneid} == $noccu) {
			$db->do("UPDATE $tabzonesdyn SET occupation = $noccu WHERE zone_id = $zoneid");
		}
		$ozone{$zoneid} = $noccu;

		# cycles
		# 0 - none, 1 - ventilation, 2 - reheating, 3 - heat call, 4 - preheating?
		my ($cycst, $cycton, $cyctoff, $cycpr) = $db->selectrow_array("SELECT state, timer_on, timer_off, priority FROM $tabzonesdyn WHERE zone_id = $zoneid");
		my ($avgte, $avghu, $maxte, $cntte, $varte) = $db->selectrow_array("SELECT AVG(T),AVG(H),MAX(T),COUNT(T),VARIANCE(T) FROM $tabstatistics WHERE data BETWEEN FROM_UNIXTIME($acurmin - ($abreak * 1 * 60)) AND FROM_UNIXTIME($acurmin) AND zone_id = $zoneid AND type = 2");
		$cycst += 0;
		$avgte += 0;
		$maxte += 0;
		$cntte += 0;
		$cyctoff += 0;
		$cycton += 0;
		$cycpr += 0;
		if (($cntte > 2) && (($maxte - $avgte) * 0.6 > $varte)) {		# hysteresis correction
			$avgte += ($maxte - $avgte) * 0.3;
		}
		if ($cycst == 0) {
			if ($cycton > 0) {
				$cycton --;
			}
			if ($cyctoff == 0) {
				if ($ozone{$zoneid} == 1) {				# occupied
					if ($avgte < ($tartem - $hystf)) {
						($cycst, $cycton) = (2, 0);		# run reheat immediately
						$cyctoff = floor(10 / $abreak);		# 10 minutes = N cycles * heartbeat duration
						$cycpr = 2;				# lower number is lower priority
					} else {
						$cycst = 1;				# zone occupied and comfort - run ventilation
						my ($cofftm, $contm) = ($HVAC{"vent.occupiedon"}, $HVAC{"vent.occupiedoff"});
						$cyctoff = floor($cofftm / $abreak);		# run vent for NN min 
						$cycton = floor($contm / $abreak);		# each MM min
						$cycpr = 1;
					}
				} else {
					if ($avgte < ($tartem - ($hystf + $zdeltat))) {	# non or semi occ with deltaT
						($cycst, $cycton) = (2, 0);		# run reheat immediately
						$cyctoff = floor(10 / $abreak);		# 10 minutes = N cycles * heartbeat duration
						$cycpr = 1;				# lower number is lower priority
					} else {
						$cycst = 1;				# zone non-occupied and comfort - run ventilation
						my ($cofftm, $contm) = ($HVAC{"vent.unoccupiedon"}, $HVAC{"vent.unoccupiedoff"});
						$cyctoff = floor($cofftm / $abreak);		# run vent for NN min 
						$cycton = floor($contm / $abreak);		# each MM min
						$cycpr = 0;				# ventilation of non-occupied room have lowest priority
					}
				}
			} else {
				$cyctoff --;					# zone idle timer
			}
		} elsif ($cycst == 1) {
			if ($cycton == 0) {
				$cyctoff --;		# just decreasing fan timer
				if ($cyctoff == 0) {
					($cycst, $cyctoff, $cycton, $cycpr) = (0, 0, 1, 0);	# successful vent
				}
			} else {
				$cycton --;
			}
		} elsif ($cycst == 2) {
			my ($heatofft, $heatont) = ($HVAC{"ft.maxruntime"}, ($HVAC{"ft.maxruntime"} / 2));	# by default furnace must be turned off for 50% of heat time
			if ($cycton == 0) {
				$cyctoff --;
				if ($avgte < ($tartem + $hystf)) {
					if ($cyctoff < (floor(10 / $abreak) - 3)) {
						my ($temcur, $temdev) = (-500, 0);
						my $all = $db->selectall_arrayref("SELECT T FROM $tabstatistics WHERE data BETWEEN FROM_UNIXTIME($acurmin - ($abreak * 3 * 60)) AND FROM_UNIXTIME($acurmin) AND zone_id = $zoneid AND type = 2 ORDER BY id");
						foreach my $row (@$all) {
							my ($temval) = @$row;
							$temdev += ($temcur == -500)?0:($temval - $temcur);		# temperature increasing?
							$temcur = $temval;
						}
						undef $all;
						$cyctoff = ($temdev >= 0.5)?$cyctoff:0;	# T not increasing? timer zero
					}
					if ($cyctoff == 0) {
						if ($ozone{$zoneid} == 1) {
							($cycst, $cycton) = (3, 0);			# occupied and comf not satisfied - run heat now
							$cyctoff = floor($heatofft / $abreak);
							$cycpr = 1;
						} else {
							($cycst, $cyctoff, $cycton, $cycpr) = (0, 0, 1, 0);	# unsuccessful reheat
						}
					}
				} else {
					($cycst, $cyctoff, $cycton, $cycpr) = (0, 0, 0, 0);	# successful reheat
				}
			} else {
				$cycton --;
			}
		} elsif ($cycst == 3) {
			my ($heatofft, $heatont) = ($HVAC{"ft.maxruntime"}, ($HVAC{"ft.maxruntime"} / 2));	# by default furnace must be turned off for 50% of heat time
			my ($venoct, $veunoct) = ($HVAC{"vent.occupiedon"}, $HVAC{"vent.unoccupiedon"});	# vent cycles
			if ($cycton == 0) {
				$cyctoff --;
				if ($avgte < ($tartem - $hystf)) {
					if ($cyctoff == 0) {
						if ($ozone{$zoneid} == 1) {
							($cycst, $cyctoff, $cycton, $cycpr) = (3, floor($heatofft / $abreak), floor($heatont / $abreak), 2);		# unsuccessful heat and occupied
						} else {
							($cycst, $cyctoff, $cycton, $cycpr) = (1, floor($veunoct / $abreak), 0, 1);	# unsuccessful heat and unoccupied
						}
					}
				} else {
					($cycst, $cyctoff, $cycton, $cycpr) = (1, floor($venoct / $abreak), 0, 1);	# successful heat
				}
			} else {
				$cycton --;
			}
		}

		# CO2 and CO alarms
		my ($maxcd, $maxco) = $db->selectrow_array("SELECT MAX(T),MAX(H) FROM $tabstatistics WHERE data BETWEEN FROM_UNIXTIME($acurmin - ($abreak * 1 * 60)) AND FROM_UNIXTIME($acurmin) AND zone_id = $zoneid AND type = 3");
		if (($HVAC{"co2.upperlimit"} > 0) && ($maxcd > $HVAC{"co2.upperlimit"})) {
			my ($uncevt) = $db->selectrow_array("SELECT COUNT(*) FROM $tabevents WHERE started BETWEEN DATE_SUB(NOW(),INTERVAL 1 HOUR) AND NOW() AND status BETWEEN 0 AND 1 AND severity = 3 AND description like 'Dangerous CO2 %'");
			if ($uncevt == 0) {
				$db->do("INSERT INTO $tabevents VALUES (NULL, NOW(), NULL, 3, 0, 'Dangerous CO2 (carbon dioxide) Level $maxcd ppm!')");
			}
			($cycst, $cyctoff, $cycton, $cycpr) = (1, floor(30 / $abreak), 0, 3);	# immediate vent for 30 minutes, high priority
		}
		if (($HVAC{"co.upperlimit"} > 0) && ($maxco > $HVAC{"co.upperlimit"})) {
			my ($uncevt) = $db->selectrow_array("SELECT COUNT(*) FROM $tabevents WHERE started BETWEEN DATE_SUB(NOW(),INTERVAL 1 HOUR) AND NOW() AND status BETWEEN 0 AND 1 AND severity = 3 AND description like 'Dangerous CO %'");
			if ($uncevt == 0) {
				$db->do("INSERT INTO $tabevents VALUES (NULL, NOW(), NULL, 3, 0, 'Dangerous CO (carbon monoxide) Level $maxco ppm!')");
			}
			($cycst, $cyctoff, $cycton, $cycpr) = (1, floor(30 / $abreak), 0, 3);	# immediate vent for 30 minutes, high priority
		}

		# humidity
		if ($avghu < $HVAC{"hum.minlevel"}) {
			# will add humidifier event here
		} elsif ($avghu > $HVAC{"hum.maxlevel"}) {
			# will add humidifier event here
		} else {
			unless ((($tarhum - $hysth) < $avghu) && ($avghu < ($tarhum + $hysth))) {
				# humidity not satisfied event here
			}
		}

		# finishing
		$db->do("INSERT INTO $tabzonesdyn VALUES ($zoneid, 0, $cycst, $cycton, $cyctoff, $cycpr) ON DUPLICATE KEY UPDATE state = $cycst, timer_on = $cycton, timer_off = $cyctoff, priority = $cycpr");
		$db->do("INSERT INTO $tabstatistics VALUES (NULL, '$cdate', $simid, $zoneid, -1, 11, ".$ozone{$zoneid}.", $cycst, $cyctoff)");		# manually insert zone changes
	}

	# sort cycles by priority and do actions
	my ($relid, $rheat, $rcool, $rfan, $relon) = $db->selectrow_array("SELECT id,wrelay,yrelay,fan,online FROM $tabcontrol WHERE type_ BETWEEN 1 AND 2");	# yrelay = cool, wrelay - heat. use wireless (type 1) or wired (2) relay
	if ($relon) {
		my $all = $db->selectall_arrayref("SELECT zone_id, state, priority, timer_on FROM $tabzonesdyn ORDER BY priority,zone_id");
		foreach my $row (@$all) {
			my ($zoneid, $state, $prior, $timer) = @$row;
			my ($drid, $dfid, $dret, $dfor) = (-1, -1, -1, -1);
			foreach my $devid (keys %dzone) {
				if (($dtype{$devid} == 0) && ($dzone{$devid} == $zoneid)) {		# return diff
					$drid = $devid;
					my ($dret) = $db->selectrow_array("SELECT controll FROM $tabparamflapdyn WHERE device_id = $drid");
				} elsif (($dtype{$devid} == 1) && ($dzone{$devid} == $zoneid)) {	# forward diff
					$dfid = $devid;
					my ($dfor) = $db->selectrow_array("SELECT controll FROM $tabparamflapdyn WHERE device_id = $dfid");
				}
			}
			if ($state == 1) {		# vent
				$rfan = ($timer > 0)?0:1;
				$rheat = 0;
				$dret = 1;		# return opened
				$dfor = 1;		# forward opened
			} elsif ($state == 2) {		# preheat
				$rfan = 1;
				$rheat = 0;
				if ($ozone{$zoneid} == 1) {	# occupied
					$dret = 0;
					$dfor = 1;
				} else {
					$dret = 1;
					$dfor = 0;
				}
			} elsif ($state == 3) {		# heat
				$rfan = 1;
				$rheat = ($timer > 0)?0:1;
				$dret = 1;
				$dfor = 1;
			} else {
				if ($timer == 0) {
					($rfan, $rheat, $dret, $dfor) = (0, 0, 0, 0);
				} else {
					($rfan, $rheat) = (0, 0);
				}
			}
			unless ($drid == -1) {
				my $ifupd = $db->do("UPDATE $tabparamflapdyn SET controll = $dret WHERE device_id = $drid");
				if (defined ($ifupd)) {
					if ($ifupd > 0) {
						$db->do("INSERT INTO $tabstatistics VALUES (NULL, '$cdate', $simid, $zoneid, $drid, 0, $dret, -1, $state)");	# save system state in addition to diff state, only if state changed
					}
				}
			}
			unless ($dfid == -1) {
				my $ifupd = $db->do("UPDATE $tabparamflapdyn SET controll = $dfor WHERE device_id = $dfid");
				if (defined ($ifupd)) {
					if ($ifupd > 0) {	# save system state in addition to diff state, only if state changed
						$db->do("INSERT INTO $tabstatistics VALUES (NULL, '$cdate', $simid, $zoneid, $dfid, 1, $dfor, -1, $state)");
					}
				}
			}
		}
		undef $all;
		if ($settings{mode} eq "auto") {		# switch off heater and cooler in offline mode
			($rheat, $rcool) = 0;
		} elsif ($settings{mode} eq "heat") {
			$rcool = 0;
		} elsif ($settings{mode} eq "cool") {
			$rheat = 0;
		}
		$db->do("UPDATE $tabcontrol SET wrelay = ".($rheat + 0).", yrelay = ".($rcool + 0).", fan = $rfan WHERE id = $relid");				# yrelay = cool, wrelay - heat
#		$db->do("INSERT INTO $tabstatistics VALUES (NULL, '$cdate', $simid, $mazone, -1, 12, ".($rheat + 0).", $rfan, ".($rcool + 0).")");		# replaced by DB trigger
	} else {
		$db->do("INSERT INTO $tabstatistics VALUES (NULL, '$cdate', $simid, $mazone, -1, 12, -1, -1, -1)");			# relay offline!
	}
	return $debug;
}

# print datetime into logfile

sub prdate {
	my $logtxt = $_[0];
	my ($nusec,$numin,$nuhour,$nuday,$numon,$nuyear) = (localtime)[0,1,2,3,4,5];
	$numon ++;
	$nuday = sprintf("%02d",$nuday);
	$numon = sprintf("%02d",$numon);
	$nusec = sprintf("%02d",$nusec);
	$numin = sprintf("%02d",$numin);
	$nuhour = sprintf("%02d",$nuhour);
	$nuyear += 1900;
	my $nucreat = "$nuyear-$numon-$nuday $nuhour:$numin:$nusec";
	unless ($logonly) {
		print $nucreat."  ".$logtxt."\n";
	}
	open(LOG,">>$logfile");
	print LOG $nucreat."  ".$logtxt."\n";
	close(LOG);
	return 0;
}

7;
