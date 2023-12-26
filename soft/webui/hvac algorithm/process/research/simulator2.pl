#!c:/perl/bin/perl.exe
#!c:/xampp/perl/bin/perl.exe
#!/usr/bin/perl

use DBI;
use POSIX;
use Time::HiRes qw ( alarm sleep );
use strict;

# Get data from memory

my %FORM = ();
my $submeth = "post";
my $forlog = "";

# get data from command line for debugging

my $console = 0;
if ($ARGV[0] ne "") {
	foreach my $args (@ARGV) {
		my ($arg,$val) = split(/\=/,$args);
		$FORM{$arg} = $val;
	}
	$console ++;
}

# get server data

my $selfpath = $ENV{'PATH_TRANSLATED'};
$selfpath =~ s/\\[^\\]*$/\\/;
if ($selfpath eq "") {
	$selfpath = $ENV{'SCRIPT_FILENAME'};
	$selfpath =~ s/\/[^\/]*$/\//;
}

my $debug = "";
my $msgtxt = "";
my $foldname = "";

# read config

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

# constants from config

my $version = (exists $config{version})?$config{version}:"13.11.29.18";
my $sysid = (exists $config{sysid})?$config{sysid}:0;			# hardlocked system ID here
my $logfile = (exists $config{logfile})?$config{logfile}:"simulator2.log";
my $logonly = (exists $config{logonly})?$config{logonly}:0;

# connect to mysql

my $dsn = 'DBI:mysql:'.$config{dbname}.":".$config{dbhost};
my $db_user_name = $config{dbuser};
my $db_password = $config{dbpass};
my $db = DBI->connect($dsn, $db_user_name, $db_password);
$db->do("SET SQL_MODE = \"NO_AUTO_VALUE_ON_ZERO\";");			# small fix to allow 0 values for autoincrement

# constants and variables

my $autosave = "";
my $outweb = "";
my $curzone = 0;
my $newzone = 0;
my $looping = 2;		# no endless loop
my $action = "view";
if (exists($FORM{action})) {
	$action = $FORM{action};
}
if (exists($FORM{curzone})) {
	$curzone = $FORM{curzone} + 0;
}
if (exists($FORM{looping})) {
	$looping = $FORM{looping} + 0;
}
my $dbpref = "";

# tables definition

my ($tabstatistics, $tabzoneadvanced, $tabtemperaturebreakout, $tabtemperatureprofile, $tabzones, $tabdevices, $tabdeviceadvanced, $tabcontrol) = ($dbpref."statistics", $dbpref."zoneadvanced", $dbpref."temperaturebreakout", $dbpref."temperatureprofile", $dbpref."zones", $dbpref."devices", $dbpref."deviceadvanced", $dbpref."control");
my ($tabzonesdyn, $tabdevicesdyn, $tabparamsensordyn, $tabparamflapdyn, $tabparamgassensordyn) = ($dbpref."zonesdyn", $dbpref."devicesdyn", $dbpref."paramsensordyn", $dbpref."paramflapdyn", $dbpref."paramgassensordyn");
my ($tabzonesimadv, $tabemu, $tabzonesim, $tabsimtriggers) = ($dbpref."sim_zoneadv", $dbpref."sim_emu", $dbpref."sim_zone", $dbpref."sim_triggers");
my ($tabevents) = ($dbpref."events");

# enumerating zones and devices

