#!/usr/bin/perl

use DBI;
use POSIX;
use Digest::MD5 qw(md5 md5_hex md5_base64);
use Time::Local;
use LWP::UserAgent;
use strict;
use Log::Log4perl qw(:easy);
use Cwd qw(abs_path);

# get server data

if ($0 =~ /^(.*\/)[^\/]+$/) {
	chdir($1);
}
my ($selfpath) = abs_path($0) =~ m/(.*)factory.pl/i;

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

my $version = (exists $config{version})?$config{version}:"14.12.13a";
my $debugmode = (exists $config{debug})?$config{debug}:0;		# simulation mode off by default
my $advmode = (exists $config{advanced})?$config{advanced}:1;		# corrections allowed
my $logpath = (exists $config{logpath})?$config{logpath}:"./";		# path for storing logs and private files
my $logfile = $logpath."factory.txt";
my $tmpfold = "/tmp/";
my $logfold = "/var/log/";
# $tmpfold = "e:/temp4/";				# DEBUG only!!
my $facfile = $tmpfold."faclist";

# init logger

Log::Log4perl->easy_init($DEBUG);
Log::Log4perl->easy_init( { level => $DEBUG,
	file => ">>$logfile" } );
my $logger = get_logger("Bar::Twix");

# check for list of actions

unless (-e $facfile) {
	prdate("no action file. exit");
	exit;
}

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

# get actions list

my %actions = ();
open(FAC, $facfile);
while(<FAC>) {
	my $inact = $_;
	chomp($inact);
	$actions{$inact} = $inact;
}
close(FAC);
unlink($facfile);
unless (scalar(keys %actions)) {
	prdate("no actions inside file. exit");
	$db->disconnect();
	exit;
}

# restore config from cloud

if (exists $actions{5}) {
	my $userhash = md5_hex($sysdesc.$authsalt);
	my $acloud = $clouda;
	my $mech = LWP::UserAgent->new;
	$mech->timeout(10);
	$mech->agent('Mozilla/5.0');
	my $url = "https://".$clouda."/charts/".$userhash.".sql";
	prdate("Restoring data from primary $url");
	my $res = $mech->get($url);
	unless ($res->is_success) {
		$acloud = $cloudb;
		$url = "https://".$cloudb."/charts/".$userhash.".sql";
		prdate("Error. Sending request to secondary $url");
		my $res = $mech->get($url);
		unless ($res->is_success) {
			prdate("Error. Exit");
			exit;
		}
	}
	my $pagedata = $res->decoded_content( charset => 'none' );
	my $sqlfile = $tmpfold.$userhash.".sql";
	open(OUF, ">$sqlfile");
	binmode(OUF);
	print OUF $pagedata;
	close(OUF);
	system("/usr/bin/mysql -u ".$db_user_name." -p".$db_password." smart2014 < ".$sqlfile);
	prdate("database restored");
}

# clear logs

if (exists $actions{3}) {
	system("/usr/bin/find $logfold -name \"*.1\" -type f -delete");
	system("/usr/bin/find $logfold -name \"*.0\" -type f -delete");
	system("/usr/bin/find $logfold -name \"*.gz\" -type f -delete");
	system("/usr/bin/find $logfold -name \"*.log\" -type f -delete");
	prdate("logfiles cleared");
}

# restore system settings

if (exists $actions{1}) {
	$db->do("UPDATE networks SET lan_dhcp = 1");
	$db->do("INSERT INTO hvac_actions (id, type_) VALUES (NULL, 1)");		# send command to update net config files with DHCP
	system("/bin/cp -f ".$selfpath."factory/hostapd.conf /etc/hostapd/hostapd.conf");
	system("/bin/cp -f ".$selfpath."factory/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf");
	prdate("system settings restored");
}

# clear database

if (exists $actions{2}) {
	if ($HVAC{"system.description"} ne "") {					 # unregister from the ASE Cloud
		my $acloud = $clouda;
		my $userhash = md5_hex($HVAC{"system.description"}.$authsalt);
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
				prdate("Error. Exit");
				exit;
			}
		}
		my $pagedata = $res->content;
		prdate($pagedata);
	} else {
		prdate("System is not registered with Cloud");
	}
	prdate("clear started");
	system("/usr/bin/mysql -u ".$db_user_name." -p".$db_password." smart2014 < ".$selfpath."factory/smart2014_dump_clean.sql");
	prdate("/usr/bin/mysql -u ".$db_user_name." -p".$db_password." smart2014 < ".$selfpath."factory/smart2014_dump_clean.sql");
	system("/usr/bin/mysql -u ".$db_user_name." -p".$db_password." smart2014 < ".$selfpath."factory/smart2014_dump_clean_triggers_only.sql");
	prdate("/usr/bin/mysql -u ".$db_user_name." -p".$db_password." smart2014 < ".$selfpath."factory/smart2014_dump_clean_triggers_only.sql");
	prdate("database cleared");
}

# clear temporary

if (exists $actions{4}) {
	system("/usr/bin/find $tmpfold -name \"*\" -type f -delete");
	prdate("tempfiles cleared");
}

# restart

system("/sbin/shutdown -r now");
sleep(130);				# make a pause for smooth restart

# exit

$db->disconnect();
exit;

sub prdate {
	my $logtxt = $_[0];
	$logger->debug($logtxt);
}

7;
