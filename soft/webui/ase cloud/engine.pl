#!c:/perl/bin/perl.exe
#!c:/xampp/perl/bin/perl.exe
#!/usr/bin/perl

use DBI;
use POSIX;
use Digest::MD5 qw(md5 md5_hex md5_base64);
use Time::Local;
use strict;

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
		$forlog .= "$curdatetime : $name - $value\n";
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

my $version = (exists $config{version})?$config{version}:"14.10.24p";
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
foreach my $cookie (@cookies) {
	if ($cookie =~ "cloudsession2014") {
		($cookname,$sessid) = split(/\=/,$cookie);
	}
	if ($cookie =~ "clouduser2014") {
		($cookname,$saveduser) = split(/\=/,$cookie);
	}
	if ($cookie =~ "cloudmode2014") {
		($cookname,$cusermode) = split(/\=/,$cookie);
	}
}
my $signtime = 60;		# time in minutes to stay logged in
my $contents = "";
my $bodyadd = "";
my $headadd = "";
my $debug = "";
my $message = "";
my $servname = $ENV{'SERVER_NAME'};
my $servport = $ENV{'SERVER_PORT'};
unless (($servport eq "80") || ($servport eq "443")) {
	$servname .= ":".$servport;
}
my $servprot = ($ENV{'HTTPS'} eq "on")?"https":"http";
my $foldname = "";
if ($ENV{'SCRIPT_NAME'} =~ /^\/(.+\/)*(.+)\.(.+)$/) {
	$foldname = $1;	
}
$forlog .= "$curdatetime : $clientip - $clientie\n";
my $connweb = $servprot."://".$servname."/connector/engine.pl";

# connect to mysql
 
my $dsn = 'DBI:mysql:'.$config{dbname}.":".$config{dbhost};
my $db_user_name = $config{dbuser};
my $db_password = $config{dbpass};
my $db = DBI->connect($dsn, $db_user_name, $db_password);
if (! $db) {
	($username, $password, $FORM{mode}, $FORM{submode}) = ("", "", "", "");
	$exitstatus = 7;
}

# get mode and action

my $savelogin = ($FORM{save_login} eq "yes")?"yes":"no";
my $uimode = (exists $FORM{mode})?$FORM{mode}:"";
my $uismode = (exists $FORM{submode})?$FORM{submode}:"";
my $action = (exists $FORM{action})?$FORM{action}:"";

# Session creator

my $clientid = -1;
my $clientacc = 0;
my $tempdbid = 0;
if (($username ne "") && ($password ne "") && ($submeth eq "post") && ($action eq "login")) {
	if ($username =~ m/^(.+)\@(\d+)$/) {							# check if domain entered
		my $rusername = $1;				# remote user
		my $homeid = sprintf("%05d",$2);	# remote homeID
		my $rdsn = "DBI:mysql:smart".$homeid.":".$config{dbhost};
		my $rdbuser = "dbuser".$homeid;
		my $rdbpass = "dbpass".$homeid;
		my $rdb = DBI->connect($rdsn, $rdbuser, $rdbpass);
		if (! $rdb) {
			($username, $password, $FORM{mode}, $FORM{submode}) = ("", "", "", "");
			$exitstatus = 7;
		} else {
			my $sth = $rdb->prepare("SELECT id,access,login FROM users WHERE login='$rusername' and password='$password'");
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
				$rdb->do("INSERT INTO sessions VALUES(NULL,$clientid,'$userhash',now(),date_add(now(),interval $signtime minute),$clientacc,0)");
				my $sth = $rdb->prepare("SELECT last_insert_id() FROM sessions");
				$sth->execute;
				($sessid) = $sth->fetchrow_array();
				$sth->finish;
			} else {
				$exitstatus = 1;
			}

			my $fut_time = gmtime(time() + (60 * 60 * 24 * 30))." GMT";  	# cookie expires in 30 days
			my $cookie = "icsession2014=$sessid; path=/; expires=$fut_time;";
			print "Set-Cookie: " . $cookie . "\n";
			$cookie = "ichomeid2014=$homeid; path=/; expires=$fut_time;";
			print "Set-Cookie: " . $cookie . "\n";

			print "Content-type: text/html\n\n";
			print "<HEAD>\n";
			print "<META HTTP-EQUIV=REFRESH CONTENT=\"0;URL=$connweb\">\n";
			print "</HEAD>\n";
			$rdb->disconnect();
			$db->disconnect();
			exit;
		}
	} else {
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
		} else {
			$exitstatus = 1;
		}

		my $fut_time = gmtime(time() + (60 * 60 * 24 * 30))." GMT";  	# cookie expires in 30 days
		my $cookie = "cloudsession2014=$sessid; path=/; expires=$fut_time;";
		print "Set-Cookie: " . $cookie . "\n";
		if (exists $FORM{savelogin}) {
			$cookie = "clouduser2014=$username; path=/; expires=$fut_time;";
			print "Set-Cookie: " . $cookie . "\n";
		}
	}
}

