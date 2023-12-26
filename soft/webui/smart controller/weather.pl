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

my $version = (exists $config{version})?$config{version}:"14.5.2a";
my $debugmode = (exists $config{debug})?$config{debug}:0;		# simulation mode off by default
my $advmode = (exists $config{advanced})?$config{advanced}:1;		# corrections allowed
my $logpath = (exists $config{logpath})?$config{logpath}:"./";		# path for storing logs and private files
my $logfile = $logpath."weather_update.log";

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

# get location

my ($location, $locold, $updper) = ("", "");
{
	my $all = $db->selectall_arrayref("SELECT city FROM users ORDER BY access DESC, id LIMIT 1");
	foreach my $row (@$all) {
		($location) = @$row;
	}
	undef $all;

	my $all = $db->selectall_arrayref("SELECT value, (UNIX_TIMESTAMP(NOW()) - UNIX_TIMESTAMP(updated)) FROM smartstatus WHERE group_ = 'weather' AND name = 'location'");
	foreach my $row (@$all) {
		($locold, $updper) = @$row;
	}
	undef $all;
}

# check if needed to update

if ($updper > 3600) {
	prdate("Weather data too old. update required");
} else {
	if ($location ne $locold) {
		prdate("Location changed. update required");
	} else {
		prdate("No update required");
		$db->disconnect();
		exit;
	}
}

# retrieve weather from server

my $pagedata = "";
if ($location ne "") {
	my $mech = LWP::UserAgent->new;
	$mech->timeout(10);
	$mech->agent('Mozilla/5.0');
	my $url = "http://api.openweathermap.org/data/2.5/weather?q=".$location."&units=metric";
	prdate("Taking weather from $url");
	my $res = $mech->get($url);
	unless ($res->is_success) {
		prdate("Cannot get weather from server");
	}
	$pagedata = $res->content;
} else {
	prdate("Location not set");
}

# weather parser

if ($pagedata ne "") {
	my ($wtemp, $whum, $wwind, $wair, $wcond) = ("", "", "", "", "");
	my ($wflag) = (0);
	chomp($pagedata);
	$pagedata =~ s/[\{\}\"\[\]]//g;
	my @pairs = split(/[\:\,]/, $pagedata);
	for my $pcnt (0 .. $#pairs) {
		if (($pairs[$pcnt] eq "main") && ($pairs[$pcnt+2] eq "description")) {		# conditions
			$wcond = $pairs[$pcnt+1].", ".$pairs[$pcnt+3];
		} elsif ($pairs[$pcnt] eq "temp") {						# temperature
			$wtemp = $pairs[$pcnt+1];
		} elsif ($pairs[$pcnt] eq "humidity") {						# humidity
			$whum = $pairs[$pcnt+1];
		} elsif ($pairs[$pcnt] eq "pressure") {						# air pressure
			$wair = $pairs[$pcnt+1];
		} elsif ($pairs[$pcnt] eq "speed") {						# wind1
			$wwind = $pairs[$pcnt+1];
		} elsif ($pairs[$pcnt] eq "deg") {						# wind2
			$wwind .= " ".$pairs[$pcnt+1];
		}
#		print $indata."\n";
	}
	prdate("location $location ;wtemp $wtemp ;whum $whum ;wwind $wwind;wair $wair;wcond $wcond");
	$db->do("UPDATE smartstatus SET updated = NOW(), value = '$location' WHERE group_ = 'weather' AND name = 'location'");
	$db->do("UPDATE smartstatus SET updated = NOW(), value = '$wtemp' WHERE group_ = 'weather' AND name = 'temp'");
	$db->do("UPDATE smartstatus SET updated = NOW(), value = '$whum' WHERE group_ = 'weather' AND name = 'humid'");
	$db->do("UPDATE smartstatus SET updated = NOW(), value = '$wwind' WHERE group_ = 'weather' AND name = 'wind'");
	$db->do("UPDATE smartstatus SET updated = NOW(), value = '$wair' WHERE group_ = 'weather' AND name = 'air_pres'");
	$db->do("UPDATE smartstatus SET updated = NOW(), value = '$wcond' WHERE group_ = 'weather' AND name = 'cond'");
} else {
	prdate("No weather data received");
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
