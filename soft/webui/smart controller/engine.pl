#!c:/perl/bin/perl.exe
#!c:/xampp/perl/bin/perl.exe
#!/usr/bin/perl

use DBI;
use POSIX;
use Digest::MD5 qw(md5 md5_hex md5_base64);
use Time::Local;
use strict;

# Get data from memory

my $debug = "";
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
#		$debug .= $name." = ".$value."<br>";
	}
}

# get server data

my $selfpath = $ENV{'PATH_TRANSLATED'};
$selfpath =~ s/\\[^\\]*$/\\/;
if ($selfpath eq "") {
	$selfpath = $ENV{'SCRIPT_FILENAME'};
	$selfpath =~ s/\/[^\/]*$/\//;
}
my $templateweb = $selfpath."template.html";
my $loginweb = $selfpath."login.html";
my $regscript = $selfpath."regcloud.pl";

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

my $version = (exists $config{version})?$config{version}:"15.1.8p";
my $debugmode = (exists $config{debug})?$config{debug}:0;		# simulation mode off by default
my $advmode = (exists $config{advanced})?$config{advanced}:1;		# corrections allowed
my $logpath = (exists $config{logpath})?$config{logpath}:"./";		# path for storing logs and private files

# hardcoded constants and moar

my @months = ("Ololo","January","February","March","April","May","June","July","August","September","October","November","December");
my @smonths = ("Ololo","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
my @ampms = ("USSR","AM","PM");
my $exitstatus = 0;				# status to exit to login page
my $sessid = -1;
my $clientip = $ENV{'REMOTE_ADDR'};
my $clientie = $ENV{'HTTP_USER_AGENT'};
my $username = $FORM{user};
my $password = $FORM{pass};
my $userhash = md5_hex($clientip."azze2014".$clientie);
my $cookname = "";
my $rcvd_cookies = $ENV{'HTTP_COOKIE'};
my @cookies = split /;/, $rcvd_cookies;
my $saveduser = "";
my $cusermode = 0;
my $homeid = 0;
foreach my $cookie (@cookies) {
	if ($cookie =~ "icsession2014") {
		($cookname,$sessid) = split(/\=/,$cookie);
	}
	if ($cookie =~ "icuser2014") {
		($cookname,$saveduser) = split(/\=/,$cookie);
	}
	if ($cookie =~ "usermode2014") {
		($cookname,$cusermode) = split(/\=/,$cookie);
	}
	if ($cookie =~ "ichomeid2014") {
		($cookname,$homeid) = split(/\=/,$cookie);
		$homeid += 0;
	}
}
my $signtime = 60;		# time in minutes to stay logged in
my $contents = "";
my $bodyadd = "";
my $headadd = "";
my $message = "";
my $servname = $ENV{'SERVER_NAME'};
my $servport = $ENV{'SERVER_PORT'};
my $servprot = ($ENV{'HTTPS'} eq "on")?"https":"http";
unless (($servport eq "80") || ($servport eq "443")) {
	$servname .= ":".$servport;
}
my $foldname = "";
if ($ENV{'SCRIPT_NAME'} =~ /^\/(.+\/)*(.+)\.(.+)$/) {
	$foldname = $1;	
}
my $loffweb = $servprot."://".$servname."/";
# my $apchans = "/tmp/apchanlist";
my $apchans = $selfpath."charts/apchanlist";		# saved in permanent place now
my $hostapd = "/etc/hostapd/hostapd.conf";
my $wpasupp = "/etc/wpa_supplicant/wpa_supplicant.conf";
my $tmpfold = "/tmp/";
if ($servport eq "8080") {
	$apchans = "e:/temp4/apchanlist";
	$hostapd = "e:/temp4/hostapd.conf";
	$wpasupp = "e:/temp4/wpa_supplicant.conf";
	$tmpfold = "e:/temp4/";
}

# get mode and action

my $savelogin = ($FORM{save_login} eq "yes")?"yes":"no";
my $uimode = (exists $FORM{mode})?$FORM{mode}:"";
my $uismode = (exists $FORM{submode})?$FORM{submode}:"";
my $action = (exists $FORM{action})?$FORM{action}:"";

# connect to mysql

my $dsn = 'DBI:mysql:'.((exists $config{dbname})?$config{dbname}:(($homeid > 0)?(sprintf("smart%05d",$homeid)):"smart")).":".((exists $config{dbhost})?$config{dbhost}:"localhost");
my $db_user_name = (exists $config{dbuser})?$config{dbuser}:(($homeid > 0)?(sprintf("dbuser%05d",$homeid)):"dbuser");
my $db_password = (exists $config{dbpass})?$config{dbpass}:(($homeid > 0)?(sprintf("dbpass%05d",$homeid)):"dbpass");
my $db = DBI->connect($dsn, $db_user_name, $db_password);
if (! $db) {
	($username, $password, $FORM{mode}, $FORM{submode}, $uimode, $uismode) = ("", "", "", "", "", "");
	$exitstatus = 7;
}

# Session creator

my $clientid = -1;
my $clientacc = 0;
my $tempdbid = 0;
if (($username ne "") && ($password ne "") && ($submeth eq "post") && ($action eq "login")) {
	my $sth = $db->prepare("select id,access,login from users where login='$username' and password='$password'");
	$sth->execute;
	unless ($sth->rows == 0) {
		my ($id,$access,$login) = $sth->fetchrow_array();
		if (($access == 1) || ($access == 0)) {			# simple user or integrator
			$clientid = $id;
			$clientacc = $access;
		} elsif ($access == 2) {				# system super admin
			$clientid = $id;
			$clientacc = $access;
		}
		$sth->finish;
	} else {
		$sth->finish;
	}

	if ($clientid >= 0) {
		$db->do("INSERT INTO sessions VALUES(NULL,$clientid,'$userhash',now(),date_add(now(),interval $signtime minute),$clientacc,0)");
		$sth = $db->prepare("SELECT last_insert_id() FROM sessions");
		$sth->execute;
		($sessid) = $sth->fetchrow_array();
		$sth->finish;
	}

	my $fut_time = gmtime(time() + (60 * 60 * 24 * 30))." GMT";  	# cookie expires in 30 days
	my $cookie = "icsession2014=$sessid; path=/; expires=$fut_time;";
	print "Set-Cookie: " . $cookie . "\n";
	if (exists $FORM{savelogin}) {
		$cookie = "icuser2014=$username; path=/; expires=$fut_time;";
		print "Set-Cookie: " . $cookie . "\n";
	}
}

# Session checker

my $ulogin = "";
my $uaccess = 0;
my $sessionnow = 0;
my $tdisp = 0;		# 0 = celsius (def), 1 = fahrenheit
my $ttzone = 0;		# timezone in +HHMM format
my $sth = $db->prepare("SELECT id_session,id_client,type,dbid FROM sessions WHERE id_session=$sessid AND hash='$userhash' AND expires>NOW()");
$sth->execute;
unless ($sth->rows == 0) {
	my ($sessid,$clid,$clientacc,$odbid) = $sth->fetchrow_array();
	$sth->finish;
	$db->do("UPDATE sessions SET expires=DATE_ADD(expires,INTERVAL $signtime MINUTE) WHERE id_session=$sessid");
	$sessionnow = $sessid;

	$sth = $db->prepare("SELECT login, access, t_display, timezone FROM users WHERE id=$clid");
	$sth->execute;
	unless ($sth->rows == 0) {
		my ($login, $access, $tdisplay, $tzdisp) = $sth->fetchrow_array();
		if ($access == 1) {
			$ulogin = $login;
			$uaccess = $access;
			$clientid = $clid;
		} elsif ($access == 2) {
			$ulogin = $login;
			$uaccess = 1;			# granting admin access to system
			$clientid = $clid;
		} elsif ($access == 0) {
			$ulogin = $login;
			$uaccess = $access;
			$clientid = $clid;
		}
		$tdisp = $tdisplay;
		$ttzone = $tzdisp;
	}
	$sth->finish;
} else {
	$clientid = -1;
	$sth->finish;
}

# get current datetime + timezone

my @tzzone = split(//, sprintf("%+05d", $ttzone));
my $tzzzone = $tzzone[0].$tzzone[1].$tzzone[2].":".$tzzone[3].$tzzone[4];		# determine and set current timezone
# $ENV{TZ} = "ASE".$tzzzone;									# does not work with mod_perl
# tzset;
my $tzsecoff = 0;
{
	my $hroff = $tzzone[1].$tzzone[2];
	my $minoff = $tzzone[3].$tzzone[4];
	$tzsecoff = (($tzzone[0] eq "+")?"":"-").(($hroff * 3600) + ($minoff * 60));
}
my ($cursec,$curmin,$curhour,$curday,$curmon,$curyear) = localtime(mktime((gmtime)[0..5]) + $tzsecoff);
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
my @monthftxt = qw(January February March April May June July August September October November December);
my @ampmtxt = ("am","pm");

# read HVAC config for system

my %HVAC = ();
{
	my $all = $db->selectall_arrayref("SELECT option_,value_ FROM hvac WHERE submenu > 0");		# read HVAC config for system only
	foreach my $row (@$all) {
		my ($opt, $val) = @$row;
		$HVAC{$opt} = $val;
	}
}
if (exists $HVAC{"system.sw_version"}) {
	my @dbversion = split(/\./, $HVAC{"system.sw_version"});
	my @swversion = split(/\./, $version);
	$dbversion[2] =~ s/p/1/gi;
	$swversion[2] =~ s/a/0/gi;
	$dbversion[2] =~ s/a/0/gi;
	$swversion[2] =~ s/p/1/gi;
	my $ddbversion = sprintf("%02d%02d%03d", $dbversion[0], $dbversion[1], $dbversion[2]);
	my $sswversion = sprintf("%02d%02d%03d", $swversion[0], $swversion[1], $swversion[2]);
	if ($ddbversion > $sswversion) {
		$version = $HVAC{"system.sw_version"};
	}
}

# check client ID

if ($clientid < 0) {
# if (($clientid < 0) && ($action eq "login")) {
	($password, $uimode, $uismode) = ("", "", "");
	$exitstatus = 1;
}
if (($clientid >= 0) && (($uimode eq "") || ($uismode eq ""))) {
	if ($HVAC{"system.description"} eq "") {
		($uimode, $uismode) = ("status", "system");			# go system if unregistered
	} else {
		($uimode, $uismode) = ("status", "relays");			# default page after login
	}
}

# menu & submenu processing

my $mainmenu = "";
my $submenu = "";
my $pagetitle = "ASE 2014 Web UI ";
my %alevel = ();
if ($uimode ne "") {
	my $all = $db->selectall_arrayref("SELECT id, menu, submenu, description, access, level FROM ui_menu WHERE level = 0 OR (menu = '$uimode' AND level = 1) ORDER BY id");	# get all main + current sub
	foreach my $row (@$all) {
		my ($meid, $imenu, $isubm, $idesc, $iacc, $mlevel) = @$row;
		$alevel{$imenu.$isubm} = $iacc;
		if ($uaccess >= $iacc) {				# show only if access allowed
			if ($mlevel == 0) {
				if ($imenu eq $uimode) {
					$mainmenu .= "<td><div id=\"div_maintab_".$meid."\" class=\"MainTab\"><a href=\"./engine.pl?mode=$imenu&submode=$isubm\"><div class=\"MainTabL10\"></div></a><a href=\"./engine.pl?mode=$imenu&submode=$isubm\"><div class=\"MainTabL11\"></div></a><a href=\"./engine.pl?mode=$imenu&submode=$isubm\"><div class=\"MainTabL12\"></div></a><a class=\"MenuTabLink\" href=\"./engine.pl?mode=$imenu&submode=$isubm\"><div class=\"MainTabL13 ShadowText\">".$idesc."</div></a><a href=\"./engine.pl?mode=$imenu&submode=$isubm\"><div class=\"MainTabL14\"></div></a><a href=\"./engine.pl?mode=$imenu&submode=$isubm\"><div class=\"MainTabL15\"></div></a><a href=\"./engine.pl?mode=$imenu&submode=$isubm\"><div class=\"MainTabL16\"></div></a></div></td>\n";
					$idesc =~ s/\<br\>//gi;
					$pagetitle .= ": $idesc";
				} else {
					$mainmenu .= "<td><div id=\"div_maintab_".$meid."\" class=\"MainTab\" onmouseover=\"main_cap('div_maintab_".$meid."');\" onmouseout=\"main_uncap('div_maintab_".$meid."');\"><a href=\"./engine.pl?mode=$imenu&submode=$isubm\"><div class=\"MainTabL30\"></div></a><a href=\"./engine.pl?mode=$imenu&submode=$isubm\"><div class=\"MainTabL31\"></div></a><a href=\"./engine.pl?mode=$imenu&submode=$isubm\"><div class=\"MainTabL32\"></div></a><a class=\"MenuTabLink\" href=\"./engine.pl?mode=$imenu&submode=$isubm\"><div class=\"MainTabL33 ShadowText\">".$idesc."</div></a><a href=\"./engine.pl?mode=$imenu&submode=$isubm\"><div class=\"MainTabL34\"></div></a><a href=\"./engine.pl?mode=$imenu&submode=$isubm\"><div class=\"MainTabL35\"></div></a><a href=\"./engine.pl?mode=$imenu&submode=$isubm\"><div class=\"MainTabL36\"></div></a></div></td>\n";
				}
			} else {
				if ($isubm eq $uismode) {
					$submenu .= "<td nowrap=\"nowrap\"><div id=\"div_subtab_".$meid."\"><div class=\"SubTabL10\"></div></a><a href=\"./engine.pl?mode=$imenu&submode=$isubm\"><div class=\"SubTabL11\"></div></a><a href=\"./engine.pl?mode=$imenu&submode=$isubm\"><div class=\"SubTabL12\"></div></a><a class=\"MenuTabLink\" href=\"./engine.pl?mode=$imenu&submode=$isubm\"><div class=\"SubTabL13\">".$idesc."</div></a></div></td>\n";
					$idesc =~ s/\<br\>//gi;
					$pagetitle .= ": $idesc";
				} else {
					$submenu .= "<td nowrap=\"nowrap\"><div id=\"div_subtab_".$meid."\" class=\"SubTab\" onmouseover=\"sub_cap('div_subtab_".$meid."');\" onmouseout=\"sub_uncap('div_subtab_".$meid."');\"><a href=\"./engine.pl?mode=$imenu&submode=$isubm\"><div class=\"SubTabL30\"></div></a><a href=\"./engine.pl?mode=$imenu&submode=$isubm\"><div class=\"SubTabL31\"></div></a><a href=\"./engine.pl?mode=$imenu&submode=$isubm\"><div class=\"SubTabL32\"></div></a><a class=\"MenuTabLink\" href=\"./engine.pl?mode=$imenu&submode=$isubm\"><div class=\"SubTabL33\">".$idesc."</div></a></div></td>\n";
				}
			}
		}
	}
}

# switch to usermode

if (($uimode eq "logout") && ($uismode eq "usermode") && ($uaccess >= $alevel{$uimode.$uismode})) {
	$cusermode = ($cusermode > 0)?0:1;
	my $fut_time = gmtime(time() + (60 * 60 * 24 * 30))." GMT";  	# cookie expires in 30 days
	my $cookie = "usermode2014=$cusermode; path=/; expires=$fut_time;";
	print "Set-Cookie: " . $cookie . "\n";
	($uimode, $uismode) = ("status", "relays");
}
my $usermode = ($uaccess > 0)?"<a href=\"./engine.pl?mode=logout&submode=usermode\" class=\"submenu\">Switch to ".(($cusermode == 0)?"usermode":"adminmode")."</a>":"&nbsp;".$ulogin;
if ($cusermode > 0) {
	$uaccess--;
}

# HVAC general menu

if (($uimode eq "hvac") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my ($subtitle, $items, $subsect, $ssectitle, $ssecitems) = ("", "", "", "", "");
	my $all = $db->selectall_arrayref("SELECT id, submenu, option_, description, value_, type_, selections, permissions, units, dependence FROM hvac WHERE permissions <= $uaccess AND (option_ = '$uismode' OR option_ LIKE '".$uismode.".%') ORDER BY id");
	foreach my $row (@$all) {
		my $submenu = @$row[1];
		if (@$row[9] ne "") {
			my @itemdep = split(/\:\:/, @$row[9]);
			if (exists $FORM{$itemdep[0]}) {
				if ($FORM{$itemdep[0]} ne $itemdep[1]) {
					$submenu = -1;		# hide submenu if dependency not equal
					$FORM{@$row[2]} = "";
				}
			} else {
				if ($HVAC{$itemdep[0]} ne $itemdep[1]) {
					$submenu = -1;		# hide submenu if dependency not equal
					$HVAC{@$row[2]} = "";
				}
			}
		}
		if ($submenu == 0) {			# main item
			$subtitle = @$row[3];
		} elsif (($submenu > 0) && (@$row[5] != 6)) {
			$items .= "<tr><td height=28 width=328>".@$row[3].":</td><td align=\"left\" width=316>";
			if (($action eq "save") && (exists $FORM{@$row[2]})) {
				if ((@$row[5] == 1) && (@$row[8] eq "&deg;C") && ($tdisp == 1)) {	# convert back to C
					$FORM{@$row[2]} = sprintf("%.2f", fah2cel($FORM{@$row[2]} + 0));
				}
				if ($FORM{@$row[2]} ne @$row[4]) {
					@$row[4] = $FORM{@$row[2]};
					dbdo("UPDATE hvac SET value_='".$FORM{@$row[2]}."' WHERE option_='".@$row[2]."'", 0);
					if (@$row[2] eq "furnace.mode") { 		# additional action for bypass on/off
						my $bpmode = (@$row[4] == 0)?1:0;
						dbdo("INSERT INTO bypass VALUES (NULL, NOW(), 1, $bpmode, 'Toggle from webui')", 0);
					}
				}
			}
			if (@$row[5] == 1) {			# text field
				my $fsize = (@$row[6] eq "")?5:(@$row[6] + 0);
				my $units = @$row[8];
				my $uvalue = @$row[4];
				if (($units eq "&deg;C") && ($tdisp == 1)) {		# convert to F
					$units = "&deg;F";
					$uvalue = sprintf("%.1f", cel2fah($uvalue)) + 0;
				} elsif (($units eq "&deg;C") && ($tdisp == 0)) {
					$uvalue = sprintf("%.1f", $uvalue) + 0;
				}
				$items .= "<input name=\"".@$row[2]."\" value=\"".$uvalue."\" size=\"$fsize\" maxlength=\"".($fsize * 2)."\" type=\"text\"> ".$units;
			} elsif (@$row[5] == 2) {			# readonly text field
				my $fsize = (@$row[6] eq "")?5:(@$row[6] + 0);
				my $units = @$row[8];
				my $uvalue = @$row[4];
				if (($units eq "&deg;C") && ($tdisp == 1)) {		# convert to F
					$units = "&deg;F";
					$uvalue = sprintf("%.1f", cel2fah($uvalue)) + 0;
				} elsif (($units eq "&deg;C") && ($tdisp == 0)) {
					$uvalue = sprintf("%.1f", $uvalue) + 0;
				}
				$items .= "<input readonly=\"readonly\" name=\"".@$row[2]."\" value=\"".$uvalue."\" size=\"$fsize\" maxlength=\"".($fsize * 2)."\" type=\"text\"> ".$units;
			} elsif (@$row[5] == 3) {		# drop down
				if (@$row[2] eq "furnace.mode") { 		# additional action for bypass on/off
					my $hbypass = 0;
					my $aall = $db->selectall_arrayref("SELECT status FROM bypass WHERE type_ = 0 ORDER BY id DESC LIMIT 1");
					foreach my $row (@$aall) {
						($hbypass) = @$row;
						$hbypass += 0;
					}
					undef $aall;
					$items .= "<select name=\"".@$row[2]."\" size=1 onChange=\"document.eventForm.submit();\"".(($hbypass == 1)?" disabled":"").">";
					@$row[4] = ($hbypass == 1)?0:@$row[4];		# very dirty hack to set mode to show bypass temporarily
				} else {
					$items .= "<select name=\"".@$row[2]."\" size=1 onChange=\"document.eventForm.submit();\">";
				}
				my @opts = split(/\;\;/,@$row[6]);
				for my $oopt (0 .. $#opts) {
					my ($ovalue, $odesc) = split(/\:\:/, $opts[$oopt]);
					$items .= "<option value=\"$ovalue\"".((@$row[4] eq $ovalue)?" selected=\"selected\"":"").">$odesc</option>";
				}
				$items .= "</select>";
			}
			$items .= "</td></tr>\n";
		} elsif (($submenu > 0) && (@$row[5] == 6)) {
			if (@$row[6] eq "%%PTLIST") {			# list of temperature probes
				if (($action eq "save") && (exists $FORM{@$row[2]})) {
					if ($FORM{@$row[2]} ne @$row[4]) {
						@$row[4] = $FORM{@$row[2]};
						dbdo("UPDATE hvac SET value_='".$FORM{@$row[2]}."' WHERE option_='".@$row[2]."'", 0);
					}
				}
				$items .= "<tr><td height=28 width=328>".@$row[3].":</td><td align=\"left\" width=316><select name=\"".@$row[2]."\" size=1 onChange=\"document.eventForm.submit();\">";
				my $aall = $db->selectall_arrayref("SELECT id, description, type_ FROM smartdevices WHERE (type_ = 2) OR (type_ = 4) ORDER BY id"); # temp probes only
				foreach my $rrow (@$aall) {
					$items .= "<option value=\"".@$rrow[0]."\" ".((@$row[4] == @$rrow[0])?"selected=\"selected\"":"").">ID.".@$rrow[0].((@$rrow[1] ne "")?": ".@$rrow[1]:"")."</option>";
				}
				undef $aall;
				$items .= "</select></td></tr>\n";
			} elsif (@$row[6] eq "%%MASTER") {			# select master sensor
				if (($action eq "save") && (exists $FORM{@$row[2]})) {
					if ($FORM{@$row[2]} ne @$row[4]) {
						@$row[4] = $FORM{@$row[2]};
						dbdo("UPDATE hvac SET value_='".$FORM{@$row[2]}."' WHERE option_='".@$row[2]."'", 0);
						dbdo("UPDATE devices SET zone_id=2 WHERE id=".$FORM{@$row[2]}, 0);
					}
				}
				$items .= "<tr><td height=28 width=328>".@$row[3].":</td><td align=\"left\" width=316><select name=\"".@$row[2]."\" size=1 onChange=\"document.eventForm.submit();\">";
				$items .= "<option value=\"0\" ".(((@$row[4] + 0) == 0)?"selected=\"selected\"":"").">None</option>";
				my $aall = $db->selectall_arrayref("SELECT devices.id, devices.description FROM devices LEFT JOIN zigbee_ase ON zigbee_ase.device_id = devices.id WHERE devices.device_type = 0 AND (zigbee_ase.device_type & 1) = 1 AND zigbee_ase.device_status != 2 GROUP BY devices.id ORDER BY devices.zone_id, devices.id");	# only ASE probes with T sensor, not deleted
				foreach my $rrow (@$aall) {
					$items .= "<option value=\"".@$rrow[0]."\" ".((@$row[4] == @$rrow[0])?"selected=\"selected\"":"").">ID.".@$rrow[0].((@$rrow[1] ne "")?": ".@$rrow[1]:"")."</option>";
				}
				undef $aall;
				$items .= "</select></td></tr>\n";
			} elsif (@$row[6] eq "%%NEST") {			# nest subsection
				if (($HVAC{"thermostat.nest_token"} eq "") || ($HVAC{"thermostat.nest_clientid"} eq "") || ($HVAC{"thermostat.nest_secret"} eq "")) { 	# need security token
					$ssecitems = "<tr><td class=\"stdbold\" nowrap=\"nowrap\" width=100%>No security token found for client. Steps to create one:<br><br>
							1. Open <a href=\"https://developer.nest.com/clients\" target=_blank>nest developers site</a> ;<br>
							2. <a href=\"https://developer.nest.com/clients/new\" target=_blank>Create new</a> or use existing client for the ASE Retrosave ;<br>
							3. Give client permissions to read thermostat data ;<br>
							4. Fill the above <u>Client ID</u> and <u>Client secret</u> fields with given data. Save ;<br>
							5. Click on <a href=\"https://home.nest.com/login/oauth2?client_id=".$HVAC{"thermostat.nest_clientid"}."&state=STATE\" target=_blank>Authorization URL</a> to request Pincode ;<br>
							6. Fill the above <u>Pincode</u> field with pincode received from Nest. Save.<br><br>
							Important! Pincode is disposable and can be used only once.</td></tr>";
				}
				if (($action eq "save") && ($FORM{"thermostat.nest_pincode"} ne "") && ($FORM{"thermostat.nest_secret"} ne "") && ($FORM{"thermostat.nest_clientid"} ne "")) {
					my $errmsg = "";
					use LWP::UserAgent;
					my $mech = LWP::UserAgent->new;
					$mech->timeout(20);
					$mech->agent('Mozilla/5.0');
					my $url = "https://api.home.nest.com/oauth2/access_token";
					my $res = $mech->post($url, 
					{ "client_id" => $FORM{"thermostat.nest_clientid"},
					  "client_secret" => $FORM{"thermostat.nest_secret"},
					  "grant_type" => "authorization_code",
					  "code" => $FORM{"thermostat.nest_pincode"} }
					);
					unless ($res->is_success) {
						$errmsg = "Error receiving security token. Try again later or request new Pincode";
					} else {
						my $tone = $res->content;
						if ($tone =~ m/\"access_token\"\:\"([a-zA-Z0-9\.]+)\"/) {
							my $token = $1;
							dbdo("UPDATE hvac SET value_='$token' WHERE option_='thermostat.nest_token'", 0);
							$FORM{"thermostat.nest_token"} = $token;
							$HVAC{"thermostat.nest_token"} = $token;
							dbdo("UPDATE hvac SET value_='' WHERE option_='thermostat.nest_pincode'", 0);
							$FORM{"thermostat.nest_pincode"} = "";
							$HVAC{"thermostat.nest_pincode"} = "";
							$errmsg = "Security token received. <a href=\"./engine.pl?mode=$uimode&submode=$uismode\">Click here to refresh</a> status page.";
						}
					}
					$ssecitems = "<tr><td class=\"stdbold\" nowrap=\"nowrap\" width=100%>$errmsg</td></tr>";
				}
				if ($HVAC{"thermostat.nest_token"} ne "") {
					$headadd .= "<meta http-equiv=\"refresh\" content=\"13;URL=./engine.pl?mode=$uimode&submode=$uismode\">\n";
					my %awaymodes = ("home", "inactive", "away", "active");
					my %nestval = ();
					my $lastupd = "";
					my $nst = $db->selectall_arrayref("SELECT * FROM (SELECT id, updated, name_, value_ FROM cots_data ORDER BY id DESC) AS nest GROUP BY name_");	# smart query to get latest values
					foreach my $row (@$nst) {
						$nestval{@$row[2]} = @$row[3];
						if (@$row[2] eq "last_connection") {
							$lastupd = @$row[1];
						}
					}
					undef $nst;
					$ssecitems = "<tr><td nowrap=\"nowrap\" width=113>Name:</td><td class=\"stdbold\" nowrap=\"nowrap\" colspan=3>".$nestval{name_long}."</td></tr>\n";
					$ssecitems .= "<tr><td nowrap=\"nowrap\" width=113>Thermostat online:</td><td class=\"stdbold\" nowrap=\"nowrap\" width=\"113\">".$nestval{is_online}."</td>\n";
					$ssecitems .= "<td nowrap=\"nowrap\" width=113>Current HVAC mode:</td><td class=\"stdbold\" nowrap=\"nowrap\" width=\"113\">".$nestval{hvac_mode}."</td></tr>\n";
					$ssecitems .= "<tr><td colspan=4><div class=in5></div></td></tr>\n";
					$ssecitems .= "<tr><td nowrap=\"nowrap\" width=113>Away mode:</td><td class=\"stdbold\" nowrap=\"nowrap\">".$awaymodes{$nestval{away}}."</td>\n";
					$ssecitems .= "<td nowrap=\"nowrap\" width=113>A/C connected:</td><td class=\"stdbold\" nowrap=\"nowrap\">".$nestval{can_cool}."</td></tr>\n";
					$ssecitems .= "<tr><td nowrap=\"nowrap\" width=113>Fan connected:</td><td class=\"stdbold\" nowrap=\"nowrap\" width=\"113\">".$nestval{has_fan}."</td>\n";
					$ssecitems .= "<td nowrap=\"nowrap\" width=113>Furnace connected:</td><td class=\"stdbold\" nowrap=\"nowrap\">".$nestval{can_heat}."</td></tr>\n";
					$ssecitems .= "<tr><td colspan=4><div class=in5></div></td></tr>\n";
					$ssecitems .= "<tr><td nowrap=\"nowrap\" width=113>Temperature:</td><td class=\"stdbold\" nowrap=\"nowrap\">".$nestval{ambient_temperature_c}."&deg;C / ".$nestval{ambient_temperature_f}."&deg;F</td>\n";
					$ssecitems .= "<td nowrap=\"nowrap\" width=113>Humidity:</td><td class=\"stdbold\" nowrap=\"nowrap\">".$nestval{humidity}."%</td></tr>\n";
					$ssecitems .= "<tr><td nowrap=\"nowrap\" width=113>Normal comfort range:</td><td class=\"stdbold\" nowrap=\"nowrap\">".$nestval{target_temperature_low_c}."-".$nestval{target_temperature_high_c}."&deg;C / ".$nestval{target_temperature_low_f}."-".$nestval{target_temperature_high_f}."&deg;F</td>\n";
					$ssecitems .= "<td nowrap=\"nowrap\" width=113>Away mode range:</td><td class=\"stdbold\" nowrap=\"nowrap\">".$nestval{away_temperature_low_c}."-".$nestval{away_temperature_high_c}."&deg;C / ".$nestval{away_temperature_low_f}."-".$nestval{away_temperature_high_f}."&deg;F</td></tr>\n";
					$ssecitems .= "<tr><td nowrap=\"nowrap\" width=113>Current target:</td><td class=\"stdbold\" nowrap=\"nowrap\">".$nestval{target_temperature_c}."&deg;C / ".$nestval{target_temperature_f}."&deg;F</td>\n";
					$ssecitems .= "<td nowrap=\"nowrap\" width=113>Last update:</td><td class=\"stdbold\" nowrap=\"nowrap\" width=\"113\">".$lastupd."</td></tr>\n";
				}
				$ssectitle = @$row[3];
				$subsect = <<EOF;
				<table class="nav">
					<tbody><tr>
						<td class="bwhead">$ssectitle</td>
						<td class="bwhead1">&nbsp;</td>
						<td class="nav1">&nbsp;</td>
					</tr>
					<tr height="3px">
						<td class="Item1"></td>
						<td class="Item2"></td>
						<td></td>
					</tr>
					<tr>
						<td class="Item1"> </td>
						<td class="Item2"> </td>
						<td class="Item3">
							<table class="std"><tbody>
								$ssecitems
							</tbody></table>
							<br>
						</td>
					</tr></tbody>
				</table>
EOF
			}
		}
	}
	undef $all;

	my $pagename = $selfpath.$uimode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--subtitle--/$subtitle/g;
		$inline =~ s/--items--/$items/g;
		$inline =~ s/--subsection--/$subsect/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# relays status page

if (($uimode eq "status") && ($uismode eq "relays") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my $relset = -1;
	my $reltab = "";
	my $relval = 0;
	if ($action eq "set") {
		$relset = $FORM{relid} + 0;
	}

	my $hbypass = 0;
	my $all = $db->selectall_arrayref("SELECT status FROM bypass WHERE type_ = 0 ORDER BY id DESC LIMIT 1");
	foreach my $row (@$all) {
		($hbypass) = @$row;
		$hbypass += 0;
	}
	undef $all;
	my $bypasshw = ($hbypass == 0)?"OFF":"ON";

	my ($bypasm, $bypweb) = (0, 0, 0);
	my $all = $db->selectall_arrayref("SELECT status FROM bypass WHERE type_ = 1 ORDER BY id DESC LIMIT 1");	# web only
	foreach my $row (@$all) {
		($bypweb) = @$row;
		$bypasm = ($hbypass == 1)?1:($bypweb + 0);
	}
	undef $all;
	my $bypass = ($bypasm == 0)?"Disabled":"Enabled";

	my ($relayupd, $wireupd) = ("N/A", "N/A");
	my ($relayw1, $relayw2, $relaybw1, $relaybw2, $relayr1, $relayby1, $relayy1, $relayr2, $relayy2, $relayby2, $relayr3, $relayg, $relaybg, $relayr4, $relayob, $relaybob, $relayr5, $relayhum, $relayr6, $relaybaux, $relayaux, $relayrcrh) = ("N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A");
	my $all = $db->selectall_arrayref("SELECT (SELECT r1 FROM relays WHERE r1 IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT r2 FROM relays WHERE r2 IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT r3 FROM relays WHERE r3 IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT r4 FROM relays WHERE r4 IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT r5 FROM relays WHERE r5 IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT r6 FROM relays WHERE r6 IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT humidifier FROM relays WHERE humidifier IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT w1 FROM relays WHERE w1 IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT w2 FROM relays WHERE w2 IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT y1 FROM relays WHERE y1 IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT y2 FROM relays WHERE y2 IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT g FROM relays WHERE g IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT ob FROM relays WHERE ob IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT aux FROM relays WHERE aux IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT rcrh FROM relays WHERE rcrh IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT updated FROM relays ORDER BY id DESC LIMIT 1)");
	foreach my $row (@$all) {
		if (($relset >= 0) && ($bypasm == 0)) {
			if ($relset == 0) {
				@$row[6] = @$row[6] ^ 1;
				$relval = @$row[6];
				$reltab = "humidifier";
			} elsif ($relset == 1) {
				@$row[7] = @$row[7] ^ 1;
				$relval = @$row[7];
				$reltab = "w1";
			} elsif ($relset == 2) {
				@$row[8] = @$row[8] ^ 1;
				$relval = @$row[8];
				$reltab = "w2";
			} elsif ($relset == 3) {
				@$row[9] = @$row[9] ^ 1;
				$relval = @$row[9];
				$reltab = "y1";
			} elsif ($relset == 4) {
				@$row[10] = @$row[10] ^ 1;
				$relval = @$row[10];
				$reltab = "y2";
			} elsif ($relset == 5) {
				@$row[11] = @$row[11] ^ 1;
				$relval = @$row[11];
				$reltab = "g";
			} elsif ($relset == 6) {
				@$row[12] = @$row[12] ^ 1;
				$relval = @$row[12];
				$reltab = "ob";
			} elsif ($relset == 7) {
				@$row[13] = @$row[13] ^ 1;
				$relval = @$row[13];
				$reltab = "aux";
			} elsif ($relset == 8) {
				@$row[14] = @$row[14] ^ 1;
				$relval = @$row[14];
				$reltab = "rcrh";
			} elsif ($relset == 9) {
				@$row[7] = @$row[7] ^ 2;
				$relval = @$row[7];
				$reltab = "w1";
			} elsif ($relset == 10) {
				@$row[8] = @$row[8] ^ 2;
				$relval = @$row[8];
				$reltab = "w2";
			} elsif ($relset == 11) {
				@$row[9] = @$row[9] ^ 2;
				$relval = @$row[9];
				$reltab = "y1";
			} elsif ($relset == 12) {
				@$row[10] = @$row[10] ^ 2;
				$relval = @$row[10];
				$reltab = "y2";
			} elsif ($relset == 13) {
				@$row[11] = @$row[11] ^ 2;
				$relval = @$row[11];
				$reltab = "g";
			} elsif ($relset == 14) {
				@$row[12] = @$row[12] ^ 2;
				$relval = @$row[12];
				$reltab = "ob";
			} elsif ($relset == 15) {
				@$row[13] = @$row[13] ^ 2;
				$relval = @$row[13];
				$reltab = "aux";
			} elsif ($relset == 16) {
				@$row[0] = @$row[0] ^ 1;
				$relval = @$row[0];
				$reltab = "r1";
			} elsif ($relset == 17) {
				@$row[1] = @$row[1] ^ 1;
				$relval = @$row[1];
				$reltab = "r2";
			} elsif ($relset == 18) {
				@$row[2] = @$row[2] ^ 1;
				$relval = @$row[2];
				$reltab = "r3";
			} elsif ($relset == 19) {
				@$row[3] = @$row[3] ^ 1;
				$relval = @$row[3];
				$reltab = "r4";
			} elsif ($relset == 20) {
				@$row[4] = @$row[4] ^ 1;
				$relval = @$row[4];
				$reltab = "r5";
			} elsif ($relset == 21) {
				@$row[5] = @$row[5] ^ 1;
				$relval = @$row[5];
				$reltab = "r6";
			}
		}
		$relayr1 = (@$row[0] ne "")?((@$row[0] == 0)?"OFF":"ON"):"N/A";
		$relayr2 = (@$row[1] ne "")?((@$row[1] == 0)?"OFF":"ON"):"N/A";
		$relayr3 = (@$row[2] ne "")?((@$row[2] == 0)?"OFF":"ON"):"N/A";
		$relayr4 = (@$row[3] ne "")?((@$row[3] == 0)?"OFF":"ON"):"N/A";
		$relayr5 = (@$row[4] ne "")?((@$row[4] == 0)?"OFF":"ON"):"N/A";
		$relayr6 = (@$row[5] ne "")?((@$row[5] == 0)?"OFF":"ON"):"N/A";
		$relayhum = (@$row[6] ne "")?((@$row[6] == 0)?"OFF":"ON"):"N/A";
		if (@$row[7] ne "") {
			$relayw1 = ((@$row[7] & 1) == 0)?"OFF":"ON";
			$relaybw1 = ((@$row[7] & 2) == 0)?"OFF":"ON";
		}
		if (@$row[8] ne "") {
			$relayw2 = ((@$row[8] & 1) == 0)?"OFF":"ON";
			$relaybw2 = ((@$row[8] & 2) == 0)?"OFF":"ON";
		}
		if (@$row[9] ne "") {
			$relayy1 = ((@$row[9] & 1) == 0)?"OFF":"ON";
			$relayby1 = ((@$row[9] & 2) == 0)?"OFF":"ON";
		}
		if (@$row[10] ne "") {
			$relayy2 = ((@$row[10] & 1) == 0)?"OFF":"ON";
			$relayby2 = ((@$row[10] & 2) == 0)?"OFF":"ON";
		}
		if (@$row[11] ne "") {
			$relayg = ((@$row[11] & 1) == 0)?"OFF":"ON";
			$relaybg = ((@$row[11] & 2) == 0)?"OFF":"ON";
		}
		if (@$row[12] ne "") {
			$relayob = ((@$row[12] & 1) == 0)?"OFF":"ON";
			$relaybob = ((@$row[12] & 2) == 0)?"OFF":"ON";
		}
		if (@$row[13] ne "") {
			$relayaux = ((@$row[13] & 1) == 0)?"OFF":"ON";
			$relaybaux = ((@$row[13] & 2) == 0)?"OFF":"ON";
		}
		$relayrcrh = (@$row[14] ne "")?((@$row[14] == 0)?"OFF":"ON"):"N/A";
		$relayupd = (@$row[15] ne "")?(@$row[15]):"N/A";
	}
	undef $all;

	if (($relset >= 0) && ($reltab ne "") && ($bypasm == 0)) {					# no bypass only
		dbdo("INSERT INTO relays (id, updated, $reltab) VALUES (NULL, NOW(), $relval)", 0);
	}

	my ($wirew1, $wirew2, $wirey1, $wirey2, $wireg, $wireob, $avgmzt, $wireaux, $wirerc, $wirerh, $wirehum) = ("N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A");
	my $all = $db->selectall_arrayref("SELECT (SELECT w1 FROM thermostat WHERE w1 IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT w2 FROM thermostat WHERE w2 IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT y1 FROM thermostat WHERE y1 IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT y2 FROM thermostat WHERE y2 IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT g FROM thermostat WHERE g IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT ob FROM thermostat WHERE ob IS NOT NULL ORDER BY id DESC LIMIT 1), updated, (SELECT avg_t FROM thermostat WHERE avg_t IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT aux FROM thermostat WHERE aux IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT rc FROM thermostat WHERE rc IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT rh FROM thermostat WHERE rh IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT hum FROM thermostat WHERE hum IS NOT NULL ORDER BY id DESC LIMIT 1) FROM thermostat ORDER BY id DESC LIMIT 1");
	foreach my $row (@$all) {
		$wirew1 = (@$row[0] ne "")?((@$row[0] == 0)?"OFF":"ON"):"N/A";
		$wirew2 = (@$row[1] ne "")?((@$row[1] == 0)?"OFF":"ON"):"N/A";
		$wirey1 = (@$row[2] ne "")?((@$row[2] == 0)?"OFF":"ON"):"N/A";
		$wirey2 = (@$row[3] ne "")?((@$row[3] == 0)?"OFF":"ON"):"N/A";
		$wireg =  (@$row[4] ne "")?((@$row[4] == 0)?"OFF":"ON"):"N/A";
		$wireob = (@$row[5] ne "")?((@$row[5] == 0)?"OFF":"ON"):"N/A";
		$wireaux =(@$row[8] ne "")?((@$row[8] == 0)?"OFF":"ON"):"N/A";
		$wirerc = (@$row[9] ne "")?((@$row[9] == 0)?"OFF":"ON"):"N/A";
		$wirerh =  (@$row[10] ne "")?((@$row[10] == 0)?"OFF":"ON"):"N/A";
		$wirehum = (@$row[11] ne "")?((@$row[11] == 0)?"OFF":"ON"):"N/A";
		$wireupd = @$row[6];
		$avgmzt = ttproper(@$row[7]);
	}
	undef $all;

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);	
		$inline =~ s/--avg_t--/$avgmzt/g;
		$inline =~ s/--relay_w1--/$relayw1/g;
		$inline =~ s/--relay_w2--/$relayw2/g;
		$inline =~ s/--relay_w1bp--/$relaybw1/g;
		$inline =~ s/--relay_w2bp--/$relaybw2/g;
		$inline =~ s/--relay_r1--/$relayr1/g;
		$inline =~ s/--relay_y1--/$relayy1/g;
		$inline =~ s/--relay_y1bp--/$relayby1/g;
		$inline =~ s/--relay_r2--/$relayr2/g;
		$inline =~ s/--relay_y2--/$relayy2/g;
		$inline =~ s/--relay_y2bp--/$relayby2/g;
		$inline =~ s/--relay_r3--/$relayr3/g;
		$inline =~ s/--relay_g--/$relayg/g;
		$inline =~ s/--relay_gbp--/$relaybg/g;
		$inline =~ s/--relay_r4--/$relayr4/g;
		$inline =~ s/--relay_ob--/$relayob/g;
		$inline =~ s/--relay_obbp--/$relaybob/g;
		$inline =~ s/--relay_r5--/$relayr5/g;
		$inline =~ s/--relay_hum--/$relayhum/g;
		$inline =~ s/--relay_r6--/$relayr6/g;
		$inline =~ s/--relay_rcrh--/$relayrcrh/g;
		$inline =~ s/--relay_aux--/$relayaux/g;
		$inline =~ s/--relay_auxbp--/$relaybaux/g;
		$inline =~ s/--wire_w1--/$wirew1/g;
		$inline =~ s/--wire_w2--/$wirew2/g;
		$inline =~ s/--wire_y1--/$wirey1/g;
		$inline =~ s/--wire_y2--/$wirey2/g;
		$inline =~ s/--wire_g--/$wireg/g;
		$inline =~ s/--wire_ob--/$wireob/g;
		$inline =~ s/--wire_aux--/$wireaux/g;
		$inline =~ s/--wire_rc--/$wirerc/g;
		$inline =~ s/--wire_rh--/$wirerh/g;
		$inline =~ s/--wire_hum--/$wirehum/g;
		$inline =~ s/--relayupd--/$relayupd/g;
		$inline =~ s/--wireupd--/$wireupd/g;
		$inline =~ s/--bypass--/$bypass/g;
		$inline =~ s/--bypasshw--/$bypasshw/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# onboard sensors status

if (($uimode eq "status") && ($uismode eq "onboard") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my ($froomt, $froomh, $ductco1, $ductco2, $sductt, $sducth, $rductt, $rducth, $htut, $airvel, $smartupd) = ("N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A");
	my ($frtsrc, $tsdsrc, $trdsrc, $cosrc) = ("", "", "", "");
	my $all = $db->selectall_arrayref("SELECT (SELECT froom_t FROM smartsensors WHERE froom_t IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT froom_h FROM smartsensors WHERE froom_h IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT co FROM smartsensors WHERE co IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT co2 FROM smartsensors WHERE co2 IS NOT NULL ORDER BY id DESC LIMIT 1),(SELECT t_supply_duct FROM smartsensors WHERE t_supply_duct IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT t_return_duct FROM smartsensors WHERE t_return_duct IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT h_supply_duct FROM smartsensors WHERE h_supply_duct IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT h_return_duct FROM smartsensors WHERE h_return_duct IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT htu FROM smartsensors WHERE htu IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT air_vel FROM smartsensors WHERE air_vel IS NOT NULL ORDER BY id DESC LIMIT 1), updated FROM smartsensors ORDER BY id DESC LIMIT 1");
	foreach my $row (@$all) {
		$froomt = ttproper(@$row[0]);
		$froomh = (@$row[1] ne "")?(@$row[1]."%"):"N/A";
		$ductco1 = (@$row[2] ne "")?(@$row[2]."ppm"):"N/A";
		$ductco2 = (@$row[3] ne "")?(@$row[3]."ppm"):"N/A";
		$sductt = ttproper(@$row[4]);
		$rductt = ttproper(@$row[5]);
		$sducth = (@$row[6] ne "")?(@$row[6]."%"):"N/A";
		$rducth = (@$row[7] ne "")?(@$row[7]."%"):"N/A";
		$htut = ttproper(@$row[8]);
		$airvel = (@$row[9] ne "")?(@$row[9]."fpm"):"N/A";
		$smartupd = @$row[10];
	}
	undef $all;

	my $all = $db->selectall_arrayref("SELECT id, type_, status, description, interface, address FROM smartdevices");
	foreach my $row (@$all) {
		my ($devid, $devtp, $devst, $devds, $devif, $devad) = @$row;
		if (($devtp == 1) && ($devst == 1) && ($devif == 0)) {		# local CO presents and active
			$cosrc = ($devds eq "")?"Local CO sensor":$devds;
		}
		if (($devtp == 2) && ($devst == 1) && ($devif == 1)) {		# local HTU T presents and active
			$frtsrc = ($devds eq "")?"Local T/H sensor":$devds;
		}
		if (($devst == 1) && ($HVAC{"furnace.sup_t_probes"} == 1) && ($devid == $HVAC{"furnace.sup_t_probe_use"})) {		# supply T sensor installed and active
			$tsdsrc = ($devds eq "")?"Sensor # $devid":$devds;
			if ($devtp == 4) {					# remote sensor
				my ($rawt) = $db->selectrow_array("SELECT value_ FROM smartsensorsraw WHERE address = '$devad' ORDER BY id DESC LIMIT 1");
				$sductt = ttproper($rawt);
				$sducth = "N/A";
			} elsif (($devtp == 2) && ($devif == 1)) {		# source is local HTU
				$sductt = $froomt;
				$sducth = $froomh;				# is it really needed?
			}
		}
		if (($devst == 1) && ($HVAC{"furnace.ret_t_probes"} == 1) && ($devid == $HVAC{"furnace.ret_t_probe_use"})) {		# return T sensor installed and active
			$trdsrc = ($devds eq "")?"Sensor # $devid":$devds;
			if ($devtp == 4) {					# remote sensor
				my ($rawt) = $db->selectrow_array("SELECT value_ FROM smartsensorsraw WHERE address = '$devad' ORDER BY id DESC LIMIT 1");
				$rductt = ttproper($rawt);
				$rducth = "N/A";
			} elsif (($devtp == 2) && ($devif == 1)) {		# source is local HTU
				$rductt = $froomt;
				$rducth = $froomh;				# is it really needed?
			}
		}
	}
	undef $all;
	if ($cosrc eq "") {
		$cosrc = "unavailable";
		$ductco1 = "N/A";
	}
	if ($frtsrc eq "") {
		$frtsrc = "unavailable";
		$froomt = "N/A";
		$froomh = "N/A";			# is it really needed?
	}
	if ($tsdsrc eq "") {
		$tsdsrc = "unavailable";
		$sductt = "N/A";
		$sducth = "N/A";			# is it really needed?
	}
	if ($trdsrc eq "") {
		$trdsrc = "unavailable";
		$rductt = "N/A";
		$rducth = "N/A";			# is it really needed?
	}
	
	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--froom_t_src--/$frtsrc/g;
		$inline =~ s/--t_supply_duct_src--/$tsdsrc/g;
		$inline =~ s/--t_return_duct_src--/$trdsrc/g;
		$inline =~ s/--co_src--/$cosrc/g;
		$inline =~ s/--froom_t--/$froomt/g;
		$inline =~ s/--froom_h--/$froomh/g;
		$inline =~ s/--t_supply_duct--/$sductt/g;
		$inline =~ s/--h_supply_duct--/$sducth/g;
		$inline =~ s/--t_return_duct--/$rductt/g;
		$inline =~ s/--h_return_duct--/$rducth/g;
		$inline =~ s/--co--/$ductco1/g;
		$inline =~ s/--co2--/$ductco2/g;
		$inline =~ s/--htu--/$htut/g;
		$inline =~ s/--air_vel--/$airvel/g;
		$inline =~ s/--smart_upd--/$smartupd/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# indoor sensors status

if (($uimode eq "status") && ($uismode eq "indoor") && ($uaccess >= $alevel{$uimode.$uismode})) {

	my ($mastert, $masterh, $masterl) = ("N/A", "N/A", "N/A");
	# master sensors TBD

	my ($zonet, $zoneh, $zonel) = ("N/A", "N/A", "N/A");
	my $curzone = (exists $FORM{curzone})?($FORM{curzone} + 0):2;	# have to be first real zone
	my $all = $db->selectall_arrayref("SELECT AVG(paramsensordyn.temperature), AVG(paramsensordyn.humidity), AVG(paramsensordyn.light) FROM paramsensordyn, devices WHERE paramsensordyn.device_id = devices.id AND devices.zone_id = $curzone AND devices.device_type = 1");
	foreach my $row (@$all) {
		$zonet = ttproper(@$row[0]);
		$zoneh = (@$row[1] ne "")?(@$row[1]."%"):"N/A";
		$zonel = (@$row[2] ne "")?(@$row[2]." lux"):"N/A";
	}
	undef $all;

	my ($zonesl, $zoneo) = ("", "N/A");
	my $all = $db->selectall_arrayref("SELECT zones.id, zonesdyn.occupation, zones.description FROM zones, zonesdyn WHERE zonesdyn.zone_id = zones.id AND zones.volume > 0 ORDER BY zones.id");
	foreach my $row (@$all) {
		$zonesl .= "<option value=\"".@$row[0]."\"".((@$row[0] == $curzone)?" selected=\"selected\"":"").">ID: ".@$row[0]." : ".@$row[2]."</option>";
		if (@$row[0] == $curzone) {
			$zoneo = (@$row[1] > 0)?((@$row[1] > 1)?"Semi-occupied":"Occupied"):"Not occupied";
		}
	}
	undef $all;
	
	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--curzone--/$curzone/g;
		$inline =~ s/--master_t--/$mastert/g;
		$inline =~ s/--master_h--/$masterh/g;
		$inline =~ s/--master_l--/$masterl/g;
		$inline =~ s/--zone_t--/$zonet/g;
		$inline =~ s/--zone_h--/$zoneh/g;
		$inline =~ s/--zone_l--/$zonel/g;
		$inline =~ s/--zone_o--/$zoneo/g;
		$inline =~ s/--zones--/$zonesl/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# outdoor sensors status

if (($uimode eq "status") && ($uismode eq "outdoor") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my ($outdoort, $outdoorh, $outdoorl, $outdoorcnt) = ("N/A", "N/A", "N/A", 0);
	my $all = $db->selectall_arrayref("SELECT AVG(paramsensordyn.temperature), AVG(paramsensordyn.humidity), AVG(paramsensordyn.light), COUNT(paramsensordyn.device_id) FROM paramsensordyn, devices WHERE paramsensordyn.device_id = devices.id AND devices.zone_id > 1 AND devices.device_type = 0");
	foreach my $row (@$all) {
		$outdoort = ttproper(@$row[0]);
		$outdoorh = (@$row[1] ne "")?(@$row[1]."%"):"N/A";
		$outdoorl = (@$row[2] ne "")?(@$row[2]." lux"):"N/A";
		$outdoorcnt = @$row[3];
	}
	undef $all;

	my ($weathert, $weatherh, $weatherloc, $weatherw, $weatherap, $weatherc) = ("N/A", "N/A", "N/A", "N/A", "N/A", "N/A");
	{
		my $all = $db->selectall_arrayref("SELECT updated, name, value FROM smartstatus WHERE group_ = 'weather'");
		foreach my $row (@$all) {
			if (@$row[1] eq "temp") {
				$weathert = ttproper(@$row[2]);
			} elsif (@$row[1] eq "humid") {
				$weatherh = (@$row[2] ne "")?(@$row[2]."%"):"N/A";
			} elsif (@$row[1] eq "location") {
				$weatherloc = (@$row[2] ne "")?(@$row[2]):"N/A";
			} elsif (@$row[1] eq "air_pres") {
				$weatherap = (@$row[2] ne "")?(@$row[2]):"N/A";
			} elsif (@$row[1] eq "cond") {
				$weatherc = (@$row[2] ne "")?(@$row[2]):"N/A";
			} elsif (@$row[1] eq "wind") {
				if (@$row[2] ne "") {
					my ($wsp, $wdir) = split(/\ /, @$row[2]);
					my $wtdir = "North";
					if (($wdir >= 11.25) && ($wdir <= 33.75)) {
						$wtdir = "North-North-East";
					} elsif (($wdir >= 33.75) && ($wdir <= 56.25)) {
						$wtdir = "North-East";
					} elsif (($wdir >= 56.25) && ($wdir <= 78.75)) {
						$wtdir = "East-North-East";
					} elsif (($wdir >= 78.75) && ($wdir <= 101.25)) {
						$wtdir = "East";
					} elsif (($wdir >= 101.25) && ($wdir <= 123.75)) {
						$wtdir = "East-South-East";
					} elsif (($wdir >= 123.75) && ($wdir <= 146.25)) {
						$wtdir = "South-East";
					} elsif (($wdir >= 146.25) && ($wdir <= 168.75)) {
						$wtdir = "South-South-East";
					} elsif (($wdir >= 168.75) && ($wdir <= 191.25)) {
						$wtdir = "South";
					} elsif (($wdir >= 191.25) && ($wdir <= 213.75)) {
						$wtdir = "South-South-West";
					} elsif (($wdir >= 213.75) && ($wdir <= 236.25)) {
						$wtdir = "South-West";
					} elsif (($wdir >= 236.25) && ($wdir <= 258.75)) {
						$wtdir = "West-South-West";
					} elsif (($wdir >= 258.75) && ($wdir <= 281.25)) {
						$wtdir = "West";
					} elsif (($wdir >= 281.25) && ($wdir <= 303.75)) {
						$wtdir = "West-North-West";
					} elsif (($wdir >= 303.75) && ($wdir <= 326.25)) {
						$wtdir = "North-West";
					} elsif (($wdir >= 326.25) && ($wdir <= 348.75)) {
						$wtdir = "North-North-West";
					}
					$weatherw = $wtdir.", ".$wsp." m/sec";
				}
			}
		}
		undef $all;
	}

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--outdoor_cnt--/$outdoorcnt/g;
		$inline =~ s/--outdoor_t--/$outdoort/g;
		$inline =~ s/--outdoor_h--/$outdoorh/g;
		$inline =~ s/--outdoor_l--/$outdoorl/g;
		$inline =~ s/--wfc_t--/$weathert/g;
		$inline =~ s/--wfc_h--/$weatherh/g;
		$inline =~ s/--wfc_loc--/$weatherloc/g;
		$inline =~ s/--wfc_w--/$weatherw/g;
		$inline =~ s/--wfc_ap--/$weatherap/g;
		$inline =~ s/--wfc_cond--/$weatherc/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# system status

if (($uimode eq "status") && ($uismode eq "system") && ($uaccess >= $alevel{$uimode.$uismode})) {
        my ($caset) = ("N/A");
        my $cputfile = "/sys/class/thermal/thermal_zone0/temp";
        if (-e $cputfile) {
        	open(CPUT, "<$cputfile");
        	while(<CPUT>) {
        		my $inline = $_;
        		chomp($inline);
        		if ($inline =~ m/(\d+)/) {
        			my $traw = $1;
        			$caset = ttproper($traw / 1000);
        		}
        	}
        	close(CPUT);
        }
#	my $all = $db->selectall_arrayref("SELECT t_int FROM smartsensors ORDER BY id DESC LIMIT 1");
#	foreach my $row (@$all) {
#		$caset = ttproper(@$row[0]);
#	}
#	undef $all;

	my ($syscpu, $sysram, $sysdisk, $sysup, $regstatus, $regtxt, $regmsg, $regamsg) = ("N/A", "N/A", "N/A", "N/A", "", "Registered", "", "");

	if ((($action eq "regmenow") || ($action eq "clean")) && ($HVAC{"system.description"} eq "")) {
		if ($action eq "regmenow") {
			$regamsg = `$regscript tryreg`;
		} elsif ($action eq "clean") {
			$regamsg = `$regscript clean`;
		}
		$regamsg =~ s/\n/\<br\>/g;
		if ($regamsg =~ m/already registered/g) {
			$regmsg = "<tr><td nowrap=\"nowrap\" colspan=2><br><b>Smart Controller already registered at the ASE Cloud server</b><br><br>To restore Smart controller configuration settings from ASE Cloud <a href=\"./engine.pl?mode=$uimode&submode=$uismode&action=restore\"><b>CLICK HERE</b></a><br>To clear saved data and register as new system <a href=\"./engine.pl?mode=$uimode&submode=$uismode&action=clean\"><b>CLICK HERE</b></a></td></tr>";
		} else {
			$regmsg = "<tr><td nowrap=\"nowrap\" colspan=2><br>Registration log:<br><br>$regamsg<br>Click on <b>REFRESH</b> button below to update the page</td></tr>";
		}
	}

	if (($action eq "regmenow") || ($action eq "clean")) {		# tried to register? re-read hvac system values
		my $all = $db->selectall_arrayref("SELECT option_,value_ FROM hvac WHERE submenu > 0 AND option_ LIKE 'system%'");
		foreach my $row (@$all) {
			my ($opt, $val) = @$row;
			$HVAC{$opt} = $val;
		}
	}

	if ($action eq "restore") {
		$regmsg = "<tr><td nowrap=\"nowrap\" colspan=2><br><b>Smart Controller configuration being restored.<br>Please wait until system restarted with new settings.<br><br>Important notice! </b>Smart Controller restart will be made in safe mode.<br>Current IP networks not applied until confirmed in <b>Networks &rarr; IP Network</b> section</a></td></tr>";
		my $facfile = $tmpfold."faclist";
		unlink($facfile);
		open(FAC, ">$facfile");
		print FAC "5\n";		# download settings from ase cloud
		close(FAC);
	}

	my $sernum = (exists $HVAC{"system.serial"})?$HVAC{"system.serial"}:"N/A";
	my $houseid = (exists $HVAC{"system.house_id"})?(sprintf("%05d",$HVAC{"system.house_id"})):"N/A";

	if (($HVAC{"system.description"} eq "") || ($HVAC{"system.serial"} eq "") || ($HVAC{"system.house_id"} eq "")) {	# system unregistered!
		unless ($regamsg =~ "Registration done") {
			$regtxt = "<font color=red>Unregistered";
		}
		$regstatus .= <<EOF;
			<table class="nav">
				<tbody><tr>
					<td class="bwhead">Registration</td>
					<td class="bwhead1">&nbsp;</td>
					<td class="nav1">&nbsp;</td>
				</tr>
				<tr height="3px">
					<td class="Item1"></td>
					<td class="Item2"></td>
					<td></td>
				</tr>
				<tr>
					<td class="Item1"> </td>
					<td class="Item2"> </td>
					<td class="Item3">
						<table class="std"><tbody>
							<tr>
								<td nowrap="nowrap" width="165">Registration status:</td>
								<td class="stdbold" nowrap="nowrap">$regtxt</td>
							</tr> 
							<tr><td colspan=2><div class="in10"></div></td></tr>
							<tr>
								<td nowrap="nowrap" colspan=2>Smart Controller functionality is limited without the ASE Cloud registration<br><b><a href="./engine.pl?mode=$uimode&submode=$uismode&action=regmenow">CLICK HERE to register</a></b>, obtain Serial Number and unique House ID.</td>
							</tr>$regmsg
						</tbody></table>
						<br>
					</td>
				</tr></tbody>
			</table>
EOF
	}

	my $all = $db->selectall_arrayref("SELECT updated, name, value FROM smartstatus WHERE group_ = 'health'");
	foreach my $row (@$all) {
		if (@$row[1] eq "cpu") {
			$syscpu = @$row[2];
		} elsif (@$row[1] eq "ram") {
			$sysram = @$row[2];
		} elsif (@$row[1] eq "disk") {
			$sysdisk = @$row[2];
		} elsif (@$row[1] eq "uptime") {
			$sysup = @$row[2];
		}
	}
	undef $all;

	my ($dbtime) = $db->selectrow_array("SELECT NOW()");
	my $systime = $curdatetime."&nbsp;&nbsp;&nbsp;(GMT".$tzzone[0].$tzzone[1].$tzzone[2].":".$tzzone[3].$tzzone[4].")";

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--regstatus--/$regstatus/g;
		$inline =~ s/--serial--/$sernum/g;
		$inline =~ s/--time_db--/$dbtime/g;
		$inline =~ s/--time_sys--/$systime/g;
		$inline =~ s/--house_id--/$houseid/g;
		$inline =~ s/--sys_cpu--/$syscpu/g;
		$inline =~ s/--sys_ram--/$sysram/g;
		$inline =~ s/--sys_disk--/$sysdisk/g;
		$inline =~ s/--sys_up--/$sysup/g;
#		$inline =~ s/--bypasshw--/$bypasshw/g;
		$inline =~ s/--case_t--/$caset/g;
#		$inline =~ s/--t_supply_duct--/$tsduct/g;
#		$inline =~ s/--t_return_duct--/$trduct/g;
#		$inline =~ s/--h_supply_duct--/$hsduct/g;
#		$inline =~ s/--h_return_duct--/$hrduct/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# networks status

if (($uimode eq "status") && ($uismode eq "networks") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my ($netip, $netgw, $netwan, $netcloud, $wanlist, $wancip, $wancgw, $dnslst, $netmac) = ("N/A", "N/A", "N/A", "N/A", "", "N/A", "N/A", "N/A", "N/A");
	{
		my $all = $db->selectall_arrayref("SELECT updated, name, value FROM smartstatus WHERE group_ = 'network'");
		foreach my $row (@$all) {
			if (@$row[1] eq "ip_main") {
				$netip = @$row[2];
			} elsif (@$row[1] eq "gateway") {
				$netgw = @$row[2];
			} elsif (@$row[1] eq "ip_wan") {
				$netwan = @$row[2];
			} elsif (@$row[1] eq "mac") {
				$netmac = @$row[2];
			} elsif (@$row[1] eq "cloud") {
				$netcloud = @$row[2];
			} elsif (@$row[1] eq "ip_cwan") {
				$wancip = (@$row[2] ne "")?@$row[2]:"N/A";
			} elsif (@$row[1] eq "gw_cwan") {
				$wancgw = (@$row[2] ne "")?@$row[2]:"N/A";
			} elsif (@$row[1] eq "dns") {
				unless (@$row[2] eq "") {
					$dnslst = "";
					my @dlst = split(/\;/, @$row[2]);
					foreach my $ditem (@dlst) {
						$dnslst .= $ditem."<br>";
					}
				}
			} elsif (@$row[1] eq "list_wan") {
				unless (@$row[2] eq "") {
					$wanlist = "<tr><td colspan=2><div class=\"in10\"></div></td></tr>";
					my ($wwwip, $wwwmac) = ("", "");
					my @wlst = split(/\;/, @$row[2]);
					foreach my $witem (@wlst) {
						my ($wwip, $wwmac) = split(/\,/, $witem);
						$wwwip .= $wwip."<br>";
						$wwwmac .= "MAC: ".$wwmac."<br>";
					}
					$wanlist .= "<tr><td nowrap=\"nowrap\" width=\"165\" valign=top>Clients Connected:</td><td class=\"stdbold\" nowrap=\"nowrap\" width=100>$wwwip</td><td class=\"stdbold\" nowrap=\"nowrap\">$wwwmac</td></tr>\n";
				}
			}
		}
		undef $all;
	}

	my ($wanap, $wancap) = ("N/A", "N/A");
	{
		my $all = $db->selectall_arrayref("SELECT ap_name, wan_ap_name FROM networks ORDER BY id DESC limit 1");
		foreach my $row (@$all) {
			unless (@$row[0] eq "") {
				$wanap = @$row[0];
			}
			unless (@$row[1] eq "") {
				$wancap = @$row[1];
			}
		}
		undef $all;
	}
	
	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--wan_list--/$wanlist/g;
		$inline =~ s/--dns--/$dnslst/g;
		$inline =~ s/--net_ip--/$netip/g;
		$inline =~ s/--net_mac--/$netmac/g;
		$inline =~ s/--net_gw--/$netgw/g;
		$inline =~ s/--net_wan--/$netwan/g;
		$inline =~ s/--net_cloud--/$netcloud/g;
		$inline =~ s/--wanc_ap--/$wancap/g;
		$inline =~ s/--wanc_ip--/$wancip/g;
		$inline =~ s/--wanc_gw--/$wancgw/g;
		$inline =~ s/--wan_ap--/$wanap/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# zigbee network status

if (($uimode eq "status") && ($uismode eq "zigbee") && ($uaccess >= $alevel{$uimode.$uismode})) {
	
	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# Zones management

if (($uimode eq "zonedev") && ($uismode eq "zones") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my ($updmsg, $upd2msg) = ("", "");

	if ($action eq "remove") {
		my $zoneid = $FORM{zoneid} + 0;
		if ($zoneid > 2) {			# if someones try to delete master zone
			dbdo("UPDATE devices SET zone_id = 1 WHERE zone_id = $zoneid", 0);		# move orphaned devices to zone1
			dbdo("DELETE FROM zonesdyn WHERE zone_id = $zoneid", 0);
			dbdo("DELETE FROM zonesadvanced WHERE zone_id = $zoneid", 0);
			dbdo("DELETE FROM states WHERE zone_id = $zoneid", 0);
			dbdo("DELETE FROM zones WHERE id = $zoneid", 0);
			$updmsg = "<tr><td colspan=6><br>Zone deleted and all previously assigned devices moved to Virtual zone</td></tr>\n";
		}
	}

	if ($action eq "save") {
		my $nzname = $FORM{zonesn};
		if ((length($nzname) < 6) && (length($nzname) > 0)) {
			$updmsg = "<tr><td colspan=6><br>Zone name should have at least 6 alphanumeric characters</td></tr>\n";
			$nzname = "";
		} elsif (length($nzname) >= 6)  {
			my ($nzcnt) = $db->selectrow_array("SELECT COUNT(*) FROM zones WHERE description = '$nzname'");
			if ($nzcnt > 0) {
				$updmsg = "<tr><td colspan=6><br>Zone name must be unique. Two zones of same name cannot be created</td></tr>\n";
				$nzname = "";
			}
		}
		unless ($nzname eq "") {
			my $sarea = (exists $FORM{zonessa})?1:0;
			my $nlev = $FORM{zonesla} + 0;
			my $nori = $FORM{zonesoa} + 0;
			dbdo("INSERT INTO zones VALUES (NULL, 1, '$nzname', 1, $sarea, $nlev, $nori)", 0, 1);
			my $sth = $db->prepare("SELECT MAX(id) FROM zones");
			$sth->execute;
			my ($nzoneid) = $sth->fetchrow_array();
			$sth->finish;
			undef $sth;
			dbdo("INSERT INTO zonesdyn VALUES ($nzoneid, 0, 0, 0, 0, 0)", 0);
		}
	}

	my @zones = ("");
	my $zonesl = "";
	my @zlevels = ("Same", "Above", "Below");
	my @zorient = ("N/A", "South", "North", "West", "East");

	my $all = $db->selectall_arrayref("SELECT id, description, sleep_area, level, orientation FROM zones ORDER BY id");
	foreach my $row (@$all) {
		my $zid = @$row[0];
		my $zonedef = "zones".$zid;
		my $zlcidx = @$row[3] + 0;
		my $zocidx = @$row[4] + 0;
		if (($action eq "save") && ($FORM{$zonedef} ne ""))  {
			my $nzsarea = (exists $FORM{"zonessa".$zid})?1:0;
			my $nzlev = $FORM{"zonesla".$zid} + 0;
			my $nzori = $FORM{"zonesoa".$zid} + 0;
			if ($FORM{$zonedef} ne @$row[1]) {
				dbdo("UPDATE zones SET description = '".$FORM{$zonedef}."' WHERE id = ".$zid, 0);
				@$row[1] = $FORM{$zonedef};
			}
			if ($nzsarea ne @$row[2]) {
				dbdo("UPDATE zones SET sleep_area = '$nzsarea' WHERE id = ".$zid, 0);
				@$row[2] = $nzsarea;
			}
			if ($zlcidx != $nzlev) {
				$zlcidx = $nzlev;
				dbdo("UPDATE zones SET level = '$nzlev' WHERE id = ".$zid, 0);
			}
			if ($zocidx != $nzori) {
				$zocidx = $nzori;
				dbdo("UPDATE zones SET orientation = '$nzori' WHERE id = ".$zid, 0);
			}
		}
		if ($zid == 1) {
			$zones[1] = @$row[1];
		} elsif ($zid == 2) {
			$zones[2] = @$row[1];
		} else {
			my ($zllist, $zolist) = ("", "");
			for my $zlidx (0 .. $#zlevels) {
				$zllist .= "<option value=\"$zlidx\" ".(($zlidx == $zlcidx)?" selected=\"selected\"":"").">".$zlevels[$zlidx]."</option>";
			}
			for my $zoidx (0 .. $#zorient) {
				$zolist .= "<option value=\"$zoidx\" ".(($zoidx == $zocidx)?" selected=\"selected\"":"").">".$zorient[$zoidx]."</option>";
			}
			$zonesl .= "<tr><td nowrap=\"nowrap\" width=\"118\">Zone ID #".$zid.":</td><td><input name=\"zones".$zid."\" size=\"20\" maxlength=\"50\" value=\"".@$row[1]."\" type=\"text\"></td><td align=center><select name=\"zonesla".$zid."\">$zllist</select></td><td align=center><select name=\"zonesoa".$zid."\">$zolist</select></td><td align=center><input name=\"zonessa".$zid."\" type=\"checkbox\" ".((@$row[2] == 1)?"checked=\"checked\"":"")."></td><td><input name=\"zones".$zid."del\" value=\"Delete\" onClick=\"window.location.href='./engine.pl?mode=$uimode&submode=$uismode&zoneid=".$zid."&action=remove'\" type=\"button\"></td></tr>\n";
		}
	}
	undef $all;

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--zones1--/$zones[1]/g;
		$inline =~ s/--zones2--/$zones[2]/g;
		$inline =~ s/--updmessage--/$updmsg/g;
		$inline =~ s/--upd2message--/$upd2msg/g;
		$inline =~ s/--zonesl--/$zonesl/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# Devices management

if (($uimode eq "zonedev") && ($uismode eq "devices") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my %asemp = ();
	{
		my $all = $db->selectall_arrayref("SELECT profile_id, description FROM asemp WHERE type_ = 2 ORDER BY profile_id");
		foreach my $row (@$all) {
#			$asemp{@$row[0]} = @$row[1];
			$asemp{@$row[0]} = (@$row[0] == 0)?"Default":"User #".@$row[0];
		}
		undef $all;
	}

	my %zones = ();
	{
		my $all = $db->selectall_arrayref("SELECT id, description FROM zones ORDER BY id");
		foreach my $row (@$all) {
			$zones{@$row[0]} = @$row[1];
		}
		undef $all;
	}

	my %devtypes = ("1", "Temperature Sensor", "2", "Humidity Sensor", "4", "PIR Sensor", "8", "Ambient Light Sensor", "16", "CO Sensor", "32", "CO2 Sensor", "64", "Future Sensor", "128", "Step motor");
	my %tdevtypes = ("6", "On/Off", "1794", "Smart Metering");
	my %tdevprof = ("260", "0x104");
	my ($devices, $tdevices, $ddevices) = ("", "", "");
	my @flaptypes = ("Generic step motor", "Supply air flap", "Return air flap");
	my $dlmzone = 0;
	{
		my $all = $db->selectall_arrayref("SELECT devices.id, devices.zone_id, devices.device_type, devices.description, devices.asemp, zigbee_ase.device_status, zigbee_ase.device_state, zigbee_ase.device_type, devices.hardware_type FROM devices LEFT JOIN zigbee_ase ON zigbee_ase.device_id = devices.id WHERE devices.device_type = 0 GROUP BY devices.id ORDER BY devices.zone_id, devices.id");
		foreach my $row (@$all) {
			my ($devid, $dzoneid, $dtype, $ddesc, $dasemp, $dzstats, $dzstate, $dztype, $dhwtype) = @$row;
			my $upbord = "";
			if (($dlmzone > 0) && ($dlmzone != $dzoneid)) {
				$upbord = "<div class=in10></div>";
				$dlmzone = $dzoneid;
			} elsif ($dlmzone == 0) {
				$dlmzone = $dzoneid;
			}
			if ($action eq "save") {
				if ((exists $FORM{"dh".$devid}) && ($FORM{"dh".$devid} != $dhwtype)) {
					$dhwtype = $FORM{"dh".$devid};
					dbdo("UPDATE devices SET hardware_type = '$dhwtype' WHERE id = $devid", 0);
				}
				if ((exists $FORM{"dz".$devid}) && ($FORM{"dz".$devid} != $dzoneid)) {
					$dzoneid = $FORM{"dz".$devid};
					dbdo("UPDATE devices SET zone_id = '$dzoneid' WHERE id = $devid", 0);
				}
				if ((exists $FORM{"dd".$devid}) && ($FORM{"dd".$devid} ne $ddesc)) {
					$ddesc = $FORM{"dd".$devid};
					dbdo("UPDATE devices SET description = '$ddesc' WHERE id = $devid", 0);
				}
				if ((exists $FORM{"da".$devid}) && ($FORM{"da".$devid} != $dasemp)) {
					$dasemp = $FORM{"da".$devid};
					dbdo("UPDATE devices SET asemp = '$dasemp' WHERE id = $devid", 0);
					dbdo("UPDATE zigbee_ase SET profile_id = '$dasemp' WHERE device_id = $devid", 0);
					$db->do("INSERT INTO commands (id, updated, command, parameters) VALUES (NULL, NOW(), 57, $devid)");	# send command to MD
				}
				if (exists $FORM{"ds".$devid}) {				# handle enable/disable/delete
					my $newstat = $FORM{"ds".$devid} + 0;
						$debug .= $newstat;
					if ($newstat == 3) {					# remove device
						$dzstats = 2;
						dbdo("UPDATE zigbee_ase SET device_status = '$dzstats', updated = NOW() WHERE device_id = $devid", 0);
					} elsif (($newstat != $dzstate) && ($newstat >= 1) && ($newstat <= 2)) {
						$dzstate = $newstat;
						dbdo("UPDATE zigbee_ase SET device_state = '$dzstate', updated = NOW() WHERE device_id = $devid", 0);
						$db->do("INSERT INTO commands (id, updated, command, parameters) VALUES (NULL, NOW(), 57, $devid)");	# send command to MD
					}
				}
			}
			if ($dzstats != 2) {									# not deleted
				my $devfeat = "";
				my $dfnum = 0;
				foreach my $ddtype (sort keys %devtypes) {
					my $dddtype = $ddtype + 0;
					if ($dztype & $dddtype) {			# bitmapped type enabled
						$devfeat .= "<option>".$devtypes{$ddtype}."</option>";
						$dfnum ++;
					}
				}
				$devices .= "<tr><td nowrap=\"nowrap\" width=60 valign=top>$upbord";
				if ($dztype & 128) {					# step motor?
					$devices .= "<select name=\"dh".$devid."\" size=1>";
					for my $hwtidx (0 .. $#flaptypes) {
						$devices .= "<option value=\"$hwtidx\"".(($dhwtype == $hwtidx)?" selected":"").">".$flaptypes[$hwtidx]."</option>";
					}
					$devices .= "</select>";
				} else {
					$devices .= "<div class=\"hhbloc\"><select multiple size=\"$dfnum\" readonly=\"readonly\">$devfeat</select></div>";
				}
				$devices .= "</td><td nowrap=\"nowrap\" width=60 valign=top>$upbord<input name=\"dd".$devid."\" size=15 maxlength=50 value=\"$ddesc\" type=text></td><td nowrap=\"nowrap\" width=100 valign=top>$upbord<select name=\"dz".$devid."\" size=1>";
				foreach my $izone (sort keys %zones) {
					$devices .= "<option value=\"$izone\"".(($izone == $dzoneid)?" selected":"").">".$zones{$izone}."</option>";
				}
				$devices .= "</select></td>
					<td nowrap=\"nowrap\" width=50 valign=top>$upbord<select name=\"da".$devid."\" size=1>";
				foreach my $iasemp (sort keys %asemp) {
					$devices .= "<option value=\"$iasemp\"".(($iasemp == $dasemp)?" selected":"").">".$asemp{$iasemp}."</option>";
				}
				$devices .= "</select></td>
					<td nowrap=\"nowrap\" width=50 valign=top>$upbord<select name=\"ds".$devid."\" size=1>
					<option value=\"1\"".(($dzstate == 1)?" selected":"").">Enabled</option>
					<option value=\"2\"".(($dzstate == 2)?" selected":"").">Disabled</option>
					<option value=\"3\">Deleted</option>
					</select></td></tr>\n";
			} elsif ($dzstats == 2) {										# deleted devices
				$ddevices .= "<tr><td nowrap=\"nowrap\" width=100>$upbord<input name=\"dd".$devid."\" size=20 maxlength=50 value=\"$ddesc\" type=text readonly=\"readonly\"></td>";
				$ddevices .= "<td nowrap=\"nowrap\" width=100>$upbord<input name=\"dz".$devid."\" size=20 type=text value=\"".$zones{$dzoneid}."\" readonly=\"readonly\">";
				$ddevices .= "<td nowrap=\"nowrap\" width=100>".$upbord."<input name=\"dtp".$devid."\" size=20 type=text value=\""."ASE Remote\" type=text readonly=\"readonly\"></td>";
				$ddevices .= "</tr>\n";
			}
		}
		undef $all;
	}

	{
		my $all = $db->selectall_arrayref("SELECT devices.id, devices.zone_id, devices.device_type, devices.description, zigbee_ha.profile_id, zigbee_ha.device_status, zigbee_ha.cluster_id FROM devices LEFT JOIN zigbee_ha ON zigbee_ha.device_id = devices.id WHERE devices.device_type = 80 GROUP BY devices.id ORDER BY devices.zone_id, devices.id");
		foreach my $row (@$all) {
			my ($devid, $dzoneid, $dtype, $ddesc, $dasemp, $dzstats, $dztype) = @$row;
			my $upbord = "";
			if (($dlmzone > 0) && ($dlmzone != $dzoneid)) {
				$upbord = "<div class=in10></div>";
				$dlmzone = $dzoneid;
			} elsif ($dlmzone == 0) {
				$dlmzone = $dzoneid;
			}
			if ($action eq "save") {
				if ((exists $FORM{"dz".$devid}) && ($FORM{"dz".$devid} != $dzoneid)) {
					$dzoneid = $FORM{"dz".$devid};
					dbdo("UPDATE devices SET zone_id = '$dzoneid' WHERE id = $devid", 0);
				}
				if ((exists $FORM{"dd".$devid}) && ($FORM{"dd".$devid} ne $ddesc)) {
					$ddesc = $FORM{"dd".$devid};
					dbdo("UPDATE devices SET description = '$ddesc' WHERE id = $devid", 0);
				}
				if ((exists $FORM{"da".$devid}) && ($FORM{"da".$devid} != $dasemp)) {
					$dasemp = $FORM{"da".$devid};
					dbdo("UPDATE devices SET asemp = '$dasemp' WHERE id = $devid", 0);
					dbdo("UPDATE zigbee_ha SET profile_id = '$dasemp' WHERE device_id = $devid", 0);
				}
				if (exists $FORM{"ds".$devid}) {				# handle enable/disable/delete
					my $newstat = $FORM{"ds".$devid} + 0;
					if ($newstat == 3) {					# remove device
						$dzstats = 2;
						dbdo("UPDATE zigbee_ase SET device_status = '$dzstats', updated = NOW() WHERE device_id = $devid", 0);
					}
				}
			}
			if ($dzstats != 2) {									# not deleted
				$tdevices .= "<tr><td nowrap=\"nowrap\" width=90>$upbord<input size=15 maxlength=50 value=\"".$tdevtypes{$dztype}."\" type=text readonly=\"readonly\"></td>\n";
				$tdevices .= "<td nowrap=\"nowrap\" width=90>$upbord<input name=\"dd".$devid."\" size=15 maxlength=50 value=\"$ddesc\" type=text></td>\n
					<td nowrap=\"nowrap\" width=100>$upbord<select name=\"dz".$devid."\" size=1>";
				foreach my $izone (sort keys %zones) {
					$tdevices .= "<option value=\"$izone\"".(($izone == $dzoneid)?" selected":"").">".$zones{$izone}."</option>";
				}
				$tdevices .= "</select></td>";
				$tdevices .= "<td nowrap=\"nowrap\" width=50>$upbord<input size=7 maxlength=50 value=\"".$tdevprof{$dasemp}."\" type=text readonly=\"readonly\"></td>\n";
				$tdevices .= "<td nowrap=\"nowrap\" width=50>$upbord<select name=\"ds".$devid."\" size=1>
					<option value=\"1\"".(($dzstats != 2)?" selected":"").">Enabled</option>
					<option value=\"2\">Deleted</option>
					</select></td></tr>\n";
			} elsif ($dzstats == 2) {										# deleted devices
				$ddevices .= "<tr><td nowrap=\"nowrap\" width=100>$upbord<input name=\"dd".$devid."\" size=20 maxlength=50 value=\"$ddesc\" type=text readonly=\"readonly\"></td>";
				$ddevices .= "<td nowrap=\"nowrap\" width=100>$upbord<input name=\"dz".$devid."\" size=20 type=text value=\"".$zones{$dzoneid}."\" readonly=\"readonly\">";
					$ddevices .= "<td nowrap=\"nowrap\" width=100>".$upbord."<input name=\"dtp".$devid."\" size=20 type=text value=\""."3rd party Zigbee\" type=text readonly=\"readonly\"></td>";
				$ddevices .= "</tr>\n";
			}
		}
		undef $all;
	}

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--devices--/$devices/g;
		$inline =~ s/--3devices--/$tdevices/g;
		$inline =~ s/--ddevices--/$ddevices/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# Devices management

if (($uimode eq "zonedev") && ($uismode eq "newdev") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my %zones = ();
	my $lzones = "";
	{
		my $all = $db->selectall_arrayref("SELECT id, description FROM zones ORDER BY id");
		foreach my $row (@$all) {
			$zones{@$row[0]} = @$row[1];
			$lzones .= "<option value=\"".@$row[0]."\">".@$row[1]."</option>";
		}
		undef $all;
	}

	if (($action eq "save") && (exists $FORM{regtimeout})) {
		my $newregtout = $FORM{regtimeout} + 0;
		if ($HVAC{"system.reg_timeout"} != $newregtout) {
			$HVAC{"system.reg_timeout"} = $newregtout;
			dbdo("UPDATE hvac SET value_ = $newregtout WHERE option_ = 'system.reg_timeout';", 0);
			my $alreg = ($HVAC{"system.regmode"} == 0)?"0":"1 $newregtout";
			$db->do("INSERT INTO commands (id, updated, command, parameters) VALUES (NULL, NOW(), 53, '$alreg')");		# issue command 0x35 to muxdemux with changed timeout
		}
	}

	my @regmode = (" onClick=\"document.newdev.submit();\"", " onClick=\"document.newdev.submit();\"", " onClick=\"document.newdev.submit();\"");
	if (($action eq "save") && (exists $FORM{regmode})) {
		my $newregmode = $FORM{regmode} + 0;
		if ($HVAC{"system.regmode"} != $newregmode) {
			$HVAC{"system.regmode"} = $newregmode;
			dbdo("UPDATE hvac SET value_ = $newregmode WHERE option_ = 'system.regmode';", 0);
			my $alreg = ($newregmode == 0)?"0":"1 ".$HVAC{"system.reg_timeout"};
			$db->do("INSERT INTO commands (id, updated, command, parameters) VALUES (NULL, NOW(), 53, '$alreg')");		# issue command 0x35 to muxdemux
		}
	}
	$regmode[$HVAC{"system.regmode"}] = " checked";

	my $regtout = "";
	my %regtlist = ("0000", "Infinite", "0005", "5 minutes", "0015", "15 minutes", "0030", "30 minutes", "0060", "1 hour", "0120", "2 hours", "1440", "1 day");
	if ($HVAC{"system.regmode"} > 0) {
		$regtout = "</tr><td nowrap=\"nowrap\" width=\"238\">Allow New Devices Registration For:</td><td align=\"left\" nowrap=\"nowrap\"><select name=\"regtimeout\" size=\"1\" onChange=\"document.newdev.submit();\">";
		foreach my $regtims (sort keys %regtlist) {
			$regtout .= "<option value=\"$regtims\"".(($regtims == $HVAC{"system.reg_timeout"})?" selected":"").">".$regtlist{$regtims}."</option>";
		}
		$regtout .= "</select>";
		if ($HVAC{"system.reg_timeout"} > 0) {
			my ($remmins) = $db->selectrow_array("SELECT FLOOR((UNIX_TIMESTAMP(NOW()) - UNIX_TIMESTAMP(updated)) / 60) FROM alarms_zigbee WHERE type_ = 13 ORDER BY id DESC LIMIT 1");
			$remmins = ($remmins > $HVAC{"system.reg_timeout"})?0:($HVAC{"system.reg_timeout"} - $remmins);
			$regtout .= "&nbsp;&nbsp;&nbsp; $remmins minutes remains";
		}
		$regtout .= "</td></tr>\n";
	}

	my ($recent, $pending) = ("", "");
	my %devtypes = ("0", "ASE Remote", "80", "3rd Party Zigbee");
	{
		my $allrows = 0;
		my $all = $db->selectall_arrayref("SELECT id, device_type, zigbee_addr64, zigbee_mode, zone_id, status FROM registrations WHERE status = 0 AND event_type = 1 ORDER BY id");	# only pending
		foreach my $row (@$all) {
			my ($devid, $dtype, $addr64, $dmode, $zoneid, $dstat) = @$row;
			if (($action eq "accept") && ($FORM{devid} == $devid)) {
				my $newzone = 1;						# default zone
				my $newasemp = 0;						# default profile
				dbdo("INSERT INTO devices VALUES(NULL, '$newzone', 0, '$dtype', '".$devtypes{$dtype}."', '$addr64', '$newasemp', '')", 0);
				$sth = $db->prepare("SELECT MAX(id) FROM devices");
				$sth->execute;
				my ($newdevid) = $sth->fetchrow_array();
				$sth->finish;
				if ($dtype == 0) {		# ASE
					dbdo("UPDATE zigbee_ase SET device_id = '$newdevid', updated = NOW(), device_status = 1, device_state = 1, profile_id = '$newasemp' WHERE addr64 = '$addr64'", 0);
				} elsif ($dtype == 80) {	# HA
					dbdo("UPDATE zigbee_ha SET device_id = '$newdevid', updated = NOW(), device_status = 1, profile_id = '260' WHERE addr64 = '$addr64'", 0);
				}
				dbdo("UPDATE registrations SET status = 2, zone_id = '$newzone', device_id = '$newdevid', updated = NOW(), asemp_id = '$newasemp' WHERE id = $devid", 0);
			} elsif (($action eq "reject") && ($FORM{devid} == $devid)) {
				dbdo("UPDATE registrations SET status = 3 WHERE id = $devid", 0);
				$db->do("INSERT INTO commands (id, updated, command, parameters) VALUES (NULL, NOW(), 54, $devid)");		# issue command 0x36 to muxdemux
			}
		}
		undef $all;
		if ($allrows == 0) {
			$pending .= "<td nowrap=\"nowrap\" class=\"stdbold\">No remote devices registrations pending</td>";
		}

		my $donerows = 0;
		my $all = $db->selectall_arrayref("SELECT id, device_type, zigbee_addr64, zigbee_mode, zone_id, status FROM registrations WHERE status = 0 AND event_type = 1 ORDER BY id DESC");
		foreach my $row (@$all) {
			my ($devid, $dtype, $addr64, $dmode, $zoneid, $dstat) = @$row;
			$donerows++;
			$recent .= "<tr>
					<td nowrap=\"nowrap\" width=\"138\" >".$devtypes{$dtype}."</td>
					<td nowrap=\"nowrap\" width=\"148\" >".$addr64."</td>
					<td nowrap=\"nowrap\" width=\"180\" >
					<input name=\"newreg".$devid."ok\" value=\"Accept\" onClick=\"window.location.href='./engine.pl?mode=$uimode&submode=$uismode&action=accept&devid=$devid';\" type=\"button\">&nbsp;<input name=\"newreg".$devid."del\" value=\"Remove\" onClick=\"window.location.href='./engine.pl?mode=$uimode&submode=$uismode&action=reject&devid=$devid'\" type=\"button\">
				</tr>\n";
		}
		undef $all;
		if ($donerows == 0) {
			$recent .= "<td nowrap=\"nowrap\" class=\"stdbold\">No recent remote device registrations to show</td>";
		} else {
			$recent = "<tr><td nowrap=\"nowrap\" width=\"138\" class=\"stdbold\">Device Group</td><td nowrap=\"nowrap\" width=\"148\" class=\"stdbold\">MAC Address</td><td nowrap=\"nowrap\" width=\"138\" class=\"stdbold\">&nbsp;</td></tr>\n".$recent;
		}
	}

	if ($HVAC{"system.regmode"} > 0) {
	$headadd .= <<EOF;
		<meta http-equiv="refresh" content="10;URL=./engine.pl?mode=$uimode&submode=$uismode">
EOF
	}
	
	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--regmode0--/$regmode[0]/g;
		$inline =~ s/--regmode1--/$regmode[1]/g;
		$inline =~ s/--regmode2--/$regmode[2]/g;
		$inline =~ s/--regtimeout--/$regtout/g;
		$inline =~ s/--recent--/$recent/g;
		$inline =~ s/--pending--/$pending/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# networks IP menu

if (($uimode eq "networks") && ($uismode eq "ip") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my @wanapnames = ("WAN Client Disabled");
	my $wanapnidx = 1;
	if ($action eq "scanwifi") {
		$db->do("INSERT INTO hvac_actions (id, type_) VALUES (NULL, 2)");		# send command to scan wifi APs
		sleep(10);									# ..and wait
	}
	if (-e $apchans) {
		open(APS, $apchans);
		while (<APS>) {
			my $inap = $_;
			chomp($inap);
			my ($wanch, $wanes) = split(/\:/, $inap);
			$wanapnames[$wanapnidx] .= "Ch.".$wanch.": ".$wanes;
			$wanapnidx++;
		}
		close(APS);
	}

	$headadd .= <<EOF;
<script src="./floater.js">
</script>
EOF

	if (($action eq "save") && (exists $FORM{netip_id})) {
		my $wanapnn = "";
		my $apchan = $FORM{ap_channel} + 0;
		if ($FORM{wan_ap_name} =~ m/^Ch\.(\d+):\s+(.+)$/) {
			my $wapchan = $1;
			$wanapnn = $2;
			if ($wapchan > 0) {
				$apchan = $wapchan;		# auto set chan for AP same to Client
			}
		} elsif ($FORM{wan_ap_name} eq $wanapnames[0]) {	# wlan client disabled?
			$FORM{wan_ap_key} = "";				# clean wan key
		}
		if (-e $wpasupp) {		# generate wpa_supplicant config
			open(WPA, ">$wpasupp");
			print WPA "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev\n";
			print WPA "update_config=1\n\n";
			print WPA "network={\n";
			print WPA "	ssid=\"".$wanapnn."\"\n";
			print WPA "	scan_ssid=1\n";
			print WPA "	psk=\"".$FORM{wan_ap_key}."\"\n";
			print WPA "	proto=RSN\n";
			print WPA "	key_mgmt=WPA-PSK\n";
			print WPA "	pairwise=CCMP\n";
			print WPA "	auth_alg=OPEN\n";
			print WPA "}\n";
			close(WPA);
		}
		my $netipid = $FORM{netip_id};
		my $dhcp = $FORM{lan_dhcp} + 0;
		if ($dhcp == 0) {
			dbdo("UPDATE networks SET lan_dhcp = '$dhcp', lan_netmask='".($FORM{lan_netmask0} + 0).".".($FORM{lan_netmask1} + 0).".".($FORM{lan_netmask2} + 0).".".($FORM{lan_netmask3} + 0)."', lan_gateway='".($FORM{lan_gateway0} + 0).".".($FORM{lan_gateway1} + 0).".".($FORM{lan_gateway2} + 0).".".($FORM{lan_gateway3} + 0)."', lan_ip='".($FORM{lan_ip0} + 0).".".($FORM{lan_ip1} + 0).".".($FORM{lan_ip2} + 0).".".($FORM{lan_ip3} + 0)."', dns1='".($FORM{dns10} + 0).".".($FORM{dns11} + 0).".".($FORM{dns12} + 0).".".($FORM{dns13} + 0)."', dns2='".($FORM{dns20} + 0).".".($FORM{dns21} + 0).".".($FORM{dns22} + 0).".".($FORM{dns23} + 0)."' WHERE id = $netipid", 0);
		}
		dbdo("UPDATE networks SET lan_dhcp = '$dhcp', timeserver1 = '".$FORM{timeserver1}."', timeserver2 = '".$FORM{timeserver2}."', ap_security = '".$FORM{ap_security}."', ap_protocol = '".($FORM{ap_protocol} + 0)."', ap_channel = '".$apchan."', ap_name = '".$FORM{ap_name}."', wan_ap_name = '".$FORM{wan_ap_name}."', wan_ap_key = '".$FORM{wan_ap_key}."' WHERE id = $netipid", 0);
		if (-e $hostapd) {		# generate hostapd config if old exists only
			open(HOS, ">$hostapd");
			print HOS "interface=wlan0\n";
			print HOS "driver=nl80211\n";
			print HOS "ssid=".$FORM{ap_name}."\n";
			print HOS "hw_mode=g\n";
			print HOS "channel=".$apchan."\n";
			print HOS "macaddr_acl=0\n";
			print HOS "auth_algs=1\n";
			print HOS "ignore_broadcast_ssid=0\n";
			print HOS "wpa=2\n";
			print HOS "wpa_passphrase=".$FORM{ap_security}."\n";
			print HOS "wpa_key_mgmt=WPA-PSK\n";
			print HOS "wpa_pairwise=TKIP\n";
			print HOS "rsn_pairwise=CCMP\n";
			print HOS "logger_syslog=-1\n";
			print HOS "logger_syslog_level=2\n";
			close(HOS);
		}
		$db->do("INSERT INTO hvac_actions (id, type_) VALUES (NULL, 1)");		# send command to update config files
		if ($FORM{wanrest} eq "yesa") {			# restart WAN Client
			sleep(3);
			$db->do("INSERT INTO hvac_actions (id, type_) VALUES (NULL, 3)");	# send command to restart WAN
			sleep(7);
		} elsif ($FORM{wanrest} eq "yesb") {		# restart WAN AP
			sleep(3);
			$db->do("INSERT INTO hvac_actions (id, type_) VALUES (NULL, 4)");	# send command to restart WAN AP
			sleep(7);
		}
	}

	my $netipid = 0;
        my @dns1 = (0, 0, 0, 0);
        my @dns2 = (0, 0, 0, 0);
        my @lanip = (0, 0, 0, 0);
        my @langw = (0, 0, 0, 0);
        my @lanmask = (0, 0, 0, 0);
        my ($timesrv1, $timesrv2) = ("", "");
        my ($cellmodem, $celltype) = ("N/A", "N/A");
        my ($apchannel, $approtocol) = (0, 0);
        my ($apsecurity, $apname) = ("", "");
        my ($wanapname, $wanapkey, $wapstatus) = ("", "", "Disconnected");
        my ($cloud1, $cloud2) = ("", "");
        my $dhcp = 0;
        my @ldhcp = ("", "");
	my $all = $db->selectall_arrayref("SELECT timeserver1, timeserver2, cell_modem, cell_type, ap_name, ap_channel, ap_security, ap_protocol, wan_ap_name, wan_ap_key, cloud1, cloud2, dns1, dns2, lan_ip, lan_gateway, lan_netmask, lan_dhcp, id FROM networks ORDER BY id DESC LIMIT 1");
	foreach my $row (@$all) {
		($timesrv1, $timesrv2) = (@$row[0], @$row[1]);
		$cellmodem = (@$row[2] == 0)?"NO":"YES";
		$celltype = (@$row[3] ne "")?@$row[3]:"N/A";
		$apname = @$row[4];
		$apchannel = @$row[5] + 0;
		$apsecurity = @$row[6];
		$approtocol = @$row[7] + 0;
		($wanapname, $wanapkey) = (@$row[8], @$row[9]);
		($cloud1, $cloud2) = (@$row[10], @$row[11]);			# cloud scan is TBD
		@dns1 = split(/\./,@$row[12]);
		@dns2 = split(/\./,@$row[13]);
		@lanip = split(/\./,@$row[14]);
		@langw = split(/\./,@$row[15]);
		@lanmask = split(/\./,@$row[16]);
		$dhcp = @$row[17] + 0;
		if ($dhcp == 1) {				# dynamic? set params as r/o
			for my $iddx (0 .. 3) {
#				$dns1[$iddx] .= "\" disabled=\"disabled";
#				$dns2[$iddx] .= "\" disabled=\"disabled";
#				$lanip[$iddx] .= "\" disabled=\"disabled";
#				$langw[$iddx] .= "\" disabled=\"disabled";
#				$lanmask[$iddx] .= "\" disabled=\"disabled";
			}
			$ldhcp[1] = "checked=\"checked\"";
		} else {
			$ldhcp[0] = "checked=\"checked\"";
		}
		$netipid = @$row[18];
	}
	undef $all;

	{
		my ($ipcwan, $gwcwan) = ("", "");
		my $all = $db->selectall_arrayref("SELECT updated, name, value FROM smartstatus WHERE group_ = 'network' AND ((name = 'ip_cwan') OR (name = 'gw_cwan'))");
		foreach my $row (@$all) {
			if ((@$row[1] eq "ip_cwan") && (@$row[2] ne "")) {
				$ipcwan = @$row[2];
			}
			if ((@$row[1] eq "gw_cwan") && (@$row[2] ne "")) {
				$gwcwan = @$row[2];
			}
		}
		undef $all;
		if (($ipcwan ne "") && ($gwcwan ne "")) {
			$wapstatus = "IP Address : $ipcwan<br>&nbsp;Gateway : $gwcwan";
		}
	}

	my ($wanapnamel, $wanapmsg) = ("", "");
	for my $wapidx (0 .. $#wanapnames) {
		$wanapnamel .= "<option value=\"".$wanapnames[$wapidx]."\" ".(($wanapnames[$wapidx] eq $wanapname)?" selected=\"selected\"":"").">".$wanapnames[$wapidx]."</option>";
		$wanapmsg = "";
	}

	my @approtocols = ("WPA2", "WPA");
	my $approtocoll = "";
	for my $appridx (0 .. $#approtocols) {
		$approtocoll .= "<option value=\"$appridx\" ".(($appridx == $approtocol)?" selected=\"selected\"":"").">".$approtocols[$appridx]."</option>";
	}

	my $apchannell = "";
	for my $apchan (1 .. 14) {
		$apchannell .= "<option value=\"$apchan\" ".(($apchan == $apchannel)?" selected=\"selected\"":"").">".(($apchan == 0)?"Auto":$apchan)."</option>";
	}

	my %timeservers = ("165.193.126.229", "nist1-nj2.ustiming.org (Weehawken, NJ)", "216.171.112.36", "nist1-ny2.ustiming.org (New York City, NY)", "206.246.122.250", "nist1-pa.ustiming.org (Hatfield, PA)", "129.6.15.30", "time-c.nist.gov (NIST, Gaithersburg, Maryland)", "98.175.203.200", "nist1-macon.macon.ga.us (Macon, Georgia)", "207.223.123.18", "wolfnisttime.com (Birmingham, Alabama)", "216.171.120.36", "nist1-chi.ustiming.org (Chicago, Illinois)", "96.226.242.9", "nist.time.nosc.us (Carrollton, Texas)", "50.245.103.198", "nist.expertsmi.com (Monroe, Michigan)", "64.113.32.5", "nist.netservicesgroup.com (Southfield, Michigan)", "66.219.116.140", "nisttime.carsoncity.k12.mi.us (Carson City, Michigan)", "216.229.0.179", "nist1-lnk.binary.net (Lincoln, Nebraska)", "24.56.178.140", "wwv.nist.gov (WWV, Fort Collins, Colorado)", "132.163.4.102", "time-b.timefreq.bldrdoc.gov (NIST, Boulder, Colorado)", "128.138.140.44", "utcnist.colorado.edu (University of Colorado, Boulder)", "128.138.141.172", "utcnist2.colorado.edu (University of Colorado, Boulder)", "198.60.73.8", "ntp-nist.ldsbc.edu (LDSBC, Salt Lake City, Utah)", "64.250.229.100", "nist1-lv.ustiming.org (Las Vegas, Nevada)", "216.228.192.69", "nist-time-server.eoni.com (La Grande, Oregon)", "69.25.96.13", "nist1.symmetricom.com (San Jose, California)");
	my $timesrv1l = "";
	my $timesrv2l = "";
	foreach my $timesrvip (sort keys %timeservers) {
		$timesrv1l .= "<option value=\"$timesrvip\"".(($timesrvip eq $timesrv1)?" selected=\"selected\"":"").">".$timeservers{$timesrvip}."</option>";
		$timesrv2l .= "<option value=\"$timesrvip\"".(($timesrvip eq $timesrv2)?" selected=\"selected\"":"").">".$timeservers{$timesrvip}."</option>";
	}
	
	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--lan_dhcp1--/$ldhcp[1]/g;
		$inline =~ s/--lan_dhcp0--/$ldhcp[0]/g;
		$inline =~ s/--dns10--/$dns1[0]/g;
		$inline =~ s/--dns11--/$dns1[1]/g;
		$inline =~ s/--dns12--/$dns1[2]/g;
		$inline =~ s/--dns13--/$dns1[3]/g;
		$inline =~ s/--dns20--/$dns2[0]/g;
		$inline =~ s/--dns21--/$dns2[1]/g;
		$inline =~ s/--dns22--/$dns2[2]/g;
		$inline =~ s/--dns23--/$dns2[3]/g;
		$inline =~ s/--lan_netmask0--/$lanmask[0]/g;
		$inline =~ s/--lan_netmask1--/$lanmask[1]/g;
		$inline =~ s/--lan_netmask2--/$lanmask[2]/g;
		$inline =~ s/--lan_netmask3--/$lanmask[3]/g;
		$inline =~ s/--lan_ip0--/$lanip[0]/g;
		$inline =~ s/--lan_ip1--/$lanip[1]/g;
		$inline =~ s/--lan_ip2--/$lanip[2]/g;
		$inline =~ s/--lan_ip3--/$lanip[3]/g;
		$inline =~ s/--lan_gateway0--/$langw[0]/g;
		$inline =~ s/--lan_gateway1--/$langw[1]/g;
		$inline =~ s/--lan_gateway2--/$langw[2]/g;
		$inline =~ s/--lan_gateway3--/$langw[3]/g;
		$inline =~ s/--wan_ap_name--/$wanapnamel/g;
		$inline =~ s/--wan_ap_key--/$wanapkey/g;
		$inline =~ s/--wan_ap_msg--/$wanapmsg/g;
		$inline =~ s/--wan_ap_status--/$wapstatus/g;
		$inline =~ s/--ap_name--/$apname/g;
		$inline =~ s/--ap_channel--/$apchannell/g;
		$inline =~ s/--ap_protocol--/$approtocoll/g;
		$inline =~ s/--ap_security--/$apsecurity/g;
		$inline =~ s/--cell_modem--/$cellmodem/g;
		$inline =~ s/--cell_type--/$celltype/g;
		$inline =~ s/--timeserver1--/$timesrv1l/g;
		$inline =~ s/--timeserver2--/$timesrv2l/g;
		$inline =~ s/--cloud1--/$cloud1/g;
		$inline =~ s/--cloud2--/$cloud2/g;
		$inline =~ s/--netip_id--/$netipid/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# networks Zigbee menu

if (($uimode eq "networks") && ($uismode eq "zigbee") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my ($updmsg, $upd2msg) = ("", "");

	if ($action eq "create") {				# create new zb network
		$updmsg = "<tr><td colspan=2><br>Zigbee Network Creating... Please hold";
		$db->do("INSERT INTO commands (id, updated, command, parameters) VALUES (NULL, NOW(), 49, '1')");		# send command 0x31 to MD
		$updmsg .= "</td></tr>\n";
	}

	if ($action eq "reset") {				# reset zb network
		$updmsg = "<tr><td colspan=2><br>Zigbee Network Restarting... Please hold";
		$db->do("INSERT INTO commands (id, updated, command) VALUES (NULL, NOW(), 48)");				# send command 0x30 to MD
		$db->do("INSERT INTO commands (id, updated, command, parameters) VALUES (NULL, NOW(), 49, '1')");		# send command 0x31 to MD
		$updmsg .= "</td></tr>\n";
	}

	if (($action eq "save") && (exists $FORM{netzb_id})) {
		my $chansnew = 0;
		my $zchasn = 2048;		# chan 11 = 0x800 bitmask
		for my $zchan (11 .. 26) {
			if (exists $FORM{"chan".$zchan}) {
				$chansnew += $zchasn;
			}
			$zchasn += $zchasn;
		}
		my $netzbid = $FORM{netzb_id};
		my $panidsel = $FORM{panid_sel} + 0;
		if ($panidsel == 0) {
			dbdo("UPDATE zigbee SET panid='".$FORM{panid}."' WHERE id = $netzbid", 0);
		}
		dbdo("UPDATE zigbee SET panid_sel=".$panidsel.", encryption=".($FORM{encryption} + 0).", channel=".($chansnew + 0)." WHERE id = $netzbid", 0);
		if (exists $FORM{sec_key}) {
			dbdo("UPDATE zigbee SET sec_key='".$FORM{sec_key}."' WHERE id = $netzbid", 0);
		}
	}

	my ($zchannell, $zchannel, $zchansel) = ("", 0, 0);
	my @lzpanidsel = ("", "");
	my ($zpanidsel, $zpanid, $zpanidro, $zencryption) = (0, "", "", 0);
	my @lzencryption = ("", "");
        my ($zaddr64, $zaddr16, $zseckey, $zmfcid, $zhwversion, $zswversion) = ("N/A", "N/A", "N/A", "N/A", "N/A", "N/A");
        my $znetzbid = 0;
	my $all = $db->selectall_arrayref("SELECT addr64, addr16, sec_key, mfc_id, hw_version, sw_version, channel, panid_sel, panid, encryption, id FROM zigbee ORDER BY id DESC LIMIT 1");
	foreach my $row (@$all) {
		$zaddr64 = (@$row[0] ne "")?(uc(@$row[0])):"N/A";
		$zaddr16 = (@$row[1] ne "")?(uc(@$row[1])):"N/A";
		$zseckey = (@$row[2] ne "")?(@$row[2]):"";
		$zmfcid = (@$row[3] ne "")?(uc(@$row[3])):"N/A";
		$zhwversion = (@$row[4] ne "")?(@$row[4]):"N/A";
		$zswversion = (@$row[5] ne "")?(@$row[5]):"N/A";
		$zchannel = @$row[6] + 0;
		$zpanidsel = @$row[7] + 0;
		$zpanid = @$row[8];
		$zencryption = @$row[9] + 0;
		$znetzbid = @$row[10] + 0;
	}
	undef $all;

	my $zchasn = 2048;		# chan 11 = 0x800 bitmask
	for my $zchan (11 .. 26) {
		if ($zchan == 11) {
			$zchannell .= "<tr bgcolor=#F0F0F0>";
		} elsif ($zchan == 19) {
			$zchannell .= "</tr><tr bgcolor=#F0F0F0>";
		}
		$zchannell .= "<td nowrap=\"nowrap\"><b><input id=\"chan".$zchan."\" name=\"chan".$zchan."\" type=\"checkbox\" ".(($zchannel & $zchasn)?"checked=\"checked\"":"")."> $zchan &nbsp;</td>";
		$zchasn += $zchasn;
	}
	$zchannell .= "</tr>";
	$headadd .= <<EOF;
	<script language="JavaScript">
		function checkAll() {
			var checkboxes = document.getElementsByTagName('input');
			for (var i = 0; i < checkboxes.length; i++) {
				if (checkboxes[i].type == 'checkbox') {
					checkboxes[i].checked = true;
				}
			}
		}
		function uncheckAll() {
			var checkboxes = document.getElementsByTagName('input');
			for (var i = 0; i < checkboxes.length; i++) {
				if (checkboxes[i].type == 'checkbox') {
					checkboxes[i].checked = false;
				}
			}
		}
		function AreYouSure(command, prompt) {
			var ays = confirm(prompt);
			if (ays == true) {
				window.location.href='./engine.pl?mode=$uimode&submode=$uismode&action='+command;
			}
			return false;
		}
	</script>
EOF

	$lzpanidsel[$zpanidsel] = "checked=\"checked\"";
	$lzencryption[$zencryption] = "checked=\"checked\"";
	$zpanidro = ($zpanidsel == 1)?" disabled=\"disabled\"":"";
	
	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--panid_sel1--/$lzpanidsel[1]/g;
		$inline =~ s/--panid_sel0--/$lzpanidsel[0]/g;
		$inline =~ s/--encryption1--/$lzencryption[1]/g;
		$inline =~ s/--encryption0--/$lzencryption[0]/g;
		$inline =~ s/--panidro--/$zpanidro/g;
		$inline =~ s/--panid--/$zpanid/g;
		$inline =~ s/--channel--/$zchannell/g;
		$inline =~ s/--addr64--/$zaddr64/g;
		$inline =~ s/--addr16--/$zaddr16/g;
		$inline =~ s/--sec_key--/$zseckey/g;
		$inline =~ s/--mfc_id--/$zmfcid/g;
		$inline =~ s/--hw_version--/$zhwversion/g;
		$inline =~ s/--sw_version--/$zswversion/g;
		$inline =~ s/--updmessage--/$updmsg/g;
		$inline =~ s/--upd2message--/$upd2msg/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--netzb_id--/$znetzbid/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# networks ASEMP profiles

if (($uimode eq "networks") && ($uismode eq "asemp") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my $profid = $FORM{profile_id} + 0;
	my $aseprefix = "ASP";

	if (($action eq "remove") && ($profid > 0)) {
		dbdo("DELETE FROM asemp WHERE profile_id = $profid", 0);
		$profid = 0;
	}

	if (($action eq "save") && ($profid > 0)) {
		$db->{'AutoCommit'} = 0;
		foreach my $formkey (sort keys %FORM) {
			if ($formkey =~ m/^ASP(.*)/) {
				my $pname = $1;
				my $vname = $FORM{$formkey};
				dbdo("DELETE FROM asemp WHERE profile_id = $profid AND parameter = '$pname'", 0);
				dbdo("INSERT INTO asemp VALUES (NULL, $profid, '$pname', '$vname', '$vname', '$pname', 0, '')", 0);
			}
		}
		dbdo("DELETE FROM asemp WHERE profile_id = $profid AND parameter = 'name'", 0);
		dbdo("INSERT INTO asemp VALUES (NULL, $profid, 'name', '0', '0', 'User Defined ASEMP Profile $profid', 2, '')", 0);
		$db->commit();
		$db->{'AutoCommit'} = 1;
	}

	my $profile = "";
	my $proflist = "";
	my $profdel = "";
	my $pridmax = 0;
	my %pvalues = ();
	my $all = $db->selectall_arrayref("SELECT profile_id, parameter, value, default_, type_, units, description FROM asemp WHERE profile_id = $profid OR profile_id = 0 OR type_ = 2 ORDER BY profile_id DESC, id");
	foreach my $row (@$all) {
		my ($prid, $param, $value, $vdef, $vtype, $units, $desc) = @$row;
		if ($prid == $profid) {
			$pvalues{$param} = $value;			# store user defined profile values
		}
		if (($prid == 0) && ($vtype < 2)) {
			$profile .= "<tr><td width=250>".$desc.":</td><td align=left>";
			$value = (exists $pvalues{$param})?$pvalues{$param}:$value;
			if ($vtype == 0) {
				$profile .= "<input id=\"$aseprefix$param\" name=\"$aseprefix$param\" value=\"1\" ".(($value == 1)?"checked=\"checked\"":"")." type=\"radio\" ".(($profid == 0)?"disabled":"")."><b>Yes</b><input id=\"$aseprefix$param\" name=\"$aseprefix$param\" value=\"0\" ".(($value == 0)?"checked=\"checked\"":"")." type=\"radio\" ".(($profid == 0)?"disabled":"")."><b>No</b>";
			} elsif ($vtype == 1) {
				$profile .= "<input name=\"$aseprefix$param\" size=\"3\" maxlength=\"10\" value=\"".(($value eq "")?$vdef:$value)."\" type=\"text\" ".(($profid == 0)?"disabled":"")."> $units";
			}
			$profile .= "</td></tr>\n";
		}
		if ($vtype == 2) {
			$proflist .= "<option value=\"$prid\" ".(($profid == $prid)?"selected=\"selected\"":"").">$desc</option>";
		}
		$pridmax = ($pridmax > $prid)?$pridmax:$prid;
	}
	undef $all;
	$pridmax++;
	$proflist .= "<option value=\"$pridmax\" ".(($profid == $pridmax)?"selected=\"selected\"":"").">New ASEMP Profile</option>";
	if (($profid > 0) && ($profid < $pridmax)) {
		$profdel = "&nbsp;&nbsp;&nbsp;<input name=\"profdel\" value=\"Delete Profile\" onClick=\"window.location.href='./engine.pl?mode=$uimode&submode=$uismode&profile_id=$profid&action=remove'\" type=\"button\">";
	}

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--profile--/$profile/g;
		$inline =~ s/--proflist--/$proflist/g;
		$inline =~ s/--profdel--/$profdel/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# sms and email alarms

if (($uimode eq "userinfo") && ($uismode eq "alarms") && ($uaccess >= $alevel{$uimode.$uismode})) {
	if ($action eq "testemail") {
		dbdo("INSERT INTO alarms_system VALUES (NULL, NOW(), 3, 0, 'Test notification')", 0);
	}

	if ($action eq "save") {
		my $newalemail = (exists $FORM{alarms_email})?1:0;
		my $newalsms = (exists $FORM{alarms_sms})?1:0;
		if ($HVAC{"system.notifications_email"} != $newalemail) {
			$HVAC{"system.notifications_email"} = $newalemail;
			dbdo("UPDATE hvac SET value_ = $newalemail WHERE option_ = 'system.notifications_email';", 0);
		}
		if ($HVAC{"system.notifications_sms"} != $newalsms) {
			$HVAC{"system.notifications_sms"} = $newalsms;
			dbdo("UPDATE hvac SET value_ = $newalsms WHERE option_ = 'system.notifications_sms';", 0);
		}
		if ($FORM{en} =~ m/^\w[\w\.\-]*\w\@\w[\w\.\-]*\w(\.\w{2,4})$/) {						# add new email
			my $sever = ((exists $FORM{"gen"})?1:0) + ((exists $FORM{"yen"})?2:0) + ((exists $FORM{"ren"})?4:0);
			dbdo("INSERT INTO notifications VALUES (NULL, '".$FORM{en}."', '', $sever)", 0);
		}
		if ((length($FORM{sn}) > 6) && ($FORM{sn} =~ m/^\d+$/)) {							# add new sms
			my $sever = ((exists $FORM{"gsn"})?1:0) + ((exists $FORM{"ysn"})?2:0) + ((exists $FORM{"rsn"})?4:0);
			dbdo("INSERT INTO notifications VALUES (NULL, '', '".$FORM{sn}."', $sever)", 0);
		}
	}

	if ($action eq "remove") {
		my $remid = $FORM{id} + 0;
		dbdo("DELETE FROM notifications WHERE id = $remid", 0);
	}

	my $lemail = "";
	my $lsms = "";
	my $all = $db->selectall_arrayref("SELECT id, email, phone, severity FROM notifications ORDER BY id");
	foreach my $row (@$all) {
		my ($noid, $email, $phone, $sever) = @$row;
		if ((length($email)) && (defined($email))) {
			if (exists $FORM{"e".$noid}) {
				if ($FORM{"e".$noid} ne $email) {
					if ($FORM{"e".$noid} =~ m/^\w[\w\.\-]*\w\@\w[\w\.\-]*\w(\.\w{2,4})$/) {		# really email?
						$email = $FORM{"e".$noid};
						dbdo("UPDATE notifications SET email='$email' WHERE id=$noid", 0);
					}
				}
				my $nsever = ((exists $FORM{"ge".$noid})?1:0) + ((exists $FORM{"ye".$noid})?2:0) + ((exists $FORM{"re".$noid})?4:0);
				if ($nsever != $sever) {
					$sever = $nsever;
					dbdo("UPDATE notifications SET severity='$sever' WHERE id=$noid", 0);
				}
			}
			$lemail .= "<tr style=\"height:30px\" align=\"center\">
						<td nowrap=\"nowrap\">
							<input name=\"e".$noid."\" size=\"30\" maxlength=\"90\" value=\"$email\" type=\"text\">
						</td>
						<td nowrap=\"nowrap\">
							<input name=\"re".$noid."\" type=\"checkbox\" ".((($sever & 4) == 0)?"/":"checked").">
						</td>
						<td nowrap=\"nowrap\">
							<input name=\"ye".$noid."\" type=\"checkbox\" ".((($sever & 2) == 0)?"/":"checked").">
						</td>
						<td nowrap=\"nowrap\">
							<input name=\"ge".$noid."\" type=\"checkbox\" ".((($sever & 1) == 0)?"/":"checked").">
						</td>
						<td nowrap=\"nowrap\"  class=\"noborder\">
							<input name=\"Deletee\"".$noid." value=\"Delete\" onClick=\"window.location.href='./engine.pl?mode=--mode--&submode=--submode--&action=remove&id=$noid';\" type=\"button\">
						</td>
					</tr>";
		}
		if ((length($phone)) && (defined($phone))) {
			if (exists $FORM{"s".$noid}) {
				if ($FORM{"s".$noid} ne $phone) {
					if ((length($FORM{"s".$noid}) > 6) && ($FORM{"s".$noid} =~ m/^\d+$/)) {			# really phone?
						$phone = $FORM{"s".$noid};
						dbdo("UPDATE notifications SET phone='$phone' WHERE id=$noid", 0);
					}
				}
				my $nsever = ((exists $FORM{"gs".$noid})?1:0) + ((exists $FORM{"ys".$noid})?2:0) + ((exists $FORM{"rs".$noid})?4:0);
				if ($nsever != $sever) {
					$sever = $nsever;
					dbdo("UPDATE notifications SET severity='$sever' WHERE id=$noid", 0);
				}
			}
			$lsms .= "<tr style=\"height:30px\" align=\"center\">
						<td nowrap=\"nowrap\">
							<input name=\"s".$noid."\" size=\"30\" maxlength=\"90\" value=\"$phone\" type=\"text\">
						</td>
						<td nowrap=\"nowrap\">
							<input name=\"rs".$noid."\" type=\"checkbox\" ".((($sever & 4) == 0)?"/":"checked").">
						</td>
						<td nowrap=\"nowrap\">
							<input name=\"ys".$noid."\" type=\"checkbox\" ".((($sever & 2) == 0)?"/":"checked").">
						</td>
						<td nowrap=\"nowrap\">
							<input name=\"gs".$noid."\" type=\"checkbox\" ".((($sever & 1) == 0)?"/":"checked").">
						</td>
						<td nowrap=\"nowrap\"  class=\"noborder\">
							<input name=\"Deletes\"".$noid." value=\"Delete\" onClick=\"window.location.href='./engine.pl?mode=--mode--&submode=--submode--&action=remove&id=$noid';\" type=\"button\">
						</td>
					</tr>";
		}
	}
	undef $all;
	
	my $alemail = ($HVAC{"system.notifications_email"} == 1)?" checked":"";
	my $alsms = ($HVAC{"system.notifications_sms"} == 1)?" checked":"";
	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--alarms_email--/$alemail/g;
		$inline =~ s/--alarms_sms--/$alsms/g;
		$inline =~ s/--emails--/$lemail/g;
		$inline =~ s/--smss--/$lsms/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# access password

if (($uimode eq "userinfo") && ($uismode eq "password") && ($uaccess >= $alevel{$uimode.$uismode})) {
        if ($action eq "save") {
		my $oldpass = "TH1SiSMAS4eRPaSS";
		{
       			my $all = $db->selectall_arrayref("SELECT password FROM users WHERE login='$ulogin' LIMIT 1");
			foreach my $row (@$all) {
				($oldpass) = @$row;
			}
			undef $all;
		}
        	my $msgtxt = "Nothing was changed";
        	if ($FORM{username} ne $ulogin) {
        		if ($FORM{username} =~ m/^[a-zA-Z0-9_]*$/) {
        			if (length($FORM{username}) < 6) {
        				$msgtxt = "<font color=red>Username too short!";
        			} else {
					if ($FORM{password_old} ne $oldpass) {
						$msgtxt = "<font color=red>Current password does not match!";
					} else {
						dbdo("UPDATE users SET login='".$FORM{username}."' WHERE login='$ulogin' AND password='".$FORM{password_old}."'", 0);
						$msgtxt = "Username changed successfully";
						$ulogin = $FORM{username};
					}
        			}
        		} else {
        			$msgtxt = "<font color=red>Username contains wrong characters!";
        		}
        	}
        	if (length($FORM{password_new}) > 0) {
        		if ($FORM{password_old} ne $oldpass) {
				$msgtxt = "<font color=red>Current password does not match!";
			} else {
				dbdo("UPDATE users SET password='".$FORM{password_new}."' WHERE login='$ulogin' AND password='".$FORM{password_old}."'", 0);
				$msgtxt = "Password changed successfully";
			}
        	}
        	$message = "<tr><td nowrap=\"nowrap\" width=\"138\">&nbsp;</td><td nowrap=\"nowrap\"><br>$msgtxt</td></tr>\n";
        }
	
	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--username--/$ulogin/g;
		$inline =~ s/--message--/$message/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# smart controller local devices

if (($uimode eq "zonedev") && ($uismode eq "smartdevices") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my ($addr, $maker, $model, $desc) = ("", "", "", "");
	my @relays = ("None", "1", "2", "3", "4", "5", "6");
	my @adcaddr = ("0", "1", "2", "3", "4");
	my @ifaces = ("ADC", "I2C", "1-wire", "IP", "Zigbee", "Relay");
	my @alarms = ("Disabled", "Enabled");
	my @status = ("Disabled", "Enabled");
	my @severs = ("Green", "Yellow", "Red");
	my %types = ("0", "Onboard CO2 sensor", "1", "Onboard CO sensor", "2", "Onboard Temperature sensor", "3", "Onboard Humidity sensor", "4", "Generic Temperature sensor", "5", "Generic Humidity sensor", "6", "Generic Velocity sensor", "7", "Generic Illumination sensor", "8", "Generic Pressure sensor", "80", "Flood sensor", "81", "Hot water tank on/off control", "82", "Damper control");
	my ($devlist, $devdel, $ltype, $liface, $lrelay, $lsever, $lalarm, $reldis, $lstatus, $lperiod, $ladcaddr, $descdis, $descdib) = ("", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
	my $devid = (exists $FORM{"device_id"})?($FORM{"device_id"} + 0):-1;
	my ($drelay, $diface, $dalarm, $dsever, $dtype, $dspeed, $dstatus, $dperiod, $dlowthres, $dhighthres) = (0, 0, 0, 0, 0, 0, 0, 40, 0, 0);	# default values
	my ($updmsg) = ("");
	my %hiders = ("addr", "1", "relay", "1", "interface", "1", "period", "1", "thresholds", "1", "speed", "1", "adcaddr", "1");

	if (($action eq "remove") && ($devid > 0)) {
		dbdo("DELETE FROM smartdevices WHERE id = $devid", 0);
		$devid = -1;
	}

	if ($action eq "scan1wire") {
		$db->do("INSERT INTO commands (id, updated, command) VALUES (NULL, NOW(), 38)");
		$updmsg = "<tr><td colspan=2><br>1-Wire bus scan started. Devices list will be updated in several seconds</td></tr>\n";
	}

	if (($action eq "reloadd") || ($action eq "reloadi")) {
		if ($devid > 0) {
			$action = "save";
		} else {
			$dtype = $FORM{type} + 0;
			$diface = $FORM{interface} + 0;
			$drelay = $FORM{relay} + 0;
			$dalarm = $FORM{alarm} + 0;
			$dstatus = $FORM{status} + 0;
			$dsever = $FORM{severity} + 0;
			$dspeed = $FORM{speed} + 0;
			$dlowthres = $FORM{lowthres} + 0;
			$dhighthres = $FORM{highthres} + 0;
			$dperiod = $FORM{period} + 0;
			$addr = $FORM{address}."";
			$maker = $FORM{maker}."";
			$model = $FORM{model}."";
			$desc = $FORM{description}."";
		}
	}

	if ($action eq "save") {
		my $ntype = $FORM{type} + 0;
		my $niface = $FORM{interface} + 0;
		my $naddr = $FORM{address}."";
		my $nrelay = $FORM{relay} + 0;
		my $nalarm = $FORM{alarm} + 0;
		my $nstatus = $FORM{status} + 0;
		my $nsever = $FORM{severity} + 0;
		my $nspeed = $FORM{speed} + 0;
		my $nlowthres = $FORM{lowthres} + 0;
		my $nhighthres = $FORM{highthres} + 0;
		my $nperiod = $FORM{period} + 0;
		my $nmaker = $FORM{maker}."";
		my $nmodel = $FORM{model}."";
		my $ndesc = $FORM{description}."";
		if ($devid > 0) {
			if ($devid > 6) {
				dbdo("UPDATE smartdevices SET updated = NOW(), speed = $nspeed, lowthres = $nlowthres, highthres = $nhighthres, type_ = $ntype, interface = $niface, address = '$naddr', relay = $nrelay, alarm = $nalarm, period = $nperiod, status = $nstatus, severity = $nsever, maker = '$nmaker', model = '$nmodel', description = '$ndesc' WHERE id = $devid", 0);
			} else {
				dbdo("UPDATE smartdevices SET updated = NOW(), speed = $nspeed, lowthres = $nlowthres, highthres = $nhighthres, relay = $nrelay, alarm = $nalarm, period = $nperiod, status = $nstatus, severity = $nsever WHERE id = $devid", 0);
			}
		} else {
			dbdo("INSERT INTO smartdevices VALUES (NULL, NOW(), $ntype, $niface, $nstatus, $nperiod, $nlowthres, $nhighthres, '$naddr', $nrelay, $nspeed, $nalarm, $nsever, '$nmaker', '$nmodel', '$ndesc')", 0);
			$sth = $db->prepare("SELECT MAX(id) FROM smartdevices");
			$sth->execute;
			($devid) = $sth->fetchrow_array();
			$sth->finish;
		}
	}

	my %urelay = ();
	{
		$devlist = "<option value=\"-1\" ".(($devid == -1)?"selected=\"selected\"":"").">Define New Device</option>";
		my $all = $db->selectall_arrayref("SELECT id, description, relay, interface FROM smartdevices ORDER BY id");
		foreach my $row (@$all) {
			$devlist .= "<option value=\"".@$row[0]."\" ".(($devid == @$row[0])?"selected=\"selected\"":"").">ID.".@$row[0].": ".$ifaces[@$row[3]].((@$row[1] ne "")?": ".@$row[1]:"")."</option>";
			if ((@$row[2] > 0) && (@$row[3] == 5)) {			# this relay is used already
				$urelay{@$row[2]} = 1;
			}
		}
		undef $all;
	}

	if ($devid > 0) {
		my $all = $db->selectall_arrayref("SELECT type_, interface, address, relay, alarm, severity, maker, model, description, speed, status, period, lowthres, highthres FROM smartdevices WHERE id = $devid");
		foreach my $row (@$all) {
			($dtype, $diface, $addr, $drelay, $dalarm, $dsever, $maker, $model, $desc, $dspeed, $dstatus, $dperiod, $dlowthres, $dhighthres) = (@$row[0], @$row[1], @$row[2], @$row[3], @$row[4], @$row[5], @$row[6], @$row[7], @$row[8], @$row[9], @$row[10], @$row[11], @$row[12], @$row[13]);
		}
		undef $all;
		if ($devid > 6) {
			$devdel = "<input name=\"devdel\" value=\"Delete Device\" onClick=\"window.location.href='./engine.pl?mode=$uimode&submode=$uismode&device_id=$devid&action=remove'\" type=\"button\"><br>&nbsp;&nbsp;&nbsp;";
		} else {
			$descdis = " disabled=\"disabled\"";
			$descdib = " disabled=\"disabled\"";
		}
		unless ($diface == 5) {
			$reldis = "disabled=\"disabled\"";
		}
	} else {
		$devdel = "<input name=\"devdel\" value=\"Scan 1-wire Devices\" onClick=\"window.location.href='./engine.pl?mode=$uimode&submode=$uismode&device_id=$devid&action=scan1wire'\" type=\"button\"><bR>&nbsp;&nbsp;&nbsp;";
	}
	for my $idx (0 .. $#relays) {
		if ((!exists $urelay{$idx}) || ($idx == $drelay)) {
			$lrelay .= "<option value=\"$idx\" ".(($idx == $drelay)?" selected=\"selected\"":"").">".$relays[$idx]."</option>";
		}
	}
	for my $idx (0 .. $#ifaces) {
		$liface .= "<option value=\"$idx\" ".(($idx == $diface)?" selected=\"selected\"":"").">".$ifaces[$idx]."</option>";
	}
	for my $idx (0 .. $#status) {
		$lstatus .= "<option value=\"$idx\" ".(($idx == $dstatus)?" selected=\"selected\"":"").">".$status[$idx]."</option>";
	}
	foreach my $idx (sort keys %types) {
		$ltype .= "<option value=\"$idx\" ".(($idx == $dtype)?" selected=\"selected\"":"").">".$types{$idx}."</option>";
	}
	for my $idx (0 .. $#alarms) {
		$lalarm .= "<option value=\"$idx\" ".(($idx == $dalarm)?" selected=\"selected\"":"").">".$alarms[$idx]."</option>";
	}
	for my $idx (0 .. $#severs) {
		$lsever .= "<option value=\"$idx\" ".(($idx == $dsever)?" selected=\"selected\"":"").">".$severs[$idx]."</option>";
	}
	for my $idx (1 .. $#adcaddr) {
		$ladcaddr .= "<option value=\"$idx\" ".(($idx == $addr)?" selected=\"selected\"":"").">".$adcaddr[$idx]."</option>";
	}
	$lperiod .= "<option value=\"0\" ".(($dperiod == 0)?" selected=\"selected\"":"").">OFF</option>";
	for (my $idx = 30; $idx <= 180; $idx += 10) {
		$lperiod .= "<option value=\"$idx\" ".(($idx == $dperiod)?" selected=\"selected\"":"").">$idx</option>";
	}

	if (($diface == 0) || ($diface == 5)) {		# hide address for ADC and Relay
		$hiders{"addr"} = 0;
	}
	if ($dtype == 1) {				# ..except CO sensor
		$hiders{"cocorr"} = 1;
		$descdib = "";
	}
	unless (($diface == 1) || ($diface == 2)) {	# speed for 1-wire and i2c
		$hiders{"speed"} = 0;
	}
	unless ($diface == 5) {
		$hiders{"relay"} = 0;
	}
	unless ($diface == 0) {
		$hiders{"adcaddr"} = 0;
	}
#	if (($dtype == 0) || ($dtype == 1) || ($dtype == 2) || ($dtype == 3)) {
#		$hiders{"interface"} = 0;
#	}
	unless (($dtype == 0) || ($dtype == 1) || ($dtype == 2) || ($dtype == 3) || ($dtype == 4) || ($dtype == 5) || ($dtype == 6) || ($dtype == 7) || ($dtype == 8) || ($dtype == 80)) {
		$hiders{"period"} = 0;
	}
	unless (($dtype == 0) || ($dtype == 1) || ($dtype == 2) || ($dtype == 3) || ($dtype == 4) || ($dtype == 5) || ($dtype == 6) || ($dtype == 7) || ($dtype == 8) || ($dtype == 80) || ($diface == 0)) {
		$hiders{"thresholds"} = 0;
	}


	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	my $hidenow = 0;
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--devlist--/$devlist/g;
		$inline =~ s/--devdel--/$devdel/g;
		$inline =~ s/--devid--/$devid/g;
		$inline =~ s/--type--/$ltype/g;
		$inline =~ s/--speed--/$dspeed/g;
		$inline =~ s/--descdis--/$descdis/g;
		$inline =~ s/--descdib--/$descdib/g;
		$inline =~ s/--lowthres--/$dlowthres/g;
		$inline =~ s/--highthres--/$dhighthres/g;
		$inline =~ s/--interface--/$liface/g;
		$inline =~ s/--relay--/$lrelay/g;
		$inline =~ s/--description--/$desc/g;
		$inline =~ s/--alarm--/$lalarm/g;
		$inline =~ s/--updmsg--/$updmsg/g;
		$inline =~ s/--status--/$lstatus/g;
		$inline =~ s/--period--/$lperiod/g;
		$inline =~ s/--relaydis--/$reldis/g;
		$inline =~ s/--severity--/$lsever/g;
		$inline =~ s/--address--/$addr/g;
		$inline =~ s/--adcaddr--/$ladcaddr/g;
		$inline =~ s/--maker--/$maker/g;
		$inline =~ s/--model--/$model/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		if ($inline =~ m/^\-\=([a-zA-Z0-9]*)\=\-/) {
			my $hidename = $1;
			if ($hidenow) {
				$hidenow = 0;
			} else {
				unless ($hiders{$hidename}) {
					$hidenow ++;
				}
			}
			$inline =~ s/^\-\=([a-zA-Z0-9]*)\=\-//;
		}
		unless ($hidenow) {
			$contents .= $inline."\n";
		}
	}
	close(INF);
}

# smart controller local devices

if (($uimode eq "zonedev") && ($uismode eq "sensorstest") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my ($froomt, $froomh, $ductco1, $ductco2, $sductt, $sducth, $rductt, $rducth, $htut, $airvel, $smartupd) = ("N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A");
	my $all = $db->selectall_arrayref("SELECT (SELECT froom_t FROM smartsensors WHERE froom_t IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT froom_h FROM smartsensors WHERE froom_h IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT co FROM smartsensors WHERE co IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT co2 FROM smartsensors WHERE co2 IS NOT NULL ORDER BY id DESC LIMIT 1),(SELECT t_supply_duct FROM smartsensors WHERE t_supply_duct IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT t_return_duct FROM smartsensors WHERE t_return_duct IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT h_supply_duct FROM smartsensors WHERE h_supply_duct IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT h_return_duct FROM smartsensors WHERE h_return_duct IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT htu FROM smartsensors WHERE htu IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT air_vel FROM smartsensors WHERE air_vel IS NOT NULL ORDER BY id DESC LIMIT 1), updated FROM smartsensors ORDER BY id DESC LIMIT 1");
	foreach my $row (@$all) {
		$froomt = ttproper(@$row[0]);
		$froomh = (@$row[1] ne "")?(@$row[1]."%"):"N/A";
		$ductco1 = (@$row[2] ne "")?(@$row[2]."ppm"):"N/A";
		$ductco2 = (@$row[3] ne "")?(@$row[3]."ppm"):"N/A";
		$sductt = ttproper(@$row[4]);
		$rductt = ttproper(@$row[5]);
		$sducth = (@$row[6] ne "")?(@$row[6]."%"):"N/A";
		$rducth = (@$row[7] ne "")?(@$row[7]."%"):"N/A";
		$htut = ttproper(@$row[8]);
		$airvel = (@$row[9] ne "")?(@$row[9]."fpm"):"N/A";
		$smartupd = @$row[10];
	}
	undef $all;

	$db->do("INSERT INTO commands (id, updated, command, type_, parameters) VALUES (NULL, NOW(), 117, 5, '0')");	# request CO2 sensor value
	$db->do("INSERT INTO commands (id, updated, command, type_, parameters) VALUES (NULL, NOW(), 117, 5, '1')");	# request CO sensor value
	$db->do("INSERT INTO commands (id, updated, command, type_, parameters) VALUES (NULL, NOW(), 117, 5, '2')");	# request HTU temperature
	$db->do("INSERT INTO commands (id, updated, command, type_, parameters) VALUES (NULL, NOW(), 117, 5, '3')");	# request HTU humidity

	my ($adc1raw, $adc2raw, $adc3raw, $adc4raw, $smartrawupd) = ("N/A", "N/A", "N/A", "N/A", "N/A");
	my $all = $db->selectall_arrayref("SELECT (SELECT value_ FROM smartsensorsraw WHERE source = 0 AND address = 1 AND value_ IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT value_ FROM smartsensorsraw WHERE source = 0 AND address = 2 AND value_ IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT value_ FROM smartsensorsraw WHERE source = 0 AND address = 3 AND value_ IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT value_ FROM smartsensorsraw WHERE source = 0 AND address = 4 AND value_ IS NOT NULL ORDER BY id DESC LIMIT 1), (SELECT updated FROM smartsensorsraw ORDER BY id DESC LIMIT 1)");
	foreach my $row (@$all) {
		$adc1raw = (@$row[0] ne "")?@$row[0]:"N/A";
		$adc2raw = (@$row[1] ne "")?@$row[1]:"N/A";
		$adc3raw = (@$row[2] ne "")?@$row[2]:"N/A";
		$adc4raw = (@$row[3] ne "")?@$row[3]:"N/A";
		$smartrawupd = @$row[4];
	}
	undef $all;

	$db->do("INSERT INTO commands (id, updated, command, type_, parameters) VALUES (NULL, NOW(), 117, 5, '5 1')");	# request ACD1 raw value
	$db->do("INSERT INTO commands (id, updated, command, type_, parameters) VALUES (NULL, NOW(), 117, 5, '5 2')");	# request ACD2 raw value
	$db->do("INSERT INTO commands (id, updated, command, type_, parameters) VALUES (NULL, NOW(), 117, 5, '5 3')");	# request ACD3 raw value
	$db->do("INSERT INTO commands (id, updated, command, type_, parameters) VALUES (NULL, NOW(), 117, 5, '5 4')");	# request ACD4 raw value

	my $senslist = "";
	my @ifaces = ("ADC", "I2C", "1-wire", "IP", "Zigbee", "Relay");
	my @status = ("Inactive", "Active");
	my %types = ("0", "Onboard CO2 sensor", "1", "Onboard CO sensor", "2", "Onboard Temperature sensor", "3", "Onboard Humidity sensor", "4", "Generic Temperature sensor", "5", "Generic Humidity sensor", "6", "Generic Velocity sensor", "7", "Generic Illumination sensor", "8", "Generic Pressure sensor", "80", "Flood sensor", "81", "Hot water tank on/off control", "82", "Damper control");
	my $all = $db->selectall_arrayref("SELECT id, updated, type_, interface, status, address FROM smartdevices WHERE interface = 2");
	foreach my $row (@$all) {
		my $dupd = @$row[1];
		my $dtype = (exists $types{@$row[2]})?$types{@$row[2]}:"Unknown";
		my $diface = $ifaces[@$row[3]];
		my $driface = @$row[3];
		my $dstat = $status[@$row[4]];
		my $daddr = @$row[5];
		my $sth = $db->prepare("SELECT value_, updated FROM smartsensorsraw WHERE source = $driface AND address = '$daddr' AND value_ IS NOT NULL ORDER BY id DESC LIMIT 1");
		$sth->execute;
		my ($drvalue, $drupd) = $sth->fetchrow_array();
		$sth->finish;
		undef $sth;
		my $dvalue = "<b>".(($drvalue ne "")?$drvalue:"N/A")."</b>&nbsp;,&nbsp;".$dstat;
		$senslist .= "<tr><td nowrap=\"nowrap\">$dtype</td><td class=\"stdbold\" nowrap=\"nowrap\" width=160>$diface, $daddr</td><td nowrap=\"nowrap\">$dvalue</td></tr>\n";
		if ($daddr ne "") {
			$db->do("INSERT INTO commands (id, updated, command, type_, parameters) VALUES (NULL, NOW(), 117, 5, '4 $daddr')");	# request 1-wire value by address
		}
	}
	undef $all;

	my $rinterval = (exists $HVAC{"system.testrefresh"})?$HVAC{"system.testrefresh"}:40;
	if ($action eq "save") {
		$rinterval = $FORM{rinterval} + 0;
		$HVAC{"system.testrefresh"} = $rinterval;
		dbdo("UPDATE hvac SET value_ = '$rinterval' WHERE option_ = 'system.testrefresh';", 0);
	}
	if ($rinterval > 0) {
	$headadd .= <<EOF;
		<meta http-equiv="refresh" content="$rinterval;URL=./engine.pl?mode=$uimode&submode=$uismode">
EOF
	}

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--sensorslist--/$senslist/g;
		$inline =~ s/--rinterval--/$rinterval/g;
		$inline =~ s/--adc1--/$adc1raw/g;
		$inline =~ s/--adc2--/$adc2raw/g;
		$inline =~ s/--adc3--/$adc3raw/g;
		$inline =~ s/--adc4--/$adc4raw/g;
		$inline =~ s/--froom_t--/$froomt/g;
		$inline =~ s/--froom_h--/$froomh/g;
		$inline =~ s/--t_supply_duct--/$sductt/g;
		$inline =~ s/--h_supply_duct--/$sducth/g;
		$inline =~ s/--t_return_duct--/$rductt/g;
		$inline =~ s/--h_return_duct--/$rducth/g;
		$inline =~ s/--co--/$ductco1/g;
		$inline =~ s/--co2--/$ductco2/g;
		$inline =~ s/--htu--/$htut/g;
		$inline =~ s/--air_vel--/$airvel/g;
		$inline =~ s/--smart_upd--/$smartupd/g;
		$inline =~ s/--smartraw_upd--/$smartrawupd/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# smart controller zigbee HA test page

if (($uimode eq "zonedev") && ($uismode eq "cluster") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my $senslist = "";
	my %tdevtypes = ("6", "On/Off", "1794", "Smart Metering");
	my @tdevstat = ("Offline", "Online", "Removed");
	my @terrret = ("ASE_COMMAND_WAIT_TO_PROCESS", "ASE_COMMAND_PENDING", "ASE_COMMAND_OK", "ASE_COMMAND_FAILURE", "ASE_COMMAND_ERROR");
	my $zdevmsg = "";

	if ($action eq "command") {
		my $comhex = $FORM{command} + 0;
		my $comdid = $FORM{devid} + 0;
		my ($addr64a) = $db->selectrow_array("SELECT addr64 FROM zigbee_ha WHERE device_id = $comdid");
		if (($addr64a eq "") || ($addr64a eq "NULL")) {
			$zdevmsg = "Device not available";
		} else {
			$db->do("INSERT INTO zigbee_commands (id, device_id, command, updated) VALUES (NULL, $comdid, $comhex, NOW())");
			$zdevmsg = "Command 0x".sprintf("%04X", $comhex)." sent to device #".$comdid;
		}
	}

	my $all = $db->selectall_arrayref("SELECT devices.id, devices.device_type, zigbee_ha.device_status, zigbee_ha.cluster_id, zigbee_ha.addr64 FROM devices LEFT JOIN zigbee_ha ON zigbee_ha.device_id = devices.id WHERE devices.device_type = 80 GROUP BY devices.id ORDER BY devices.zone_id, devices.id");
	foreach my $row (@$all) {
		my ($devid, $dtype, $dzstats, $dztype, $dzaddr) = @$row;
		$senslist .= "<tr><td nowrap=\"nowrap\">$dzaddr</td>";
		$senslist .= "<td nowrap=\"nowrap\">0x".sprintf("%04X", $dztype)." (".$tdevtypes{$dztype}.")</td>";
		my ($rawval) = $db->selectrow_array("SELECT return_value FROM zigbee_commands WHERE device_id = $devid AND return_value IS NOT NULL ORDER BY id DESC LIMIT 1");
		$senslist .= "<td nowrap=\"nowrap\">".((($rawval eq "") || ($rawval eq "NULL"))?"N/A":$rawval)."</td>";
		$senslist .= "<td nowrap=\"nowrap\">".$tdevstat[$dzstats]."</td>";
		my $clcomm = "N/A";
		unless ($dzstats == 2) {
			if ($dztype == 6) {			# on/off device
				$clcomm = "<a href=\"./engine.pl?mode=$uimode&submode=$uismode&action=command&devid=$devid&command=6\" class=\"navi\">ON/OFF Action</a>";
			} elsif ($dztype == 1794) {		# metering device
				$clcomm = "<a href=\"./engine.pl?mode=$uimode&submode=$uismode&action=command&devid=$devid&command=1794\" class=\"navi\">Metering Action</a>";
			}
		}
		$senslist .= "<td nowrap=\"nowrap\">$clcomm</td></tr>\n";
	}
	undef $all;
	if ($zdevmsg ne "") {
		$senslist .= "<tr><td colspan=5><br>$zdevmsg</td></tr>\n";
	} else {
		my ($errval, $errcom) = $db->selectrow_array("SELECT return_code, command FROM zigbee_commands WHERE return_code IS NOT NULL ORDER BY id DESC LIMIT 1");
		unless (($errval eq "") || ($errval eq "NULL")) {
			$senslist .= "<tr><td colspan=5><br>Last command 0x".sprintf("%04X", $errcom)." return code 0x".sprintf("%02X", $errval)." (".$terrret[$errval].")</td></tr>\n";
		}
	}

	my $rinterval = (exists $HVAC{"system.testrefresh"})?$HVAC{"system.testrefresh"}:40;
	if ($action eq "save") {
		$rinterval = $FORM{rinterval} + 0;
		$HVAC{"system.testrefresh"} = $rinterval;
		dbdo("UPDATE hvac SET value_ = '$rinterval' WHERE option_ = 'system.testrefresh';", 0);
	}
	if ($rinterval > 0) {
	$headadd .= <<EOF;
		<meta http-equiv="refresh" content="$rinterval;URL=./engine.pl?mode=$uimode&submode=$uismode">
EOF
	}

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--senslist--/$senslist/g;
		$inline =~ s/--rinterval--/$rinterval/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# customer details

if (($uimode eq "userinfo") && ($uismode eq "details") && ($uaccess >= $alevel{$uimode.$uismode})) {

	my %provinces = ("NONE", "Not Canada or USA", "CAN-AL", "Alberta", "CAN-BC", "British Columbia", "CAN-MT", "Manitoba", "CAN-NB", "New Brunswick", "CAN-NS", "Nova Scotia", "CAN-ON", "Ontario", "CAN-QB", "Quebec", "CAN-SS", "Saskatchewan", "CAN-PE", "Prince Edward Island", "CAN-NL", "Newfoundland and Labrador", "USA-AL", "Alabama", "USA-AK", "Alaska", "USA-AZ", "Arizona", "USA-AR", "Arkansas", "USA-CA", "California", "USA-CO", "Colorado", "USA-CT", "Connecticut", "USA-DE", "Delaware", "USA-FL", "Florida", "USA-GA", "Georgia", "USA-HI", "Hawaii", "USA-ID", "Idaho", "USA-IL", "Illinois", "USA-IN", "Indiana", "USA-IA", "Iowa", "USA-KS", "Kansas", "USA-KY", "Kentucky", "USA-LA", "Louisiana", "USA-ME", "Maine", "USA-MD", "Maryland", "USA-MA", "Massachusetts", "USA-MI", "Michigan", "USA-MN", "Minnesota", "USA-MS", "Mississippi", "USA-MO", "Missouri", "USA-MT", "Montana", "USA-NE", "Nebraska", "USA-NV", "Nevada", "USA-NH", "New Hampshire", "USA-NJ", "New Jersey", "USA-NM", "New Mexico", "USA-NY", "New York", "USA-NC", "North Carolina", "USA-ND", "North Dakota", "USA-OH", "Ohio", "USA-OK", "Oklahoma", "USA-OR", "Oregon", "USA-PA", "Pennsylvania", "USA-RI", "Rhode Island", "USA-SC", "South Carolina", "USA-SD", "South Dakota", "USA-TN", "Tennessee", "USA-TX", "Texas", "USA-UT", "Utah", "USA-VT", "Vermont", "USA-VA", "Virginia", "USA-WA", "Washington", "USA-WV", "West Virginia", "USA-WI", "Wisconsin", "USA-WY", "Wyoming");
	my %countries = ("Afghanistan", "Afghanistan", "Aland Islands", "Aland Islands", "Albania", "Albania", "Algeria", "Algeria", "American Samoa", "American Samoa", "Andorra", "Andorra", "Angola", "Angola", "Anguilla", "Anguilla", "Antarctica", "Antarctica", "Antigua and Barbuda", "Antigua and Barbuda", "Argentina", "Argentina", "Armenia", "Armenia", "Aruba", "Aruba", "Australia", "Australia", "Austria", "Austria", "Azerbaijan", "Azerbaijan", "Bahamas", "Bahamas", "Bahrain", "Bahrain", "Bangladesh", "Bangladesh", "Barbados", "Barbados", "Belarus", "Belarus", "Belgium", "Belgium", "Belize", "Belize", "Benin", "Benin", "Bermuda", "Bermuda", "Bhutan", "Bhutan", "Bolivia", "Bolivia", "Bosnia and Herzegovina", "Bosnia and Herzegovina", "Botswana", "Botswana", "Bouvet Island", "Bouvet Island", "Brazil", "Brazil", "British Indian Ocean Territory", "British Indian Ocean Territory", "Brunei Darussalam", "Brunei Darussalam", "Bulgaria", "Bulgaria", "Burkina Faso", "Burkina Faso", "Burundi", "Burundi", "Cambodia", "Cambodia", "Cameroon", "Cameroon", "Canada", "Canada", "Cape Verde", "Cape Verde", "Cayman Islands", "Cayman Islands", "Central African Republic", "Central African Republic", "Chad", "Chad", "Chile", "Chile", "China", "China", "Christmas Island", "Christmas Island", "Cocos (Keeling) Islands", "Cocos (Keeling) Islands", "Colombia", "Colombia", "Comoros", "Comoros", "Congo", "Congo", "Cook Islands", "Cook Islands", "Costa Rica", "Costa Rica", "Cote D'ivoire", "Cote D'ivoire", "Croatia", "Croatia", "Cuba", "Cuba", "Cyprus", "Cyprus", "Czech Republic", "Czech Republic", "Denmark", "Denmark", "Djibouti", "Djibouti", "Dominica", "Dominica", "Dominican Republic", "Dominican Republic", "Ecuador", "Ecuador", "Egypt", "Egypt", "El Salvador", "El Salvador", "Equatorial Guinea", "Equatorial Guinea", "Eritrea", "Eritrea", "Estonia", "Estonia", "Ethiopia", "Ethiopia", "Falkland Islands", "Falkland Islands (Malvinas)", "Faroe Islands", "Faroe Islands", "Fiji", "Fiji", "Finland", "Finland", "France", "France", "French Guiana", "French Guiana", "French Polynesia", "French Polynesia", "French Southern Territories", "French Southern Territories", "Gabon", "Gabon", "Gambia", "Gambia", "Georgia", "Georgia", "Germany", "Germany", "Ghana", "Ghana", "Gibraltar", "Gibraltar", "Greece", "Greece", "Greenland", "Greenland", "Grenada", "Grenada", "Guadeloupe", "Guadeloupe", "Guam", "Guam", "Guatemala", "Guatemala", "Guernsey", "Guernsey", "Guinea", "Guinea", "Guinea-bissau", "Guinea-bissau", "Guyana", "Guyana", "Haiti", "Haiti", "Heard Island", "Heard Island and Mcdonald Islands", "Holy See", "Holy See (Vatican City State)", "Honduras", "Honduras", "Hong Kong", "Hong Kong", "Hungary", "Hungary", "Iceland", "Iceland", "India", "India", "Indonesia", "Indonesia", "Iran", "Iran, Islamic Republic of", "Iraq", "Iraq", "Ireland", "Ireland", "Isle of Man", "Isle of Man", "Israel", "Israel", "Italy", "Italy", "Jamaica", "Jamaica", "Japan", "Japan", "Jersey", "Jersey", "Jordan", "Jordan", "Kazakhstan", "Kazakhstan", "Kenya", "Kenya", "Kiribati", "Kiribati", "Korea Democratic People Republic", "Korea, Democratic People's Republic of", "Korea Republic", "Korea, Republic of", "Kuwait", "Kuwait", "Kyrgyzstan", "Kyrgyzstan", "Laos", "Lao People's Democratic Republic", "Latvia", "Latvia", "Lebanon", "Lebanon", "Lesotho", "Lesotho", "Liberia", "Liberia", "Libyan Arab Jamahiriya", "Libyan Arab Jamahiriya", "Liechtenstein", "Liechtenstein", "Lithuania", "Lithuania", "Luxembourg", "Luxembourg", "Macao", "Macao", "Macedonia", "Macedonia, The Former Yugoslav Republic of", "Madagascar", "Madagascar", "Malawi", "Malawi", "Malaysia", "Malaysia", "Maldives", "Maldives", "Mali", "Mali", "Malta", "Malta", "Marshall Islands", "Marshall Islands", "Martinique", "Martinique", "Mauritania", "Mauritania", "Mauritius", "Mauritius", "Mayotte", "Mayotte", "Mexico", "Mexico", "Micronesia", "Micronesia, Federated States of", "Moldova", "Moldova, Republic of", "Monaco", "Monaco", "Mongolia", "Mongolia", "Montenegro", "Montenegro", "Montserrat", "Montserrat", "Morocco", "Morocco", "Mozambique", "Mozambique", "Myanmar", "Myanmar", "Namibia", "Namibia", "Nauru", "Nauru", "Nepal", "Nepal", "Netherlands", "Netherlands", "Netherlands Antilles", "Netherlands Antilles", "New Caledonia", "New Caledonia", "New Zealand", "New Zealand", "Nicaragua", "Nicaragua", "Niger", "Niger", "Nigeria", "Nigeria", "Niue", "Niue", "Norfolk Island", "Norfolk Island", "Northern Mariana Islands", "Northern Mariana Islands", "Norway", "Norway", "Oman", "Oman", "Pakistan", "Pakistan", "Palau", "Palau", "Palestinian Territory", "Palestinian Territory, Occupied", "Panama", "Panama", "Papua New Guinea", "Papua New Guinea", "Paraguay", "Paraguay", "Peru", "Peru", "Philippines", "Philippines", "Pitcairn", "Pitcairn", "Poland", "Poland", "Portugal", "Portugal", "Puerto Rico", "Puerto Rico", "Qatar", "Qatar", "Reunion", "Reunion", "Romania", "Romania", "Russian Federation", "Russian Federation", "Rwanda", "Rwanda", "Saint Helena", "Saint Helena", "Saint Kitts and Nevis", "Saint Kitts and Nevis", "Saint Lucia", "Saint Lucia", "Saint Pierre and Miquelon", "Saint Pierre and Miquelon", "Saint Vincent and The Grenadines", "Saint Vincent and The Grenadines", "Samoa", "Samoa", "San Marino", "San Marino", "Sao Tome and Principe", "Sao Tome and Principe", "Saudi Arabia", "Saudi Arabia", "Senegal", "Senegal", "Serbia", "Serbia", "Seychelles", "Seychelles", "Sierra Leone", "Sierra Leone", "Singapore", "Singapore", "Slovakia", "Slovakia", "Slovenia", "Slovenia", "Solomon Islands", "Solomon Islands", "Somalia", "Somalia", "South Africa", "South Africa", "South Georgia", "South Georgia and The South Sandwich Islands", "Spain", "Spain", "Sri Lanka", "Sri Lanka", "Sudan", "Sudan", "Suriname", "Suriname", "Svalbard and Jan Mayen", "Svalbard and Jan Mayen", "Swaziland", "Swaziland", "Sweden", "Sweden", "Switzerland", "Switzerland", "Syrian Arab Republic", "Syrian Arab Republic", "Taiwan", "Taiwan, Province of China", "Tajikistan", "Tajikistan", "Tanzania", "Tanzania, United Republic of", "Thailand", "Thailand", "Timor-leste", "Timor-leste", "Togo", "Togo", "Tokelau", "Tokelau", "Tonga", "Tonga", "Trinidad and Tobago", "Trinidad and Tobago", "Tunisia", "Tunisia", "Turkey", "Turkey", "Turkmenistan", "Turkmenistan", "Turks and Caicos Islands", "Turks and Caicos Islands", "Tuvalu", "Tuvalu", "Uganda", "Uganda", "Ukraine", "Ukraine", "United Arab Emirates", "United Arab Emirates", "United Kingdom", "United Kingdom", "United States", "United States", "United States Minor Outlying Islands", "United States Minor Outlying Islands", "Uruguay", "Uruguay", "Uzbekistan", "Uzbekistan", "Vanuatu", "Vanuatu", "Venezuela", "Venezuela", "Viet Nam", "Viet Nam", "Virgin Islands, British", "Virgin Islands, British", "Virgin Islands, U.S.", "Virgin Islands, U.S.", "Wallis and Futuna", "Wallis and Futuna", "Western Sahara", "Western Sahara", "Yemen", "Yemen", "Zambia", "Zambia", "Zimbabwe", "Zimbabwe");
	my @timezones = ("(GMT-12:00) International Date Line West", "(GMT-11:00) Mixxxay Island, Samoa", "(GMT-10:00) Hawaii", "(GMT-09:00) Alaska", "(GMT-08:00) Pacific Time (USA &amp; Canada)", "(GMT-07:00) Arizona", "(GMT-07:00) Mountain Time (USA &amp; Canada)", "(GMT-06:00) Central America", "(GMT-06:00) Central Time (USA &amp; Canada)", "(GMT-06:00) Guadalajara, Mexico City, Monterrey", "(GMT-06:00) Saskatchewan", "(GMT-05:00) Bogota, Lima, Quito", "(GMT-05:00) Eastern Time (USA &amp; Canada)", "(GMT-05:00) Indiana (East)", "(GMT-04:00) Atlantic Time (Canada)", "(GMT-04:00) Caracas, La Paz", "(GMT-04:00) Santiago", "(GMT-03:30) Newfoundland", "(GMT-03:00) Brasilia", "(GMT-03:00) Buenos Aires, Georgetown", "(GMT-03:00) Greenland", "(GMT-02:00) Mid-Atlantic", "(GMT-01:00) Azores", "(GMT-01:00) Cape Verde ls.", "(GMT) Casablanca, Monrovia", "(GMT) Greenwich Mean Time: Dublin, Edinburgh, Lisbon, London", "(GMT+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna", "(GMT+01:00) Belgrade, Bratislava, Budapest, Ljubljana, Prague", "(GMT+01:00) Brussels, Copenhagen, Madrid, Paris", "(GMT+01:00) Sarajevo, Skopje, Warsaw, Zagreb", "(GMT+01:00) West Central Africa", "(GMT+02:00) Athens, Istanbul, Minsk", "(GMT+02:00) Bucharest", "(GMT+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius", "(GMT+02:00) Jerusalem", "(GMT+03:00) Baghdad", "(GMT+03:00) Moscow, St. Petersburg, Volgograd", "(GMT+03:00) Nairobi", "(GMT+03:30) Tehran", "(GMT+04:00) Abu Dhabi, Muscat", "(GMT+04:30) Kabul", "(GMT+05:00) Ekaterinburg", "(GMT+05:30) Chennai, Kolkata, Mumbai, New Delhi", "(GMT+05:45) Kathmandu", "(GMT+06:00) Almaty, Novosibirsk", "(GMT+06:00) Astana, Dhaka", "(GMT+06:30) Rangoon", "(GMT+07:00) Bangkok, Hanoi, Jakarta", "(GMT+07:00) Krasnoyarsk", "(GMT+08:00) Beijing, Chongqing, Hong Kong, Urumqi", "(GMT+08:00) Irkutsk, Ulaan Bataar", "(GMT+08:00) Kuala Lumpur, Singapore", "(GMT+08:00) Taipei", "(GMT+09:00) Osaka, Sapporo, Tokyo", "(GMT+09:00) Seoul", "(GMT+09:30) Adelaide", "(GMT+10:00) Brisbane", "(GMT+10:00) Vladivostok", "(GMT+11:00) Magadan, Solomon Is., New Caledonia", "(GMT+12:00) Auckland, Wellington", "(GMT+12:00) Fiji, Kamchatka, Marshall Is.", "(GMT+13:00) Nuku'alofa");

	if (($action eq "save") && ($clientid > 0)) {
		dbdo("UPDATE users SET city='".$FORM{city}."', province='".$FORM{province}."', country='".$FORM{country}."', postal='".$FORM{postal}."', phone1='".$FORM{phone1}."', phone2='".$FORM{phone2}."', phone3='".$FORM{phone3}."', email='".$FORM{email}."', timezone='".($FORM{timezone} + 0)."', comfort='".($FORM{comfort} + 0)."', t_display='".($FORM{t_display} + 0)."', name1='".$FORM{name1}."', name2='".$FORM{name2}."', address1='".$FORM{address1}."', address2='".$FORM{address2}."' WHERE id = $clientid", 0);
#		if (($FORM{name1} eq "") || ($FORM{name2} eq "") || ($FORM{address1} eq "") || ($FORM{city} eq "") || ($FORM{postal} eq "") || ($FORM{email} eq "")) {
#			$message = "<tr><td nowrap=\"nowrap\" width=\"138\">&nbsp;</td><td nowrap=\"nowrap\"><font color=red><br>One or more important fields must be filled!</td></tr>\n";
#		}
	}
        
        my $comfort = 0;
        my @lcomfort = ("", "", "", "", "");
        my $tdisplay = 0;
        my @ltdisp = ("", "");
        my $timezone = 0;
        my ($ltimezone, $province, $lprovince, $country, $lcountry) = ("", "", "", "", "");
        my ($name1, $name2, $email, $phone1, $phone2, $phone3, $postal, $city, $address1, $address2) = ("", "", "", "", "", "", "", "", "", "");
	my $all = $db->selectall_arrayref("SELECT comfort, t_display, timezone, province, country, name1, name2, email, phone1, phone2, phone3, postal, city, address1, address2 FROM users WHERE id = $clientid ORDER BY id DESC LIMIT 1");
	foreach my $row (@$all) {
		$comfort = @$row[0] + 0;
		$lcomfort[$comfort] = "checked=\"checked\"";
		$tdisplay = @$row[1] + 0;
		$ltdisp[$tdisplay] = "checked=\"checked\"";
		$timezone = @$row[2] + 0;
		$province = @$row[3];
		$country = @$row[4];
		$name1 = @$row[5];
		$name2 = @$row[6];
		$email = @$row[7];
		$phone1 = @$row[8];
		$phone2 = @$row[9];
		$phone3 = @$row[10];
		$postal = @$row[11];
		$city = @$row[12];
		$address1 = @$row[13];
		$address2 = @$row[14];
	}
	undef $all;

	foreach my $iprovince (sort keys %provinces) {
		$lprovince .= "<option value=\"$iprovince\"".(($province eq $iprovince)?" selected=\"selected\"":"").">".$provinces{$iprovince}."</option>";
	}
	foreach my $icountry (sort keys %countries) {
		$lcountry .= "<option value=\"$icountry\"".(($country eq $icountry)?" selected=\"selected\"":"").">".$countries{$icountry}."</option>";
	}
	for my $itimezone (0 .. $#timezones) {
		my $ltzone = 0;
		if ($timezones[$itimezone] =~ m/^\(GMT([\+\-]\d\d)\:(\d\d)\)/) {		# extract timezone from list
			$ltzone = $1.$2;
		}
		$ltimezone .= "<option value=\"".$ltzone."\" ".(($ltzone == $timezone)?" selected=\"selected\"":"").">".$timezones[$itimezone]."</option>";
	}

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--email--/$email/g;
		$inline =~ s/--name1--/$name1/g;
		$inline =~ s/--name2--/$name2/g;
		$inline =~ s/--phone1--/$phone1/g;
		$inline =~ s/--phone2--/$phone2/g;
		$inline =~ s/--phone3--/$phone3/g;
		$inline =~ s/--postal--/$postal/g;
		$inline =~ s/--city--/$city/g;
		$inline =~ s/--address1--/$address1/g;
		$inline =~ s/--address2--/$address2/g;
		$inline =~ s/--t_display0--/$ltdisp[0]/g;
		$inline =~ s/--t_display1--/$ltdisp[1]/g;
		$inline =~ s/--comfort0--/$lcomfort[0]/g;
		$inline =~ s/--comfort1--/$lcomfort[1]/g;
		$inline =~ s/--comfort2--/$lcomfort[2]/g;
		$inline =~ s/--comfort3--/$lcomfort[3]/g;
		$inline =~ s/--comfort4--/$lcomfort[4]/g;
		$inline =~ s/--timezone--/$ltimezone/g;
		$inline =~ s/--province--/$lprovince/g;
		$inline =~ s/--country--/$lcountry/g;
		$inline =~ s/--message--/$message/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# events and alarms viewer

if (($uimode eq "events") && ($uismode eq "events") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my $yearf = (exists $FORM{year_f})?$FORM{year_f}:$curyear;
	my $yeart = (exists $FORM{year_t})?$FORM{year_t}:$curyear;
	my $monthf = (exists $FORM{month_f})?$FORM{month_f}:$curmon;
	my $montht = (exists $FORM{month_t})?$FORM{month_t}:$curmon;
	my $dayf = (exists $FORM{day_f})?$FORM{day_f}:$curday;
	my $dayt = (exists $FORM{day_t})?$FORM{day_t}:$curday;
	my $evtype = (exists $FORM{evtype})?$FORM{evtype}:0;
	my $severity = (exists $FORM{severity})?$FORM{severity}:3;
	my @sevlist = ("Green", "Yellow", "Red", "Show All");
	my ($lyearf, $lyeart, $lmonthf, $lmontht, $ldayf, $ldayt, $levtype, $lseverity, $evlist) = ("", "", "", "", "", "", "", "", "", "");

	my $all = $db->selectall_arrayref("SELECT type_, description FROM alarms_types WHERE alarm_id = -1 ORDER BY type_");
	foreach my $row (@$all) {
		my ($altype, $aldesc) = @$row;
		$levtype .= "<option value=\"$altype\"".(($altype == $evtype)?" selected=\"selected\"":"").">$aldesc</option>";
	}
	undef $all;

	for my $year (2014 .. 2024) {
		$lyearf .= "<option value=\"$year\"".(($year == $yearf)?" selected=\"selected\"":"").">$year</option>";
		$lyeart .= "<option value=\"$year\"".(($year == $yeart)?" selected=\"selected\"":"").">$year</option>";
	}
	for my $month (1 .. 12) {
		$lmonthf .= "<option value=\"$month\"".(($month == $monthf)?" selected=\"selected\"":"").">".$monthtxt[($month - 1)]."</option>";
		$lmontht .= "<option value=\"$month\"".(($month == $montht)?" selected=\"selected\"":"").">".$monthtxt[($month - 1)]."</option>";
	}
	for my $day (1 .. 31) {
		$ldayf .= "<option value=\"$day\"".(($day == $dayf)?" selected=\"selected\"":"").">$day</option>";
		$ldayt .= "<option value=\"$day\"".(($day == $dayt)?" selected=\"selected\"":"").">$day</option>";
	}
	for my $sevv (0 .. $#sevlist) {
		$lseverity .= "<option value=\"$sevv\"".(($severity == $sevv)?" selected=\"selected\"":"").">".$sevlist[$sevv]."</option>";
	}
	my $datef = sprintf("%04d%02d%02d000000", $yearf, $monthf, $dayf);
	my $datet = sprintf("%04d%02d%02d235959", $yeart, $montht, $dayt);

	# other type events viewer TBD!!

	if ($evtype == 5) {					# view registration events
		my %alist = ();
		my %asevr = ();
		my $all = $db->selectall_arrayref("SELECT alarm_id, severity, description FROM alarms_types WHERE type_ = 5 AND alarm_id >= 0");		# only reg alarms list
		foreach my $row (@$all) {
			my ($alid, $alsev, $aldesc) = @$row;
			$alist{$alid} = $aldesc;
			$asevr{$alid} = $alsev;
		}
		undef $all;

		my @regstat = ("Pending", "Inactive", "Accepted", "Rejected");
		my $all = $db->selectall_arrayref("SELECT DATE_FORMAT(updated, '%b %e, %H:%i'), event_type, device_type, status FROM registrations WHERE updated BETWEEN $datef AND $datet ORDER BY id DESC");
		foreach my $row (@$all) {
			my ($update, $evtype, $devtype, $rstat) = @$row;
			if (($severity > 2) || ($asevr{$evtype} == $severity)) {
				$evlist .= "<tr><td nowrap=\"nowrap\" width=\"80\">$update</td>
						<td class=\"stdbold\" width=\"50\">".$sevlist[$asevr{$evtype}]."</td>
						<td>".$alist{$evtype}.(($evtype == 1)?": ".$regstat[$rstat]:"")."</td></tr>\n";
			}
		}
		undef $all;
	}

	if ($evlist eq "") {
		$evlist = "<tr><td nowrap=\"nowrap\" width=\"120\">No events to display</td>
				<td class=\"stdbold\" width=\"50\"></td>
				<td></td></tr>\n";
	}

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--events--/$evlist/g;
		$inline =~ s/--severity--/$lseverity/g;
		$inline =~ s/--evtype--/$levtype/g;
		$inline =~ s/--year_f--/$lyearf/g;
		$inline =~ s/--year_t--/$lyeart/g;
		$inline =~ s/--month_f--/$lmonthf/g;
		$inline =~ s/--month_t--/$lmontht/g;
		$inline =~ s/--day_f--/$ldayf/g;
		$inline =~ s/--day_t--/$ldayt/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# network events and alarms management

if (($uimode eq "events") && ($uismode eq "management") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my @severity = ("Green", "Yellow", "Red");
	my @alarms = ("", "", "", "", "", "");

	my $all = $db->selectall_arrayref("SELECT id, status, severity, description, type_ FROM alarms_types WHERE alarm_id >= 0 AND (type_ = 3 OR type_ = 5 OR type_ = 1) ORDER BY type_, id");
	foreach my $row (@$all) {
		my ($alid, $alst, $alsev, $aldesc, $altype) = @$row;
		if ($action eq "save") {
			if (exists $FORM{"alst".$alid}) {
				if ($FORM{"alst".$alid} != $alst) {
					$alst = $FORM{"alst".$alid} + 0;
					dbdo("UPDATE alarms_types SET status = '$alst' WHERE id = $alid", 0);
				}
			}
		}		
		$alarms[$altype] .= "<tr><td nowrap=\"nowrap\" width=\"220\">$aldesc</td>";
		if ($uaccess > 0) {
			if ($action eq "save") {
				if (exists $FORM{"alsev".$alid}) {
					if ($FORM{"alsev".$alid} != $alsev) {
						$alsev = $FORM{"alsev".$alid} + 0;
						dbdo("UPDATE alarms_types SET severity = '$alsev' WHERE id = $alid", 0);
					}
				}
			}
			my $sevtxt = "<select name=\"alsev".$alid."\" size=\"1\">";
			for my $sevv (0 .. $#severity) {
				$sevtxt .= "<option value=\"$sevv\"".(($alsev == $sevv)?" selected=\"selected\"":"").">".$severity[$sevv]."</option>";
			}
			$alarms[$altype] .= "<td nowrap=\"nowrap\" width=70>$sevtxt</select></td>";
		} else {
			$alarms[$altype] .= "<td class=\"stdbold\" nowrap=\"nowrap\" width=70>&nbsp;&nbsp;&nbsp;".$severity[$alsev]."</td>";
		}
		$alarms[$altype] .= "<td nowrap=\"nowrap\"><select name=\"alst".$alid."\" size=\"1\"><option value=\"0\"".(($alst == 0)?" selected=\"selected\"":"").">Disabled</option><option value=\"1\"".(($alst == 1)?" selected=\"selected\"":"").">Enabled</option></select></td></tr>";
	}
	undef $all;

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--alarms_zigbee--/$alarms[1]/g;
		$inline =~ s/--alarms_net--/$alarms[3]/g;
		$inline =~ s/--alarms_reg--/$alarms[5]/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# system events and alarms management

if (($uimode eq "events") && ($uismode eq "alarms") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my @severity = ("Green", "Yellow", "Red");
	my @alarms = ("", "", "", "", "", "");

	my $all = $db->selectall_arrayref("SELECT id, status, severity, description, type_ FROM alarms_types WHERE alarm_id >= 0 AND (type_ = 0 OR type_ = 2 OR type_ = 4) ORDER BY type_, id");
	foreach my $row (@$all) {
		my ($alid, $alst, $alsev, $aldesc, $altype) = @$row;
		if ($action eq "save") {
			if (exists $FORM{"alst".$alid}) {
				if ($FORM{"alst".$alid} != $alst) {
					$alst = $FORM{"alst".$alid} + 0;
					dbdo("UPDATE alarms_types SET status = '$alst' WHERE id = $alid", 0);
				}
			}
		}
		$alarms[$altype] .= "<tr><td nowrap=\"nowrap\" width=\"220\">$aldesc</td>";
		if ($uaccess > 0) {
			if ($action eq "save") {
				if (exists $FORM{"alsev".$alid}) {
					if ($FORM{"alsev".$alid} != $alsev) {
						$alsev = $FORM{"alsev".$alid} + 0;
						dbdo("UPDATE alarms_types SET severity = '$alsev' WHERE id = $alid", 0);
					}
				}
			}
			my $sevtxt = "<select name=\"alsev".$alid."\" size=\"1\">";
			for my $sevv (0 .. $#severity) {
				$sevtxt .= "<option value=\"$sevv\"".(($alsev == $sevv)?" selected=\"selected\"":"").">".$severity[$sevv]."</option>";
			}
			$alarms[$altype] .= "<td nowrap=\"nowrap\" width=70>$sevtxt</select></td>";
		} else {
			$alarms[$altype] .= "<td class=\"stdbold\" nowrap=\"nowrap\" width=70>&nbsp;&nbsp;&nbsp;".$severity[$alsev]."</td>";
		}
		$alarms[$altype] .= "<td nowrap=\"nowrap\"><select name=\"alst".$alid."\" size=\"1\"><option value=\"0\"".(($alst == 0)?" selected=\"selected\"":"").">Disabled</option><option value=\"1\"".(($alst == 1)?" selected=\"selected\"":"").">Enabled</option></select></td></tr>";
	}
	undef $all;

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--alarms_sys--/$alarms[2]/g;
		$inline =~ s/--alarms_pressure--/$alarms[4]/g;
		$inline =~ s/--alarms_save--/$alarms[0]/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# software update page

if (($uimode eq "system") && ($uismode eq "update") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my $updmsg = "";
	if ($action eq "save") {				# update check TBD
		$updmsg = "<tr><td colspan=2><br>No updates currently available</td></tr>\n";
	}

        my ($cloud1, $cloud2) = ("", "");
	my $all = $db->selectall_arrayref("SELECT cloud1, cloud2, id FROM networks ORDER BY id DESC LIMIT 1");
	foreach my $row (@$all) {
		($cloud1, $cloud2) = (@$row[0], @$row[1]);
	}
	undef $all;

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--sw_version--/$version/g;
		$inline =~ s/--cloud1--/$cloud1/g;
		$inline =~ s/--cloud2--/$cloud2/g;
		$inline =~ s/--updmessage--/$updmsg/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# system advanced tools

if (($uimode eq "system") && ($uismode eq "advanced") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my ($updmsg, $upd2msg) = ("", "");
	my @restnum = (0, 0, 0);
	my @restlast = ("Never", "Never", "Never");
	{
		my $all = $db->selectall_arrayref("SELECT COUNT(id), MAX(updated), type_ FROM alarms_system WHERE type_ BETWEEN 11 and 13 GROUP BY type_");
		foreach my $row (@$all) {
			my ($rcnt, $rlast, $rtype) = @$row;
			$restnum[$rtype - 11] = $rcnt;
			$restlast[$rtype - 11] = $rlast;
		}
		undef $all;
	}
        if (($action eq "reboot") || ($action eq "restart") || ($action eq "shutdown")) {
		my $hbypass = 0;
		my $all = $db->selectall_arrayref("SELECT status FROM bypass WHERE type_ = 0 ORDER BY id DESC LIMIT 1");
		foreach my $row (@$all) {
			($hbypass) = @$row;
			$hbypass += 0;
		}
		undef $all;
		my ($bypasm, $bypweb) = (0, 0);
		my $all = $db->selectall_arrayref("SELECT status FROM bypass WHERE type_ = 1 ORDER BY id DESC LIMIT 1");	# web only
		foreach my $row (@$all) {
			($bypweb) = @$row;
			$bypasm = ($hbypass == 1)?1:($bypweb + 0);
		}
		undef $all;
		if ($bypasm == 0) {				# bypass disabled? prohibit critical operations
			$action = "";
			$updmsg = "<tr><td colspan=2><br><font color=red><b>Bypass mode</b> must be enabled for critical operations!</td></tr>\n";
		}
        }
	if ($action eq "reboot") {				# reboot system
		dbdo("INSERT INTO alarms_system VALUES (NULL, NOW(), 12, 0, 'System reboot from webui')", 0);
		$updmsg = "<tr><td colspan=2><br>System restarting.. Downtime up to 1 minute";
		my $mesg = `/usr/bin/sudo /sbin/shutdown -r now`;
		$updmsg .= "</td></tr>\n";
	}
	if ($action eq "restart") {				# restart retrosave
		dbdo("INSERT INTO alarms_system VALUES (NULL, NOW(), 11, 0, 'RetroSAVE restart from webui')", 0);
		$updmsg = "<tr><td colspan=2><br>RetroSAVE restarting.. Please wait";
		$db->do("INSERT INTO hvac_actions (id, type_) VALUES (NULL, 7)");	# send command to restart retrosave
		$updmsg .= "</td></tr>\n";
	}
	if ($action eq "shutdown") {				# shutdown system
		dbdo("INSERT INTO alarms_system VALUES (NULL, NOW(), 13, 0, 'System shutdown from webui')", 0);
		$updmsg = "<tr><td colspan=2><br>System shutting down..";
		my $mesg = `/usr/bin/sudo /sbin/shutdown -h now`;
		$updmsg .= "</td></tr>\n";
	}
	if ($action eq "netresetw") {				# restart wireless networking
		$updmsg = "<tr><td colspan=2><br>Wireless networking restart.. Please wait";
		$db->do("INSERT INTO hvac_actions (id, type_) VALUES (NULL, 3)");	# send command to restart WAN
		$updmsg .= "</td></tr>\n";
	}
	if ($action eq "netreseta") {				# restart wired networking
		$updmsg = "<tr><td colspan=2><br>Wired networking restart.. Please wait";
		my $mesg = "/usr/bin/sudo ".$selfpath."lan_restart.sh &";
		exec($mesg);
		$updmsg .= "</td></tr>\n";
	}
	my ($fac1c, $fac2c, $fac3c, $fac4c) = ("", "", "", "");
	if ($action eq "save") {				# restore to defaults proc
		my $faclist = "";
		($fac1c, $fac2c, $fac3c, $fac4c) = (" disabled=\"disabled\"", " disabled=\"disabled\"", " disabled=\"disabled\"", " disabled=\"disabled\"");
		if (exists $FORM{factory1}) {
			$fac1c .= " checked=\"checked\"";
			$faclist .= "1\n";
		}
		if (exists $FORM{factory2}) {
			$fac2c .= " checked=\"checked\"";
			$faclist .= "2\n";
		}
		if (exists $FORM{factory3}) {
			$fac3c .= " checked=\"checked\"";
			$faclist .= "3\n";
		}
		if (exists $FORM{factory4}) {
			$fac4c .= " checked=\"checked\"";
			$faclist .= "4\n";
		}
		my $facfile = $tmpfold."faclist";
		if ($faclist eq "") {
			$upd2msg = "<tr><td colspan=2><br>No operations were selected from the list above!</td></tr>\n";
			unlink($facfile);
			($fac1c, $fac2c, $fac3c, $fac4c) = ("", "", "", "");
		} else {
			$upd2msg = "<tr><td colspan=2><br>All operations selected above will start in several seconds.<br>System will automatically restart when completed and boot normally.<br>Please do not make any operations until system restarts or controller may be bricked!</td></tr>\n";
			open(FAC, ">$facfile");
			print FAC $faclist;
			close(FAC);
		}
	}

	$headadd .= <<EOF;
	<script language="JavaScript">
		function AreYouSure(command, prompt) {
			var ays = confirm(prompt);
			if (ays == true) {
				window.location.href='./engine.pl?mode=$uimode&submode=$uismode&action='+command;
			}
			return false;
		}
		function FactorySure(prompt) {
			var ays = confirm(prompt);
			if (ays == true) {
				document.advancedForm.submit();
			}
			return false;
		}
	</script>
EOF

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--restnum0--/$restnum[0]/g;
		$inline =~ s/--restnum1--/$restnum[1]/g;
		$inline =~ s/--restnum2--/$restnum[2]/g;
		$inline =~ s/--restlast0--/$restlast[0]/g;
		$inline =~ s/--restlast1--/$restlast[1]/g;
		$inline =~ s/--restlast2--/$restlast[2]/g;
		$inline =~ s/--f1chk--/$fac1c/g;
		$inline =~ s/--f2chk--/$fac2c/g;
		$inline =~ s/--f3chk--/$fac3c/g;
		$inline =~ s/--f4chk--/$fac4c/g;
		$inline =~ s/--updmessage--/$updmsg/g;
		$inline =~ s/--upd2message--/$upd2msg/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# RTC page

if (($uimode eq "system") && ($uismode eq "datetime") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my $updmsg = "";
	if ($action eq "save") {				# send command to muxdemux
		my $cohour = (($FORM{chour} == 12)?0:$FORM{chour}) + (12 * ($FORM{campm} - 1));
		my $fulltime = $FORM{cyear}."-".$FORM{cmonth}."-".$FORM{cday}." ".$cohour.":".$FORM{cminute}.":00";
		$sth = $db->prepare("SELECT UNIX_TIMESTAMP('$fulltime')");
		$sth->execute;
		my ($unixtime) = $sth->fetchrow_array();
		$unixtime -= $tzsecoff;				# convert back to GMT+0
		$sth->finish;
		if ($unixtime == 0) {
			$updmsg = "<tr><td colspan=2><br>Rejected. Selected date and time are incorrect</td></tr>\n";
		} else {
			$db->do("INSERT INTO commands (id, updated, command, parameters) VALUES (NULL, NOW(), 126, '$unixtime')");
			$updmsg = "<tr><td colspan=2><br>Accepted. RTC will be updated in several seconds</td></tr>\n";
		}
	}

	my ($cyear, $cmonth, $cday, $chour, $campm, $cminute) = ("", "", "", "", "", "");
	for my $idx (2014 .. 2024) {
		$cyear .= "<option value=\"$idx\" ".(($idx == $curyear)?" selected=\"selected\"":"").">$idx</option>";
	}
	for my $idx (1 .. 12) {
		$cmonth .= "<option value=\"$idx\" ".(($idx == $curmon)?" selected=\"selected\"":"").">".$monthftxt[$idx - 1]."</option>";
	}
	for my $idx (1 .. 31) {
		$cday .= "<option value=\"$idx\" ".(($idx == $curday)?" selected=\"selected\"":"").">$idx</option>";
	}
	for my $idx (1 .. 60) {
		$cminute .= "<option value=\"$idx\" ".(($idx == $curmin)?" selected=\"selected\"":"").">".sprintf("%02d", $idx)."</option>";
	}
	for my $idx (1 .. 12) {
		my $cchour = $curhour;
		if ($cchour > 11) {
			$cchour -= 12;
		}
		if ($cchour == 0) {
			$cchour = 12;
		}
		$chour .= "<option value=\"$idx\" ".(($idx == $cchour)?" selected=\"selected\"":"").">".sprintf("%02d", $idx)."</option>";
	}
	for my $idx (1 .. 2) {
		$campm .= "<option value=\"$idx\" ".(($idx == $curampm)?" selected=\"selected\"":"").">".uc($ampmtxt[$idx - 1])."</option>";
	}

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--cyear--/$cyear/g;
		$inline =~ s/--cmonth--/$cmonth/g;
		$inline =~ s/--cday--/$cday/g;
		$inline =~ s/--chour--/$chour/g;
		$inline =~ s/--campm--/$campm/g;
		$inline =~ s/--cminute--/$cminute/g;
		$inline =~ s/--updmessage--/$updmsg/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# database maintenance page

if (($uimode eq "system") && ($uismode eq "db") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my $maxdays = (exists $HVAC{"system.max_days"})?$HVAC{"system.max_days"}:30;
	my $maxstrv = (exists $HVAC{"system.max_storage"})?$HVAC{"system.max_storage"}:0;
	my @maxstor = ("", "");

	if (($action eq "save") && (exists $FORM{max_days}) && (exists $FORM{max_storage})) {
		my $newmaxdays = $FORM{max_days} + 0;
		if ($maxdays != $newmaxdays) {
			$maxdays = $newmaxdays;
			dbdo("UPDATE hvac SET value_ = $maxdays WHERE option_ = 'system.max_days';", 0);
		}
		my $newmaxstor = $FORM{max_storage} + 0;
		if ($maxstrv != $newmaxstor) {
			$maxstrv = $newmaxstor;
			dbdo("UPDATE hvac SET value_ = $maxstrv WHERE option_ = 'system.max_storage';", 0);
		}
	}
	$maxstor[$maxstrv] = " checked=\"checked\"";

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--max_days--/$maxdays/g;
		$inline =~ s/--max_storage0--/$maxstor[0]/g;
		$inline =~ s/--max_storage1--/$maxstor[1]/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# occupancy schedule report

if (($uimode eq "reports") && ($uismode eq "occupancy") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my $yearf = (exists $FORM{year_f})?$FORM{year_f}:$curyear;
	my $yeart = (exists $FORM{year_t})?$FORM{year_t}:$curyear;
	my $monthf = (exists $FORM{month_f})?$FORM{month_f}:$curmon;
	my $montht = (exists $FORM{month_t})?$FORM{month_t}:$curmon;
	my $dayf = (exists $FORM{day_f})?$FORM{day_f}:$curday;
	my $dayt = (exists $FORM{day_t})?$FORM{day_t}:$curday;
	my $zone = (exists $FORM{zone})?$FORM{zone}:2;
	my $bout = (exists $FORM{breakout})?$FORM{breakout}:1;
	my ($lyearf, $lyeart, $lmonthf, $lmontht, $ldayf, $ldayt) = ("", "", "", "", "", "");
	my ($lzone, $lbreak, $loccup) = ("", "", "");

	for my $breaks (0 .. 1) {
		$lbreak .= "<option value=\"$breaks\"".(($bout == $breaks)?" selected=\"selected\"":"").">".(($breaks + 1) * 15)."</option>";	# 15 min increment
	}
	for my $year (2014 .. 2024) {
		$lyearf .= "<option value=\"$year\"".(($year == $yearf)?" selected=\"selected\"":"").">$year</option>";
		$lyeart .= "<option value=\"$year\"".(($year == $yeart)?" selected=\"selected\"":"").">$year</option>";
	}
	for my $month (1 .. 12) {
		$lmonthf .= "<option value=\"$month\"".(($month == $monthf)?" selected=\"selected\"":"").">".$monthtxt[($month - 1)]."</option>";
		$lmontht .= "<option value=\"$month\"".(($month == $montht)?" selected=\"selected\"":"").">".$monthtxt[($month - 1)]."</option>";
	}
	for my $day (1 .. 31) {
		$ldayf .= "<option value=\"$day\"".(($day == $dayf)?" selected=\"selected\"":"").">$day</option>";
		$ldayt .= "<option value=\"$day\"".(($day == $dayt)?" selected=\"selected\"":"").">$day</option>";
	}
	my $datef = sprintf("%04d%02d%02d000000", $yearf, $monthf, $dayf);
	my $datet = sprintf("%04d%02d%02d235959", $yeart, $montht, $dayt);

	{
		my $all = $db->selectall_arrayref("SELECT id, description FROM zones WHERE id > 1 ORDER BY id");
		foreach my $row (@$all) {
			$lzone .= "<option value=\"".@$row[0]."\"".((@$row[0] == $zone)?" selected=\"selected\"":"").">".@$row[1]."</option>";
		}
		undef $all;
	}

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
			$loccup .= "<tr><td class=\"stdbold\" align=center>".sprintf("%02d:%02d - %02d:%02d", $hfrom, $mfrom, $hrto, $minto)." ".(($ampm == 0)?"AM":"PM")."</td><td align=center>0%</td><td align=center>0%</td><td align=center>0%</td><td align=center>0%</td><td align=center>0%</td><td align=center>0%</td><td align=center>0%</td></tr>\n";
		}
	}

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--zone--/$lzone/g;
		$inline =~ s/--occupancy--/$loccup/g;
		$inline =~ s/--breakout--/$lbreak/g;
		$inline =~ s/--year_f--/$lyearf/g;
		$inline =~ s/--year_t--/$lyeart/g;
		$inline =~ s/--month_f--/$lmonthf/g;
		$inline =~ s/--month_t--/$lmontht/g;
		$inline =~ s/--day_f--/$ldayf/g;
		$inline =~ s/--day_t--/$ldayt/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# charts

if (($uimode eq "reports") && ($uismode eq "charts") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my $yearf = (exists $FORM{year_f})?$FORM{year_f}:$curyear;
	my $yeart = (exists $FORM{year_t})?$FORM{year_t}:$curyear;
	my $monthf = (exists $FORM{month_f})?$FORM{month_f}:$curmon;
	my $montht = (exists $FORM{month_t})?$FORM{month_t}:$curmon;
	my $dayf = (exists $FORM{day_f})?$FORM{day_f}:$curday;
	my $dayt = (exists $FORM{day_t})?$FORM{day_t}:$curday;
	my $zone = (exists $FORM{zone})?$FORM{zone}:2;
	my ($lyearf, $lyeart, $lmonthf, $lmontht, $ldayf, $ldayt) = ("", "", "", "", "", "");
	my ($lzone, $chart, $czname) = ("", "", "");

	for my $year (2014 .. 2024) {
		$lyearf .= "<option value=\"$year\"".(($year == $yearf)?" selected=\"selected\"":"").">$year</option>";
		$lyeart .= "<option value=\"$year\"".(($year == $yeart)?" selected=\"selected\"":"").">$year</option>";
	}
	for my $month (1 .. 12) {
		$lmonthf .= "<option value=\"$month\"".(($month == $monthf)?" selected=\"selected\"":"").">".$monthtxt[($month - 1)]."</option>";
		$lmontht .= "<option value=\"$month\"".(($month == $montht)?" selected=\"selected\"":"").">".$monthtxt[($month - 1)]."</option>";
	}
	for my $day (1 .. 31) {
		$ldayf .= "<option value=\"$day\"".(($day == $dayf)?" selected=\"selected\"":"").">$day</option>";
		$ldayt .= "<option value=\"$day\"".(($day == $dayt)?" selected=\"selected\"":"").">$day</option>";
	}
	my $datef = sprintf("%04d%02d%02d000000", $yearf, $monthf, $dayf);
	my $datet = sprintf("%04d%02d%02d235959", $yeart, $montht, $dayt);

	{
		my $all = $db->selectall_arrayref("SELECT id, description FROM zones WHERE id > 1 ORDER BY id");
		foreach my $row (@$all) {
			$lzone .= "<option value=\"".@$row[0]."\"".((@$row[0] == $zone)?" selected=\"selected\"":"").">".@$row[1]."</option>";
			if (@$row[0] == $zone) {
				$czname = @$row[1];
			}
		}
		undef $all;
	}

	my ($zonet, $zoneh, $tsensor, $hsensor) = ("N/A", "N/A", "Unavailable", "Unavailable");
	if ($czname ne "") {
		use GD::Graph::lines;
		my $picname = $clientid."-$curyear$curmon$curday$curhour$curmin$cursec.png";
		my $picfile = $selfpath."charts/".$picname;
		my ($udatef, $udatet) = (0, 0);

		my $all = $db->selectall_arrayref("SELECT UNIX_TIMESTAMP($datef), UNIX_TIMESTAMP($datet)");
		foreach my $row (@$all) {
			if (@$row[0] < @$row[1]) {
				($udatef, $udatet) = (@$row[0], @$row[1]);
			} else {
				($udatef, $udatet) = (@$row[1], @$row[0]);		# fool check ))
			}
		}
		undef $all;

		my $all = $db->selectall_arrayref("SELECT AVG(paramsensordyn.temperature), AVG(paramsensordyn.humidity), devices.description FROM paramsensordyn, devices WHERE paramsensordyn.device_id = devices.id AND devices.zone_id = $zone AND devices.device_type = 1");
		foreach my $row (@$all) {
			$zonet = ttproper(@$row[0]);
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
		
		my $graph = GD::Graph::lines->new(500, 500);
		$czname =~ s/\szone$//i;
		$graph->set( 
			title		=> "$czname zone graph",
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
		my $gd = $graph->plot(\@data) or die $graph->error;
		open(IMG, ">$picfile") or die $!;
		binmode IMG;
		print IMG $gd->png;
		$chart = "<img src=\"charts/$picname\" border=0 width=500 height=500>";
		close(IMG);
	}

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--t_sensor--/$tsensor/g;
		$inline =~ s/--h_sensor--/$hsensor/g;
		$inline =~ s/--zone--/$lzone/g;
		$inline =~ s/--chart--/$chart/g;
		$inline =~ s/--year_f--/$lyearf/g;
		$inline =~ s/--year_t--/$lyeart/g;
		$inline =~ s/--month_f--/$lmonthf/g;
		$inline =~ s/--month_t--/$lmontht/g;
		$inline =~ s/--day_f--/$ldayf/g;
		$inline =~ s/--day_t--/$ldayt/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# COTS charts

if (($uimode eq "reports") && ($uismode eq "cots") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my $yearf = (exists $FORM{year_f})?$FORM{year_f}:$curyear;
	my $yeart = (exists $FORM{year_t})?$FORM{year_t}:$curyear;
	my $monthf = (exists $FORM{month_f})?$FORM{month_f}:$curmon;
	my $montht = (exists $FORM{month_t})?$FORM{month_t}:$curmon;
	my $dayf = (exists $FORM{day_f})?$FORM{day_f}:$curday;
	my $dayt = (exists $FORM{day_t})?$FORM{day_t}:$curday;
	my $line = (exists $FORM{line})?$FORM{line}:"w1";
	my ($lyearf, $lyeart, $lmonthf, $lmontht, $ldayf, $ldayt) = ("", "", "", "", "", "");
	my @linames = ("w1", "w2", "y1", "y2", "g", "ob", "aux");
	my ($lilist, $chart) = ("", "");
	foreach my $liitem (@linames) {
		$lilist .= "<option value=\"$liitem\"".(($liitem eq $line)?" selected=\"selected\"":"").">".uc($liitem)."</option>";
	}

	for my $year (2014 .. 2024) {
		$lyearf .= "<option value=\"$year\"".(($year == $yearf)?" selected=\"selected\"":"").">$year</option>";
		$lyeart .= "<option value=\"$year\"".(($year == $yeart)?" selected=\"selected\"":"").">$year</option>";
	}
	for my $month (1 .. 12) {
		$lmonthf .= "<option value=\"$month\"".(($month == $monthf)?" selected=\"selected\"":"").">".$monthtxt[($month - 1)]."</option>";
		$lmontht .= "<option value=\"$month\"".(($month == $montht)?" selected=\"selected\"":"").">".$monthtxt[($month - 1)]."</option>";
	}
	for my $day (1 .. 31) {
		$ldayf .= "<option value=\"$day\"".(($day == $dayf)?" selected=\"selected\"":"").">$day</option>";
		$ldayt .= "<option value=\"$day\"".(($day == $dayt)?" selected=\"selected\"":"").">$day</option>";
	}
	my $datef = sprintf("%04d%02d%02d000000", $yearf, $monthf, $dayf);
	my $datet = sprintf("%04d%02d%02d235959", $yeart, $montht, $dayt);

	my $czname = uc($line);
	if ($czname ne "") {
		use GD::Graph::lines;
		my $picname = $clientid."-$line-$curyear$curmon$curday$curhour$curmin$cursec.png";
		my $picfile = $selfpath."charts/".$picname;
		my ($udatef, $udatet) = (0, 0);

		my $all = $db->selectall_arrayref("SELECT UNIX_TIMESTAMP($datef), UNIX_TIMESTAMP($datet)");
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
		
		my $graph = GD::Graph::lines->new(500, 500);			# uses twax_y2 that needs GD::Graph::axestype.pm fix
		$graph->set( 
			title		=> "$czname line graph",
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
		my $gd = $graph->plot(\@data) or die $graph->error;
		open(IMG, ">$picfile") or die $!;
		binmode IMG;
		print IMG $gd->png;
		$chart = "<img src=\"charts/$picname\" border=0 width=500 height=500>";
		close(IMG);
	}

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--line--/$lilist/g;
		$inline =~ s/--line_sel--/$czname/g;
		$inline =~ s/--chart--/$chart/g;
		$inline =~ s/--year_f--/$lyearf/g;
		$inline =~ s/--year_t--/$lyeart/g;
		$inline =~ s/--month_f--/$lmonthf/g;
		$inline =~ s/--month_t--/$lmontht/g;
		$inline =~ s/--day_f--/$ldayf/g;
		$inline =~ s/--day_t--/$ldayt/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# retrosave and bypass runtime report

if (($uimode eq "reports") && ($uismode eq "retrosave") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my $yearf = (exists $FORM{year_f})?$FORM{year_f}:$curyear;
	my $yeart = (exists $FORM{year_t})?$FORM{year_t}:$curyear;
	my $monthf = (exists $FORM{month_f})?$FORM{month_f}:$curmon;
	my $montht = (exists $FORM{month_t})?$FORM{month_t}:$curmon;
	my $dayf = (exists $FORM{day_f})?$FORM{day_f}:$curday;
	my $dayt = (exists $FORM{day_t})?$FORM{day_t}:$curday;
	my ($lyearf, $lyeart, $lmonthf, $lmontht, $ldayf, $ldayt) = ("", "", "", "", "", "");
	my ($totdays) = ("");
	my ($rsaveA, $bpassA) = ("", "");
	my ($rrsave, $rbpass) = (0, 0);				# runtime in seconds
	my ($rsaveB, $bpassB) = (0, 0);				# runtime in percent

	for my $year (2014 .. 2024) {
		$lyearf .= "<option value=\"$year\"".(($year == $yearf)?" selected=\"selected\"":"").">$year</option>";
		$lyeart .= "<option value=\"$year\"".(($year == $yeart)?" selected=\"selected\"":"").">$year</option>";
	}
	for my $month (1 .. 12) {
		$lmonthf .= "<option value=\"$month\"".(($month == $monthf)?" selected=\"selected\"":"").">".$monthtxt[($month - 1)]."</option>";
		$lmontht .= "<option value=\"$month\"".(($month == $montht)?" selected=\"selected\"":"").">".$monthtxt[($month - 1)]."</option>";
	}
	for my $day (1 .. 31) {
		$ldayf .= "<option value=\"$day\"".(($day == $dayf)?" selected=\"selected\"":"").">$day</option>";
		$ldayt .= "<option value=\"$day\"".(($day == $dayt)?" selected=\"selected\"":"").">$day</option>";
	}
	my $datef = sprintf("%04d%02d%02d000000", $yearf, $monthf, $dayf);
	my $datet = sprintf("%04d%02d%02d235959", $yeart, $montht, $dayt);
	my ($udatef, $udatet) = (0, 0);

	{	# calc of date period
		my $all = $db->selectall_arrayref("SELECT UNIX_TIMESTAMP($datef), UNIX_TIMESTAMP($datet)");
		foreach my $row (@$all) {
			if (@$row[0] < @$row[1]) {
				($udatef, $udatet) = (@$row[0], @$row[1]);
			} else {
				($udatef, $udatet) = (@$row[1], @$row[0]);		# fool check ))
			}
		}
		undef $all;
		$totdays = BreakSec($udatet - $udatef);
	}

	{
		# retrosave / bypass stats TDB

		$rsaveA = BreakSec($rrsave);
		$bpassA = BreakSec($rbpass);
	}

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--totaldays--/$totdays/g;
		$inline =~ s/--retrosave_A--/$rsaveA/g;
		$inline =~ s/--bypass_A--/$bpassA/g;
		$inline =~ s/--retrosave_B--/$rsaveB/g;
		$inline =~ s/--bypass_B--/$bpassB/g;
		$inline =~ s/--year_f--/$lyearf/g;
		$inline =~ s/--year_t--/$lyeart/g;
		$inline =~ s/--month_f--/$lmonthf/g;
		$inline =~ s/--month_t--/$lmontht/g;
		$inline =~ s/--day_f--/$ldayf/g;
		$inline =~ s/--day_t--/$ldayt/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# hvac runtime report

if (($uimode eq "reports") && ($uismode eq "runtime") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my $yearf = (exists $FORM{year_f})?$FORM{year_f}:$curyear;
	my $yeart = (exists $FORM{year_t})?$FORM{year_t}:$curyear;
	my $monthf = (exists $FORM{month_f})?$FORM{month_f}:$curmon;
	my $montht = (exists $FORM{month_t})?$FORM{month_t}:$curmon;
	my $dayf = (exists $FORM{day_f})?$FORM{day_f}:$curday;
	my $dayt = (exists $FORM{day_t})?$FORM{day_t}:$curday;
	my ($lyearf, $lyeart, $lmonthf, $lmontht, $ldayf, $ldayt) = ("", "", "", "", "", "");
	my ($totdays) = ("");
	my @rhvac = ("", "", "", "", "", "", "");						# hum, w1, w2, y1, y2, g, ob
	my @rrhvac = (0, 0, 0, 0, 0, 0, 0);
	my @rphvac = (0, 0, 0, 0, 0, 0, 0);

	for my $year (2014 .. 2024) {
		$lyearf .= "<option value=\"$year\"".(($year == $yearf)?" selected=\"selected\"":"").">$year</option>";
		$lyeart .= "<option value=\"$year\"".(($year == $yeart)?" selected=\"selected\"":"").">$year</option>";
	}
	for my $month (1 .. 12) {
		$lmonthf .= "<option value=\"$month\"".(($month == $monthf)?" selected=\"selected\"":"").">".$monthtxt[($month - 1)]."</option>";
		$lmontht .= "<option value=\"$month\"".(($month == $montht)?" selected=\"selected\"":"").">".$monthtxt[($month - 1)]."</option>";
	}
	for my $day (1 .. 31) {
		$ldayf .= "<option value=\"$day\"".(($day == $dayf)?" selected=\"selected\"":"").">$day</option>";
		$ldayt .= "<option value=\"$day\"".(($day == $dayt)?" selected=\"selected\"":"").">$day</option>";
	}
	my $datef = sprintf("%04d%02d%02d000000", $yearf, $monthf, $dayf);
	my $datet = sprintf("%04d%02d%02d235959", $yeart, $montht, $dayt);
	my ($udatef, $udatet) = (0, 0);

	{	# calc of date period
		my $all = $db->selectall_arrayref("SELECT UNIX_TIMESTAMP($datef), UNIX_TIMESTAMP($datet)");
		foreach my $row (@$all) {
			if (@$row[0] < @$row[1]) {
				($udatef, $udatet) = (@$row[0], @$row[1]);
			} else {
				($udatef, $udatet) = (@$row[1], @$row[0]);		# fool check ))
			}
		}
		undef $all;
		$totdays = BreakSec($udatet - $udatef);
	}

	{
		# hardware stats TBD

		for my $irhvac (0 .. $#rhvac) {
			$rhvac[$irhvac] = BreakSec($rrhvac[$irhvac]);
		}
	}

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--totaldays--/$totdays/g;
		$inline =~ s/--humidifier_A--/$rhvac[0]/g;
		$inline =~ s/--w1_A--/$rhvac[1]/g;
		$inline =~ s/--w2_A--/$rhvac[2]/g;
		$inline =~ s/--y1_A--/$rhvac[3]/g;
		$inline =~ s/--y2_A--/$rhvac[4]/g;
		$inline =~ s/--g_A--/$rhvac[5]/g;
		$inline =~ s/--ob_A--/$rhvac[6]/g;
		$inline =~ s/--humidifier_B--/$rphvac[0]/g;
		$inline =~ s/--w1_B--/$rphvac[1]/g;
		$inline =~ s/--w2_B--/$rphvac[2]/g;
		$inline =~ s/--y1_B--/$rphvac[3]/g;
		$inline =~ s/--y2_B--/$rphvac[4]/g;
		$inline =~ s/--g_B--/$rphvac[5]/g;
		$inline =~ s/--ob_B--/$rphvac[6]/g;
		$inline =~ s/--year_f--/$lyearf/g;
		$inline =~ s/--year_t--/$lyeart/g;
		$inline =~ s/--month_f--/$lmonthf/g;
		$inline =~ s/--month_t--/$lmontht/g;
		$inline =~ s/--day_f--/$ldayf/g;
		$inline =~ s/--day_t--/$ldayt/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# retrosave and bypass runtime report

if (($uimode eq "reports") && ($uismode eq "savings") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my $yearf = (exists $FORM{year_f})?$FORM{year_f}:$curyear;
	my $yeart = (exists $FORM{year_t})?$FORM{year_t}:$curyear;
	my $monthf = (exists $FORM{month_f})?$FORM{month_f}:$curmon;
	my $montht = (exists $FORM{month_t})?$FORM{month_t}:$curmon;
	my $dayf = (exists $FORM{day_f})?$FORM{day_f}:$curday;
	my $dayt = (exists $FORM{day_t})?$FORM{day_t}:$curday;
	my ($lyearf, $lyeart, $lmonthf, $lmontht, $ldayf, $ldayt) = ("", "", "", "", "", "");
	my ($elused, $elsaved) = ("", "");
	my ($relused, $relsaved) = (0, 0);				# electricity in Watt

	for my $year (2014 .. 2024) {
		$lyearf .= "<option value=\"$year\"".(($year == $yearf)?" selected=\"selected\"":"").">$year</option>";
		$lyeart .= "<option value=\"$year\"".(($year == $yeart)?" selected=\"selected\"":"").">$year</option>";
	}
	for my $month (1 .. 12) {
		$lmonthf .= "<option value=\"$month\"".(($month == $monthf)?" selected=\"selected\"":"").">".$monthtxt[($month - 1)]."</option>";
		$lmontht .= "<option value=\"$month\"".(($month == $montht)?" selected=\"selected\"":"").">".$monthtxt[($month - 1)]."</option>";
	}
	for my $day (1 .. 31) {
		$ldayf .= "<option value=\"$day\"".(($day == $dayf)?" selected=\"selected\"":"").">$day</option>";
		$ldayt .= "<option value=\"$day\"".(($day == $dayt)?" selected=\"selected\"":"").">$day</option>";
	}
	my $datef = sprintf("%04d%02d%02d000000", $yearf, $monthf, $dayf);
	my $datet = sprintf("%04d%02d%02d235959", $yeart, $montht, $dayt);

	{
		# electricity stats TDB

		$elused = sprintf("%.1f", $relused);
		$elsaved = sprintf("%.1f", $relsaved);
	}

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--el_used--/$elused/g;
		$inline =~ s/--el_saved--/$elsaved/g;
		$inline =~ s/--year_f--/$lyearf/g;
		$inline =~ s/--year_t--/$lyeart/g;
		$inline =~ s/--month_f--/$lmonthf/g;
		$inline =~ s/--month_t--/$lmontht/g;
		$inline =~ s/--day_f--/$ldayf/g;
		$inline =~ s/--day_t--/$ldayt/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$inline =~ s/--usermode--/$usermode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# logout from system

if (($uimode eq "logout") && ($uismode eq "logout") && ($uaccess >= $alevel{$uimode.$uismode})) {
	($password, $uimode, $uismode) = ("", "", "", "");
	$exitstatus = 2;
}

# login page

if (($uimode eq "") && ($uismode eq "")) {
	my $fut_time = gmtime(time() - 3600)." GMT";  # make time expired
	my $cookie = "icsession2014=; path=/; expires=$fut_time;";
	print "Set-Cookie: " . $cookie . "\n";
	$cookie = "usermode2014=; path=/; expires=$fut_time;";
	print "Set-Cookie: " . $cookie . "\n";

	if (-e $loginweb) {
		my $logmsg = "";
		if ($exitstatus == 0) {					# opened by mistake?
		} elsif ($exitstatus == 1) {				# wrong login/password
			$logmsg = "Wrong credentials! Please retry.";
			$cookie = "icuser2014=; path=/; expires=$fut_time;";
			print "Set-Cookie: " . $cookie . "\n";
		} elsif ($exitstatus == 2) {				# logout
			$logmsg = "Good bye.";
		} elsif ($exitstatus == 7) {				# DB error
			$logmsg = "Cannon connect local Database";
		}
		my $savelogin = ($saveduser ne "")?" checked":"";
		$username = ($saveduser ne "")?$saveduser:"";
		print "Content-type: text/html\n\n";
		open(INF,$loginweb);
		while (<INF>) {
			my $inline = $_;
			chomp ($inline);
			$inline =~ s/--logmessage--/$logmsg/g;
			$inline =~ s/--username--/$username/g;
			$inline =~ s/--password--/$password/g;
			$inline =~ s/--savelogin--/$savelogin/g;
			$inline =~ s/--version--/$version/g;
			print $inline."\n";
		}
		close(INF);
	} else {
		print "Content-type: text/html\n\n";
		print "<HEAD>\n";
		print "<META HTTP-EQUIV=REFRESH CONTENT=\"0;URL=$loffweb\">\n";
		print "</HEAD>\n";
	}

	$db->disconnect();
	exit;
}

# print out page

print "Content-type: text/html\n\n";
open(INF,$templateweb);
while (<INF>) {
	my $inline = $_;
	chomp ($inline);
	$inline =~ s/--mainmenu--/$mainmenu/g;
	$inline =~ s/--submenu--/$submenu/g;
	$inline =~ s/--contents--/$contents/g;
	$inline =~ s/--title--/$pagetitle/g;
	$inline =~ s/--version--/$version/g;
	$inline =~ s/--debug--/$debug/g;
	$inline =~ s/--bodyadd--/$bodyadd/g;
	$inline =~ s/--headadd--/$headadd/g;
	print $inline."\n";
}
close(INF);

# exit

$db->disconnect();
exit;

# Quick sync script + submit query

sub dbdo {
	my $query = $_[0];
	my $prio = $_[1] + 0;
	$db->do($query);
#	$db->do("INSERT INTO sync_db VALUES (0, NOW(), $prio, 0, \"$query\")");		# outdated method of replication
	return 1;
}

# nice second representation

sub BreakSec {
	my $seconds = $_[0] + 0;
	my $rsday = floor($seconds / 86400);
	my $rshour = floor($seconds / 3600) - ($rsday * 24);
	my $rsmin = floor($seconds / 60) - ($rsday * 24 * 60) - ($rshour * 60);
	my $brtime = sprintf("%d day %02d hour %02d minute", $rsday, $rshour, $rsmin);
	return $brtime;
}

# temperature conversion

sub ttproper {
	my $outtemp = "N/A";
	unless ($_[0] eq "") {
		if ($tdisp == 0) {
			$outtemp = sprintf("%.1f", $_[0])."&deg;C";
		} else {
			$outtemp = sprintf("%.1f", cel2fah($_[0]))."&deg;F";
		}
	}
	return $outtemp;
}

sub cel2fah {
	my $fah = (9 * $_[0] / 5) + 32;
	return $fah;
}

sub fah2cel {
	my $cel = ($_[0] - 32) * 5 / 9;
	return $cel;
}

7;