# Session checker

my $ulogin = "";
my $uaccess = 0;
my $sessionnow = 0;
my $sth = $db->prepare("SELECT id_session,id_client,type,dbid FROM sessions WHERE id_session=$sessid AND hash='$userhash' AND expires>NOW()");
$sth->execute;
unless ($sth->rows == 0) {
	my ($sessid,$clid,$clientacc,$odbid) = $sth->fetchrow_array();
	$sth->finish;
	$db->do("UPDATE sessions SET expires=DATE_ADD(expires,INTERVAL $signtime MINUTE) WHERE id_session=$sessid");
	$sessionnow = $sessid;

	$sth = $db->prepare("select login,access from users where id=$clid");
	$sth->execute;
	unless ($sth->rows == 0) {
		my ($login,$access) = $sth->fetchrow_array();
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
	}
	$sth->finish;
} else {
	$clientid = -1;
	$sth->finish;
}

if ($clientid < 0) {
	($password, $uimode, $uismode) = ("", "", "");
	unless ($exitstatus > 0) {
		$exitstatus = 3;
	}
}
if (($clientid >= 0) && (($uimode eq "") || ($uismode eq ""))) {
	($uimode, $uismode) = ("systems", "retrosave");			# default page after login
}

# read config for cloud

my %HVAC = ();
{
	my $all = $db->selectall_arrayref("SELECT option_,value_ FROM cloud WHERE submenu > 0");		# read HVAC config for system only
	foreach my $row (@$all) {
		my ($opt, $val) = @$row;
		$HVAC{$opt} = $val;
	}
}

# menu & submenu processing

my $mainmenu = "";
my $submenu = "";
my $pagetitle = "ASE 2014 Web Cloud ";
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
	$sth->finish;
}

# database maintenance page

if (($uimode eq "systems") && ($uismode eq "settings") && ($uaccess >= $alevel{$uimode.$uismode})) {
	my $syncmin = (exists $HVAC{"system.sync_min"})?$HVAC{"system.sync_min"}:1;
	my $syncpref = (exists $HVAC{"system.sync_pref"})?$HVAC{"system.sync_pref"}:0;
	my @tsyncpref = ("", "");

	if (($action eq "save") && (exists $FORM{sync_min}) && (exists $FORM{sync_pref})) {
		my $newsyncpref = $FORM{sync_pref} + 0;
		if ($syncpref != $newsyncpref) {
			$syncpref = $newsyncpref;
			$db->do("UPDATE cloud SET value_ = $syncpref WHERE option_ = 'system.sync_pref';");
		}
		my $newsyncmin = $FORM{sync_min} + 0;
		if (($syncmin != $newsyncmin) && ($newsyncmin > 0)) {
			$syncmin = $newsyncmin;
			$db->do("UPDATE cloud SET value_ = $syncmin WHERE option_ = 'system.sync_min';");
		}
	}
	$tsyncpref[$syncpref] = " checked=\"checked\"";

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--sync_min--/$syncmin/g;
		$inline =~ s/--sync_pref0--/$tsyncpref[0]/g;
		$inline =~ s/--sync_pref1--/$tsyncpref[1]/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
		$contents .= $inline."\n";
	}
	close(INF);
}

