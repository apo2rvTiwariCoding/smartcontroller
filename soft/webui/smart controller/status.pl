#!/usr/bin/perl

use DBI;
use POSIX;
use Digest::MD5 qw(md5 md5_hex md5_base64);
use Time::Local;
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

my $version = (exists $config{version})?$config{version}:"14.12.16a";
my $debugmode = (exists $config{debug})?$config{debug}:0;		# simulation mode off by default
my $advmode = (exists $config{advanced})?$config{advanced}:1;		# corrections allowed
my $logpath = (exists $config{logpath})?$config{logpath}:"./";		# path for storing logs and private files
my $logfile = $logpath."system_status.log";
my $statfile = "/tmp/status";
my $arpfile = "/tmp/arplist";
my $wanfile = "/tmp/wlan1";
my $wchfile = "/tmp/wlanchan";
my $hostapd = "/etc/hostapd/hostapd.conf";

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

# status parser

if (-e $statfile) {
	my ($scpu, $sram, $sdisk, $supt, $sip, $sgw, $swan, $sdns, $slwan, $smac, $spwan, $spgw) = ("", "", "", "", "", "", "", "", "", "", "", "");
	my ($wanext, $ipnext, $pwanext) = (0, 0, 0);
	open(INF, "<$statfile");
	while(<INF>) {
		my $inline = $_;
		chomp($inline);
		if ($inline =~ m/^ \d\d:\d\d:\d\d up (.+)\,  (.+)\,  load average: (.+)$/) {		# cpu and uptime
			$supt = $1;
			$scpu = $3;
		}
		if ($inline =~ m/^Mem:\s+(\d+)\s+(\d+)\s+(\d+)\s+.+/) {					# ram
			$sram = $2."Mb used, ".$3."Mb free";
		}
		if ($inline =~ m/^rootfs\s+(\d+)\s+(\d+)\s+(\d+)\s+.+/) {				# disk
			my ($dused, $dfree) = ($2, $3);
			$sdisk = (floor($dused / 1024))."Mb used, ".(floor($dfree / 1024))."Mb free";
		}
		if ($inline =~ m/^default\s+(\d+)\.(\d+)\.(\d+)\.(\d+)\s+.+/) {				# main GW
			$sgw = $1.".".$2.".".$3.".".$4;
		}
		if ($inline =~ m/^0\.0\.0\.0\s+(\d+)\.(\d+)\.(\d+)\.(\d+)\s+.+/) {			# main GW with route -n
			$sgw = $1.".".$2.".".$3.".".$4;
		}
		if ($inline =~ m/^eth(\d+)\s+Link/) {					# ip 1st
			($wanext, $pwanext, $ipnext) = (0, 0, 1);
		}
		if ($inline =~ m/^wlan(\d+)\s+Link/) {					# wlan 1st and 2nd
			my $wlannum = $1 + 0;
			if ($1 == 0) {
				($wanext, $pwanext, $ipnext) = (1, 0, 0);
			} elsif ($1 == 1) {
				($wanext, $pwanext, $ipnext) = (0, 1, 0);
			}
		}
		if ($inline =~ m/HWaddr (\w\w):(\w\w):(\w\w):(\w\w):(\w\w):(\w\w)/) {			# MAC address
			my $macaddr = uc($1.$2.$3.$4.$5.$6);
			if ($ipnext) {
				$smac = $macaddr;
			}
		}
		if ($inline =~ m/^\s+inet addr:(\d+)\.(\d+)\.(\d+)\.(\d+)/) {
			my $ipaddr = $1.".".$2.".".$3.".".$4;
			if ($ipnext) {
				$sip = $ipaddr;
				$ipnext = 0;
			} elsif ($wanext) {
				$swan = $ipaddr;
				$wanext = 0;
			} elsif ($pwanext) {
				$spwan = $ipaddr;
				$pwanext = 0;
			}
		}
		if ($inline =~ m/^nameserver\s+(\d+)\.(\d+)\.(\d+)\.(\d+)/) {					# DNS list
			$sdns .= (($sdns eq "")?"":";").$1.".".$2.".".$3.".".$4;
		}
	}
	close(INF);

	if (-e $wanfile) {
		open(INF, "<$wanfile");
		while(<INF>) {
			my $inline = $_;
			chomp($inline);
			if ($inline =~ m/^DHCPACK from (\d+)\.(\d+)\.(\d+)\.(\d+)/) {				# WAN client gateway
				$spgw = $1.".".$2.".".$3.".".$4;
			}
		}
		close(INF);
	}

	if (-e $arpfile) {
		open(INF, "<$arpfile");
		while(<INF>) {
			my $inline = $_;
			chomp($inline);
			if ($inline =~ m/([0-9\.]+)\s+ether\s+([a-z0-9\:A-Z]+)\s+.+wlan/) {
				$slwan .= (($slwan eq "")?"":";").$1.",".$2;
			}
		}
		close(INF);
	}

	if (($sgw eq "") && ($spgw ne "")) {		# change default route to WAN client if LAN is down and route not already set to WAN
		my $mesg = "/sbin/route add default gw ".$spgw;
		system($mesg);
		$sgw = $spgw;
	}

	my $wchan = 0;
	if (($spgw ne "") && ($spwan ne "")) {		# WAN client up? check and fix AP channel if not set same to WAN client channel
		if (-e $wchfile) {
			open(INF, "<$wchfile");
			while(<INF>) {
				my $inline = $_;
				chomp($inline);
				if ($inline =~ m/\(Channel (\d+)\)$/) {
					$wchan = $1 + 0;
				}
			}
			close(INF);
		}
	}
	if ($wchan > 0) {				# check current channel in config now
		if (-e $hostapd) {
			my $hostfile = "";
			my $oldchan = 0;
			open(HAP, "<$hostapd");
			while(<HAP>) {
				my $inline = $_;
				chomp($inline);
				if ($inline =~ m/^channel\=(\d+)$/) {		# channel?
					$oldchan = $1 + 0;
					$hostfile .= "channel=".$wchan."\n";
				} else {
					$hostfile .= $inline."\n";
				}
			}
			close(HAP);
			if ($oldchan != $wchan) {		# write new config if channels not match, fix DB, restart hostapd
				open(HAP, ">$hostapd");
				print HAP $hostfile;
				close(HAP);
				$db->do("UPDATE networks SET ap_channel = '$wchan'");
				$db->do("INSERT INTO hvac_actions (id, type_) VALUES (NULL, 4)");	# send command to restart WAN AP
			}
		}
	}

	prdate("CPU : $scpu , RAM : $sram , Disk : $sdisk , Uptime : $supt , IP : $sip , GW : $sgw , CGW : $spgw , WAN : $swan , CWAN : $spwan , DNS : $sdns , WANcl : $slwan , MAC : $smac , WANCliChan : $wchan");
	
	$db->do("UPDATE smartstatus SET updated = NOW(), value = '$sram' WHERE group_ = 'health' AND name = 'ram'");
	$db->do("UPDATE smartstatus SET updated = NOW(), value = '$scpu' WHERE group_ = 'health' AND name = 'cpu'");
	$db->do("UPDATE smartstatus SET updated = NOW(), value = '$sdisk' WHERE group_ = 'health' AND name = 'disk'");
	$db->do("UPDATE smartstatus SET updated = NOW(), value = '$supt' WHERE group_ = 'health' AND name = 'uptime'");
	$db->do("UPDATE smartstatus SET updated = NOW(), value = '$sip' WHERE group_ = 'network' AND name = 'ip_main'");
	$db->do("UPDATE smartstatus SET updated = NOW(), value = '$sgw' WHERE group_ = 'network' AND name = 'gateway'");
	$db->do("UPDATE smartstatus SET updated = NOW(), value = '$swan' WHERE group_ = 'network' AND name = 'ip_wan'");
	$db->do("UPDATE smartstatus SET updated = NOW(), value = '$spwan' WHERE group_ = 'network' AND name = 'ip_cwan'");
	$db->do("UPDATE smartstatus SET updated = NOW(), value = '$spgw' WHERE group_ = 'network' AND name = 'gw_cwan'");
	$db->do("UPDATE smartstatus SET updated = NOW(), value = '$sdns' WHERE group_ = 'network' AND name = 'dns'");
	$db->do("UPDATE smartstatus SET updated = NOW(), value = '$smac' WHERE group_ = 'network' AND name = 'mac'");
	$db->do("UPDATE smartstatus SET updated = NOW(), value = '$slwan' WHERE group_ = 'network' AND name = 'list_wan'");

} else {
	prdate("status file not found");
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
