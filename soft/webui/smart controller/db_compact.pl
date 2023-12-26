#!/usr/bin/perl

use DBI;
use POSIX;
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

my $version = (exists $config{version})?$config{version}:"14.11.13p";
my $logpath = (exists $config{logpath})?$config{logpath}:"./";		# path for storing logs and private files
my $logfile = $logpath."db_compact.log";

# init logger

Log::Log4perl->easy_init($DEBUG);
Log::Log4perl->easy_init( { level => $DEBUG,
	file    => ">>$logfile" } );
my $logger = get_logger("Bar::Twix");

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

# list of tables to compact

my %tabcol = (
	"alarms_networks", "updated", 
	"alarms_pressure", "updated", 
	"alarms_retrosave", "updated", 
	"alarms_system", "updated", 
	"alarms_zigbee", "updated", 
	"bypass", "updated", 
	"commands", "updated", 
	"diagnostics", "updated", 
	"events", "started", 
	"history_store", "timemark", 
	"history_store_old", "timemark", 
	"occupancy", "updated", 
	"registrations", "updated", 
	"relays", "updated", 
	"remotecontrol", "updated", 
	"sensorsdyn", "updated", 
	"sessions", "opened", 
	"smartsensors", "updated", 
	"smartsensorsraw", "updated", 
	"smartstatus", "updated", 
	"statistics", "data", 
	"thermostat", "updated", 
);
my %tabttl = (
	"alarms_networks", "7", 
	"alarms_pressure", "7", 
	"alarms_retrosave", "7", 
	"alarms_system", "7", 
	"alarms_zigbee", "7", 
	"bypass", "7", 
	"commands", "1", 
	"diagnostics", "7", 
	"events", "7", 
	"history_store", "7", 
	"history_store_old", "7", 
	"occupancy", "14", 
	"registrations", "7", 
	"relays", "7", 
	"remotecontrol", "7", 
	"sensorsdyn", "7", 
	"sessions", "1", 
	"smartsensors", "7", 
	"smartsensorsraw", "7", 
	"smartstatus", "7", 
	"statistics", "14", 
	"thermostat", "7", 
);

# compacting

foreach my $tabname (sort keys %tabcol) {
	my $column = $tabcol{$tabname};
	my $ival = $tabttl{$tabname};
	my $drows = $db->do("DELETE FROM $tabname WHERE $column BETWEEN 20130101000000 AND DATE_SUB(NOW(), INTERVAL $ival DAY)");
	$drows = ($drows eq "0E0")?0:$drows;
	prdate("Deleted $drows records from '$tabname'");
	if ($drows > 0) {		# optimize if something deleted
		$db->do("OPTIMIZE TABLE $tabname");
	}
}


# exit

$db->disconnect();
exit;

sub prdate {
	my $logtxt = $_[0];
	$logger->debug($logtxt);
#	print $logtxt."\n";		# debugging only
}

7;
