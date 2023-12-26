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
my $logfile = $logpath."cloud_sync_out.log";

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

# Send changes to cloud

if ($HVAC{"system.description"} ne "") {
	my $all = $db->selectall_arrayref("SELECT (timemark + 0), table_name, pk_date_dest, record_state FROM history_store WHERE record_state < 100 ORDER BY timemark");
	my $records = 0;
	my $syncdata = "";
	foreach my $row (@$all) {
		my ($rtime, $rtab, $rid, $rst) = @$row;
		my ($rcol, $rcid, $rprn) = ("", "", "");
		if ($rid =~ m/^\<(.+)\>(\d+)\</) {
			$rcol = $1;
			$rcid = $2;
			$rprn = $rtab."\t".$rtime."\t".$rst."\t".$rcol."\t".$rcid;
			if (($rst == 1) || ($rst == 2)) {
				my $rcc = $db->selectall_arrayref("SELECT * FROM $rtab WHERE $rcol = $rcid");
				foreach my $rcrow (@$rcc) {
					foreach my $rctab (@$rcrow) {
						if (!defined($rctab)) {
							$rprn .= "\t'NULL'";
						} elsif (!length($rctab)) {
							$rprn .= "\t''";
						} else {
							$rprn .= "\t".$rctab;
						}
					}
				}
			}
			$syncdata .= $rprn."\n";
		}
		$records++;
	}
	$syncdata .= $records."\n";
#	print $syncdata;
	undef $all;

	my $acloud = $clouda;
	my $userhash = md5_hex($HVAC{"system.description"}.$authsalt);
	my $mech = LWP::UserAgent->new;
	$mech->timeout(10);
	$mech->agent('Mozilla/5.0');
	my $url = "https://".$clouda."/sync.pl";
	prdate("Sending data to primary $url");
	my $res = $mech->post($url, 
		{ "action" => "place",
		  "version" => $swversion,
		  "system" => $userhash,
		  "syncdata" => $syncdata }
	);
	unless ($res->is_success) {
		$acloud = $cloudb;
		$url = "https://".$cloudb."/sync.pl";
		prdate("Error. Taking data from secondary $url");
		$res = $mech->post($url, 
			{ "action" => "place",
			  "version" => $swversion,
			  "system" => $userhash,
			  "syncdata" => $syncdata }
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
	} elsif ($pagedata =~ m/^success/) {
		$db->do("UPDATE smartstatus SET value='$acloud' WHERE group_='network' AND name='cloud'");
		my @sucln = split(/\n/, $pagedata);
		my ($datefrom, $dateto, $retcnt, $syncnt) = split(/\t/, $sucln[1]);
		if ((($retcnt > 0) || ($syncnt > 0)) && ($datefrom > 0) && ($dateto > 0)) {
			$db->do("INSERT INTO history_store_old SELECT * FROM history_store WHERE timemark BETWEEN $datefrom AND $dateto");
			$db->do("DELETE FROM history_store WHERE timemark BETWEEN $datefrom AND $dateto");
		}
		prdate("Sync done. Period $datefrom - $dateto . $syncnt requested , $retcnt synced.");
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
