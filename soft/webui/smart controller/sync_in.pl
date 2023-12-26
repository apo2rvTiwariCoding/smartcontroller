#!/usr/bin/perl

use DBI;
use POSIX;
use Digest::MD5 qw(md5 md5_hex md5_base64);
use Time::Local;
use LWP::UserAgent;
use strict;
use Log::Log4perl qw(:easy);

# get server data

if ($0 =~ /^(.*\/)[^\/]+$/) {
        chdir($1);
}
my $selfpath = "./";

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

my $version = (exists $config{version})?$config{version}:"14.8.4p";
my $debugmode = (exists $config{debug})?$config{debug}:0;		# simulation mode off by default
my $advmode = (exists $config{advanced})?$config{advanced}:1;		# corrections allowed
my $logpath = (exists $config{logpath})?$config{logpath}:"./";		# path for storing logs and private files
my $logfile = $logpath."cloud_sync_in.log";

# init logger

Log::Log4perl->easy_init($DEBUG);
Log::Log4perl->easy_init( { level => $DEBUG,
	file    => ">>$logfile" } );
my $logger = get_logger("Bar::Twix");

# hardcoded constants and moar

my $authsalt = "retro2014";

# connect to mysql

my $dsn = 'DBI:mysql:'.$config{dbname}.":".((exists $config{dbhost})?$config{dbhost}:"localhost");
my $db_user_name = $config{dbuser};
my $db_password = $config{dbpass};
my $db = DBI->connect($dsn, $db_user_name, $db_password);
if (! $db) {
	prdate("Cannot connect to database");
	exit;
}

# read system config

my %HVAC = ();
{
	my $all = $db->selectall_arrayref("SELECT option_,value_ FROM hvac WHERE submenu > 0");		# read HVAC config for system only
	foreach my $row (@$all) {
		my ($opt, $val) = @$row;
		$HVAC{$opt} = $val;
	}
}
my ($clouda, $cloudb) = ("", "");
{
	my $all = $db->selectall_arrayref("SELECT cloud1, cloud2 FROM networks LIMIT 1");		# read only cloud names
	foreach my $row (@$all) {
		($clouda, $cloudb) = @$row;
	}
}
my $swversion = (exists $HVAC{"system.sw_version"})?$HVAC{"system.sw_version"}:$version;

# Retrieve changes from cloud

if ($HVAC{"system.description"} ne "") {
	my $userhash = md5_hex($HVAC{"system.description"}.$authsalt);
	my $mech = LWP::UserAgent->new;
	$mech->timeout(10);
	$mech->agent('Mozilla/5.0');
	my $acloud = $clouda;
	my $url = "https://".$clouda."/sync.pl";
	prdate("Taking data from primary $url");
	my $res = $mech->post($url, 
		{ "action" => "receive",
		  "version" => $swversion,
		  "system" => "$userhash" }
	);
	unless ($res->is_success) {
		$acloud = $cloudb;
		$url = "https://".$cloudb."/sync.pl";
		prdate("Error. Taking data from secondary $url");
		$res = $mech->post($url, 
			{ "action" => "retrieve",
			  "version" => $swversion,
			  "system" => $userhash }
		);
		unless ($res->is_success) {
			prdate("Error. Exit");
			exit;
		}
	}
	my $pagedata = $res->content;
	if ($pagedata =~ m/^error/) {
		chomp($pagedata);
		prdate($pagedata);
		exit;
	} else {
		$db->do("UPDATE smartstatus SET value='$acloud' WHERE group_='network' AND name='cloud'");
	}
	my ($syncnt, $mintime, $maxtime) = (0, 0, 0);
	my @plines = split(/\n/,$pagedata);
	foreach my $line (@plines) {
		$line =~ s/\v//g;
		if ($line =~ m/^(\d+)$/) {		# sync lines count
			my $retcnt = $1;
			prdate("Sync finished for period $mintime - $maxtime. $retcnt received. $syncnt synced");
			last;
		} elsif ($line ne "") {
			my @items = split(/\t/,$line);
			my $dbname = $items[0];
			my $dbtime = $items[1];
			$maxtime = ($dbtime > $maxtime)?$dbtime:$maxtime;
			$mintime = ($dbtime < $mintime)?$dbtime:(($mintime == 0)?$dbtime:$mintime);
			my $dbact = $items[2] + 0;
			my $dbidn = $items[3];
			my $dbidv = $items[4];
			$db->do('SET @DISABLE_TRIGGER_'.$dbname."=1");			# disable table trigger
			if (($dbact == 2) || ($dbact == 3)) {				# delete or update
				$db->do("DELETE FROM $dbname WHERE $dbidn = $dbidv");
#				print "DELETE FROM $dbname WHERE $dbidn = $dbidv\n";
			}
			if (($dbact == 1) || ($dbact == 2)) {				# insert or update
				my $insval = "'".$items[5]."'";
				for my $itcnt (6 .. $#items) {
					my $iival = $items[$itcnt];
					if ($iival eq "'NULL'") {
						$insval .= ",NULL";
					} elsif ($iival eq "''") {
						$insval .= ",''";
					} else {
						$insval .= ",'$iival'";
					}
				}
				$db->do("INSERT INTO $dbname VALUES($insval)");
#				print "INSERT INTO $dbname VALUES($insval)\n";
			}
			$db->do('SET @DISABLE_TRIGGER_'.$dbname."=NULL");		# enable table trigger
			$syncnt++;
		}
	}
	if ($syncnt > 0) {				# confirm sync if records exists
		my $dperiod = $mintime."\t".$maxtime;
		$res = $mech->post($url, 
			{ "action" => "confirm",
			  "version" => $swversion,
			  "system" => $userhash,
			  "confirmation" => $dperiod }
		);
		unless ($res->is_success) {
			prdate("Confirm error. Exit");
			exit;
		} else {
			my $pagedata = $res->content;
			if ($pagedata =~ m/^error/) {
				chomp($pagedata);
				prdate($pagedata);
			}
		}
	}
} else {
	prdate("No password set. Exit");
}

# exit

$db->disconnect();
exit;

sub prdate {
	my $logtxt = $_[0];
	$logger->debug($logtxt);
#	my $logtxt = $_[0]."\n";
#	my ($nusec,$numin,$nuhour,$nuday,$numon,$nuyear) = (localtime)[0,1,2,3,4,5];
#	my $nucreat = sprintf("%04d-%02d-%02d %02d:%02d:%02d",($nuyear + 1900),($numon + 1),$nuday,$nuhour,$numin,$nusec);
#	print $nucreat." - ".$logtxt;
#	open(LOG,">>$logfile");
#	print LOG $nucreat." - ".$logtxt;
#	close(LOG);
#	return $nucreat;
}

7;