# access password

if (($uimode eq "systems") && ($uismode eq "retrosave") && ($uaccess >= $alevel{$uimode.$uismode})) {
	if ($action eq "unreg") {
		my $homeid = $FORM{homeid} + 0;
		my $rdbid = sprintf("smart%05d", $homeid);
		$db->do("DROP DATABASE IF EXISTS $rdbid");
		$db->do("DELETE FROM systems WHERE house_id = $homeid");
                $action = "view";
	}
        if ($action eq "connect") {
		my $homeid = sprintf("%05d",$FORM{homeid});	# remote homeID
		my $rdsn = "DBI:mysql:smart".$homeid.":".$config{dbhost};
		my $rdbuser = "dbuser".$homeid;
		my $rdbpass = "dbpass".$homeid;
		my ($rclientid, $rclientacc) = (-1, -1);
		my $rdb = DBI->connect($rdsn, $rdbuser, $rdbpass);
		if ($rdb) {
			my $sth = $rdb->prepare("SELECT id, access FROM users ORDER BY access DESC LIMIT 1");
			$sth->execute;
			unless ($sth->rows == 0) {
				my ($id, $access) = $sth->fetchrow_array();
				if ($access >= 1) {					# use admin only
					$rclientid = $id;
					$rclientacc = $access;
				}
				$sth->finish;
			} else {
				$sth->finish;
			}

			if ($clientid >= 0) {
				$rdb->do("INSERT INTO sessions VALUES(NULL,$rclientid,'$userhash',now(),date_add(now(),interval $signtime minute),$rclientacc,0)");
				my $sth = $rdb->prepare("SELECT last_insert_id() FROM sessions");
				$sth->execute;
				($sessid) = $sth->fetchrow_array();
				$sth->finish;

				my $fut_time = gmtime(time() + (60 * 60 * 24 * 30))." GMT";  	# cookie expires in 30 days
				my $cookie = "icsession2014=$sessid; path=/; expires=$fut_time;";
				print "Set-Cookie: " . $cookie . "\n";
				$cookie = "ichomeid2014=$homeid; path=/; expires=$fut_time;";
				print "Set-Cookie: " . $cookie . "\n";

				print "Content-type: text/html\n\n";
				print "<HEAD>\n";
				print "<META HTTP-EQUIV=REFRESH CONTENT=\"0;URL=".$connweb."?mode=status&submode=system\">\n";
				print "</HEAD>\n";
				$rdb->disconnect();
				$db->disconnect();
				exit;
			}
		}
		$action = "view";
        }

	my $homelist = "";
	my $all = $db->selectall_arrayref("SELECT house_id, version, connected, description FROM systems ORDER BY id");
	foreach my $row (@$all) {
		my $homeid = sprintf("%05d",@$row[0]);
		my $homedesc = @$row[3];
		my $homever = @$row[1];
		my $homeconn = @$row[2];
		$homelist .= "<tr><td nowrap=\"nowrap\" width=100>Home ID:</td>
			<td class=\"stdbold\" width=\"120\">$homeid</td>
			<td nowrap=\"nowrap\" width=\"240\" class=\"stdbold\" >$homedesc&nbsp;</td></tr>
			<tr><td nowrap=\"nowrap\" width=\"100\">Firmware Version:</td>
			<td class=\"stdbold\" width=\"120\">0.$homever</td>
			<td nowrap=\"nowrap\" rowspan=2 valign=center align=left><input name=\"connect\" value=\"Connect Cloud Database\" onClick=\"window.location.href='./engine.pl?mode=systems&submode=retrosave&action=connect&homeid=$homeid';\" type=\"button\">&nbsp;&nbsp;&nbsp;<input name=\"unreg\" value=\"Unregister\" onClick=\"UnregSys($homeid);\" type=\"button\"></td></tr>
			<tr><td nowrap=\"nowrap\" width=\"100\">Last accessed:</td>
			<td class=\"stdbold\" width=\"120\">$homeconn</td></tr> 
			<tr><td nowrap=\"nowrap\" colspan=2><div class=in10></div></td></tr>\n";
	}
	$sth->finish;
	undef $all;
	if ($homelist eq "") {
		$homelist .= "<tr><td nowrap=\"nowrap\" width=460 class=\"stdbold\"><br>No Smart controllers registered with Cloud yet<br>&nbsp;</td></tr>
			<tr><td nowrap=\"nowrap\"><div class=in10></div></td></tr>\n";
	}

	$headadd .= <<EOF;
		<script language="JavaScript">
		function UnregSys(dbid) {
			var answer = confirm ("Action cleans ASE Cloud storage for controller\\n\\nAre you sure to de-register system with HomeID "+dbid+" ?");
			if (answer) {
				window.location = './engine.pl?mode=systems&submode=retrosave&action=unreg&homeid='+dbid;
			}
		}
		</script>
EOF

	my $pagename = $selfpath.$uimode."_".$uismode.".html";
	open(INF,$pagename);
	while (<INF>) {
		my $inline = $_;
		chomp ($inline);
		$inline =~ s/--homelist--/$homelist/g;
		$inline =~ s/--message--/$message/g;
		$inline =~ s/--mode--/$uimode/g;
		$inline =~ s/--submode--/$uismode/g;
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
			$sth->finish;
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
						$db->do("UPDATE users SET login='".$FORM{username}."' WHERE login='$ulogin' AND password='".$FORM{password_old}."'");
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
				$db->do("UPDATE users SET password='".$FORM{password_new}."' WHERE login='$ulogin' AND password='".$FORM{password_old}."'");
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
		$contents .= $inline."\n";
	}
	close(INF);
}

