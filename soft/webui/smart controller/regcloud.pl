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

# command line arguments :
#				tryreg	- default. try to register on cloud. stop if already registered or other error
#				restore	- restore database contents from the cloud
#				clean	- force database clear and register as new system

my $carg = lc($ARGV[0]);
if ($carg eq "") {
	$carg = "tryreg";
}

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

my $version = (exists $config{version})?$config{version}:"14.12.8p";
my $debugmode = (exists $config{debug})?$config{debug}:0;		# simulation mode off by default
my $advmode = (exists $config{advanced})?$config{advanced}:1;		# corrections allowed
my $logpath = (exists $config{logpath})?$config{logpath}:"./";		# path for storing logs and private files
my $logfile = $logpath."cloud_reg.log";

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
my ($macaddr, $sysdesc) = ("", "");
{
	my $all = $db->selectall_arrayref("SELECT value FROM smartstatus WHERE group_ = 'network' AND name = 'mac'");	# get MAC address
	foreach my $row (@$all) {
		($macaddr) = @$row;
	}
	$sysdesc = "New system ".$macaddr;
}
my $swversion = (exists $HVAC{"system.sw_version"})?$HVAC{"system.sw_version"}:$version;

# Send changes to cloud

if (($carg eq "clean") && ($HVAC{"system.description"} eq "") && ($macaddr ne "")) {		# unregister from the cloud
	my $acloud = $clouda;
	my $userhash = md5_hex($sysdesc.$authsalt);
	my $mech = LWP::UserAgent->new;
	$mech->timeout(10);
	$mech->agent('Mozilla/5.0');
	my $url = "https://".$clouda."/sync.pl";
	prdate("Sending data to primary $url");
	my $res = $mech->post($url, 
		{ "action" => "unregister",
		  "version" => $swversion,
		  "system" => $userhash }
	);
	unless ($res->is_success) {
		$acloud = $cloudb;
		$url = "https://".$cloudb."/sync.pl";
		prdate("Error. Sending request to secondary $url");
		$res = $mech->post($url, 
			{ "action" => "unregister",
			  "version" => $swversion,
			  "system" => $userhash }
		);
		unless ($res->is_success) {
			prdate("Error. Unable to unregister from cloud");
			exit;
		}
	}
	my $pagedata = $res->content;
#	prdate($pagedata);
	$carg = "tryreg";
}

if (($carg eq "tryreg") && ($HVAC{"system.description"} eq "") && ($macaddr ne "")) {
	my $acloud = $clouda;
	my $userhash = md5_hex($sysdesc.$authsalt);
	my $mech = LWP::UserAgent->new;
	$mech->timeout(10);
	$mech->agent('Mozilla/5.0');
	my $url = "https://".$clouda."/sync.pl";
	prdate("Sending data to primary $url");
	my $res = $mech->post($url, 
		{ "action" => "register",
		  "version" => $swversion,
		  "system" => $userhash,
		  "sysdesc" => $sysdesc }
	);
	unless ($res->is_success) {
		$acloud = $cloudb;
		$url = "https://".$cloudb."/sync.pl";
		prdate("Error. Taking data from secondary $url");
		$res = $mech->post($url, 
			{ "action" => "register",
			  "version" => $swversion,
			  "system" => $userhash,
			  "sysdesc" => $sysdesc }
		);
		unless ($res->is_success) {
			prdate("No connecton to the ASE Cloud.");
			exit;
		}
	}
	my $pagedata = $res->content;
	if ($pagedata =~ m/^error/) {
		chomp($pagedata);
		prdate($pagedata);
	} elsif ($pagedata =~ m/^success/) {
		my @pagedet = split(/\n/,$pagedata);
		my $houseid = $pagedet[1];
		my $sernum = $pagedet[2];
		$db->do("UPDATE smartstatus SET value='$acloud' WHERE group_='network' AND name='cloud'");		# set cloud hostname
		$db->do("UPDATE hvac SET value_ = '$houseid' WHERE option_ = 'system.house_id'");			# set global house ID
		$db->do("UPDATE hvac SET value_ = '$sernum' WHERE option_ = 'system.serial'");				# set global serial number
		$db->do("UPDATE hvac SET value_ = '$sysdesc' WHERE option_ = 'system.description'");			# set global system description
		prdate("Registration done. Assigned House ID : $houseid");
	}
} else {
	prdate("Registration error.");
}

# exit

$db->disconnect();
exit;

sub prdate {
	my $logtxt = $_[0];
	$logger->debug($logtxt);
	my ($nusec,$numin,$nuhour,$nuday,$numon,$nuyear) = (localtime)[0,1,2,3,4,5];
	my $nucreat = sprintf("%04d-%02d-%02d %02d:%02d:%02d",($nuyear + 1900),($numon + 1),$nuday,$nuhour,$numin,$nusec);
	print $nucreat." - ".$logtxt."\n";
}

7;
