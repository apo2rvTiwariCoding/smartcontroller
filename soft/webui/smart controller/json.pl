#!c:/perl/bin/perl.exe
#!c:/xampp/perl/bin/perl.exe
#!/usr/bin/perl

use DBI;
use POSIX;
use Time::Local;
use strict;
use Net::Domain qw (hostname hostfqdn hostdomain);

# get current datetime

my ($cursec,$curmin,$curhour,$curday,$curmon,$curyear) = (localtime)[0,1,2,3,4,5];
my $loadtime = time();
$curmon ++;
$curday = sprintf("%02d",$curday);
$curmon = sprintf("%02d",$curmon);
$cursec = sprintf("%02d",$cursec);
$curmin = sprintf("%02d",$curmin);
$curhour = sprintf("%02d",$curhour);
$curyear += 1900;
my $curdatetime = "$curyear-$curmon-$curday $curhour:$curmin:$cursec";
my $curampm = 1;
if ($curhour > 11) {
	$curampm ++;	# 1 - AM, 2 - PM
}
my @monthtxt = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
my @ampmtxt = ("am","pm");
my @yesnotxt = ("no","yes");
my @bitsev = (1, 2, 4);		# severity to bitmask

# Get data from memory

my %FORM = ();
my $submeth = "post";
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
	}
}

# get server data

my $selfpath = $ENV{'PATH_TRANSLATED'};
$selfpath =~ s/\\[^\\]*$/\\/;
if ($selfpath eq "") {
	$selfpath = $ENV{'SCRIPT_FILENAME'};
	$selfpath =~ s/\/[^\/]*$/\//;
}
my $servername = $ENV{'SERVER_NAME'};
my $serverport = ($ENV{'SERVER_PORT'} eq "")?"80":$ENV{'SERVER_PORT'};

# read config

my %config = ();
my $confile = $selfpath."settings-json.cnf";
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

my $version = (exists $config{version})?$config{version}:"14.12.23.0";	# version for controller devices
my $debugmode = (exists $config{debug})?$config{debug}:0;		# simulation mode off by default
my $advmode = (exists $config{advanced})?$config{advanced}:1;		# corrections allowed
my $cdbprefix = (exists $config{sysid})?$config{dbprefix}:"smart";	# prefix for cloud database

# hardcoded constants and moar

my $username = $FORM{login};
my $password = $FORM{password};
my $debug = "";
my @occstates = ("Unoccupied", "Occupied", "Pre-heated");
my @alarmdb = ("alarms_retrosave", "alarms_zigbee", "alarms_system", "alarms_networks", "alarms_pressure");		# corresponding data for alarms_types table

# connect to mysql
 
my $dsn = 'DBI:mysql:'.$config{dbname}.":".$config{dbhost};
my $db_user_name = $config{dbuser};
my $db_password = $config{dbpass};
my $db = DBI->connect($dsn, $db_user_name, $db_password) or seclose(7);
if (! $db) {
	exit;
}

# modes

my $uimode = $FORM{mode};
my $uismode = $FORM{submode};
my $action = $FORM{action};
if (($uimode eq "") && ($uismode eq "") && ($action eq "")) {
	$uimode = "zones";
}
my $textout = "";
my $jsonout = "";

# identify device

my $deviceid = lc($FORM{deviceid});
$deviceid =~ s/\-//g;
my $homeid = 0;

# login

if ($action eq "login") {
	my $username = lc($FORM{username});		# username is always lowercase
	if ($username =~ /^(.+)\@(\d+)$/) {		# login with domain
		$username = $1;
		$homeid = $2 + 0;			# numeric sysid here
	}
	my $dbpref = "";
	if ($homeid > 0) {		# homeid exists? check for cloud connection
		my $all = $db->selectall_arrayref("SELECT id, house_id FROM systems WHERE house_id = $homeid");
		$homeid = 0;
		foreach my $row (@$all) {
			my ($id, $hid) = @$row;
			if ($hid > 0) {
				$homeid = $hid;
				$dbpref = $cdbprefix.sprintf("%05d",$homeid).".";
			}
		}
		undef $all;		
	}
	my $password = $FORM{password};
	if (($username ne "") && ($password ne "")) {
		my $all = $db->selectall_arrayref("SELECT id,access FROM ".$dbpref."users WHERE login='$username' AND password='$password'");
		foreach my $row (@$all) {
			my ($id, $type) = @$row;
			$db->do("INSERT INTO sessions VALUES (NULL, $id, '$deviceid', NOW(), DATE_ADD(NOW(), INTERVAL 1 DAY), $type, $homeid)");
			$textout = "Success";
		}
		undef $all;
	}
	$textout = ($textout eq "Success")?$textout:"Unknown";
}

# logoff

if ($action eq "logout") {
	$db->do("UPDATE sessions SET expires=DATE_SUB(NOW(), INTERVAL 1 HOUR) WHERE hash='$deviceid'");
	$textout = "Success";
}

# session check

my ($userlevel, $sessionid, $clientid) = (-1, -1, -1);
if ($uimode ne "") {
	my $all = $db->selectall_arrayref("SELECT id_client,type,dbid,id_session FROM sessions WHERE hash='$deviceid' AND expires > NOW()");
	foreach my $row (@$all) {
		my ($id, $type, $dbid, $seid) = @$row;
		$userlevel = $type;			# 0 - user, 1 - admin, -1 - none
		$sessionid = $seid;
		$clientid = $id;
		$homeid = $dbid;
	}
	undef $all;
	if ($sessionid >= 0) {		# extend session
		$db->do("UPDATE sessions SET expires = DATE_ADD(NOW(), INTERVAL 1 DAY) WHERE id_session = '$sessionid'");
	}
}

# reconnect to local db if cloud found

if ($homeid > 0) {
	$db->disconnect();
	$dsn = 'DBI:mysql:'.$cdbprefix.sprintf("%05d",$homeid).":".$config{dbhost};
	$db = DBI->connect($dsn, $db_user_name, $db_password) or seclose(7);
	if (! $db) {
		exit;
	}
}

# read HVAC config for system

my %HVAC = ();
{
	my $all = $db->selectall_arrayref("SELECT option_,value_ FROM hvac WHERE submenu > 0");		# read HVAC config for system only
	foreach my $row (@$all) {
		my ($opt, $val) = @$row;
		$HVAC{$opt} = $val;
	}
}

# views