{
	$db->do("DELETE FROM $tabzonesdyn");
	my %zonetemp = ();
	my %zonehum = ();
	{
		my $all = $db->selectall_arrayref("SELECT $tabzones.id,$tabzones.description,$tabtemperatureprofile.temperature,$tabtemperatureprofile.humidity FROM $tabzones LEFT JOIN $tabzonesdyn ON ($tabzonesdyn.zone_id = $tabzones.id) LEFT JOIN $tabtemperatureprofile ON ($tabtemperatureprofile.id = $tabzones.temperature_profile_id) WHERE 1=1 ORDER BY $tabzones.volume desc");
		foreach my $row (@$all) {
			my ($id, $desc, $stemp, $shumid) = @$row;
			$zonetemp{$id} = $stemp;
			$zonehum{$id} = $shumid;
			if ($stemp > 0) {
				my $occu = int(rand() + 0.5);
				$db->do("INSERT INTO $tabzonesdyn VALUES ($id, $occu, 0, 0, 0, 0) ON DUPLICATE KEY UPDATE occupation = $occu");
			}
		}
	}

	foreach my $zoneid (sort keys %zonetemp) {
		my $all = $db->selectall_arrayref("SELECT $tabdevices.id,$tabdevices.zone_id,$tabdevices.hardware_type,$tabdevices.device_type FROM $tabdevices WHERE $tabdevices.zone_id = $zoneid");
		foreach my $row (@$all) {
			my ($id, $zid, $hwtype, $devtype) = @$row;
			$db->do("INSERT INTO $tabdevicesdyn VALUES ($id, 1, 13, NOW()) ON DUPLICATE KEY UPDATE online = 1, device_status = 13, updated_time = NOW()");	# put online
			if ($devtype == 0) {		# sensors
				if (($hwtype == 8) || ($hwtype == 9)) {		# gas
					my $co2ppm = int(rand() * 300) + 200;
					my $coppm = int(rand() * 5) + 2;
					my $pir = int(rand() + 0.5);
					$db->do("INSERT INTO $tabparamgassensordyn VALUES ($id, 100, $pir, $co2ppm, $coppm) ON DUPLICATE KEY UPDATE pir = $pir, co2_ppm = $co2ppm, co_ppm = $coppm");
				} elsif (($hwtype == 2) || ($hwtype == 1) || ($hwtype == 3) || ($hwtype == 4)) {	# TLH
					if ($zonetemp{$zoneid} == 0) {
						$zonetemp{$zoneid} = 10;	# spring :)
						$zonehum{$zoneid} = 20;
					}
					my $tempr = (int(rand() * 60) / 10) + $zonetemp{$zoneid} - 3;
					my $humid = (int(rand() * 300) / 10) + $zonehum{$zoneid} - 15;
					my $light = int(rand() * 10000);
					my $motion = int(rand() + 0.5);
					$db->do("INSERT INTO $tabparamsensordyn VALUES ($id, 100, $light, $tempr, $humid, $motion) ON DUPLICATE KEY UPDATE light = $light, temperature = $tempr, humidity = $humid, motion = $motion");
				}
			} elsif (($devtype == 1) || ($devtype == 2)) {	# flaps
				my $controll = int(rand() + 0.5);
				$db->do("INSERT INTO $tabparamflapdyn VALUES ($id, 100, $controll, 20, 0) ON DUPLICATE KEY UPDATE controll = $controll");
			}
		}
	}
}

# simulation engine mk.II +gas

while($looping) {
	$db->do("INSERT INTO $tabevents VALUES (NULL, NOW(), NULL, 1, 0, 'New simulation started')");
	my $msg = simii();
	prdate($msg);
	if ($looping == 1) {
		$msg = resim();
		prdate($msg);
	} else {
		$looping = 0;
	}
}
$db->do("INSERT INTO $tabsimtriggers VALUES (NULL, NOW(), 0, 0)");							# tell ASE to stop processing

# simulation procedures

