#!/usr/bin/perl

use POSIX;
use LWP::UserAgent;
use strict;
use DBI;
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

my $version = (exists $config{version})?$config{version}:"14.11.21p";
my $logpath = (exists $config{logpath})?$config{logpath}:"./";		# path for storing logs and private files
my $logfile = $logpath."nest2.log";

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

# read hvac config

my %HVAC = ();
{
	my $all = $db->selectall_arrayref("SELECT option_,value_ FROM hvac WHERE submenu > 0");		# read HVAC config
	foreach my $row (@$all) {
		my ($opt, $val) = @$row;
		$HVAC{$opt} = $val;
	}
}

# request data

my %opts = ("name_long", "", "can_heat", "", "can_cool", "", "hvac_mode", "", "humidity", "", "has_fan", "", 
	"target_temperature_c", "", "target_temperature_f", "", "target_temperature_high_c", "", "target_temperature_high_f", "",
	"target_temperature_low_c", "", "target_temperature_low_f", "", "ambient_temperature_c", "", "ambient_temperature_f", "", 
	"away_temperature_high_c", "", "away_temperature_high_f", "", "away_temperature_low_c", "", "away_temperature_low_f", "", 
	"is_online", "", "last_connection", "", "country_code", "", "away", "");
my $cloop = 1;
while ($cloop) {
	unless ($db->ping) {
		$db = DBI->connect($dsn, $db_user_name, $db_password);
		prdate("[!] Database connection restored");
	}
	if (($HVAC{"thermostat.type"} != 1) || ($HVAC{"thermostat.connected"} != 1) || ($HVAC{"thermostat.smart_model"} != 1)) {	# cots must be connected. right model and type
		prdate("[!] No cots connected");
		sleep(30);
		($HVAC{"thermostat.type"}) = $db->selectrow_array("SELECT value_ FROM hvac WHERE option_ = 'thermostat.type'");
		($HVAC{"thermostat.connected"}) = $db->selectrow_array("SELECT value_ FROM hvac WHERE option_ = 'thermostat.connected'");
		($HVAC{"thermostat.smart_model"}) = $db->selectrow_array("SELECT value_ FROM hvac WHERE option_ = 'thermostat.smart_model'");
		next;
	}
	if ($HVAC{"thermostat.nest_token"} ne "") {
		my $mech = LWP::UserAgent->new;
		$mech->timeout(10);
		$mech->agent('Mozilla/5.0');
		$mech->default_header('Accept' => "text/event-stream");
		$mech->add_handler( response_data => sub {
			my $res = shift;
			prdate("-------------data-chunk-------------");
			my $rescont = $res->content();
			$rescont =~ s/[\{\}]/\,/g;
			my @condata = split(/\,/, $rescont);
			foreach my $pair (@condata) {
				my ($name, $value) = split(/\"\:/, $pair);
				$name =~ s/\"//g;
				$value =~ s/\"//g;
				if (exists $opts{$name}) {
					if ($opts{$name} ne $value) {		# saving only when something changed
						prdate("$name : $value");
						$opts{$name} = $value;
						unless ($db->ping) {
							$db = DBI->connect($dsn, $db_user_name, $db_password);
							prdate("[!] Database connection restored");
						}
						$db->do("INSERT INTO cots_data VALUES (NULL, 1, NOW(), '$name', '$value')");
					}
				}
			}
			$res->content("");
			return 1;
		});
		$mech->add_handler( response_done => sub {
			my $res = shift;
			prdate("-------------data--------------");
			my $reqdata = $res->dump();
			prdate($reqdata);
			if ($reqdata =~ m/HTTP\/1\.1 (\d+) (.+)/) {
				my $reqstat = $1." ".$2;
				unless ($db->ping) {
					$db = DBI->connect($dsn, $db_user_name, $db_password);
					prdate("[!] Database connection restored");
				}
				$db->do("INSERT INTO cots_data VALUES (NULL, 1, NOW(), 'error', '$reqstat')");
			}
		});
		my $url = "https://developer-api.nest.com/?auth=".$HVAC{"thermostat.nest_token"};
		my $res = $mech->get($url);
		prdate("[!] Connection closed");
		sleep(60);
	} else {
		prdate("[!] No security token");
		sleep(13);
		($HVAC{"thermostat.nest_token"}) = $db->selectrow_array("SELECT value_ FROM hvac WHERE option_ = 'thermostat.nest_token'");
	}
}

# logger 

sub prdate {
	my $logtxt = $_[0];
	$logger->debug($logtxt);
	print $logtxt."\n";
}

# exit

exit;
7;