if (($uimode eq "notifications") && ($userlevel >= 0)) {			# return notification status
	my $nenabled = $HVAC{"system.notifications_email"} + 0;
	my $nsnabled = $HVAC{"system.notifications_sms"} + 0;
	$jsonout .= "{\"group\":\"0\",\"value\":\"$nenabled\"},";
	{		# notification emails
		my $all = $db->selectall_arrayref("SELECT id, email, phone, severity FROM notifications ORDER BY id desc");	# get list of emails and phones
		foreach my $row (@$all) {
			my ($nid, $email, $phone, $sever) = @$row;
			if ((length($email)) && (defined($email))) {
				$jsonout .= "{\"group\":\"1\",\"id\":\"$nid\",\"email\":\"$email\",\"notices\":\"".(($sever & 1)?"checked":"")."\",\"warnings\":\"".(($sever & 2)?"checked":"")."\",\"alarms\":\"".(($sever & 4)?"checked":"")."\"},";
			}
			if ((length($phone)) && (defined($phone))) {
				$jsonout .= "{\"group\":\"2\",\"id\":\"$nid\",\"phone\":\"$phone\",\"notices\":\"".(($sever & 1)?"checked":"")."\",\"warnings\":\"".(($sever & 2)?"checked":"")."\",\"alarms\":\"".(($sever & 4)?"checked":"")."\"},";
			}
		}
		undef $all;
	}
	$jsonout .= "{\"group\":\"3\",\"value\":\"$nsnabled\"}";
}

