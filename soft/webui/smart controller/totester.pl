#!/usr/bin/perl

use POSIX;
use strict;
use Log::Log4perl qw(:easy);
use DBI;

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

my $version = (exists $config{version})?$config{version}:"14.11.6a";
my $debugmode = (exists $config{debug})?$config{debug}:0;		# simulation mode off by default
my $advmode = (exists $config{advanced})?$config{advanced}:1;		# corrections allowed
my $logpath = (exists $config{logpath})?$config{logpath}:"./";		# path for storing logs and private files
my $logfile = $logpath."timeout_tester.log";

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

# test timeouts

my $running = 1;
while ($running) {
	my ($tnow) = $db->selectrow_array("SELECT NOW()");
	prdate("DB time $tnow");
	sleep(1);
}

# exit

$db->disconnect();
exit;

sub prdate {
	my $logtxt = $_[0];
	$logger->debug($logtxt);
}

7;