# personal details

if (($uimode eq "userinfo") && ($uismode eq "details") && ($uaccess >= $alevel{$uimode.$uismode})) {

	my %provinces = ("NONE", "Not Canada or USA", "CAN-AL", "Alberta", "CAN-BC", "British Columbia", "CAN-MT", "Manitoba", "CAN-NB", "New Brunswick", "CAN-NS", "Nova Scotia", "CAN-ON", "Ontario", "CAN-QB", "Quebec", "CAN-SS", "Saskatchewan", "CAN-PE", "Prince Edward Island", "CAN-NL", "Newfoundland and Labrador", "USA-AL", "Alabama", "USA-AK", "Alaska", "USA-AZ", "Arizona", "USA-AR", "Arkansas", "USA-CA", "California", "USA-CO", "Colorado", "USA-CT", "Connecticut", "USA-DE", "Delaware", "USA-FL", "Florida", "USA-GA", "Georgia", "USA-HI", "Hawaii", "USA-ID", "Idaho", "USA-IL", "Illinois", "USA-IN", "Indiana", "USA-IA", "Iowa", "USA-KS", "Kansas", "USA-KY", "Kentucky", "USA-LA", "Louisiana", "USA-ME", "Maine", "USA-MD", "Maryland", "USA-MA", "Massachusetts", "USA-MI", "Michigan", "USA-MN", "Minnesota", "USA-MS", "Mississippi", "USA-MO", "Missouri", "USA-MT", "Montana", "USA-NE", "Nebraska", "USA-NV", "Nevada", "USA-NH", "New Hampshire", "USA-NJ", "New Jersey", "USA-NM", "New Mexico", "USA-NY", "New York", "USA-NC", "North Carolina", "USA-ND", "North Dakota", "USA-OH", "Ohio", "USA-OK", "Oklahoma", "USA-OR", "Oregon", "USA-PA", "Pennsylvania", "USA-RI", "Rhode Island", "USA-SC", "South Carolina", "USA-SD", "South Dakota", "USA-TN", "Tennessee", "USA-TX", "Texas", "USA-UT", "Utah", "USA-VT", "Vermont", "USA-VA", "Virginia", "USA-WA", "Washington", "USA-WV", "West Virginia", "USA-WI", "Wisconsin", "USA-WY", "Wyoming");
	my %countries = ("Afghanistan", "Afghanistan", "Aland Islands", "Aland Islands", "Albania", "Albania", "Algeria", "Algeria", "American Samoa", "American Samoa", "Andorra", "Andorra", "Angola", "Angola", "Anguilla", "Anguilla", "Antarctica", "Antarctica", "Antigua and Barbuda", "Antigua and Barbuda", "Argentina", "Argentina", "Armenia", "Armenia", "Aruba", "Aruba", "Australia", "Australia", "Austria", "Austria", "Azerbaijan", "Azerbaijan", "Bahamas", "Bahamas", "Bahrain", "Bahrain", "Bangladesh", "Bangladesh", "Barbados", "Barbados", "Belarus", "Belarus", "Belgium", "Belgium", "Belize", "Belize", "Benin", "Benin", "Bermuda", "Bermuda", "Bhutan", "Bhutan", "Bolivia", "Bolivia", "Bosnia and Herzegovina", "Bosnia and Herzegovina", "Botswana", "Botswana", "Bouvet Island", "Bouvet Island", "Brazil", "Brazil", "British Indian Ocean Territory", "British Indian Ocean Territory", "Brunei Darussalam", "Brunei Darussalam", "Bulgaria", "Bulgaria", "Burkina Faso", "Burkina Faso", "Burundi", "Burundi", "Cambodia", "Cambodia", "Cameroon", "Cameroon", "Canada", "Canada", "Cape Verde", "Cape Verde", "Cayman Islands", "Cayman Islands", "Central African Republic", "Central African Republic", "Chad", "Chad", "Chile", "Chile", "China", "China", "Christmas Island", "Christmas Island", "Cocos (Keeling) Islands", "Cocos (Keeling) Islands", "Colombia", "Colombia", "Comoros", "Comoros", "Congo", "Congo", "Cook Islands", "Cook Islands", "Costa Rica", "Costa Rica", "Cote D'ivoire", "Cote D'ivoire", "Croatia", "Croatia", "Cuba", "Cuba", "Cyprus", "Cyprus", "Czech Republic", "Czech Republic", "Denmark", "Denmark", "Djibouti", "Djibouti", "Dominica", "Dominica", "Dominican Republic", "Dominican Republic", "Ecuador", "Ecuador", "Egypt", "Egypt", "El Salvador", "El Salvador", "Equatorial Guinea", "Equatorial Guinea", "Eritrea", "Eritrea", "Estonia", "Estonia", "Ethiopia", "Ethiopia", "Falkland Islands", "Falkland Islands (Malvinas)", "Faroe Islands", "Faroe Islands", "Fiji", "Fiji", "Finland", "Finland", "France", "France", "French Guiana", "French Guiana", "French Polynesia", "French Polynesia", "French Southern Territories", "French Southern Territories", "Gabon", "Gabon", "Gambia", "Gambia", "Georgia", "Georgia", "Germany", "Germany", "Ghana", "Ghana", "Gibraltar", "Gibraltar", "Greece", "Greece", "Greenland", "Greenland", "Grenada", "Grenada", "Guadeloupe", "Guadeloupe", "Guam", "Guam", "Guatemala", "Guatemala", "Guernsey", "Guernsey", "Guinea", "Guinea", "Guinea-bissau", "Guinea-bissau", "Guyana", "Guyana", "Haiti", "Haiti", "Heard Island", "Heard Island and Mcdonald Islands", "Holy See", "Holy See (Vatican City State)", "Honduras", "Honduras", "Hong Kong", "Hong Kong", "Hungary", "Hungary", "Iceland", "Iceland", "India", "India", "Indonesia", "Indonesia", "Iran", "Iran, Islamic Republic of", "Iraq", "Iraq", "Ireland", "Ireland", "Isle of Man", "Isle of Man", "Israel", "Israel", "Italy", "Italy", "Jamaica", "Jamaica", "Japan", "Japan", "Jersey", "Jersey", "Jordan", "Jordan", "Kazakhstan", "Kazakhstan", "Kenya", "Kenya", "Kiribati", "Kiribati", "Korea Democratic People Republic", "Korea, Democratic People's Republic of", "Korea Republic", "Korea, Republic of", "Kuwait", "Kuwait", "Kyrgyzstan", "Kyrgyzstan", "Laos", "Lao People's Democratic Republic", "Latvia", "Latvia", "Lebanon", "Lebanon", "Lesotho", "Lesotho", "Liberia", "Liberia", "Libyan Arab Jamahiriya", "Libyan Arab Jamahiriya", "Liechtenstein", "Liechtenstein", "Lithuania", "Lithuania", "Luxembourg", "Luxembourg", "Macao", "Macao", "Macedonia", "Macedonia, The Former Yugoslav Republic of", "Madagascar", "Madagascar", "Malawi", "Malawi", "Malaysia", "Malaysia", "Maldives", "Maldives", "Mali", "Mali", "Malta", "Malta", "Marshall Islands", "Marshall Islands", "Martinique", "Martinique", "Mauritania", "Mauritania", "Mauritius", "Mauritius", "Mayotte", "Mayotte", "Mexico", "Mexico", "Micronesia", "Micronesia, Federated States of", "Moldova", "Moldova, Republic of", "Monaco", "Monaco", "Mongolia", "Mongolia", "Montenegro", "Montenegro", "Montserrat", "Montserrat", "Morocco", "Morocco", "Mozambique", "Mozambique", "Myanmar", "Myanmar", "Namibia", "Namibia", "Nauru", "Nauru", "Nepal", "Nepal", "Netherlands", "Netherlands", "Netherlands Antilles", "Netherlands Antilles", "New Caledonia", "New Caledonia", "New Zealand", "New Zealand", "Nicaragua", "Nicaragua", "Niger", "Niger", "Nigeria", "Nigeria", "Niue", "Niue", "Norfolk Island", "Norfolk Island", "Northern Mariana Islands", "Northern Mariana Islands", "Norway", "Norway", "Oman", "Oman", "Pakistan", "Pakistan", "Palau", "Palau", "Palestinian Territory", "Palestinian Territory, Occupied", "Panama", "Panama", "Papua New Guinea", "Papua New Guinea", "Paraguay", "Paraguay", "Peru", "Peru", "Philippines", "Philippines", "Pitcairn", "Pitcairn", "Poland", "Poland", "Portugal", "Portugal", "Puerto Rico", "Puerto Rico", "Qatar", "Qatar", "Reunion", "Reunion", "Romania", "Romania", "Russian Federation", "Russian Federation", "Rwanda", "Rwanda", "Saint Helena", "Saint Helena", "Saint Kitts and Nevis", "Saint Kitts and Nevis", "Saint Lucia", "Saint Lucia", "Saint Pierre and Miquelon", "Saint Pierre and Miquelon", "Saint Vincent and The Grenadines", "Saint Vincent and The Grenadines", "Samoa", "Samoa", "San Marino", "San Marino", "Sao Tome and Principe", "Sao Tome and Principe", "Saudi Arabia", "Saudi Arabia", "Senegal", "Senegal", "Serbia", "Serbia", "Seychelles", "Seychelles", "Sierra Leone", "Sierra Leone", "Singapore", "Singapore", "Slovakia", "Slovakia", "Slovenia", "Slovenia", "Solomon Islands", "Solomon Islands", "Somalia", "Somalia", "South Africa", "South Africa", "South Georgia", "South Georgia and The South Sandwich Islands", "Spain", "Spain", "Sri Lanka", "Sri Lanka", "Sudan", "Sudan", "Suriname", "Suriname", "Svalbard and Jan Mayen", "Svalbard and Jan Mayen", "Swaziland", "Swaziland", "Sweden", "Sweden", "Switzerland", "Switzerland", "Syrian Arab Republic", "Syrian Arab Republic", "Taiwan", "Taiwan, Province of China", "Tajikistan", "Tajikistan", "Tanzania", "Tanzania, United Republic of", "Thailand", "Thailand", "Timor-leste", "Timor-leste", "Togo", "Togo", "Tokelau", "Tokelau", "Tonga", "Tonga", "Trinidad and Tobago", "Trinidad and Tobago", "Tunisia", "Tunisia", "Turkey", "Turkey", "Turkmenistan", "Turkmenistan", "Turks and Caicos Islands", "Turks and Caicos Islands", "Tuvalu", "Tuvalu", "Uganda", "Uganda", "Ukraine", "Ukraine", "United Arab Emirates", "United Arab Emirates", "United Kingdom", "United Kingdom", "United States", "United States", "United States Minor Outlying Islands", "United States Minor Outlying Islands", "Uruguay", "Uruguay", "Uzbekistan", "Uzbekistan", "Vanuatu", "Vanuatu", "Venezuela", "Venezuela", "Viet Nam", "Viet Nam", "Virgin Islands, British", "Virgin Islands, British", "Virgin Islands, U.S.", "Virgin Islands, U.S.", "Wallis and Futuna", "Wallis and Futuna", "Western Sahara", "Western Sahara", "Yemen", "Yemen", "Zambia", "Zambia", "Zimbabwe", "Zimbabwe");
	my @timezones = ("(GMT-12:00) International Date Line West", "(GMT-11:00) Mixxxay Island, Samoa", "(GMT-10:00) Hawaii", "(GMT-09:00) Alaska", "(GMT-08:00) Pacific Time (USA &amp; Canada)", "(GMT-07:00) Arizona", "(GMT-07:00) Mountain Time (USA &amp; Canada)", "(GMT-06:00) Central America", "(GMT-06:00) Central Time (USA &amp; Canada)", "(GMT-06:00) Guadalajara, Mexico City, Monterrey", "(GMT-06:00) Saskatchewan", "(GMT-05:00) Bogota, Lima, Quito", "(GMT-05:00) Eastern Time (USA &amp; Canada)", "(GMT-05:00) Indiana (East)", "(GMT-04:00) Atlantic Time (Canada)", "(GMT-04:00) Caracas, La Paz", "(GMT-04:00) Santiago", "(GMT-03:30) Newfoundland", "(GMT-03:00) Brasilia", "(GMT-03:00) Buenos Aires, Georgetown", "(GMT-03:00) Greenland", "(GMT-02:00) Mid-Atlantic", "(GMT-01:00) Azores", "(GMT-01:00) Cape Verde ls.", "(GMT) Casablanca, Monrovia", "(GMT) Greenwich Mean Time: Dublin, Edinburgh, Lisbon, London", "(GMT+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna", "(GMT+01:00) Belgrade, Bratislava, Budapest, Ljubljana, Prague", "(GMT+01:00) Brussels, Copenhagen, Madrid, Paris", "(GMT+01:00) Sarajevo, Skopje, Warsaw, Zagreb", "(GMT+01:00) West Central Africa", "(GMT+02:00) Athens, Istanbul, Minsk", "(GMT+02:00) Bucharest", "(GMT+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius", "(GMT+02:00) Jerusalem", "(GMT+03:00) Baghdad", "(GMT+03:00) Moscow, St. Petersburg, Volgograd", "(GMT+03:00) Nairobi", "(GMT+03:30) Tehran", "(GMT+04:00) Abu Dhabi, Muscat", "(GMT+04:30) Kabul", "(GMT+05:00) Ekaterinburg", "(GMT+05:30) Chennai, Kolkata, Mumbai, New Delhi", "(GMT+05:45) Kathmandu", "(GMT+06:00) Almaty, Novosibirsk", "(GMT+06:00) Astana, Dhaka", "(GMT+06:30) Rangoon", "(GMT+07:00) Bangkok, Hanoi, Jakarta", "(GMT+07:00) Krasnoyarsk", "(GMT+08:00) Beijing, Chongqing, Hong Kong, Urumqi", "(GMT+08:00) Irkutsk, Ulaan Bataar", "(GMT+08:00) Kuala Lumpur, Singapore", "(GMT+08:00) Taipei", "(GMT+09:00) Osaka, Sapporo, Tokyo", "(GMT+09:00) Seoul", "(GMT+09:30) Adelaide", "(GMT+10:00) Brisbane", "(GMT+10:00) Vladivostok", "(GMT+11:00) Magadan, Solomon Is., New Caledonia", "(GMT+12:00) Auckland, Wellington", "(GMT+12:00) Fiji, Kamchatka, Marshall Is.", "(GMT+13:00) Nuku'alofa");

	if (($action eq "save") && ($clientid > 0)) {
		$db->do("UPDATE users SET city='".$FORM{city}."', province='".$FORM{province}."', country='".$FORM{country}."', postal='".$FORM{postal}."', phone1='".$FORM{phone1}."', phone2='".$FORM{phone2}."', phone3='".$FORM{phone3}."', email='".$FORM{email}."', timezone='".($FORM{timezone} + 0)."', comfort='".($FORM{comfort} + 0)."', t_display='".($FORM{t_display} + 0)."', name1='".$FORM{name1}."', name2='".$FORM{name2}."', address1='".$FORM{address1}."', address2='".$FORM{address2}."' WHERE id = $clientid");
		if (($FORM{name1} eq "") || ($FORM{name2} eq "") || ($FORM{address1} eq "") || ($FORM{city} eq "") || ($FORM{postal} eq "") || ($FORM{email} eq "")) {
			$message = "<tr><td nowrap=\"nowrap\" width=\"138\">&nbsp;</td><td nowrap=\"nowrap\"><font color=red><br>One or more important fields must be filled!</td></tr>\n";
		}
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
	$sth->finish;
	undef $all;

	foreach my $iprovince (sort keys %provinces) {
		$lprovince .= "<option value=\"$iprovince\"".(($province eq $iprovince)?" selected=\"selected\"":"").">".$provinces{$iprovince}."</option>";
	}
	foreach my $icountry (sort keys %countries) {
		$lcountry .= "<option value=\"$icountry\"".(($country eq $icountry)?" selected=\"selected\"":"").">".$countries{$icountry}."</option>";
	}
	for my $itimezone (0 .. $#timezones) {
		$ltimezone .= "<option value=\"".$itimezone."\" ".(($itimezone == $timezone)?" selected=\"selected\"":"").">".$timezones[$itimezone]."</option>";
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
	my $cookie = "cloudsession2014=; path=/; expires=$fut_time;";
	print "Set-Cookie: " . $cookie . "\n";
	$cookie = "cloudmode2014=; path=/; expires=$fut_time;";
	print "Set-Cookie: " . $cookie . "\n";

	my $logmsg = "";
	if ($exitstatus == 0) {					# opened by mistake?
	} elsif ($exitstatus == 1) {				# wrong login/password
		$logmsg = "Wrong credentials! Please retry.";
		$cookie = "clouduser2014=; path=/; expires=$fut_time;";
		print "Set-Cookie: " . $cookie . "\n";
	} elsif ($exitstatus == 2) {				# logout
		$logmsg = "Good bye.";
	} elsif ($exitstatus == 3) {				# tips
		$logmsg = "Please use HomeID to login";
	} elsif ($exitstatus == 7) {				# DB error
		$logmsg = "Cannon connect Database";
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
7;