if (($uimode eq "thermostatpage") && ($userlevel >= 0)) {			# thermostat page handler
	{		# comfort level and other thermostat params
		$jsonout .= "{\"group\":\"1\",\"comflevelt\":\"".$HVAC{"thermostat.target_t"}."\",\"comflevelh\":\"".$HVAC{"thermostat.target_h"}."\",\"mainmode\":\"".$HVAC{"thermostat.mode"}."\",\"cfanslider\":\"".$HVAC{"thermostat.fan_mode"}."\",\"custslider\":\"".$HVAC{"thermostat.connected"}."\"},";
	}
	{		# bypass switch status
		my $bypass = 0;
		my $all = $db->selectall_arrayref("SELECT status FROM bypass ORDER BY id DESC LIMIT 1");
		foreach my $row (@$all) {
			($bypass) = @$row;
		}
		undef $all;
		$jsonout .= "{\"group\":\"2\",\"bypassmode\":\"$bypass\"},";
	}
	{		# thermostat wires status
		my ($wirew1, $wirew2, $wirey1, $wirey2, $wireg, $wireob, $avgmzt, $wireaux, $wirerc, $wirerh, $wirehum) = ("0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
		my $all = $db->selectall_arrayref("SELECT (SELECT w1 FROM thermostat WHERE w1 IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT w2 FROM thermostat WHERE w2 IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT y1 FROM thermostat WHERE y1 IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT y2 FROM thermostat WHERE y2 IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT g FROM thermostat WHERE g IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT ob FROM thermostat WHERE ob IS NOT NULL ORDER BY id DESC LIMIT 1), updated, (SELECT avg_t FROM thermostat WHERE avg_t IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT aux FROM thermostat WHERE aux IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT rc FROM thermostat WHERE rc IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT rh FROM thermostat WHERE rh IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT hum FROM thermostat WHERE hum IS NOT NULL ORDER BY id DESC LIMIT 1) FROM thermostat ORDER BY id DESC LIMIT 1");
		foreach my $row (@$all) {
			$wirew1 = (@$row[0] ne "")?((@$row[0] == 0)?"0":"1"):"0";
			$wirew2 = (@$row[1] ne "")?((@$row[1] == 0)?"0":"1"):"0";
			$wirey1 = (@$row[2] ne "")?((@$row[2] == 0)?"0":"1"):"0";
			$wirey2 = (@$row[3] ne "")?((@$row[3] == 0)?"0":"1"):"0";
			$wireg =  (@$row[4] ne "")?((@$row[4] == 0)?"0":"1"):"0";
			$wireob = (@$row[5] ne "")?((@$row[5] == 0)?"0":"1"):"0";
			$wireaux =(@$row[8] ne "")?((@$row[8] == 0)?"0":"1"):"0";
			$wirerc = (@$row[9] ne "")?((@$row[9] == 0)?"0":"1"):"0";
			$wirerh =  (@$row[10] ne "")?((@$row[10] == 0)?"0":"1"):"0";
			$wirehum = (@$row[11] ne "")?((@$row[11] == 0)?"0":"1"):"0";
		}
		undef $all;
		$jsonout .= "{\"group\":\"3\",\"p7wg\":\"$wireg\",\"p7w1\":\"$wirew1\",\"p7w2\":\"$wirew2\",\"p7y1\":\"$wirey1\",\"p7y2\":\"$wirey2\",\"p7aux\":\"$wireaux\",\"p7rc\":\"$wirerc\",\"p7rh\":\"$wirerh\",\"p7ob\":\"$wireob\"},";
	}
	$jsonout =~ s/\,$//;
}

if (($uimode eq "reports") && ($userlevel >= 0)) {			# reports page handler
	if ($uismode eq "zonelist") {				# create list of zones
		my $all = $db->selectall_arrayref("SELECT id, description FROM zones WHERE id > 1 ORDER BY id");
		foreach my $row (@$all) {
			$jsonout .= "{\"id\":\"".@$row[0]."\",\"desc\":\"".@$row[1]."\"},";
		}
		undef $all;
	}
	if ($uismode eq "build") {				# report builder
		my ($datefrom, $dateto) = ("20130101", "20141230");
		if ($FORM{datefrom} =~ m/^(\d\d\d\d)\-(\d\d)-(\d\d)$/) {		# YYYY-MM-DD got from ios
			$datefrom = $1.$2.$3;
		}
		if ($FORM{dateto} =~ m/^(\d\d\d\d)\-(\d\d)-(\d\d)$/) {
			$dateto = $1.$2.$3;
		}
		if ($datefrom > $dateto) {
			($datefrom, $dateto) = ($dateto, $datefrom);
		}
		my $ddatef = $datefrom."000000";
		my $ddatet = $dateto."235959";
		my $zone = $FORM{zone} + 0;
		my $wire = $FORM{wire} + 0;			# COTS wire. w1 = 0, w2, y1, y2, g, ob = 5, aux = 6
		my $bout = $FORM{bout} + 0;			# breakout interval. 0 = 15 min. 1 = 30 min
		my $type = $FORM{type} + 0;			# report type
		my $short = (exists $FORM{iphone})?(($FORM{iphone} eq "yes")?1:0):0;
		if ($type == 0) {			# Statistical Occupancy Stats
			$textout .= "<table width=100% border=0 cellpadding=0 cellspacing=0><tbody><tr><td align=center width=20%>Time Interval</td><td align=center width=11%>Sunday</td><td align=center width=11%>Monday</td><td align=center width=11%>Tuesday</td><td align=center width=13%>Wednesday</td><td align=center width=12%>Thursday</td><td align=center width=11%>Friday</td><td align=center width=11%>Saturday</td></tr>\n";
			for my $ampm (0 .. 1) {
				for (my $hcnt = 0; $hcnt < 720; $hcnt += (($bout + 1) * 15)) {
					my $hfrom = floor($hcnt / 60);
					my $hrto = floor(($hcnt + (($bout + 1) * 15)) / 60);
					my $mfrom = $hcnt - ($hfrom * 60);
					my $minto = ($hcnt + (($bout + 1) * 15)) - ($hrto * 60);
					if ($hfrom == 0) {
						$hfrom = 12;
					}
					if ($hrto == 0) {
						$hrto = 12;
					}
					$textout .= "<tr><td align=center>".sprintf("%02d:%02d - %02d:%02d", $hfrom, $mfrom, $hrto, $minto)." ".(($ampm == 0)?"AM":"PM")."</td><td align=center>0%</td><td align=center>0%</td><td align=center>0%</td><td align=center>0%</td><td align=center>0%</td><td align=center>0%</td><td align=center>0%</td></tr>\n";
				}
			}
			$textout .= "</tbody></table>";
		} elsif ($type == 1) {			# RetroSAVE Runtime
			my ($totdays) = ("");
			my ($rsaveA, $bpassA) = ("", "");
			my ($rrsave, $rbpass) = (0, 0);				# runtime in seconds
			my ($rsaveB, $bpassB) = (0, 0);				# runtime in percent
			my ($udatef, $udatet) = (0, 0);
			{				# calc of date period
				my $all = $db->selectall_arrayref("SELECT UNIX_TIMESTAMP($ddatef), UNIX_TIMESTAMP($ddatet)");
				foreach my $row (@$all) {
					if (@$row[0] < @$row[1]) {
						($udatef, $udatet) = (@$row[0], @$row[1]);
					} else {
						($udatef, $udatet) = (@$row[1], @$row[0]);		# fool check ))
					}
				}
				undef $all;
				$totdays = BreakSec(($udatet - $udatef), $short);
			}
			{					# moved from web ui
				$rsaveA = BreakSec($rrsave, $short);
				$bpassA = BreakSec($rbpass, $short);
			}
			$textout .= "<table width=100% border=0 cellpadding=0 cellspacing=0><tbody>\n";
			$textout .= "<tr><td nowrap=\"nowrap\" width=34%>Total Period:</td><td nowrap=\"nowrap\" width=33%>$totdays</td><td nowrap=\"nowrap\" width=33%>&nbsp;</td></tr>\n";
			$textout .= "<tr><td nowrap=\"nowrap\" colspan=3><div class=inpad10></div></td></tr>\n";
			$textout .= "<tr><td nowrap=\"nowrap\" width=34%>RetroSAVE Mode ".(($short)?":&nbsp;&nbsp;&nbsp;":"running for:")."</td><td nowrap=\"nowrap\">$rsaveA</td><td nowrap=\"nowrap\">".$rsaveB."%</td></tr>\n";
			$textout .= "<tr><td nowrap=\"nowrap\" width=34%>Bypass Mode ".(($short)?":&nbsp;&nbsp;&nbsp;":"running for:")."</td><td nowrap=\"nowrap\">$bpassA</td><td nowrap=\"nowrap\">".$bpassB."%</td></tr>\n";
			$textout .= "</tbody></table>\n";
		} elsif ($type == 2) {			# Charts
			my ($czname, $picname) = ("", "");
			{
				my $all = $db->selectall_arrayref("SELECT id, description FROM zones WHERE id = $zone");
				foreach my $row (@$all) {
					$czname = @$row[1];
				}
				undef $all;
			}
			my ($zonet, $zoneh, $tsensor, $hsensor) = ("N/A", "N/A", "Unavailable", "Unavailable");
			if ($czname ne "") {
				use GD::Graph::lines;
				$picname = $clientid."-$curyear$curmon$curday$curhour$curmin$cursec.png";
				my $picfile = $selfpath."charts/".$picname;
				my ($udatef, $udatet) = (0, 0);
                
				my $all = $db->selectall_arrayref("SELECT UNIX_TIMESTAMP($ddatef), UNIX_TIMESTAMP($ddatet)");
				foreach my $row (@$all) {
					if (@$row[0] < @$row[1]) {
						($udatef, $udatet) = (@$row[0], @$row[1]);
					} else {
						($udatef, $udatet) = (@$row[1], @$row[0]);
					}
				}
				undef $all;
                
				my $all = $db->selectall_arrayref("SELECT AVG(paramsensordyn.temperature), AVG(paramsensordyn.humidity), devices.description FROM paramsensordyn, devices WHERE paramsensordyn.device_id = devices.id AND devices.zone_id = $zone AND devices.device_type = 1");
				foreach my $row (@$all) {
					$zonet = (@$row[0] ne "")?(@$row[0]."&deg;C"):"N/A";
					$zoneh = (@$row[1] ne "")?(@$row[1]."%"):"N/A";
					$tsensor = (@$row[2] ne "")?(@$row[2]):"Unlabeled";
					$hsensor = (@$row[2] ne "")?(@$row[2]):"Unlabeled";
				}
				undef $all;
                
				my $iters = 30;						# number of iteratio points
				my $idatp = 2;						# date placement per iteration
				my $dincr = floor(($udatet - $udatef) / $iters);	# seconds increment
				my $idatr = 0;						# date placement counter
				my @datemarks = ();
				my @dbgtemp = ();					# temperature debug only!
				my @dbghum = ();					# hum --//--
				for my $datper (0 .. $iters) {
					my ($dmsec,$dmmin,$dmhr,$dmday,$dmmon,$dmyr) = localtime(($datper * $dincr) + $udatef);
					$dmmon += 1;
					$dmyr += 1900;
					if ($idatr == 0) {
						$datemarks[$datper] = sprintf("%02d-%02d-%02d %02d:%02d", ($dmyr - 2000), $dmmon, $dmday, $dmhr, $dmmin); 
						$idatr = $idatp;
					} else {
						$datemarks[$datper] = "-";
						$idatr--;
					}
					$dbgtemp[$datper] = (floor(rand(40)) / 10) + 18;		# 18 - 24 deg fluct
					$dbghum[$datper] = floor(rand(20)) + 30;			# 30 - 70% fluct
				}
				my @data = ( 
				    [@datemarks],
				    [@dbgtemp],
				    [@dbghum],
				  );
				
				my $graph = GD::Graph::lines->new(700, 630);
				$czname =~ s/\szone$//i;
				$graph->set( 
					title		=> "   ",
					two_axes	=> 1,
					use_axis	=> [1,2,1],
					x_label		=> '',
					y1_label	=> '',
					y1_min_value	=> 0,
					y1_max_value	=> 28,
					y_tick_number	=> 16,
					y_label_skip	=> 2,
					y2_label	=> '',
					y2_min_value	=> 0,
					y2_max_value	=> 100,
					x_labels_vertical	=> 1
				) or die $graph->error;
				$graph->set_y_axis_font(GD::gdLargeFont);
				$graph->set_x_axis_font(GD::gdSmallFont);
#				$graph->set_title_font(GD::gdLargeFont);
				my $gd = $graph->plot(\@data) or die $graph->error;
				open(IMG, ">$picfile") or die $!;
				binmode IMG;
				print IMG $gd->png;
				close(IMG);
			}

			$textout .= "<table width=100% border=0 cellpadding=0 cellspacing=0><tbody>\n";
			$textout .= "<tr><td nowrap=\"nowrap\" width=25%><font color=red>Temperature &deg;C</font></td><td nowrap=\"nowrap\" width=75%>Taken from $tsensor</td></tr>\n";
			$textout .= "<tr><td nowrap=\"nowrap\" width=25%><font color=green>Humidity %</font></td><td nowrap=\"nowrap\" width=75%>Taken from $hsensor</td></tr>\n";
			$textout .= "<tr><td nowrap=\"nowrap\" colspan=2><div class=inpad10></div></td></tr>\n";
			$textout .= "<tr><td nowrap=\"nowrap\" width=100% colspan=2 align=center><img src=\"--hosturl--charts/$picname\" border=0 width=700 height=630></td></tr>\n";
			$textout .= "</tbody></table>\n";
		} elsif ($type == 3) {			# Savings
			my ($elused, $elsaved) = ("", "");
			my ($relused, $relsaved) = (0, 0);				# electricity in Watt
			my ($totdays) = ("");
			my ($udatef, $udatet) = (0, 0);
			{				# calc of date period
				my $all = $db->selectall_arrayref("SELECT UNIX_TIMESTAMP($ddatef), UNIX_TIMESTAMP($ddatet)");
				foreach my $row (@$all) {
					if (@$row[0] < @$row[1]) {
						($udatef, $udatet) = (@$row[0], @$row[1]);
					} else {
						($udatef, $udatet) = (@$row[1], @$row[0]);		# fool check ))
					}
				}
				undef $all;
				$totdays = BreakSec(($udatet - $udatef), $short);
			}
			{	# moved from smart ui
				$elused = sprintf("%.1f", $relused);
				$elsaved = sprintf("%.1f", $relsaved);
			}
			$textout .= "<table width=100% border=0 cellpadding=0 cellspacing=0><tbody>\n";
			if ($short) {
				$textout .= "<tr><td nowrap=\"nowrap\" width=34%>Total Period:</td><td nowrap=\"nowrap\" width=33%>$totdays</td><td nowrap=\"nowrap\" width=33%>&nbsp;</td></tr>\n";
			} else {
				$textout .= "<tr><td nowrap=\"nowrap\" width=34%>Total Period:</td><td nowrap=\"nowrap\" width=66%>$totdays</td></tr>\n";
			}
			$textout .= "<tr><td nowrap=\"nowrap\" colspan=3><div class=inpad10></div></td></tr>\n";
			if ($short) {
				$textout .= "<tr><td nowrap=\"nowrap\" colspan=2>Total electricity used:</td><td nowrap=\"nowrap\">$elused kWatt</td></tr>\n";
				$textout .= "<tr><td nowrap=\"nowrap\" colspan=2>Total electricity saved:</td><td nowrap=\"nowrap\">$elsaved kWatt</td></tr>\n";
			} else {
				$textout .= "<tr><td nowrap=\"nowrap\" width=34%>Total electricity used:</td><td nowrap=\"nowrap\">$elused kWatt</td></tr>\n";
				$textout .= "<tr><td nowrap=\"nowrap\" width=34%>Total electricity saved:</td><td nowrap=\"nowrap\">$elsaved kWatt</td></tr>\n";
			}
			$textout .= "</tbody></table>\n";
		} elsif ($type == 4) {			# HVAC Runtime
			my ($totdays) = ("");
			my ($udatef, $udatet) = (0, 0);
			my @rhvac = ("", "", "", "", "", "", "", "");						# hum, w1, w2, y1, y2, g, ob, aux
			my @rrhvac = (0, 0, 0, 0, 0, 0, 0, 0);
			my @rphvac = (0, 0, 0, 0, 0, 0, 0, 0);
			{				# calc of date period
				my $all = $db->selectall_arrayref("SELECT UNIX_TIMESTAMP($ddatef), UNIX_TIMESTAMP($ddatet)");
				foreach my $row (@$all) {
					if (@$row[0] < @$row[1]) {
						($udatef, $udatet) = (@$row[0], @$row[1]);
					} else {
						($udatef, $udatet) = (@$row[1], @$row[0]);		# fool check ))
					}
				}
				undef $all;
				$totdays = BreakSec(($udatet - $udatef), $short);
			}
			{					# moved from web ui
				for my $irhvac (0 .. $#rhvac) {
					$rhvac[$irhvac] = BreakSec($rrhvac[$irhvac], $short);
				}
			}
			$textout .= "<table width=100% border=0 cellpadding=0 cellspacing=0><tbody>\n";
			$textout .= "<tr><td nowrap=\"nowrap\" width=34%>Total Period:</td><td nowrap=\"nowrap\" width=33%>$totdays</td><td nowrap=\"nowrap\" width=33%>&nbsp;</td></tr>\n";
			$textout .= "<tr><td nowrap=\"nowrap\" colspan=3><div class=inpad10></div></td></tr>\n";
			if ($short) {
				$textout .= "<tr><td nowrap=\"nowrap\" width=34%>Humidifier:</td><td nowrap=\"nowrap\">".$rhvac[0]."</td><td nowrap=\"nowrap\">".$rphvac[0]."%</td></tr>\n";
				$textout .= "<tr><td nowrap=\"nowrap\" width=34%>W1 line (Furnace):&nbsp;&nbsp;&nbsp;</td><td nowrap=\"nowrap\">".$rhvac[1]."</td><td nowrap=\"nowrap\">".$rphvac[1]."%</td></tr>\n";
				$textout .= "<tr><td nowrap=\"nowrap\" width=34%>W2 line (Furnace):&nbsp;&nbsp;&nbsp;</td><td nowrap=\"nowrap\">".$rhvac[2]."</td><td nowrap=\"nowrap\">".$rphvac[2]."%</td></tr>\n";
				$textout .= "<tr><td nowrap=\"nowrap\" width=34%>Y1 line (A/C):</td><td nowrap=\"nowrap\">".$rhvac[3]."</td><td nowrap=\"nowrap\">".$rphvac[3]."%</td></tr>\n";
				$textout .= "<tr><td nowrap=\"nowrap\" width=34%>Y2 line (A/C):</td><td nowrap=\"nowrap\">".$rhvac[4]."</td><td nowrap=\"nowrap\">".$rphvac[4]."%</td></tr>\n";
				$textout .= "<tr><td nowrap=\"nowrap\" width=34%>O/B line:</td><td nowrap=\"nowrap\">".$rhvac[5]."</td><td nowrap=\"nowrap\">".$rphvac[5]."%</td></tr>\n";
				$textout .= "<tr><td nowrap=\"nowrap\" width=34%>G line (Fan):</td><td nowrap=\"nowrap\">".$rhvac[6]."</td><td nowrap=\"nowrap\">".$rphvac[6]."%</td></tr>\n";
				$textout .= "<tr><td nowrap=\"nowrap\" width=34%>Aux line:</td><td nowrap=\"nowrap\">".$rhvac[7]."</td><td nowrap=\"nowrap\">".$rphvac[7]."%</td></tr>\n";
			} else {
				$textout .= "<tr><td nowrap=\"nowrap\" width=34%>Humidifier running for:</td><td nowrap=\"nowrap\">".$rhvac[0]."</td><td nowrap=\"nowrap\">".$rphvac[0]."%</td></tr>\n";
				$textout .= "<tr><td nowrap=\"nowrap\" width=34%>W1 line (Furnace) enabled for:</td><td nowrap=\"nowrap\">".$rhvac[1]."</td><td nowrap=\"nowrap\">".$rphvac[1]."%</td></tr>\n";
				$textout .= "<tr><td nowrap=\"nowrap\" width=34%>W2 line (Furnace) enabled for:</td><td nowrap=\"nowrap\">".$rhvac[2]."</td><td nowrap=\"nowrap\">".$rphvac[2]."%</td></tr>\n";
				$textout .= "<tr><td nowrap=\"nowrap\" width=34%>Y1 line (A/C) enabled for:</td><td nowrap=\"nowrap\">".$rhvac[3]."</td><td nowrap=\"nowrap\">".$rphvac[3]."%</td></tr>\n";
				$textout .= "<tr><td nowrap=\"nowrap\" width=34%>Y2 line (A/C) enabled for:</td><td nowrap=\"nowrap\">".$rhvac[4]."</td><td nowrap=\"nowrap\">".$rphvac[4]."%</td></tr>\n";
				$textout .= "<tr><td nowrap=\"nowrap\" width=34%>O/B line enabled for:</td><td nowrap=\"nowrap\">".$rhvac[5]."</td><td nowrap=\"nowrap\">".$rphvac[5]."%</td></tr>\n";
				$textout .= "<tr><td nowrap=\"nowrap\" width=34%>G line (Fan) enabled for:</td><td nowrap=\"nowrap\">".$rhvac[6]."</td><td nowrap=\"nowrap\">".$rphvac[6]."%</td></tr>\n";
				$textout .= "<tr><td nowrap=\"nowrap\" width=34%>Aux line enabled for:</td><td nowrap=\"nowrap\">".$rhvac[7]."</td><td nowrap=\"nowrap\">".$rphvac[7]."%</td></tr>\n";
			}
			$textout .= "</tbody></table>\n";
		} elsif ($type == 5) {			# COTS Thermostat stats
			my @linames = ("W1", "W2", "Y1", "Y2", "G", "OB", "Aux");
			my ($lilist, $chart) = ("", "");
			my ($czname, $picname) = ("", "");
			$czname = $linames[$wire];
			if ($czname ne "") {
				use GD::Graph::lines;
				$picname = $clientid."-$wire-$curyear$curmon$curday$curhour$curmin$cursec.png";
				my $picfile = $selfpath."charts/".$picname;
				my ($udatef, $udatet) = (0, 0);
                
				my $all = $db->selectall_arrayref("SELECT UNIX_TIMESTAMP($ddatef), UNIX_TIMESTAMP($ddatet)");
				foreach my $row (@$all) {
					if (@$row[0] < @$row[1]) {
						($udatef, $udatet) = (@$row[0], @$row[1]);
					} else {
						($udatef, $udatet) = (@$row[1], @$row[0]);		# fool check ))
					}
				}
				undef $all;
                
				my $iters = 52;						# number of iteratio points
				my $idatp = 3;						# date placement per iteration
				my $dincr = floor(($udatet - $udatef) / $iters);	# seconds increment
				my $idatr = 0;						# date placement counter
				my @datemarks = ();
				my @dbgtemp = ();					# temperature debug only!
				my @dbghum = ();					# hum --//--
				for my $datper (0 .. $iters) {
					my ($dmsec,$dmmin,$dmhr,$dmday,$dmmon,$dmyr) = localtime(($datper * $dincr) + $udatef);
					$dmmon += 1;
					$dmyr += 1900;
					if ($idatr == 0) {
						$datemarks[$datper] = sprintf("%02d-%02d-%02d %02d:%02d", ($dmyr - 2000), $dmmon, $dmday, $dmhr, $dmmin); 
						$idatr = $idatp;
					} else {
						$datemarks[$datper] = "-";
						$idatr--;
					}
					$dbgtemp[$datper] = (floor(rand(40)) / 20) + 20 + (abs($datper - ($iters / 2)) * 0.13);			# some random values
					$dbghum[$datper] = floor(rand(1) + 0.5) * 8 + 1;			# 1 to 9
				}
				my @data = ( 
				    [@datemarks],
				    [@dbgtemp],
				    [@dbghum],
				  );
				
				my $graph = GD::Graph::lines->new(700, 630);			# uses twax_y2 that needs GD::Graph::axestype.pm fix
				$graph->set( 
					title		=> "   ",
					two_axes	=> 1,
					use_axis	=> [1,2,1],
					line_types	=> [1,1],
					x_label		=> '',
					y1_label	=> '',
					y1_min_value	=> 0,
					y1_max_value	=> 28,
					y_tick_number	=> 16,
					y_label_skip	=> 2,
					y2_label	=> 'LOW              Thermostat line state              HIGH',
					y2_min_value	=> 0,
					y2_max_value	=> 10,
					twax_y2		=> 0,
					x_labels_vertical	=> 1
				) or die $graph->error;
				$graph->set_y_axis_font(GD::gdLargeFont);
				$graph->set_y_label_font(GD::gdLargeFont);
				$graph->set_x_axis_font(GD::gdSmallFont);
				my $gd = $graph->plot(\@data) or die $graph->error;
				open(IMG, ">$picfile") or die $!;
				binmode IMG;
				print IMG $gd->png;
				$chart = "<img src=\"charts/$picname\" border=0 width=500 height=500>";
				close(IMG);
			}

			$textout .= "<table width=100% border=0 cellpadding=0 cellspacing=0><tbody>\n";
			$textout .= "<tr><td nowrap=\"nowrap\" width=100%><font color=red>Average Master Zone Temperature &deg;C</font></td></tr>\n";
			$textout .= "<tr><td nowrap=\"nowrap\" width=100%><font color=green>COTS Thermostat Line ".$linames[$wire]." State</font></td></tr>\n";
			$textout .= "<tr><td nowrap=\"nowrap\" colspan=2><div class=inpad10></div></td></tr>\n";
			$textout .= "<tr><td nowrap=\"nowrap\" width=100% colspan=2 align=center><img src=\"--hosturl--charts/$picname\" border=0 width=700 height=630></td></tr>\n";
			$textout .= "</tbody></table>\n";
		}
	}
	$jsonout =~ s/\,$//;
}

if (($uimode eq "mainpage") && ($userlevel >= 0)) {				# return brief information about system (relays, comfort mode, etc)
	my $tunits = 0;		# celsius
	{		# fill relays information
		my $hrvrelay = "0";
		if ($HVAC{"hrverv.installed"} > 0) {
			$hrvrelay = "R".($HVAC{"hrverv.relay_id"} + 0);
		}
		my ($hrv, $fan, $fur, $acr, $hum) = (0, 0, 0, 0, 0);
		my $all = $db->selectall_arrayref("SELECT (SELECT $hrvrelay FROM relays WHERE $hrvrelay IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT g FROM relays WHERE g IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT humidifier FROM relays WHERE humidifier IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT w1 FROM relays WHERE w1 IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT w2 FROM relays WHERE w2 IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT y1 FROM relays WHERE y1 IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT y2 FROM relays WHERE y2 IS NOT NULL ORDER BY id DESC LIMIT 1)");
		foreach my $row (@$all) {
			$hrv = (@$row[0] ne "")?((@$row[0] == 0)?"0":"1"):"0";
			$fan = (@$row[1] ne "")?((@$row[1] == 0)?"0":"1"):"0";
			$hum = (@$row[2] ne "")?((@$row[2] == 0)?"0":"1"):"0";
			my $fura= (@$row[3] ne "")?((@$row[3] == 0)?"0":"1"):"0";
			my $furb= (@$row[4] ne "")?((@$row[4] == 0)?"0":"1"):"0";
			$fur = $fura + $furb;
			my $acra= (@$row[5] ne "")?((@$row[5] == 0)?"0":"1"):"0";
			my $acrb= (@$row[6] ne "")?((@$row[6] == 0)?"0":"1"):"0";
			$acr = $acra + $acrb;
		}
		undef $all;
		$jsonout .= "{\"name\":\"fanslider\",\"value\":\"$fan\",\"group\":\"1\"},";	# fan
		$jsonout .= "{\"name\":\"heatslider\",\"value\":\"$fur\",\"group\":\"1\"},";	# furnace
		$jsonout .= "{\"name\":\"acslider\",\"value\":\"$acr\",\"group\":\"1\"},";	# ac
		$jsonout .= "{\"name\":\"hrvslider\",\"value\":\"$hrv\",\"group\":\"1\"},";	# hrv/erv if connected
		$jsonout .= "{\"name\":\"humslider\",\"value\":\"$hum\",\"group\":\"1\"},";	# humidifier
	}
	{		# bypass switch status, away switch, comfort mode
		my $awaymode = (exists $HVAC{"retrosave.away_mode"})?($HVAC{"retrosave.away_mode"} + 0):0;
		my $bypass = 0;
		my $all = $db->selectall_arrayref("SELECT status FROM bypass ORDER BY id DESC LIMIT 1");
		foreach my $row (@$all) {
			($bypass) = @$row;
		}
		undef $all;
		my $savemode = 0;
		my $all = $db->selectall_arrayref("SELECT comfort, t_display FROM users WHERE id = $clientid");
		foreach my $row (@$all) {
			($savemode, $tunits) = @$row;
		}
		undef $all;
		$jsonout .= "{\"group\":\"4\",\"bypassmode\":\"$bypass\",\"savemode\":\"$savemode\",\"awaymode\":\"$awaymode\",\"tunits\":\"$tunits\"},";
	}
	{		# zones and sensors + outdoor
		my ($outdoort, $outdoorh, $outdoorl, $outdoorcnt) = ("N/A", "N/A", "N/A", 0);
		my $all = $db->selectall_arrayref("SELECT AVG(paramsensordyn.temperature), AVG(paramsensordyn.humidity), AVG(paramsensordyn.light) FROM paramsensordyn, devices WHERE paramsensordyn.device_id = devices.id AND devices.zone_id > 1 AND devices.device_type = 0");
		foreach my $row (@$all) {
			$jsonout .= "{\"group\":\"3\",\"id\":\"1\",\"desc\":\"Outdoor Area\",\"occu\":\"N/A\",\"temp\":\"".((@$row[0] ne "")?(TShow(@$row[0], $tunits)):"N/A")."\",\"hum\":\"".((@$row[1] ne "")?(@$row[1]."%"):"N/A")."\",\"light\":\"".((@$row[2] ne "")?(@$row[2]." lux"):"N/A")."\"},";
		}
		undef $all;

		my %ztemp = ();
		my %zhum = ();
		my %zlight = ();
		my $all = $db->selectall_arrayref("SELECT devices.zone_id, AVG(paramsensordyn.temperature), AVG(paramsensordyn.humidity), AVG(paramsensordyn.light) FROM paramsensordyn, devices WHERE paramsensordyn.device_id = devices.id AND devices.device_type = 1 GROUP BY devices.zone_id");
		foreach my $row (@$all) {
			my $zoid = @$row[0];
			$ztemp{$zoid} = @$row[1];
			$zhum{$zoid} = @$row[2];
			$zlight{$zoid} = @$row[3];
		}
		undef $all;

		my $all = $db->selectall_arrayref("SELECT zones.id, zonesdyn.occupation, zones.description FROM zones, zonesdyn WHERE zonesdyn.zone_id = zones.id AND zones.volume > 0 ORDER BY zones.id");
		foreach my $row (@$all) {
			my $zoid = @$row[0];
			my $desc = @$row[2];
			my $occu = @$row[1];
			$jsonout .= "{\"group\":\"3\",\"id\":\"$zoid\",\"desc\":\"$desc\",\"occu\":\"".$occstates[$occu + 0]."\",\"temp\":\"".((exists $ztemp{$zoid})?(TShow($ztemp{$zoid}, $tunits)):"N/A")."\",\"hum\":\"".((exists $zhum{$zoid})?($zhum{$zoid}."%"):"N/A")."\",\"light\":\"".((exists $zlight{$zoid})?($zlight{$zoid}." lux"):"N/A")."\"},";
		}
		undef $all;
	}
	{		# important events from temporary table
		$db->do("CREATE TEMPORARY TABLE alarms_recent (updated DATETIME DEFAULT NULL, alarm_id int(11) NOT NULL DEFAULT 0, type_ int(11) NOT NULL DEFAULT 0, severity tinyint(4) NOT NULL DEFAULT 0)");
		for my $dbtype (0 .. $#alarmdb) {
			my $dbname = $alarmdb[$dbtype];
			$db->do("INSERT INTO alarms_recent SELECT updated, type_, $dbtype, severity FROM $dbname WHERE updated BETWEEN DATE_SUB(NOW(), INTERVAL 14 DAY) AND NOW()");
		}
		my $all = $db->selectall_arrayref("SELECT alarms_types.id, alarms_recent.updated, alarms_recent.severity, alarms_types.status, alarms_types.description FROM alarms_recent LEFT JOIN alarms_types ON alarms_types.alarm_id = alarms_recent.alarm_id AND alarms_types.type_ = alarms_recent.type_ ORDER BY alarms_recent.updated DESC, alarms_recent.severity DESC LIMIT 6");
		foreach my $row (@$all) {
			my ($id, $started, $severity, $status, $desc) = @$row;
			$jsonout .= "{\"id\":\"$id\",\"started\":\"$started\",\"desc\":\"$desc\",\"severity\":\"$severity\",\"status\":\"$status\",\"group\":\"5\"},";
		}
		undef $all;
		$db->do("DROP TEMPORARY TABLE alarms_recent");
	}
	$jsonout =~ s/\,$//;
}

if (($uimode eq "events") && ($userlevel >= 0)) {			# return full event list
	{		# important events from temporary table
		my ($datefrom, $dateto) = ("20130101", "20141230");
		if ($FORM{datefrom} =~ m/^(\d\d\d\d)\-(\d\d)-(\d\d)$/) {
			$datefrom = $1.$2.$3;
		}
		if ($FORM{dateto} =~ m/^(\d\d\d\d)\-(\d\d)-(\d\d)$/) {
			$dateto = $1.$2.$3;
		}
		if ($datefrom > $dateto) {
			($datefrom, $dateto) = ($dateto, $datefrom);
		}
		$datefrom .= "000000";
		$dateto .= "235959";
		$db->do("CREATE TEMPORARY TABLE alarms_recent (id int(11) UNSIGNED NOT NULL AUTO_INCREMENT, updated DATETIME DEFAULT NULL, alarm_id int(11) NOT NULL DEFAULT 0, type_ int(11) NOT NULL DEFAULT 0, severity tinyint(4) NOT NULL DEFAULT 0, PRIMARY KEY (id), UNIQUE INDEX id (id))");
		for my $dbtype (0 .. $#alarmdb) {
			my $dbname = $alarmdb[$dbtype];
			$db->do("INSERT INTO alarms_recent SELECT 0, updated, type_, $dbtype, severity FROM $dbname WHERE updated BETWEEN $datefrom AND $dateto");
		}
		my $all = $db->selectall_arrayref("SELECT alarms_recent.id, alarms_recent.updated, alarms_recent.severity, alarms_types.status, alarms_types.description, alarms_recent.type_ FROM alarms_recent LEFT JOIN alarms_types ON alarms_types.alarm_id = alarms_recent.alarm_id AND alarms_types.type_ = alarms_recent.type_ ORDER BY alarms_recent.severity DESC, alarms_recent.updated DESC");
		foreach my $row (@$all) {
			my ($id, $started, $severity, $status, $desc, $type) = @$row;
			$jsonout .= "{\"id\":\"$id\",\"started\":\"$started\",\"desc\":\"$desc\",\"severity\":\"".$bitsev[$severity]."\",\"status\":\"$status\",\"type\":\"$type\",\"sort\":\"0\"},";
		}
		undef $all;
		my $all = $db->selectall_arrayref("SELECT alarms_recent.id, alarms_recent.updated, alarms_recent.severity FROM alarms_recent LEFT JOIN alarms_types ON alarms_types.alarm_id = alarms_recent.alarm_id AND alarms_types.type_ = alarms_recent.type_ ORDER BY alarms_recent.updated DESC, alarms_recent.severity DESC");
		foreach my $row (@$all) {
			my ($id, $started, $severity) = @$row;
			$jsonout .= "{\"id\":\"$id\",\"sort\":\"1\"},";
		}
		undef $all;
		$db->do("DROP TEMPORARY TABLE alarms_recent");
		if ($jsonout eq "") {
			$jsonout .= "{\"id\":\"0\",\"sort\":\"2\"},";		# dummy record for zero events
		}
	}
	$jsonout =~ s/\,$//;
}

# actions

if (($action eq "p5newmail") && ($userlevel >= 0)) {			# add new email or SMS for notification
	if ($FORM{p5newmail} =~ m/^\w[\w\.\-]*\w\@\w[\w\.\-]*\w(\.\w{2,4})$/) {		# new email added? check validity
		my $severity = ((exists $FORM{p5sev2new})?1:0) + ((exists $FORM{p5sev1new})?2:0) + ((exists $FORM{p5sev0new})?4:0);
		$db->do("INSERT INTO notifications VALUES (NULL, '".$FORM{p5newmail}."', '', $severity)");
		$textout = $FORM{p5newmail}." added";
	} elsif ($FORM{p5newsms} =~ m/^\d+$/) {				# new phone added? check validity
		my $severity = ((exists $FORM{p5sev2snew})?1:0) + ((exists $FORM{p5sev1snew})?2:0) + ((exists $FORM{p5sev0snew})?4:0);
		$db->do("INSERT INTO notifications VALUES (NULL, '', '".$FORM{p5newsms}."', $severity)");
		$textout = $FORM{p5newsms}." added";
	} else {
		$textout = "Wrong value";
	}
}

if (($action eq "p5modmail") && ($userlevel >= 0)) {			# modify severity
	my $mailid = $FORM{mailid} + 0;
	if ($mailid > 0) {
		my $severity = ((exists $FORM{("p5sev2id".$mailid)})?1:0) + ((exists $FORM{("p5sev1id".$mailid)})?2:0) + ((exists $FORM{("p5sev0id".$mailid)})?4:0);
		$db->do("UPDATE notifications SET severity = $severity WHERE id = $mailid");
		$textout = $mailid." changed";
	} else {
		$textout = "Wrong value";
	}
}

if (($action eq "p5delmail") && ($userlevel >= 0)) {			# delete notification email
	my $mailid = $FORM{mailid} + 0;
	if ($mailid > 0) {
		$db->do("DELETE FROM notifications WHERE id = $mailid");
		$textout = $mailid." deleted";
	} else {
		$textout = "Wrong value";
	}
}

if (($action eq "p5setnot") && ($userlevel >= 0)) {			# set notification mode
	if (exists $FORM{notmode}) {
		my $notmode = $FORM{notmode} + 0;
		$db->do("UPDATE hvac SET value_ = $notmode WHERE option_ = 'system.notifications_email'");
		$textout = "email notifications ".$notmode." set";
	} elsif (exists $FORM{sotmode}) {
		my $sotmode = $FORM{sotmode} + 0;
		$db->do("UPDATE hvac SET value_ = $sotmode WHERE option_ = 'system.notifications_sms'");
		$textout = "sms notifications ".$sotmode." set";
	}
}

if (($action eq "setmode") && ($userlevel >= 0)) {			# set some settings
	my $desc = $FORM{desc};
	my $value = $FORM{value};
	if ($desc ne "") {
		my @ddesc = split(/\./, $desc);
		if ($ddesc[0] eq "users") {			# set user preferences
			my $tabname = $ddesc[1];
			$db->do("UPDATE users SET $tabname = '$value' WHERE id = $clientid");
			$textout = "users set $tabname = $value OK";
		} elsif ($ddesc[0] eq "hvac") {			# set hvac preferences
			my $optname = $ddesc[1].".".$ddesc[2];
			$db->do("UPDATE hvac SET value_ = '$value' WHERE option_ = '$optname'");
			$textout = "hvac set $optname = $value OK";
		} elsif ($desc eq "bypassmode") {		# set bypass switch mode
			$db->do("INSERT INTO bypass VALUES (0, NOW(), 2, $value, 'Toggle from mobile app')");
			$textout = "bypass set $value OK";
		}
	} else {
		$textout = "Wrong value";
	}
}

# procedure to check version

if (($userlevel < 0) && ($textout eq "")) {
	$jsonout .= "{\"host\":\"$servername\",\"port\":\"$serverport\",\"version\":\"$version\"}";
}

# temperature converter

sub TFah {
	my $tcel = $_[0];
	my $tfah = (9 * $tcel / 5) + 32;
	return $tfah;
}

sub TShow {
	my $tinp = $_[0];
	my $tunin = $_[1];	# 0 -cels, 1 - fahr
	my $tout = ($tunin == 0)?($tinp."&deg;C"):(TFah($tinp)."&deg;F");
}

# Time HH/MM/SS converters

sub timeHS {
	my $mins = int($_[0] / 60);
	my $out = timeHM($mins);
	return $out;
}

sub timeHM {
	my $mins = int($_[0]);
	my $out = "";
	if ($mins >= 60) {
		my $hours = floor($mins / 60);
		my $mins = $mins - ($hours * 60);
		$out = $hours." hr. ".sprintf("%02d",$mins)." min.";
	} else {
		$out = $mins." min.";
	}
	return $out;
}

# nice second representation

sub BreakSec {
	my $seconds = $_[0] + 0;
	my $short = $_[1] + 0;
	my $rsday = floor($seconds / 86400);
	my $rshour = floor($seconds / 3600) - ($rsday * 24);
	my $rsmin = floor($seconds / 60) - ($rsday * 24 * 60) - ($rshour * 60);
	my $brtime = sprintf("%d day %02d hour %02d minute", $rsday, $rshour, $rsmin);
	if ($short) {
		$brtime = sprintf("%dd %02dh %02dm", $rsday, $rshour, $rsmin);
	}
	return $brtime;
}

# Output

if ($textout ne "") {
	print "Content-type: text/plain\n\n";
	print $textout;
	print "\n";
} elsif ($jsonout ne "") {
	print "Content-type: application/json\n\n";
	print $FORM{jsoncallback}."([";
	print $jsonout;
	print "]);\n";
}

$db->disconnect();
exit;
7;