sub simii {
	my $resim = 0;
	my $simid = $FORM{zoneid};
	my ($delay, $durat, $break, $week, $hour, $desc, $curtsec, $outdin, $outdout, $scaling) = (20, 120, 2, 0, 0, "", 0, 20, 20, 60);
	my $all = $db->selectall_arrayref("SELECT scaling,delay,duration,breakout,weekday,daytime,description,outdoor_in,outdoor_out,UNIX_TIMESTAMP(NOW()) FROM $tabzonesim WHERE id = $simid");
	foreach my $row (@$all) {
		($scaling, $delay, $durat, $break, $week, $hour, $desc, $outdin, $outdout, $curtsec) = @$row;
	}
	undef $all;

	# read HVAC config
	my %GHVAC = ();
	my $all = $db->selectall_arrayref("SELECT option_,value_ FROM ".$dbpref."hvac WHERE submenu > 0");
	foreach my $row (@$all) {
		my ($opt, $val) = @$row;
		$GHVAC{$opt} = $val;
	}

	my %stin = ();
	my %stout = ();
	my %liin = ();
	my %liout = ();
	my %tein = ();
	my %teout = ();
	my %huin = ();
	my %huout = ();
	my %dtype = ();
	my %dzone = ();
	my $all = $db->selectall_arrayref("SELECT $tabemu.device_id,$tabemu.status_in,$tabemu.status_out,$tabemu.light_in,$tabemu.light_out,$tabemu.temperature_in,$tabemu.temperature_out,$tabemu.humidity_in,$tabemu.humidity_out,$tabdevices.hardware_type,$tabdevices.device_type,$tabdevices.zone_id FROM $tabemu LEFT JOIN $tabdevices ON $tabdevices.id = $tabemu.device_id ORDER BY $tabemu.id");
	foreach my $row (@$all) {
		my ($devid, $stiin, $stoout, $liiin, $lioout, $teiin, $teoout, $huiin, $huoout, $hwtype, $devtype, $zoneid) = @$row;
		$stin{$devid} = $stiin;
		$stout{$devid} = $stoout;
		$liin{$devid} = $liiin;
		$liout{$devid} = $lioout;
		$tein{$devid} = $teiin;
		$teout{$devid} = $teoout;
		$huin{$devid} = $huiin;
		$huout{$devid} = $huoout;
		$dtype{$devid} = 0;			# 0 - flap return, 1 - flap forward, 2 - THL sensor, 3 - gas/pir sensor, 4 - sound level sensor (obsolete)
		if ($devtype == 0) {			# sensor
			if ($hwtype == 1) {
				$dtype{$devid} = 3;				# digi sensors?
			} elsif (($hwtype == 2) || ($hwtype == 3) || ($hwtype == 4)) {
				$dtype{$devid} = 2;				# THL
			} elsif (($hwtype == 8) || ($hwtype == 9)) {
				$dtype{$devid} = 3;				# gas sensors
			}
		} elsif ($devtype == 1) {		# flap fw
			$dtype{$devid} = 1;
		} elsif ($devtype == 2) {		# flap ret
			$dtype{$devid} = 0;
		}
		$dzone{$devid} = $zoneid;
	}
	undef $all;

	my %tgain = ();
	my %tloose = ();
	my %tmax = ();
	my %tmin = ();
	my %teadd = ();
	my $all = $db->selectall_arrayref("SELECT zone_id, gain, loose, tmax, tmin FROM $tabzonesimadv");
	foreach my $row (@$all) {
		my ($zoneid, $ttgain, $ttloose, $ttmax, $ttmin) = @$row;
		($teadd{$zoneid}, $tgain{$zoneid}, $tloose{$zoneid}, $tmax{$zoneid}, $tmin{$zoneid}) = (0, $ttgain, $ttloose, $ttmax, $ttmin);
	}
	undef $all;

	my %stcur = ();
	my %licur = ();
	my %tecur = ();
	my %hucur = ();
	my %mocur = ();
	foreach my $devid (keys %dtype) {
		my $devtp = $dtype{$devid};
		if (($devtp == 0) || ($devtp == 1)) {
			$stcur{$devid} = 0;
			$licur{$devid} = 1;		# Diffuser emulated online status is ON
			$tecur{$devid} = 0;
			$hucur{$devid} = 0;
		} elsif (($devtp == 2) || ($devtp == 3) || ($devtp == 4)) {
			my $all = $db->selectall_arrayref("SELECT 0,light,temperature,humidity,motion FROM $tabparamsensordyn WHERE device_id = $devid");
			foreach my $row (@$all) {
				my ($sttm, $litm, $tetm, $hutm, $motm) = @$row;
				$sttm += 0;
				$stcur{$devid} = $sttm;
				$licur{$devid} = $litm;
				$hucur{$devid} = $hutm;
				$tecur{$devid} = $tetm;
				$mocur{$devid} = $motm;
			}
			undef $all;
		}
		$db->do("UPDATE $tabemu SET device_type = '$devtp' WHERE device_id = $devid");
	}

	$db->do("INSERT INTO $tabsimtriggers VALUES (NULL, DATE_ADD(NOW(), INTERVAL 0 MINUTE), 1, $break)");		# tell ASE to start processing

	my $steps = floor($durat / (($break == 0)?1:$break)) - 1;		# easier to connect simulations with round duration
	my $stdelay = (($durat / $steps) * 60) / $scaling;			# delay between steps in seconds
	prdate("Simulation session delay $stdelay sec");
	for (my $ii = 0; $ii <= $steps; $ii += 1) {
		my $curmin = $ii * (($break == 0)?1:$break);
		$curmin += ((($hour / 2) - floor($hour / 2)) * 30) + (floor($hour / 2) * 60);		# add hour start
		$curmin += $week * 24 * 60;								# add day start

		my $all = $db->selectall_arrayref("SELECT $tabzones.id, $tabzonesdyn.occupation FROM $tabzones LEFT JOIN $tabzonesdyn ON $tabzonesdyn.zone_id = $tabzones.id");
		foreach my $row (@$all) {
			my ($zoneid, $zoccu) = @$row;
			$zoccu += 0;			# could be null
			if ($zoccu == 1) {
				$teadd{$zoneid} += ($tgain{$zoneid} == 0)?0:((1 / $tgain{$zoneid}) * $break);
			} else {
				$teadd{$zoneid} -= ($tloose{$zoneid} == 0)?0:((1 / $tloose{$zoneid}) * $break);
			}
		}
		undef $all;

		$db->do("INSERT INTO $tabstatistics VALUES (NULL, DATE_ADD(NOW(), INTERVAL $curmin MINUTE), $simid, -1, -1, -1, -1, -1, -1)");		# insert time ticker
		foreach my $devid (keys %dtype) {
			my ($eventt, $eventh, $eventl) = (-1, -1, -1);
			my $devtp = $dtype{$devid};
			my $devzone = $dzone{$devid};
			if (($devtp == 0) || ($devtp == 1)) {
				if ($licur{$devid} != $liin{$devid}) {											# H <- RD - Heater, FD - Fan
					$eventl = sprintf("%d",$liin{$devid});										# L <- online status
					$licur{$devid} = $liin{$devid};											# T <- diff open/close
				}
			} elsif ($devtp == 2) {		# TLH
				my $tenew = sprintf("%.1f",((($teout{$devid} - $tein{$devid}) / $steps) * $ii) + $tein{$devid}) + 0;
				$tenew += $teadd{$devzone};											# add occupation correction
				unless ($teadd{$devzone} == 0) {
					my $odcur = $outdin + (($outdout - $outdin) * ($ii / $steps));
					prdate($devzone." - ".$teadd{$devzone}." - ".$odcur);
					if ($tenew < ($tmin{$devzone} + $odcur)) {
						$tenew = $tmin{$devzone} + $odcur;
					} elsif ($tenew > ($tmax{$devzone} + $odcur)) {
						$tenew = $tmax{$devzone} + $odcur;
					}
				}
				my $teold = sprintf("%.1f",$tecur{$devid}) + 0;
				$eventt = $tenew;												# T <- temperature
				unless ($tenew == $teold) {
					$tecur{$devid} = $tenew;
					$db->do("UPDATE $tabparamsensordyn SET temperature = '$tenew' WHERE device_id = $devid");
				}
				my $hunew = sprintf("%.0f",((($huout{$devid} - $huin{$devid}) / $steps) * $ii) + $huin{$devid}) + 0;
				my $huold = sprintf("%.0f",$hucur{$devid}) + 0;
				$eventh = $hunew;												# H <- humidity	
				unless ($hunew == $huold) {
					$hucur{$devid} = $hunew;
					$db->do("UPDATE $tabparamsensordyn SET humidity = '$hunew' WHERE device_id = $devid");
				}
				my $linew = sprintf("%.0f",(((($liout{$devid} / 10) - ($liin{$devid} / 10)) / $steps) * $ii) + ($liin{$devid} / 10)) * 10;
				my $liold = sprintf("%.0f",($licur{$devid} / 10)) * 10;
				$eventl = $linew;												# L <- light
				unless ($linew == $liold) {
					$licur{$devid} = $linew;
					$db->do("UPDATE $tabparamsensordyn SET light = '$linew' WHERE device_id = $devid");
				}
			} elsif ($devtp == 3) {		# Gas/PIR
				my $tenew = sprintf("%.0f",((($teout{$devid} - $tein{$devid}) / $steps) * $ii) + $tein{$devid}) + 0;
				my $teold = sprintf("%.0f",$tecur{$devid}) + 0;
				$eventt = $tenew;												# T <- CO2
				unless ($tenew == $teold) {
					$tecur{$devid} = $tenew;
#					$db->do("UPDATE $tabparamsensordyn SET temperature = '$tenew' WHERE device_id = $devid");		# obsolete!
				}
				my $hunew = sprintf("%.0f",((($huout{$devid} - $huin{$devid}) / $steps) * $ii) + $huin{$devid}) + 0;
				my $huold = sprintf("%.0f",$hucur{$devid}) + 0;
				$eventh = $hunew;												# H <- CO (monoxide)
				unless ($hunew == $huold) {
					$hucur{$devid} = $hunew;
#					$db->do("UPDATE $tabparamsensordyn SET humidity = '$hunew' WHERE device_id = $devid");			# obsolete!
				}
				my $linew = sprintf("%.0f",$liin{$devid}) + 0;
				my $liold = sprintf("%.0f",$licur{$devid}) + 0;
				$eventl = $linew;												# L <- PIR
				unless ($linew == $liold) {
					$licur{$devid} = $liin{$devid};
#					$db->do("UPDATE $tabparamsensordyn SET light = '$linew' WHERE device_id = $devid");			# obsolete!
				}
				if (($tenew != $teold) || ($hunew != $huold) || ($linew == $liold)) {
					$db->do("INSERT INTO $tabparamgassensordyn VALUES ($devid, 100, $linew, $tenew, $hunew) ON DUPLICATE KEY UPDATE pir = $linew, co2_ppm = $tenew, co_ppm = $hunew");
				}
			} elsif ($devtp == 4) {		# Sound
				my $linew = sprintf("%.0f",((($liout{$devid} - $liin{$devid}) / $steps) * $ii) + $liin{$devid}) + 0;
				my $liold = sprintf("%.0f",$licur{$devid}) + 0;
				$eventl = $linew;												# L <- sound level
				unless ($linew == $liold) {											# obsolete!!
					$licur{$devid} = $linew;
					$db->do("UPDATE $tabparamsensordyn SET light = '$linew' WHERE device_id = $devid");
				}
			}
			unless (($eventt == -1) && ($eventh == -1) && ($eventl == -1)) {
#				$db->do("INSERT INTO $tabstatistics VALUES (NULL, DATE_ADD(NOW(), INTERVAL $curmin MINUTE), $simid, $devzone, $devid, $devtp, $eventt, $eventh, $eventl)");
			}
		}
		$db->do("INSERT INTO $tabsimtriggers VALUES (NULL, DATE_ADD(NOW(), INTERVAL $curmin MINUTE), 3, $simid)");
#		$debug .= ase($curmin, $resim, $break);
		sleep($stdelay);
	}

	my ($endtsec) = $db->selectrow_array("SELECT UNIX_TIMESTAMP(NOW())");
	$msgtxt = "Simulation $simid.'$desc' finished in ".($endtsec - $curtsec)." seconds";
	return $msgtxt;
}

sub resim {
	my $simid = $FORM{zoneid};
#	$db->do("DELETE FROM $tabstatistics WHERE sim_id = $simid");
	$db->do("DELETE FROM $tabsimtriggers");				# remove all unprocessed events
	$db->do("UPDATE $tabzonesdyn SET occupation = 0");
	$msgtxt = "Simulation $simid last results cleared";
	return $msgtxt;
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

# endofworld

$db->disconnect;
exit;

7;
