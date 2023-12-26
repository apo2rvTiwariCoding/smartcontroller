#!"\xampp\perl\bin\perl.exe"

use DBI;
use POSIX;
use strict;

my $version = "14.08.19";
my $debugmode = 0;

# Get data from memory

my %FORM = ();
my $submeth = "post";
my $forlog = "";
unless (exists($FORM{"testnoenv"})) {
	my $bufer = "";
	if ($ENV{'REQUEST_METHOD'} eq "POST") {
		read(STDIN, $bufer, $ENV{'CONTENT_LENGTH'});
		$submeth = "post";
	} else {
		$bufer=$ENV{'QUERY_STRING'};
		$submeth = "get";
	}

	my @pairs = split(/&/, $bufer);

	foreach my $pair (@pairs)
	{
		my ($name, $value) = split(/=/, $pair);
		$name =~ tr/+/ /;
		$name =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
		$value =~ tr/+/ /;
		$value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
		$value =~ s/[\\\'\"\`\%]/\ /g;
		$FORM{$name} = $value;
		$forlog .= "$name - $value\n";
	}
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
# $debug .= $forlog;
my $servname = $ENV{'SERVER_NAME'};
my $servport = $ENV{'SERVER_PORT'};
unless ($servport eq "80") {
	$servname .= ":".$servport;
}
my $foldname = "";
my $mainweb = $selfpath."main.html";

# connect to mysql
 
my $dsn = 'DBI:mysql:asecloud:localhost';
my $db_user_name = 'ase2011';
my $db_password = 'cloud';
my $db = DBI->connect($dsn, $db_user_name, $db_password);
$db->do("SET SQL_MODE = \"NO_AUTO_VALUE_ON_ZERO\";");			# small fix to allow 0 values for autoincrement

# constants and variables

my ($comfli, $comftem, $comfhum, $comfpir, $comfco1, $comfco2, $comfdif) = (2000, 22, 55, 0, 200, 2, 1);
my $autosave = "";
my $outweb = "";
my $curzone = 0;
my $newzone = 0;
my $action = "view";
if (exists($FORM{action})) {
	$action = $FORM{action};
}
if (exists($FORM{curzone})) {
	$curzone = $FORM{curzone} + 0;
}
if (exists($FORM{zone})) {
	$newzone = $FORM{zone} + 0;
}
if (exists($FORM{button1})) {
	$action = "save";
} elsif (exists($FORM{button2})) {
	$action = "sim";
} elsif (exists($FORM{button3})) {
	$action = "newsim";
} elsif (exists($FORM{button4})) {
	$action = "resetsim";
} elsif (exists($FORM{button5})) {
	$action = "connsim";
} elsif (exists($FORM{button6})) {
	$action = "reslastsim";
}
if (exists($FORM{autosave})) {
	$autosave = " checked";
	if ($action eq "view") {
		$action = "save";
	}
}
my $dbpref = "000003";
my ($tabzonesadvanced, $tabzonesimadv, $tabstates, $tabtemperaturebreakout, $tabtemperatureprofile, $tabevents, $tabzones, $tabdevices, $tabparamairflowcontrol, $tabemu, $tabparamsensorlth, $tabdeviceadvanced, $tabzonesim, $tabcontrol) = ($dbpref."zonesadvanced", $dbpref."zonesimadv", $dbpref."states", $dbpref."temperaturebreakout", $dbpref."temperatureprofile", $dbpref."events", $dbpref."zones", $dbpref."devices", $dbpref."paramairflowcontrol", $dbpref."emu", $dbpref."paramsensorlth", $dbpref."deviceadvanced", $dbpref."zonesim", $dbpref."control");

# visualisation

if ($action eq "getcsv") {
	my $simid = $FORM{simid};
	my $outcsv = "sim".$simid.".csv";

	my %zonedesc = ();
	my $all = $db->selectall_arrayref("SELECT id,description FROM $tabzones ORDER BY id");
	foreach my $row (@$all) {
		my ($ezoneid,$ezonedesc) = @$row;
		$zonedesc{$ezoneid} = $ezonedesc;
	}
	undef $all;

	my $csvcont = "datetime;zone ID;zone name;target T;Temperature;target H;Humidity;Light;CO2 ;CO;PIR;Sound;Occupancy;Supply Diff;Return Diff;Heater;Fan;Cooler;State;\n";
	my $datetime = "";
        my (%tartem, %tarhum, %curtem, %curhum, %curli, %curcd, %curco, %curpir, %curdb, %curoc, %curfw, %curret, %curheat, %curfan, %curcool, %curstate) = ((), (), (), (), (), (), (), (), (), (), (), (), (), (), (), (), ());
	my $all = $db->selectall_arrayref("SELECT DATE_FORMAT(data, '%e %b %y %H:%i:%S'), zone_id, type, T, H, L from $tabevents WHERE sim_id = $simid ORDER BY data, id");
	foreach my $row (@$all) {
		my ($curdate, $ezoneid, $etype, $evalt, $evalh, $evall) = @$row;		# 2 - THL sensor, 3 - gas/pir sensor, 4 - sound level sensor, 0 - diff return, 1 - diff forward
		if ($etype == -1) {								# 10 - THL target, 11 - Occupation, 12 - Heat/Cold/Fan
			foreach my $zoneid (sort(keys %zonedesc)) {
				unless ($datetime eq "") {
					$csvcont .= "$datetime;$zoneid;".$zonedesc{$zoneid}.";".$tartem{$zoneid}.";".$curtem{$zoneid}.";".$tarhum{$zoneid}.";".$curhum{$zoneid}.";".$curli{$zoneid}.";".$curcd{$zoneid}.";".$curco{$zoneid}.";".$curpir{$zoneid}.";".$curdb{$zoneid}.";".$curoc{$zoneid}.";".$curfw{$zoneid}.";".$curret{$zoneid}.";".$curheat{$zoneid}.";".$curfan{$zoneid}.";".$curcool{$zoneid}.";".$curstate{$zoneid}.";\n";
				}
				($tartem{$zoneid}, $tarhum{$zoneid}, $curtem{$zoneid}, $curhum{$zoneid}, $curli{$zoneid}, $curcd{$zoneid}, $curco{$zoneid}, $curpir{$zoneid}, $curdb{$zoneid}, $curoc{$zoneid}, $curfw{$zoneid}, $curret{$zoneid}, $curheat{$zoneid}, $curfan{$zoneid}, $curcool{$zoneid}) = ("", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
			}
			$datetime = $curdate;
		} else {
			unless ($evalt == -1) {
				if ($etype == 2) {
					$curtem{$ezoneid} = sprintf("%.1f",$evalt);
				} elsif ($etype == 10) {	# target T
					$tartem{$ezoneid} = sprintf("%.1f",$evalt);
				} elsif ($etype == 11) {	# Occupation
					$curoc{$ezoneid} = ($evalt == 0)?"None":(($evalt == 1)?"Full":"Semi");
				} elsif ($etype == 3) {
					$curcd{$ezoneid} = sprintf("%.0f",$evalt);
				} elsif ($etype == 1) {
					$curfw{$ezoneid} = ($evalt == 0)?"Closed":"Opened";
				} elsif ($etype == 0) {
					$curret{$ezoneid} = ($evalt == 0)?"Closed":"Opened";
				} elsif ($etype == 12) {
					$curheat{$ezoneid} = ($evalt == 0)?"OFF":"ON";
				}
			}
			unless ($evalh == -1) {
				if ($etype == 2) {
					$curhum{$ezoneid} = sprintf("%.0f",$evalh);
				} elsif ($etype == 10) {	# target H
					$tarhum{$ezoneid} = sprintf("%.0f",$evalh);
				} elsif ($etype == 3) {
					$curco{$ezoneid} = sprintf("%.0f",$evalh);
				} elsif ($etype == 12) {
					$curfan{$ezoneid} = ($evalh == 0)?"OFF":"ON";
				}
			}
			unless ($evall == -1) {
				if ($etype == 2) {
					$curli{$ezoneid} = sprintf("%.0f",$evall);
				} elsif ($etype == 3) {
					$curpir{$ezoneid} = ($evall == 0)?"OFF":"ON";
				} elsif ($etype == 4) {
					$curdb{$ezoneid} = sprintf("%.0f",$evall);
				} elsif ($etype == 12) {
					$curcool{$ezoneid} = ($evall == 0)?"OFF":"ON";
				} elsif (($etype == 0) || ($etype == 1)) {
					my @cstates = ("Neutral", "Vent", "Reheat", "Heat", "Preheat");
					$curstate{$ezoneid} = $cstates[$evall];
				}
			}
		}
	}
	undef $all;
	foreach my $zoneid (sort(keys %zonedesc)) {
		$csvcont .= "$datetime;$zoneid;".$zonedesc{$zoneid}.";".$tartem{$zoneid}.";".$curtem{$zoneid}.";".$tarhum{$zoneid}.";".$curhum{$zoneid}.";".$curli{$zoneid}.";".$curcd{$zoneid}.";".$curco{$zoneid}.";".$curpir{$zoneid}.";".$curdb{$zoneid}.";".$curoc{$zoneid}.";".$curfw{$zoneid}.";".$curret{$zoneid}.";".$curheat{$zoneid}.";".$curfan{$zoneid}.";".$curcool{$zoneid}.";".$curstate{$zoneid}.";\n";
	}

	print "Content-type: text/csv\n";
	print "Content-Disposition: attachment; filename=\"$outcsv\"\n\n";
	print $csvcont;
	$db->disconnect;
	exit;
}

if ($action eq "getpng") {
	my $zoom = 1.5;
	my $simid = $FORM{simid};
	my $outpng = $selfpath."sims/sim".$simid.".png";
	my $urlpng = "http://".$servname."/sims/sim".$simid.".png";
	my @weekds = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat");
	my ($recnum, $minwtime, $maxwtime, $minhtime, $maxhtime) = $db->selectrow_array("SELECT COUNT(id),DATE_FORMAT(MIN(data),'%w'),DATE_FORMAT(MAX(data),'%w'),DATE_FORMAT(MIN(data),'%H:%i'),DATE_FORMAT(MAX(data),'%H:%i') FROM $tabevents WHERE sim_id = $simid AND type = -1");
	my $mintime = $weekds[$minwtime]." ".$minhtime;
	my $maxtime = $weekds[$maxwtime]." ".$maxhtime;
	my ($devnum) = $db->selectrow_array("SELECT COUNT(id) FROM $tabemu");
	my ($minte, $maxte) = $db->selectrow_array("SELECT MIN(T),MAX(T) FROM $tabevents WHERE sim_id = $simid AND T >= 0 AND (type = 2 OR type = 10)");
	my ($minhu, $maxhu) = $db->selectrow_array("SELECT MIN(H),MAX(H) FROM $tabevents WHERE sim_id = $simid AND H >= 0 AND (type = 2 OR type = 10)");
	my ($minli, $maxli) = $db->selectrow_array("SELECT MIN(L),MAX(L) FROM $tabevents WHERE sim_id = $simid AND L >= 0 AND (type = 2 OR type = 10)");
	my ($mincd, $maxcd) = $db->selectrow_array("SELECT MIN(T),MIN(T) FROM $tabevents WHERE sim_id = $simid AND T >= 0 AND H >= 0 AND type = 3");
	my ($minco, $maxco) = $db->selectrow_array("SELECT MIN(H),MIN(H) FROM $tabevents WHERE sim_id = $simid AND T >= 0 AND H >= 0 AND type = 3");
	my ($mindb, $maxdb) = $db->selectrow_array("SELECT MIN(L),MAX(L) FROM $tabevents WHERE sim_id = $simid AND L >= 0 AND type = 4");
	my $ppxte = (($maxte - $minte) == 0)?0:((380 * $zoom) / ($maxte - $minte));
	my $ppxhu = (($maxhu - $minhu) == 0)?0:((380 * $zoom) / ($maxhu - $minhu));
	my $ppxli = (($maxli - $minli) == 0)?0:((380 * $zoom) / ($maxli - $minli));
	my $ppxcd = (($maxcd - $mincd) == 0)?0:((380 * $zoom) / ($maxcd - $mincd));
	my $ppxco = (($maxco - $minco) == 0)?0:((380 * $zoom) / ($maxco - $minco));
	my $ppxdb = (($maxdb - $mindb) == 0)?0:((380 * $zoom) / ($maxdb - $mindb));
	my ($minpir, $maxpir, $ppxpir) = (0, 1, (365 * $zoom));
	my ($minfd, $maxfd, $ppxfd) = (0, 1, (360 * $zoom));
	my ($minrd, $maxrd, $ppxrd) = (0, 1, (335 * $zoom));
	my ($minhe, $maxhe, $ppxhe) = (0, 1, (350 * $zoom));
	my ($minfa, $maxfa, $ppxfa) = (0, 1, (345 * $zoom));
	my ($minoc, $maxoc, $ppxoc) = (0, 2, ((340 * $zoom) / 2));
	$minte = sprintf("%.1f",$minte + 0);
	$maxte = sprintf("%.1f",$maxte + 0);
	$minhu = sprintf("%.0f",$minhu + 0);
	$maxhu = sprintf("%.0f",$maxhu + 0);
	$minli = sprintf("%.0f",$minli + 0);
	$maxli = sprintf("%.0f",$maxli + 0);
	$mincd = sprintf("%.0f",$mincd + 0);
	$maxcd = sprintf("%.0f",$maxcd + 0);
	$minco = sprintf("%.0f",$minco + 0);
	$maxco = sprintf("%.0f",$maxco + 0);
	$mindb = sprintf("%.0f",$mindb + 0);
	$maxdb = sprintf("%.0f",$maxdb + 0);

	my $yperzone = 430 * $zoom;
	my $zonenum = 0;
	my %fzoids = ();
	my %fzodesc = ();
	my $all = $db->selectall_arrayref("SELECT id,description FROM $tabzones ORDER BY id");
	foreach my $row (@$all) {
		my ($ezoneid,$ezonedesc) = @$row;
		$fzoids{$ezoneid} = $zonenum;
		$fzodesc{$zonenum} = $ezonedesc;
		$zonenum ++;
	}
	undef $all;

	my %gclr = ('oc', '#77f', 'te', '#f00', 'hu', '#191', 'tte', '#f99', 'thu', '#9f9', 'li', '#00f', 'cd', '#111', 'co', '#888', 'db', '#f0f', 'fd', '#5c5', 'rd', '#555', 'time', '#135', 'pir', '#d7d', 'zd', '#77e', 'he', '#c55', 'fa', '#55c');
	my $imgsize = ($recnum * 2 * $zoom + 64 * $zoom)."x".($yperzone * $zonenum);
	use Image::Magick;
	my $png=Image::Magick->new;
	$png->Set(size=>$imgsize);
	$png->ReadImage('canvas:white');
	for (my $yy = 0; $yy < ($zonenum * $yperzone); $yy += $yperzone) {
		$png->Draw(stroke=>'black', primitive=>'line', points=>(60 * $zoom).','.(1 + $yy).' '.(60 * $zoom).','.((400 * $zoom) + $yy));
		my $lpoints = (60 * $zoom).",".((400 * $zoom) + $yy)." ".($recnum * 2 * $zoom + (60 * $zoom)).",".((400 * $zoom) + $yy);
		$png->Draw(stroke=>'black', primitive=>'line', points=>$lpoints);
		$png->Annotate(text=>($maxte.' deg'), pointsize=>(10 * $zoom), fill=>$gclr{te}, x=>(58 * $zoom), y=>((11 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>($maxhu.' %'), pointsize=>(10 * $zoom), fill=>$gclr{hu}, x=>(58 * $zoom), y=>((22 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>($maxli.' lux'), pointsize=>(10 * $zoom), fill=>$gclr{li}, x=>(58 * $zoom), y=>((33 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>($maxcd.' ppm'), pointsize=>(10 * $zoom), fill=>$gclr{cd}, x=>(58 * $zoom), y=>((44 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>($maxco.' ppm'), pointsize=>(10 * $zoom), fill=>$gclr{co}, x=>(58 * $zoom), y=>((55 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>($maxdb.' dB'), pointsize=>(10 * $zoom), fill=>$gclr{db}, x=>(58 * $zoom), y=>((66 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>($minte.' deg'), pointsize=>(10 * $zoom), fill=>$gclr{te}, x=>(58 * $zoom), y=>((344 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>($minhu.' %'), pointsize=>(10 * $zoom), fill=>$gclr{hu}, x=>(58 * $zoom), y=>((355 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>($minli.' lux'), pointsize=>(10 * $zoom), fill=>$gclr{li}, x=>(58 * $zoom), y=>((366 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>($mincd.' ppm'), pointsize=>(10 * $zoom), fill=>$gclr{cd}, x=>(58 * $zoom), y=>((377 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>($minco.' ppm'), pointsize=>(10 * $zoom), fill=>$gclr{co}, x=>(58 * $zoom), y=>((388 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>($mindb.' dB'), pointsize=>(10 * $zoom), fill=>$gclr{db}, x=>(58 * $zoom), y=>((399 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>'Occupancy', pointsize=>(10 * $zoom), fill=>$gclr{oc}, x=>(58 * $zoom), y=>((156 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>'Temperature', pointsize=>(10 * $zoom), fill=>$gclr{te}, x=>(58 * $zoom), y=>((166 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>'Humidity', pointsize=>(10 * $zoom), fill=>$gclr{hu}, x=>(58 * $zoom), y=>((177 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>'Light', pointsize=>(10 * $zoom), fill=>$gclr{li}, x=>(58 * $zoom), y=>((188 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>'CO2', pointsize=>(10 * $zoom), fill=>$gclr{cd}, x=>(58 * $zoom), y=>((199 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>'CO', pointsize=>(10 * $zoom), fill=>$gclr{co}, x=>(58 * $zoom), y=>((210 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>'Sound', pointsize=>(10 * $zoom), fill=>$gclr{db}, x=>(58 * $zoom), y=>((221 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>'PIR', pointsize=>(10 * $zoom), fill=>$gclr{pir}, x=>(58 * $zoom), y=>((232 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>'Target T', strokewidth=>'0.5', pointsize=>(10 * $zoom), fill=>$gclr{tte}, x=>(58 * $zoom), y=>((242 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>'Target H', strokewidth=>'0.5', pointsize=>(10 * $zoom), fill=>$gclr{thu}, x=>(58 * $zoom), y=>((252 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>'Time', pointsize=>(10 * $zoom), fill=>$gclr{time}, x=>($recnum * $zoom + (60 * $zoom)), y=>((411 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Center', antialias=>'true');
		$png->Annotate(text=>'Forward', pointsize=>(10 * $zoom), fill=>$gclr{fd}, x=>(58 * $zoom), y=>((126 * $zoom) + $yy), style=>'Oblique', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>'diffuser', pointsize=>(10 * $zoom), fill=>$gclr{fd}, x=>(58 * $zoom), y=>((136 * $zoom) + $yy), style=>'Oblique', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>'Return', pointsize=>(10 * $zoom), fill=>$gclr{rd}, x=>(58 * $zoom), y=>((272 * $zoom) + $yy), style=>'Oblique', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>'diffuser', pointsize=>(10 * $zoom), fill=>$gclr{rd}, x=>(58 * $zoom), y=>((282 * $zoom) + $yy), style=>'Oblique', stretch=>'normal', align=>'Right', antialias=>'true');
		if ($yy == 0) {
			$png->Annotate(text=>'Heater', pointsize=>(10 * $zoom), fill=>$gclr{he}, x=>(58 * $zoom), y=>((106 * $zoom) + $yy), style=>'Oblique', stretch=>'normal', align=>'Right', antialias=>'true');
			$png->Annotate(text=>'Fan', pointsize=>(10 * $zoom), fill=>$gclr{fa}, x=>(58 * $zoom), y=>((302 * $zoom) + $yy), style=>'Oblique', stretch=>'normal', align=>'Right', antialias=>'true');
		}
		$png->Annotate(text=>$mintime, pointsize=>(10 * $zoom), fill=>$gclr{time}, x=>(60 * $zoom), y=>((411 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Left', antialias=>'true');
		$png->Annotate(text=>$maxtime, pointsize=>(10 * $zoom), fill=>$gclr{time}, x=>($recnum * 2 * $zoom + (60 * $zoom)), y=>((411 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
		$png->Annotate(text=>$fzodesc{($yy / $yperzone)}, pointsize=>(10 * $zoom), fill=>$gclr{zd}, x=>($recnum * 2 * $zoom + (60 * $zoom)), y=>((11 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
	}

	my %eoldtx = ();
	my %eoldty = ();
	my %eoldhx = ();
	my %eoldhy = ();
	my %eoldlx = ();
	my %eoldly = ();
	my $xcoor = 0;
	my %lasty = ();
	my %lastx = ();
	my %lastc = ();
	my $oldhour = -1;
	my $oldweek = -1;
	my $all = $db->selectall_arrayref("SELECT zone_id, device_id, type, T, H, L, DATE_FORMAT(data, '%H'), DATE_FORMAT(data, '%w') from $tabevents WHERE sim_id = $simid ORDER BY data, id");
	foreach my $row (@$all) {
		my ($ezoneid, $edevid, $etype, $evalt, $evalh, $evall, $chour, $cweek) = @$row;	# 2 - THL sensor, 3 - gas/pir sensor, 4 - sound level sensor, 0 - diff return, 1 - diff forward
		if ($etype == -1) {								# 10 - THL target, 11 - Occupation, 12 - Heat/Cold/Fan
			$xcoor ++;
			unless ($chour == $oldhour) {
				unless ($oldhour == -1) {
					for (my $yy = 0; $yy < ($zonenum * $yperzone); $yy += $yperzone) {
						my $ltpoints = ($xcoor * 2 * $zoom + (60 * $zoom)).",".(1 + $yy)." ".($xcoor * 2 * $zoom + (60 * $zoom)).",".((400 * $zoom) + $yy);
						$png->Draw(stroke=>'#eee', primitive=>'line', points=>$ltpoints);
					}
				}
				$oldhour = $chour;
			}
			unless ($cweek == $oldweek) {
				unless ($oldweek == -1) {
					for (my $yy = 0; $yy < ($zonenum * $yperzone); $yy += $yperzone) {
						my $ltpoints = ($xcoor * 2 * $zoom + (60 * $zoom)).",".(1 + $yy)." ".($xcoor * 2 * $zoom + (60 * $zoom)).",".((400 * $zoom) + $yy);
						$png->Draw(stroke=>'#bbb', primitive=>'line', points=>$ltpoints);
                                                $png->Annotate(text=>$weekds[$cweek], pointsize=>(10 * $zoom), fill=>$gclr{time}, x=>($xcoor * 2 * $zoom + (60 * $zoom)), y=>((411 * $zoom) + $yy), style=>'normal', stretch=>'normal', align=>'Right', antialias=>'true');
					}
				}
				$oldweek = $cweek;
			}
		} else {
			if ($edevid == -1) {
				$edevid = $etype."+".$ezoneid;
			}
			my $pnts = "0,0 0,0";
			my $pclr = "black";
			my $pbstr = 2.2;
			unless ($evalt == -1) {
				my $pstr = 1;
				my $nxcoor = $xcoor * 2 * $zoom + (60 * $zoom);
				my $oxcoor = (exists $eoldtx{$edevid})?$eoldtx{$edevid}:(62 * $zoom);
				my $nycoor = 0;
				if ($etype == 2) {
					$pclr = $gclr{te};
					$nycoor = ((390 * $zoom) - ($evalt - $minte) * $ppxte) + ($fzoids{$ezoneid} * $yperzone);
				} elsif ($etype == 10) {	# target T
					$pclr = $gclr{tte};
					$nycoor = ((390 * $zoom) - ($evalt - $minte) * $ppxte) + ($fzoids{$ezoneid} * $yperzone);
				} elsif ($etype == 11) {	# Occupation
					$pclr = $gclr{oc};
					$nycoor = ((365 * $zoom) - ((($evalt == 0)?0:(($evalt == 1)?2:1)) - $minoc) * $ppxoc) + ($fzoids{$ezoneid} * $yperzone);
				} elsif ($etype == 3) {
					$pclr = $gclr{cd};
					$nycoor = ((390 * $zoom) - ($evalt - $mincd) * $ppxcd) + ($fzoids{$ezoneid} * $yperzone);
				} elsif ($etype == 1) {
					$pclr = $gclr{fd};
					$pstr = $pbstr;
					$nycoor = ((382 * $zoom) - ($evalt - $minfd) * $ppxfd) + ($fzoids{$ezoneid} * $yperzone);
				} elsif ($etype == 0) {
					$pclr = $gclr{rd};
					$pstr = $pbstr;
					$nycoor = ((373 * $zoom) - ($evalt - $minrd) * $ppxrd) + ($fzoids{$ezoneid} * $yperzone);
				} elsif ($etype == 12) {
					$pclr = $gclr{he};
					$pstr = $pbstr;
					$nycoor = ((367 * $zoom) - ($evalt - $minhe) * $ppxhe) + ($fzoids{$ezoneid} * $yperzone);
				}
				my $oycoor = (exists $eoldty{$edevid})?$eoldty{$edevid}:$nycoor;
				$pnts = $oxcoor.",".$oycoor." ".$nxcoor.",".$nycoor;
				$eoldty{$edevid} = $nycoor;
				$eoldtx{$edevid} = $nxcoor;
				$png->Draw(stroke=>$pclr, primitive=>'line', points=>$pnts, strokewidth=>$pstr);
				$lastx{$edevid."t"} = $nxcoor;
				$lasty{$edevid."t"} = $nycoor;
				$lastc{$edevid."t"} = $pclr;
			}
			unless ($evalh == -1) {
				my $pstr = 1;
				my $nxcoor = $xcoor * 2 * $zoom + (60 * $zoom);
				my $oxcoor = (exists $eoldhx{$edevid})?$eoldhx{$edevid}:(62 * $zoom);
				my $nycoor = 0;
				if ($etype == 2) {
					$pclr = $gclr{hu};
					$nycoor = ((390 * $zoom) - ($evalh - $minhu) * $ppxhu) + ($fzoids{$ezoneid} * $yperzone);
				} elsif ($etype == 10) {	# target H
					$pclr = $gclr{thu};
					$nycoor = ((390 * $zoom) - ($evalh - $minhu) * $ppxhu) + ($fzoids{$ezoneid} * $yperzone);
				} elsif ($etype == 3) {
					$pclr = $gclr{co};
					$nycoor = ((390 * $zoom) - ($evalh - $minco) * $ppxco) + ($fzoids{$ezoneid} * $yperzone);
				} elsif ($etype == 12) {
					$pclr = $gclr{fa};
					$pstr = $pbstr;
					$nycoor = ((364 * $zoom) - ($evalh - $minfa) * $ppxfa) + ($fzoids{$ezoneid} * $yperzone);
				}
				my $oycoor = (exists $eoldhy{$edevid})?$eoldhy{$edevid}:$nycoor;
				$pnts = $oxcoor.",".$oycoor." ".$nxcoor.",".$nycoor;
				$eoldhy{$edevid} = $nycoor;
				$eoldhx{$edevid} = $nxcoor;
				$png->Draw(stroke=>$pclr, primitive=>'line', points=>$pnts, strokewidth=>$pstr);
				$lastx{$edevid."h"} = $nxcoor;
				$lasty{$edevid."h"} = $nycoor;
				$lastc{$edevid."h"} = $pclr;
			}
			unless ($evall == -1) {
				my $pstr = 1;
				my $nxcoor = $xcoor * 2 * $zoom + (60 * $zoom);
				my $oxcoor = (exists $eoldlx{$edevid})?$eoldlx{$edevid}:(62 * $zoom);
				my $nycoor = 0;
				if ($etype == 2) {
					$pclr = $gclr{li};
					$nycoor = ((390 * $zoom) - ($evall - $minli) * $ppxli) + ($fzoids{$ezoneid} * $yperzone);
				} elsif ($etype == 3) {
					$pclr = $gclr{pir};
					$nycoor = ((380 * $zoom) - ($evall - $minpir) * $ppxpir) + ($fzoids{$ezoneid} * $yperzone);
				} elsif ($etype == 4) {
					$pclr = $gclr{db};
					$nycoor = ((390 * $zoom) - ($evall - $mindb) * $ppxdb) + ($fzoids{$ezoneid} * $yperzone);
				}
				my $oycoor = (exists $eoldly{$edevid})?$eoldly{$edevid}:$nycoor;
				$pnts = $oxcoor.",".$oycoor." ".$nxcoor.",".$nycoor;
				$eoldly{$edevid} = $nycoor;
				$eoldlx{$edevid} = $nxcoor;
				$png->Draw(stroke=>$pclr, primitive=>'line', points=>$pnts, strokewidth=>$pstr);
				$lastx{$edevid."l"} = $nxcoor;
				$lasty{$edevid."l"} = $nycoor;
				$lastc{$edevid."l"} = $pclr;
			}
		}
	}
	undef $all;
	foreach my $edevid (keys %lastc) {
		my $pclr = $lastc{$edevid};
		my $pnts = $lastx{$edevid}.",".$lasty{$edevid}." ".($xcoor * 2 * $zoom + (60 * $zoom)).",".$lasty{$edevid};
		$png->Draw(stroke=>$pclr, primitive=>'line', points=>$pnts);
	}

	$png->Write(filename=>$outpng);
	print "Content-type: text/html\n\n";
	print "<HTML>\n<HEAD>\n<META HTTP-EQUIV=REFRESH CONTENT=\"0;URL=$urlpng\">\n</HEAD>\n";
	$db->disconnect;
	exit;
}

# simulation

if ($action eq "sim") {
	my $resim = 0;
	unless ($autosave eq "") {
		my ($id, $delay, $durat, $break, $week, $hour, $desc, $outdin, $outdout) = ($FORM{zoneid}, $FORM{preheat}, $FORM{duration}, $FORM{breakout}, $FORM{dayfrom}, $FORM{timefrom}, $FORM{description}, $FORM{outdin}, $FORM{outdout});
		$db->do("UPDATE $tabzonesim SET delay = '$delay', duration = '$durat', breakout = '$break', weekday = '$week', daytime = '$hour', description = '$desc', outdoor_in = '$outdin', outdoor_out = '$outdout' WHERE id = $id");
	}
	my $simid = $FORM{zoneid};
        my ($delay, $durat, $break, $week, $hour, $desc, $curtsec, $outdin, $outdout) = (20, 120, 2, 0, 0, "", 0, 20, 20);
	my $all = $db->selectall_arrayref("SELECT delay,duration,breakout,weekday,daytime,description,outdoor_in,outdoor_out,UNIX_TIMESTAMP(NOW()) FROM $tabzonesim WHERE id = $simid");
	foreach my $row (@$all) {
		($delay, $durat, $break, $week, $hour, $desc, $outdin, $outdout, $curtsec) = @$row;
	}
	undef $all;

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
	my $all = $db->selectall_arrayref("SELECT $tabemu.device_id,$tabemu.status_in,$tabemu.status_out,$tabemu.light_in,$tabemu.light_out,$tabemu.temperature_in,$tabemu.temperature_out,$tabemu.humidity_in,$tabemu.humidity_out,$tabdeviceadvanced.realvar1,$tabparamairflowcontrol.type,$tabdevices.zone_id FROM $tabemu LEFT JOIN $tabdevices ON $tabdevices.id = $tabemu.device_id LEFT JOIN $tabparamairflowcontrol ON $tabparamairflowcontrol.device_id = $tabemu.device_id LEFT JOIN $tabdeviceadvanced ON ($tabdeviceadvanced.device_id = $tabemu.device_id AND $tabdeviceadvanced.type = 5) ORDER BY $tabemu.id");
	foreach my $row (@$all) {
		my ($devid, $stiin, $stoout, $liiin, $lioout, $teiin, $teoout, $huiin, $huoout, $rvar, $diftp, $zoneid) = @$row;
		$stin{$devid} = $stiin;
		$stout{$devid} = $stoout;
		$liin{$devid} = $liiin;
		$liout{$devid} = $lioout;
		$tein{$devid} = $teiin;
		$teout{$devid} = $teoout;
		$huin{$devid} = $huiin;
		$huout{$devid} = $huoout;
		$dtype{$devid} = 0;			# 0 - diff return
		if ($diftp eq "") {
			$rvar += 0;
			$dtype{$devid} = $rvar + 2;	# 2 - THL sensor, 3 - gas/pir sensor, 4 - sound level sensor
		} else {
			$diftp += 0;
			$dtype{$devid} = $diftp;	# 1 - diff forward
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
	foreach my $devid (keys %dtype) {
		my $devtp = $dtype{$devid};
		if (($devtp == 0) || ($devtp == 1)) {
			$stcur{$devid} = 0;
			$licur{$devid} = 1;		# Diffuser emulated online status is ON
			$tecur{$devid} = 0;
			$hucur{$devid} = 0;
		} elsif (($devtp == 2) || ($devtp == 3) || ($devtp == 4)) {
			my $all = $db->selectall_arrayref("SELECT status,light,temperature,humidity FROM $tabparamsensorlth WHERE device_id = $devid");
			foreach my $row (@$all) {
				my ($sttm, $litm, $tetm, $hutm) = @$row;
				$sttm += 0;
				$stcur{$devid} = $sttm;
				$licur{$devid} = $litm;
				$hucur{$devid} = $hutm;
				$tecur{$devid} = $tetm;
			}
			undef $all;
		}
		$db->do("UPDATE $tabemu SET device_type = '$devtp' WHERE device_id = $devid");
	}

	my $steps = floor($durat / (($break == 0)?1:$break)) - 1;		# easier to connect simulations with round duration
	for (my $ii = 0; $ii <= $steps; $ii += 1) {
		my $curmin = $ii * (($break == 0)?1:$break);
		$curmin += ((($hour / 2) - floor($hour / 2)) * 30) + (floor($hour / 2) * 60);		# add hour start
		$curmin += $week * 24 * 60;								# add day start

		my $all = $db->selectall_arrayref("SELECT id, occupation FROM $tabzones");
		foreach my $row (@$all) {
			my ($zoneid, $zoccu) = @$row;
			if ($zoccu == 1) {
				$teadd{$zoneid} += ($tgain{$zoneid} == 0)?0:((1 / $tgain{$zoneid}) * $break);
			} else {
				$teadd{$zoneid} -= ($tloose{$zoneid} == 0)?0:((1 / $tloose{$zoneid}) * $break);
			}
		}
		undef $all;

		$db->do("INSERT INTO $tabevents VALUES (NULL, DATE_ADD('20120220000000', INTERVAL $curmin MINUTE), $simid, -1, -1, -1, -1, -1, -1)");
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
					$db->do("UPDATE $tabparamsensorlth SET temperature = '$tenew' WHERE device_id = $devid");
				}
				my $hunew = sprintf("%.0f",((($huout{$devid} - $huin{$devid}) / $steps) * $ii) + $huin{$devid}) + 0;
				my $huold = sprintf("%.0f",$hucur{$devid}) + 0;
				$eventh = $hunew;												# H <- humidity	
				unless ($hunew == $huold) {
					$hucur{$devid} = $hunew;
					$db->do("UPDATE $tabparamsensorlth SET humidity = '$hunew' WHERE device_id = $devid");
				}
				my $linew = sprintf("%.0f",(((($liout{$devid} / 10) - ($liin{$devid} / 10)) / $steps) * $ii) + ($liin{$devid} / 10)) * 10;
				my $liold = sprintf("%.0f",($licur{$devid} / 10)) * 10;
				$eventl = $linew;												# L <- light
				unless ($linew == $liold) {
					$licur{$devid} = $linew;
					$db->do("UPDATE $tabparamsensorlth SET light = '$linew' WHERE device_id = $devid");
				}
			} elsif ($devtp == 3) {		# Gas/PIR
				my $tenew = sprintf("%.0f",((($teout{$devid} - $tein{$devid}) / $steps) * $ii) + $tein{$devid}) + 0;
				my $teold = sprintf("%.0f",$tecur{$devid}) + 0;
				$eventt = $tenew;												# T <- CO2
				unless ($tenew == $teold) {
					$tecur{$devid} = $tenew;
					$db->do("UPDATE $tabparamsensorlth SET temperature = '$tenew' WHERE device_id = $devid");
				}
				my $hunew = sprintf("%.0f",((($huout{$devid} - $huin{$devid}) / $steps) * $ii) + $huin{$devid}) + 0;
				my $huold = sprintf("%.0f",$hucur{$devid}) + 0;
				$eventh = $hunew;												# H <- CO (monoxide)
				unless ($hunew == $huold) {
					$hucur{$devid} = $hunew;
					$db->do("UPDATE $tabparamsensorlth SET humidity = '$hunew' WHERE device_id = $devid");
				}
				my $linew = sprintf("%.0f",$liin{$devid}) + 0;
				my $liold = sprintf("%.0f",$licur{$devid}) + 0;
				$eventl = $linew;												# L <- PIR
				unless ($linew == $liold) {
					$licur{$devid} = $liin{$devid};
					$db->do("UPDATE $tabparamsensorlth SET light = '$linew' WHERE device_id = $devid");
				}
			} elsif ($devtp == 4) {		# Sound
				my $linew = sprintf("%.0f",((($liout{$devid} - $liin{$devid}) / $steps) * $ii) + $liin{$devid}) + 0;
				my $liold = sprintf("%.0f",$licur{$devid}) + 0;
				$eventl = $linew;												# L <- sound level
				unless ($linew == $liold) {
					$licur{$devid} = $linew;
					$db->do("UPDATE $tabparamsensorlth SET light = '$linew' WHERE device_id = $devid");
				}
			}
			unless (($eventt == -1) && ($eventh == -1) && ($eventl == -1)) {
				$db->do("INSERT INTO $tabevents VALUES (NULL, DATE_ADD('20120220000000', INTERVAL $curmin MINUTE), $simid, $devzone, $devid, $devtp, $eventt, $eventh, $eventl)");
			}
		}
		$debug .= ase($curmin, $resim, $break);
	}

	my ($endtsec) = $db->selectrow_array("SELECT UNIX_TIMESTAMP(NOW())");
	$action = "view";
	$msgtxt = "Simulation $simid.'$desc' finished in ".($endtsec - $curtsec)." seconds<br><br>View results in <a href=\"./engine.pl?action=getcsv&simid=".$simid."\" class=rzone target=_blank>text form (CSV)</a> or <a href=\"./engine.pl?action=getpng&simid=".$simid."\" class=rzone target=_blank>graph (PNG)</a>";
}

# ase algorithm

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
	my %dzone = ();
	my %dtype = ();		# 2 - THL sensor, 3 - gas/pir sensor, 4 - sound level sensor, 0 - diff return, 1 - diff forward
	my %donli = ();		# 10 - target TH event, 11 - occupancy event, 
	my %ozone = ();
	my $all = $db->selectall_arrayref("SELECT $tabdevices.id,$tabdevices.zone_id,$tabdevices.online,$tabzones.temperature_profile_id,$tabdeviceadvanced.realvar1,$tabparamairflowcontrol.type,$tabzones.occupation FROM $tabdevices LEFT JOIN $tabparamairflowcontrol ON $tabparamairflowcontrol.device_id = $tabdevices.id LEFT JOIN $tabzones ON $tabzones.id = $tabdevices.zone_id LEFT JOIN $tabdeviceadvanced ON ($tabdeviceadvanced.device_id = $tabdevices.id AND $tabdeviceadvanced.type = 5) WHERE $tabdevices.zone_id > -1");
	foreach my $row (@$all) {
		my ($devid, $zoneid, $devon, $ztpro, $rvar1, $diftp, $toccu) = @$row;
		$dzone{$devid} = $zoneid;
		$tprof{$zoneid} = $ztpro;
		$donli{$devid} = $devon;
		if ($diftp ne "") {
			$dtype{$devid} = $diftp + 0;
		} else {
			$dtype{$devid} = $rvar1 + 2;
		}
		$ozone{$zoneid} = $toccu;
	}
	undef $all;

	# get deltaT correction factors
	my ($mazone) = $db->selectrow_array("SELECT id FROM $tabzones ORDER BY volume DESC LIMIT 1");				# main zone is one with bigger volume
	my (%dtcorf, %dtcort) = ((), ());
	my $maincorf = 0.3;			# default recovery factor
	my $all = $db->selectall_arrayref("SELECT zone_id, realvar1, realvar2 FROM $tabzonesadvanced WHERE type = 1");	# 1 - correction. var1 = recover factor, var2 = off timer
	foreach my $row (@$all) {
		my ($zoneid, $corf, $cort) = @$row;
		$dtcorf{$zoneid} = $corf;
		$dtcort{$zoneid} = $cort;
		if ($zoneid == $mazone) {
			$maincorf = $corf;
		}
	}
	undef $all;

	# comfort targets
	my ($wday, $wtime, $simid, $cdate) = $db->selectrow_array("SELECT DATE_FORMAT(DATE_ADD('20120220000000', INTERVAL $acurmin MINUTE),'%w'), DATE_FORMAT(DATE_ADD('20120220000000', INTERVAL $acurmin MINUTE),'%k%i'), sim_id, (data + 0) FROM $tabevents ORDER BY id DESC LIMIT 1");	# 0 - sunday
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
		$db->do("INSERT INTO $tabevents VALUES (NULL, '$cdate', $simid, $zoneid, -1, 10, $tartem, $tarhum, -1)");
		$ttem{$zoneid} = $tartem;
		$thum{$zoneid} = $tarhum;

		# occupancy states
		my $noccu = $ozone{$zoneid};
		if ($ozone{$zoneid} == 0) {		# unoccupied zone
			my ($minpir, $maxpir, $cntpir) = $db->selectrow_array("SELECT MIN(L),MAX(L),COUNT(L) FROM $tabevents WHERE data BETWEEN DATE_ADD('20120220000000', INTERVAL ".($acurmin - ($abreak * 3))." MINUTE) AND DATE_ADD('20120220000000', INTERVAL $acurmin MINUTE) AND zone_id = $zoneid AND type = 3");
			if (($minpir == 1) && ($maxpir == 1) && ($cntpir >= 3)) {
				$noccu = 1;
			}
		} elsif ($ozone{$zoneid} == 1) {	# occupied zone
			my ($minpir, $maxpir, $cntpir) = $db->selectrow_array("SELECT MIN(L),MAX(L),COUNT(L) FROM $tabevents WHERE data BETWEEN DATE_ADD('20120220000000', INTERVAL ".($acurmin - ($abreak * 3))." MINUTE) AND DATE_ADD('20120220000000', INTERVAL $acurmin MINUTE) AND zone_id = $zoneid AND type = 3");
			if (($minpir == 0) && ($maxpir == 0) && ($cntpir >= 3)) {
				my ($co2cur, $co2dev) = (-500, 0);
				my $all = $db->selectall_arrayref("SELECT T FROM $tabevents WHERE data BETWEEN DATE_ADD('20120220000000', INTERVAL ".($acurmin - ($abreak * 10))." MINUTE) AND DATE_ADD('20120220000000', INTERVAL $acurmin MINUTE) AND zone_id = $zoneid AND type = 3 ORDER BY id");
				foreach my $row (@$all) {
					my ($co2val) = @$row;
                                        $co2dev += ($co2cur == -500)?0:($co2val - $co2cur);		# CO2 increasing?
					$co2cur = $co2val;
				}
				undef $all;
				$noccu = ($co2dev > 0)?1:2;
			}
		} elsif ($ozone{$zoneid} == 2) {	# semi-occupied zone
			my ($minpir, $maxpir, $cntpir) = $db->selectrow_array("SELECT MIN(T),MAX(T),COUNT(T) FROM $tabevents WHERE data BETWEEN DATE_ADD('20120220000000', INTERVAL ".($acurmin - ($abreak * 60))." MINUTE) AND DATE_ADD('20120220000000', INTERVAL $acurmin MINUTE) AND zone_id = $zoneid AND type = 11");
			if (($minpir == 2) && ($maxpir == 2) && ($cntpir >= 60)) {
				$noccu = 0;
			}
			($minpir, $maxpir, $cntpir) = $db->selectrow_array("SELECT MIN(L),MAX(L),COUNT(L) FROM $tabevents WHERE data BETWEEN DATE_ADD('20120220000000', INTERVAL ".($acurmin - ($abreak * 3))." MINUTE) AND DATE_ADD('20120220000000', INTERVAL $acurmin MINUTE) AND zone_id = $zoneid AND type = 3");
			if (($minpir == 1) && ($maxpir == 1) && ($cntpir >= 3)) {
				$noccu = 1;
			}
		}
		unless ($ozone{$zoneid} == $noccu) {
			$db->do("UPDATE $tabzones SET occupation = $noccu WHERE id = $zoneid");
		}
		$ozone{$zoneid} = $noccu;

		# cycles
		# 0 - none, 1 - ventilation, 2 - reheating, 3 - heat call, 4 - preheating?
                my ($cycst, $cycton, $cyctoff, $cycpr) = $db->selectrow_array("SELECT state, timer_on, timer_off, priority FROM $tabstates WHERE zone_id = $zoneid");
                my ($avgte, $avghu, $maxte, $cntte, $varte) = $db->selectrow_array("SELECT AVG(T),AVG(H),MAX(T),COUNT(T),VARIANCE(T) FROM $tabevents WHERE data BETWEEN DATE_ADD('20120220000000', INTERVAL ".($acurmin - ($abreak * 1))." MINUTE) AND DATE_ADD('20120220000000', INTERVAL $acurmin MINUTE) AND zone_id = $zoneid AND type = 2");
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
						$cycpr = 1;				# lower number is lower priority
					} else {
						$cycst = 1;				# zone occupied and comfort
						$cyctoff = floor(5 / $abreak);		# run vent for 5 min 
						$cycton = floor(15 / $abreak);		# each 15 min
						$cycpr = 1;
					}
				} else {
					if ($avgte < ($tartem - ($hystf + $zdeltat))) {	# non or semi occ with deltaT
						($cycst, $cycton) = (2, 0);		# run reheat immediately
						$cyctoff = floor(10 / $abreak);		# 10 minutes = N cycles * heartbeat duration
						$cycpr = 1;				# lower number is lower priority
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
			if ($cycton == 0) {
				$cyctoff --;
				if ($avgte < ($tartem + $hystf)) {
					if ($cyctoff < (floor(10 / $abreak) - 3)) {
						my ($temcur, $temdev) = (-500, 0);
						my $all = $db->selectall_arrayref("SELECT T FROM $tabevents WHERE data BETWEEN DATE_ADD('20120220000000', INTERVAL ".($acurmin - ($abreak * 3))." MINUTE) AND DATE_ADD('20120220000000', INTERVAL $acurmin MINUTE) AND zone_id = $zoneid AND type = 2 ORDER BY id");
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
							$cyctoff = floor(25 / $abreak);
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
			if ($cycton == 0) {
				$cyctoff --;
				if ($avgte < ($tartem - $hystf)) {
					if ($cyctoff == 0) {
						if ($ozone{$zoneid} == 1) {
							($cycst, $cyctoff, $cycton, $cycpr) = (3, floor(25 / $abreak), floor(10 / $abreak), 2);		# unsuccessful heat and occupied
						} else {
							($cycst, $cyctoff, $cycton, $cycpr) = (1, floor(10 / $abreak), 0, 1);	# unsuccessful heat and unoccupied
						}
					}
				} else {
					($cycst, $cyctoff, $cycton, $cycpr) = (1, floor(10 / $abreak), 0, 1);	# successful heat
				}
			} else {
				$cycton --;
			}
		}

		# exclusions
                my ($maxcd, $maxco) = $db->selectrow_array("SELECT T,H FROM $tabevents WHERE data BETWEEN DATE_ADD('20120220000000', INTERVAL ".($acurmin - ($abreak * 1))." MINUTE) AND DATE_ADD('20120220000000', INTERVAL $acurmin MINUTE) AND zone_id = $zoneid AND type = 3");
                if (($maxcd > 1300) || ($maxco > 35)) {
                	($cycst, $cyctoff, $cycton, $cycpr) = (1, floor(30 / $abreak), 0, 3);	# immediate vent for 30 minutes, high priority
                }
		$db->do("INSERT INTO $tabstates VALUES (NULL, $zoneid, $cycst, $cycton, $cyctoff, $cycpr) ON DUPLICATE KEY UPDATE state = $cycst, timer_on = $cycton, timer_off = $cyctoff, priority = $cycpr");
                $db->do("INSERT INTO $tabevents VALUES (NULL, '$cdate', $simid, $zoneid, -1, 11, ".$ozone{$zoneid}.", $cycst, $cyctoff)");

                # humidity
		if ($avghu < 35) {
			# will add humidifier event here
		} else {
			unless ((($tarhum - $hysth) < $avghu) && ($avghu < ($tarhum + $hysth))) {
				# humidity not satisfied event here
			}
		}
	}

	# assort cycles and do actions
	my ($relid, $rheat, $rcool, $rfan) = $db->selectrow_array("SELECT id, heat_on,cool_on,fan_on FROM $tabcontrol WHERE type = 1");
	my $all = $db->selectall_arrayref("SELECT zone_id, state, priority, timer_on FROM $tabstates ORDER BY priority,id");
	foreach my $row (@$all) {
		my ($zoneid, $state, $prior, $timer) = @$row;
		my ($drid, $dfid, $dret, $dfor) = (-1, -1, -1, -1);
                foreach my $devid (keys %dzone) {
                	if (($dtype{$devid} == 0) && ($dzone{$devid} == $zoneid)) {		# return diff
                		$drid = $devid;
				my ($dret) = $db->selectrow_array("SELECT controll FROM $tabparamairflowcontrol WHERE device_id = $drid");
                	} elsif (($dtype{$devid} == 1) && ($dzone{$devid} == $zoneid)) {	# forward diff
                		$dfid = $devid;
				my ($dfor) = $db->selectrow_array("SELECT controll FROM $tabparamairflowcontrol WHERE device_id = $dfid");
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
			$db->do("UPDATE $tabparamairflowcontrol SET controll = $dret WHERE device_id = $drid");
                	$db->do("INSERT INTO $tabevents VALUES (NULL, '$cdate', $simid, $zoneid, $drid, 0, $dret, -1, $state)");	# save system state in addition to diff state
                }
                unless ($dfid == -1) {
			$db->do("UPDATE $tabparamairflowcontrol SET controll = $dfor WHERE device_id = $dfid");
                	$db->do("INSERT INTO $tabevents VALUES (NULL, '$cdate', $simid, $zoneid, $dfid, 1, $dfor, -1, $state)");	# save system state in addition to diff state
                }
	}
	undef $all;
	$db->do("UPDATE $tabcontrol SET heat_on = $rheat, cool_on = $rcool, fan_on = $rfan WHERE id = $relid");
	$db->do("INSERT INTO $tabevents VALUES (NULL, '$cdate', $simid, $mazone, -1, 12, $rheat, $rfan, $rcool)");

	return $debug;
}

if ($action eq "save") {
	if ($curzone == 0) {
		if (exists $FORM{zoneid}) {
			my ($id, $delay, $durat, $break, $week, $hour, $desc, $outdin, $outdout) = ($FORM{zoneid}, $FORM{preheat}, $FORM{duration}, $FORM{breakout}, $FORM{dayfrom}, $FORM{timefrom}, $FORM{description}, $FORM{outdin}, $FORM{outdout});
			$db->do("UPDATE $tabzonesim SET delay = '$delay', duration = '$durat', breakout = '$break', weekday = '$week', daytime = '$hour', description = '$desc', outdoor_in = '$outdin', outdoor_out = '$outdout' WHERE id = $id");
			$action = "view";
			$msgtxt = "Simulation settings saved";
		} else {
			$action = "newsim";
		}
	} else {
		my ($tmax, $tmin, $tloose, $tgain) = (($FORM{tmax} + 0), ($FORM{tmin} + 0), ($FORM{tloose} + 0), ($FORM{tgain} + 0));
		$db->do("INSERT INTO $tabzonesimadv VALUES ($curzone, '$tgain', '$tloose', '$tmin', '$tmax') ON DUPLICATE KEY UPDATE gain = '$tgain', loose = '$tloose', tmin = '$tmin', tmax = '$tmax'");
		my @vids = ("status","temperature","humidity","light");
		foreach my $frkey (keys %FORM) {
			if ($frkey =~ m/^d(\d+)v(\d+)(i|o)$/) {
				my ($devid, $varid, $inout) = ($1, $2, $3);
				my $colname = $vids[$varid]."_".(($inout eq "i")?"in":"out");
				$db->do("INSERT INTO $tabemu VALUES (NULL, $devid, 0, 0, 0, 0, 0, 0, 0, 0, -1)");
				$db->do("UPDATE $tabemu SET $colname = '".$FORM{$frkey}."' WHERE device_id = $devid");
			}
		}
		$action = "view";
		$msgtxt = "Zone $curzone parameters saved";
	}
}

if ($action eq "newsim") {
	$db->do("DELETE FROM $tabemu");
	$db->do("DELETE FROM $tabstates");
	$db->do("INSERT INTO $tabzonesim VALUES (NULL, 20, 60, 1, 0, 0, NOW(), 20, 20, '')");
	$db->do("UPDATE $tabzones SET occupation = 0");
	$msgtxt = "New simulation created";
	$action = "view";
}

if ($action eq "reslastsim") {
	my $simid = $FORM{zoneid};
	my $curmin = ($FORM{dayfrom} * 24 * 60) + ($FORM{timefrom} * 30);
	$db->do("DELETE FROM $tabevents WHERE sim_id = $simid AND data between DATE_ADD('20120220000000', INTERVAL $curmin MINUTE) and 20130101000000");
	$db->do("UPDATE $tabzones SET occupation = 0");
	$db->do("DELETE FROM $tabstates");
	$msgtxt = "Simulation $simid last results cleared";
	$action = "view";
}

if ($action eq "resetsim") {
	my $simid = $FORM{zoneid};
	$db->do("DELETE FROM $tabevents WHERE sim_id = $simid");
	$msgtxt = "Simulation $simid results cleared";
	$action = "view";
}

if ($action eq "connsim") {
	my $simid = $FORM{zoneid};
	my $break = $FORM{breakout};

        my ($endday, $endhour, $endmin) = $db->selectrow_array("SELECT DATE_FORMAT(DATE_ADD(data, INTERVAL $break MINUTE),'%w'), DATE_FORMAT(DATE_ADD(data, INTERVAL $break MINUTE),'%k'), DATE_FORMAT(DATE_ADD(data, INTERVAL $break MINUTE),'%i') FROM $tabevents WHERE sim_id = $simid ORDER BY data DESC LIMIT 1");
        $endday = (($endday == 0)?6:($endday - 1));
        $endhour = ($endhour * 2) + ceil($endmin / 30);
        $db->do("UPDATE $tabzonesim SET weekday = '$endday', daytime = '$endhour', outdoor_in = outdoor_out WHERE id = $simid");
        $db->do("UPDATE $tabemu SET light_in = light_out, humidity_in = humidity_out WHERE device_type = 2");
        $db->do("UPDATE $tabemu SET $tabemu.temperature_in = (SELECT $tabparamsensorlth.temperature FROM $tabparamsensorlth WHERE $tabparamsensorlth.device_id = $tabemu.device_id) WHERE $tabemu.device_type = 2");	# connect to previous sim easily
        $db->do("UPDATE $tabemu SET temperature_in = temperature_out, humidity_in = humidity_out WHERE device_type = 3");
        $db->do("UPDATE $tabemu SET light_in = light_out WHERE device_type = 4");

	$msgtxt = "Simulation $simid start moment and initial sensor values fixed";
	$action = "view";
}

# view current settings

if ($action eq "view") {
	my $vinlist = "";
	my $zonelist = "<option value=\"0\"".(($newzone == 0)?" selected":"").">&nbsp;- Global settings -&nbsp;</option>";
	my $voutlist = "";
	my $buttlist = "";

	if ($newzone == 0) {
		my $simid = -1;
		my $all = $db->selectall_arrayref("SELECT id,delay,duration,breakout,weekday,daytime,description,created,outdoor_in,outdoor_out FROM $tabzonesim ORDER BY id DESC LIMIT 1");
		foreach my $row (@$all) {
			my ($id, $delay, $durat, $break, $week, $hour, $desc, $creat, $outdin, $outdout) = @$row;
			$vinlist .= "<table border=0 cellpadding=0 cellspacing=0><input type=hidden name=zoneid value=$id><input type=hidden name=preheat value='$delay'>\n";
			$vinlist .= "<tr><td class=bene align=center colspan=2><font color=#567>Simulation panel</font></td></tr>\n";
			$vinlist .= "<tr><td class=newsb align=left>Created</td><td class=newsb align=left>$creat</td></tr>\n";
			$vinlist .= "<tr><td class=newsg align=left>Description</td><td class=newsb align=left><input type=text class=forms12l150b0 maxlength=200 name=description value='".(($desc eq "")?("New ".$id):$desc)."'></td></tr>\n";
			$vinlist .= "<tr><td class=newsg align=left>Start weekday</td><td class=newsb align=left><select name=\"dayfrom\" class=tah12n100><option value='6'".(($week == 6)?" selected":"").">Sunday<option value='0'".(($week == 0)?" selected":"").">Monday<option value='1'".(($week == 1)?" selected":"").">Tuesday<option value='2'".(($week == 2)?" selected":"").">Wednesday<option value='3'".(($week == 3)?" selected":"").">Thursday<option value='4'".(($week == 4)?" selected":"").">Friday<option value='5'".(($week == 5)?" selected":"").">Saturday</td></tr>\n";
			$vinlist .= "<tr><td class=newsg align=left>Start hour</td><td class=newsb align=left><select name=\"timefrom\" class=tah12n80>";
			for (my $ii = 0; $ii < 48; $ii ++) {
				$vinlist .= "<option value='$ii'".(($ii == $hour)?" selected":"").">".sprintf("%02d:%02d",floor(($ii - (($ii <= 1)?-24:(($ii >= 24)?(($ii < 26)?0:24):0))) / 2),(($ii / 2) - floor($ii / 2)) * 60)." ".(($ii >= 24)?"PM":"AM");
			}
			$vinlist .= "</select></td></tr>\n";
			$vinlist .= "<tr><td class=newsg align=left>Test duration</td><td class=newsb align=left><input type=text class=forms12l50b0 maxlength=6 name=duration value='$durat'> minutes</td></tr>\n";
			$vinlist .= "<tr><td class=newsg align=left>Time breakout</td><td class=newsb align=left><input type=text class=forms12l50b0 maxlength=6 name=breakout value='$break'> minutes</td></tr>\n";
			$vinlist .= "<tr><td class=newsg align=left>Outdoor T&ordm;</td><td class=newsb align=left><input type=text class=forms12l40b0 maxlength=6 name=outdin value=\"$outdin\"><b>&rarr;</b><input type=text class=forms12l40b0 maxlength=6 name=outdout value=\"$outdout\"> degree</td></tr>\n";
			$vinlist .= "</table>\n";
			$simid = $id;
		}
		undef $all;

		my $all = $db->selectall_arrayref("SELECT id,type,xbee_addr64,heat_on,cool_on,fan_on,not_connect FROM $tabcontrol ORDER BY id DESC");
		foreach my $row (@$all) {
			my ($id, $type, $mac, $heat, $cool, $fan1, $fan2) = @$row;
			$voutlist .= (($voutlist eq "")?"":"<div class=in10></div>\n")."<table border=0 cellpadding=0 cellspacing=0>\n";
			$voutlist .= "<tr><td class=bene align=center colspan=2><font color=#567>Relays module : </font>".(($type == 1)?"XBee Router":"USB Coordinator")."</td></tr>\n";
			$voutlist .= "<tr><td class=newsb align=left>Device ID:MAC</td><td class=newsb align=left>".$id.":".uc($mac)."</td></tr>\n";
			$voutlist .= "<tr><td class=newsb align=left>Heating status</td><td class=newsb align=left>".(($heat == 0)?"OFF":"ON")."</td></tr>\n";
			$voutlist .= "<tr><td class=newsb align=left>Cooling status</td><td class=newsb align=left>".(($cool == 0)?"OFF":"ON")."</td></tr>\n";
			$voutlist .= "<tr><td class=newsb align=left>Fan #1 status</td><td class=newsb align=left>".(($fan1 == 0)?"OFF":"ON")."</td></tr>\n";
			$voutlist .= "<tr><td class=newsb align=left>Fan #2 status</td><td class=newsb align=left>".(($fan2 == 0)?"OFF":"ON")."</td></tr>\n";
			$voutlist .= "</table>\n";
		}
		undef $all;

		$buttlist = "<input name=button1 type=submit value=\"Apply global settings\" class=subgrn>&nbsp;&nbsp;<input name=button2 type=submit value=\"Start processing\" class=subblu>&nbsp;&nbsp;<input name=button3 type=submit value=\"New simulation\" class=subred onClick=\"javasript:return confirm ('Are you sure to create new simulation?');\">&nbsp;&nbsp;<input name=button4 type=submit value=\"Clear all results\" class=subred onClick=\"javascript:return confirm ('Are you sure to clear simulation results?');\">&nbsp;&nbsp;<input name=button6 type=submit value=\"Clear last results\" class=subred onClick=\"javascript:return confirm ('Are you sure to clear last simulation results?');\">";
		my ($simexists) = $db->selectrow_array("SELECT COUNT(*) FROM $tabevents WHERE sim_id = $simid");
		if ($simexists) {
			$buttlist .= "<div class=in10></div><input name=button5 type=submit value=\"Connect sim parts\" class=subblu>&nbsp;&nbsp;<input name=buttont0 type=submit value=\"Get CSV sheet\" class=subblu OnClick=\"window.open('./engine.pl?action=getcsv&simid=".$simid."')\">&nbsp;&nbsp;<input name=buttont1 type=submit value=\"Get PNG graph\" class=subblu OnClick=\"window.open('./engine.pl?action=getpng&simid=".$simid."')\">";
		}
	} else {
		my ($tgain, $tloose, $tmin, $tmax) = $db->selectrow_array("SELECT gain, loose, tmin, tmax FROM $tabzonesimadv WHERE zone_id = $newzone");
                ($tgain, $tloose, $tmin, $tmax) = (($tgain + 0), ($tloose + 0), ($tmin + 0), ($tmax + 0));
		$vinlist .= "<table border=0 cellpadding=0 cellspacing=0>";
		$vinlist .= "<tr><td class=bene align=center colspan=2>Heat loose/gain settings</td></tr>\n";
		$vinlist .= "<tr><td class=newsg align=left nowrap=\"true\">Heat gain</td><td class=newsb align=left nowrap=\"true\"><input type=text class=forms12l40b0 maxlength=6 name=tgain value=\"$tgain\"> minutes per 1 degree</td></tr>\n";
		$vinlist .= "<tr><td class=newsg align=left nowrap=\"true\">Heat loose</td><td class=newsb align=left nowrap=\"true\"><input type=text class=forms12l40b0 maxlength=6 name=tloose value=\"$tloose\"> minutes per 1 degree</td></tr>\n";
		$vinlist .= "<tr><td class=newsg align=left nowrap=\"true\">Maximum T</td><td class=newsb align=left nowrap=\"true\"><input type=text class=forms12l40b0 maxlength=6 name=tmax value=\"$tmax\"> degrees + outdoor T</td></tr>\n";
		$vinlist .= "<tr><td class=newsg align=left nowrap=\"true\">Minimum T</td><td class=newsb align=left nowrap=\"true\"><input type=text class=forms12l40b0 maxlength=6 name=tmin value=\"$tmin\"> degrees + outdoor T</td></tr>\n";
		$vinlist .= "</table>\n";
		my ($ztpro, $tartem, $tarhum) = $db->selectrow_array("SELECT $tabzones.temperature_profile_id, $tabtemperatureprofile.temperature, $tabtemperatureprofile.humidity FROM $tabtemperatureprofile,$tabzones WHERE $tabzones.id = $newzone AND $tabtemperatureprofile.id = $tabzones.temperature_profile_id");
		my ($wday, $wtime) = $db->selectrow_array("SELECT weekday,daytime FROM $tabzonesim ORDER BY id DESC LIMIT 1");
		my $wtime = (($wtime - (floor($wtime / 100) * 100)) >= 30)?(floor($wtime / 100) * 100 + 30):(floor($wtime / 100) * 100);
		my ($ttartem) = $db->selectrow_array("SELECT temperature FROM $tabtemperaturebreakout WHERE temperature_profile_id = $ztpro AND dayofweek = $wday AND timeframe = $wtime");
		$ttartem += 0;
		$tartem = ($ttartem > 0)?$ttartem:$tartem;
		my $all = $db->selectall_arrayref("SELECT $tabdevices.id,$tabdevices.description,$tabdevices.xbee_addr64,$tabparamairflowcontrol.id,$tabparamairflowcontrol.type,$tabparamairflowcontrol.controll,$tabparamsensorlth.id,$tabparamsensorlth.status,$tabdeviceadvanced.realvar1,$tabemu.status_in,$tabemu.status_out,$tabemu.light_in,$tabemu.light_out,$tabemu.temperature_in,$tabemu.temperature_out,$tabemu.humidity_in,$tabemu.humidity_out FROM $tabdevices LEFT JOIN $tabparamairflowcontrol ON $tabparamairflowcontrol.device_id = $tabdevices.id LEFT JOIN $tabparamsensorlth ON $tabparamsensorlth.device_id = $tabdevices.id LEFT JOIN $tabdeviceadvanced ON ($tabdeviceadvanced.device_id = $tabdevices.id AND $tabdeviceadvanced.type = 5) LEFT JOIN $tabemu ON $tabemu.device_id = $tabdevices.id WHERE $tabdevices.zone_id = $newzone");
		foreach my $row (@$all) {
			my ($id, $desc, $mac, $difid, $diftp, $difst, $senid, $senst, $advtp, $inst, $outst, $inli, $outli, $intem, $outtem, $inhum, $outhum) = @$row;
			$advtp += 0;
			if ($senid ne "") {
				$vinlist .= (($vinlist eq "")?"":"<div class=in10></div>\n")."<table border=0 cellpadding=0 cellspacing=0>\n";
				$vinlist .= "<tr><td class=bene align=center colspan=2><font color=#567>".(($advtp == 0)?"Environment":"Occupation")." sensor : </font>".$desc."</td></tr>\n";
				$vinlist .= "<tr><td class=newsb align=left>Device ID:MAC</td><td class=newsb align=left>".$id.":".uc($mac)."</td></tr>\n";
				if ($advtp == 0) {
					($inli eq "")?($inli = $comfli):($inli += 0);
					($outli eq "")?($outli = $comfli):($outli += 0);
					($intem eq "")?($intem = $comftem):($intem += 0);
					($outtem eq "")?($outtem = $comftem):($outtem += 0);
					($inhum eq "")?($inhum = $comfhum):($inhum += 0);
					($outhum eq "")?($outhum = $comfhum):($outhum += 0);
					$vinlist .= "<tr><td class=newsg align=left>Temperature</td><td class=newsb align=left nowrap=\"true\"><input type=text class=forms12l40b0 maxlength=6 name=d".$id."v1i value=\"$intem\"><b>&rarr;</b><input type=text class=forms12l40b0 maxlength=6 name=d".$id."v1o value=\"$outtem\"> degree (Tgt: ".$tartem.")</td></tr>\n";
					$vinlist .= "<tr><td class=newsg align=left>Humidity</td><td class=newsb align=left nowrap=\"true\"><input type=text class=forms12l40b0 maxlength=6 name=d".$id."v2i value=\"$inhum\"><b>&rarr;</b><input type=text class=forms12l40b0 maxlength=6 name=d".$id."v2o value=\"$outhum\"> percent (Tgt: ".$tarhum.")</td></tr>\n";
					$vinlist .= "<tr><td class=newsg align=left>Light Level</td><td class=newsb align=left><input type=text class=forms12l40b0 maxlength=6 name=d".$id."v3i value=\"$inli\"><b>&rarr;</b><input type=text class=forms12l40b0 maxlength=6 name=d".$id."v3o value=\"$outli\"> lux</td></tr>\n";
				} elsif ($advtp == 1) {
					($inli eq "")?($inli = $comfpir):($inli += 0);
					($outli eq "")?($outli = $comfpir):($outli += 0);
					($intem eq "")?($intem = $comfco1):($intem += 0);
					($outtem eq "")?($outtem = $comfco1):($outtem += 0);
					($inhum eq "")?($inhum = $comfco2):($inhum += 0);
					($outhum eq "")?($outhum = $comfco2):($outhum += 0);
					$vinlist .= "<tr><td class=newsg align=left>CO Level</td><td class=newsb align=left><input type=text class=forms12l40b0 maxlength=6 name=d".$id."v1i value=\"$intem\"><b>&rarr;</b><input type=text class=forms12l40b0 maxlength=6 name=d".$id."v1o value=\"$outtem\"> ppm</td></tr>\n";
					$vinlist .= "<tr><td class=newsg align=left>CO<sup>2</sup> Level</td><td class=newsb align=left><input type=text class=forms12l40b0 maxlength=6 name=d".$id."v2i value=\"$inhum\"><b>&rarr;</b><input type=text class=forms12l40b0 maxlength=6 name=d".$id."v2o value=\"$outhum\"> ppm</td></tr>\n";
					$vinlist .= "<tr><td class=newsg align=left>PIR Status</td><td class=newsb align=left><input type=radio name=d".$id."v3i value=1".(($inli == 0)?"":" checked").">ON&nbsp;<input type=radio name=d".$id."v3i value=0".(($inli == 0)?" checked":"").">OFF</td></tr>\n";
				} elsif ($advtp == 2) {
					$vinlist .= "<tr><td class=newsg align=left>Sound Level</td><td class=newsb align=left><input type=text class=forms12l40b0 maxlength=6 name=d".$id."v1i value=\"$intem\"><b>&rarr;</b><input type=text class=forms12l40b0 maxlength=6 name=d".$id."v1o value=\"$outtem\"> dB</td></tr>\n";
				}
				$vinlist .= "</table>\n";
			} elsif ($difid ne "") {
				($inli eq "")?($inli = $comfdif):($inli += 0);
				($outli eq "")?($outli = $comfdif):($outli += 0);
				$diftp += 0;
				$difst += 0;
				my $diftst = "status unknown";
				if ($difst == 0) {
					$diftst = "fully closed";
				} elsif (($difst > 0) && ($difst < 100)) {
					$diftst = $difst."% opened";
				} elsif ($difst >= 100) {
					$diftst = "fully opened";
				}
				$voutlist .= (($voutlist eq "")?"":"<div class=in10></div>\n")."<table border=0 cellpadding=0 cellspacing=0>\n";
				$voutlist .= "<tr><td class=bene align=center colspan=2><font color=#567>".(($diftp == 0)?"Return":"Forward")." diffuser : </font>".$desc."</td></tr>\n";
				$voutlist .= "<tr><td class=newsb align=left>Device ID:MAC</td><td class=newsb align=left>".$id.":".uc($mac)."</td></tr>\n";
				$voutlist .= "<tr><td class=newsb align=left>Diffuser status</td><td class=newsb align=left>Flaps $diftst</td></tr>\n";
				$voutlist .= "<tr><td class=newsg align=left>Online Status</td><td class=newsb align=left><input type=radio name=d".$id."v3i value=1".(($inli == 0)?"":" checked").">ON&nbsp;<input type=radio name=d".$id."v3i value=0".(($inli == 0)?" checked":"").">OFF</td></tr>\n";
				$voutlist .= "</table>\n";
			}
		}
		undef $all;

		$buttlist = "<input name=button1 type=submit value=\"Apply changes to zone\" class=subgrn><input type=hidden name=zoneid value=$newzone>";
	}

	my ($mainzone) = $db->selectrow_array("SELECT id FROM $tabzones ORDER BY volume DESC LIMIT 1");
	my $all = $db->selectall_arrayref("SELECT $tabzones.id,$tabzones.description FROM $tabzones ORDER BY $tabzones.id");
	foreach my $row (@$all) {
		my ($id, $desc) = @$row;
		$zonelist .= "<option value=\"$id\"".(($newzone == $id)?" selected":"").">&nbsp;$id. ".$desc."&nbsp;".(($mainzone == $id)?"(main)&nbsp;":"")."</option>";
	}
	undef $all;

	$curzone = $newzone;
	$msgtxt .= (($msgtxt eq "")?"Zone $curzone parameters loaded":"");
	open(INF,$mainweb);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--debug--/$debug/g;
		$inline =~ s/--version--/$version/g;
		$inline =~ s/--curzone--/$curzone/g;
		$inline =~ s/--zonelist--/$zonelist/g;
		$inline =~ s/--input--/$vinlist/g;
		$inline =~ s/--output--/$voutlist/g;
		$inline =~ s/--buttons--/$buttlist/g;
		$inline =~ s/--autosave--/$autosave/g;
		$inline =~ s/--message--/$msgtxt/g;
		$outweb .= $inline."\n";
	}
	close(INF);
}

# print out result

print "Content-type: text/html\n\n";
print $outweb."\n";

# endofworld

$db->disconnect;
exit;
7;
