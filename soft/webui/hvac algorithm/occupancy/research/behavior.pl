#!"\xampp\perl\bin\perl.exe"

use DBI;
use POSIX;
use strict;

# connect to mysql
 
my $dsn = 'DBI:mysql:asecloud:localhost';
my $db_user_name = 'ase2011';
my $db_password = 'cloud';
my $db = DBI->connect($dsn, $db_user_name, $db_password);
$db->do("SET SQL_MODE = \"NO_AUTO_VALUE_ON_ZERO\";");			# small fix to allow 0 values for autoincrement

my $dbpref = "000003";
my ($tabzonesadvanced, $tabzonesimadv, $tabstates, $tabtemperaturebreakout, $tabtemperatureprofile, $tabevents, $tabzones, $tabdevices, $tabparamairflowcontrol, $tabemu, $tabparamsensorlth, $tabdeviceadvanced, $tabzonesim, $tabcontrol) = ($dbpref."zonesadvanced", $dbpref."zonesimadv", $dbpref."states", $dbpref."temperaturebreakout", $dbpref."temperatureprofile", $dbpref."events", $dbpref."zones", $dbpref."devices", $dbpref."paramairflowcontrol", $dbpref."emu", $dbpref."paramsensorlth", $dbpref."deviceadvanced", $dbpref."zonesim", $dbpref."control");

# first step to determine total occupancy thresholds

my $anlen = 14;
my %daily = ();
my ($tmax1, $tmax2, $tavg) = (0, 0, 0);
my ($maxday) = $db->selectrow_array("SELECT DATE_FORMAT(MAX(data),'%Y%m%d') FROM $tabevents");
for (my $ii = 0; $ii < $anlen; $ii ++) {
	my $dayfrom = $maxday."000000";
	my $dayto = $maxday."235959";

	my $all = $db->selectall_arrayref("SELECT AVG(T),DATE_SUB('$dayfrom',INTERVAL $ii DAY) from $tabevents WHERE data BETWEEN DATE_SUB('$dayfrom',INTERVAL $ii DAY) AND DATE_SUB('$dayto',INTERVAL $ii DAY) AND type = 11 AND T BETWEEN 0 AND 1");
	foreach my $row (@$all) {
		my ($avoccu, $datefrom) = @$row;
		if ($avoccu >= $tmax1) {
			$tmax1 = $avoccu;
			$tmax2 = $tmax1;
		}
		$tavg += $avoccu;
		$daily{$datefrom} = $avoccu;
	}
	undef $all;
}
$tavg = $tavg / $anlen;
my $wwthr = ($tavg + $tmax2) / 2;	# this will be weekday to weekend occupancy threshold
print sprintf("maximum occupancy: %.3f, %.3f, average occupancy: %.3f, weekday/weekend threshold: %.3f", $tmax1, $tmax2, $tavg, $wwthr)."\n";
my ($wdall, $weall) = (0, 0);
foreach my $datefrom (sort keys %daily) {
	if ($daily{$datefrom} > $wwthr) {
		$weall ++;
	} else {
		$wdall ++;
	}
	print "$datefrom : ".sprintf("%.3f",$daily{$datefrom})." : ".(($daily{$datefrom} > $wwthr)?"weekend":"weekday")."\n";
}

# second step to create occupancy patterns

my (%wdpat, %wepat, %zones) = ((), (), ());
for (my $ii = 0; $ii < $anlen; $ii ++) {
	my $dayfrom = $maxday."000000";
	my $dayto = $maxday."005959";
	for (my $iii = 0; $iii < 24; $iii ++) {
		my $valsub = $iii + $ii * 24;
		my $all = $db->selectall_arrayref("SELECT AVG(T),DATE_SUB('$dayfrom',INTERVAL $valsub HOUR),zone_id,DATE_SUB('$dayfrom',INTERVAL $ii DAY) from $tabevents WHERE data BETWEEN DATE_SUB('$dayfrom',INTERVAL $valsub HOUR) AND DATE_SUB('$dayto',INTERVAL $valsub HOUR) AND type = 11 AND T BETWEEN 0 AND 1 GROUP BY zone_id");
		foreach my $row (@$all) {
			my ($avoccu, $hourfrom, $zoneid, $datefrom) = @$row;
#			print "$hourfrom : $zoneid : $avoccu\n";
			my $patkey = $zoneid.":".$iii;
			if ($daily{$datefrom} > $wwthr) {		# weekend pattern
				if (exists $wepat{$patkey}) {
					$wepat{$patkey} += $avoccu;
				} else {
					$wepat{$patkey} = $avoccu;
				}
			} else {					# weekday pattern
				if (exists $wdpat{$patkey}) {
					$wdpat{$patkey} += $avoccu;
				} else {
					$wdpat{$patkey} = $avoccu;
				}
			}
			$zones{$zoneid} = 1;
		}
		undef $all;
	}
}
foreach my $hourfrom (keys %wdpat) {
	$wdpat{$hourfrom} = $wdpat{$hourfrom} / $wdall;
#	print "$hourfrom : ".$wdpat{$hourfrom}."\n";
}
foreach my $hourfrom (keys %wepat) {
	$wepat{$hourfrom} = $wepat{$hourfrom} / $weall;
#	print "$hourfrom : ".$wepat{$hourfrom}."\n";
}

# debugging

my $ocuthr = $wwthr * 1.5;		# this value will set adapted occupation accuracy
print "\nweekday patterns\n";
foreach my $zoneid (sort keys %zones) {
	print "Zone $zoneid\n";
	print "000000000011111111112222\n";
	print "012345678901234567890123\n";
        for (my $iii = 23; $iii >= 0; $iii --) {
		my $patkey = $zoneid.":".$iii;
		print (($wdpat{$patkey} > $ocuthr)?"O":"x");
	}
	print "\n";
}
print "\nweekend patterns\n";
foreach my $zoneid (sort keys %zones) {
	print "Zone $zoneid\n";
	print "000000000011111111112222\n";
	print "012345678901234567890123\n";
        for (my $iii = 23; $iii >= 0; $iii --) {
		my $patkey = $zoneid.":".$iii;
		print (($wepat{$patkey} > $ocuthr)?"O":"x");
	}
	print "\n";
}

# endofworld

$db->disconnect;
exit;
7;
