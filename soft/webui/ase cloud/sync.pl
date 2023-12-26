#!c:/perl/bin/perl.exe
#!c:/xampp/perl/bin/perl.exe
#!/usr/bin/perl

use DBI;
use POSIX;
use Digest::MD5 qw(md5 md5_hex md5_base64);
use Time::Local;
use strict;

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
#		$value =~ s/[\\\'\"\`\%]/\ /g;
		$FORM{$name} = $value;
	}
}

# get server data

my $selfpath = $ENV{'PATH_TRANSLATED'};
$selfpath =~ s/\\[^\\]*$/\\/;
if ($selfpath eq "") {
	$selfpath = $ENV{'SCRIPT_FILENAME'};
	$selfpath =~ s/\/[^\/]*$/\//;
}
my $clientip = $ENV{'REMOTE_ADDR'};

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

my $version = (exists $config{version})?$config{version}:"14.12.6a";
my $debugmode = (exists $config{debug})?$config{debug}:0;		# simulation mode off by default
my $advmode = (exists $config{advanced})?$config{advanced}:1;		# corrections allowed
my $logpath = (exists $config{logpath})?$config{logpath}:"./";		# path for storing logs and private files

# connect mysql
 
my $dsn = 'DBI:mysql:'.$config{dbname}.":".$config{dbhost};
my $db_user_name = $config{dbuser};
my $db_password = $config{dbpass};
my $db = DBI->connect($dsn, $db_user_name, $db_password);
if (! $db) {
	print "error. db missing 1\n";
	exit;
}

# get mode and action

print "Content-type: text/plain\n\n";

my $action = (exists $FORM{action})?$FORM{action}:"";
my $system = (exists $FORM{system})?$FORM{system}:"";
my $authsalt = "retro2014";
if (($action eq "") || ($system eq "")) {
	print "error. data missing 1\n";
	$db->disconnect();
	exit;
}
my $swversion = (exists $FORM{version})?$FORM{version}:$version;

# find corresponding system

my $houseid = 0;
my ($housetid, $housedesc) = ("", "");
if (($action eq "receive") || ($action eq "place") || ($action eq "confirm") || ($action eq "register") || ($action eq "unregister")) {
	my $all = $db->selectall_arrayref("SELECT house_id, description FROM systems WHERE MD5(CONCAT(description,'$authsalt')) = '$system'");
	foreach my $row (@$all) {
		($houseid, $housedesc) = @$row;
		$housetid = sprintf("%05d", $houseid);
	}
}

# connect cloud customer db

if ($houseid == 0) {
	if ($action eq "register") {		# prepare for registration
		my $sysdesc = $FORM{sysdesc};
		if ($sysdesc eq "") {
			print "error. data missing 6\n";
			$db->disconnect();
			exit;
		} else {
			my $all = $db->selectall_arrayref("SELECT MAX(house_id) FROM systems");
			foreach my $row (@$all) {
				my ($maxhid) = @$row;
				$houseid = $maxhid + 1;
			}
			$db->do("INSERT INTO systems VALUES (NULL, $houseid, '$swversion', NOW(), '$clientip', '$sysdesc')");
			$housetid = sprintf("%05d", $houseid);
			my $sernum = "ASESC-".$housetid;
			$db->do("CREATE DATABASE smart".$housetid);
			$db->do("GRANT ALL ON smart".$housetid.".* TO 'dbuser".$housetid."' IDENTIFIED BY 'dbpass".$housetid."'");
			system("/usr/bin/mysql -u ".$db_user_name." -p".$db_password." smart".$housetid." < ".$selfpath."smart2014_dump_clean.sql");
			print "success\n";
			print $houseid."\n";
			print $sernum."\n";		# send return data to client
			$db->disconnect();
			exit;
		}
	} else {
		print "error. data missing 2\n";
		$db->disconnect();
		exit;
	}
} else {
	if ($action eq "register") {		# is system already registered?
		my $dumpfile = "/tmp/smart".$housetid."_dump.sql";
		system("/usr/bin/mysqldump --no-create-info --skip-triggers --skip-add-drop-table --skip-comments --skip-disable-keys --skip-set-charset -u ".$db_user_name." -p".$db_password." smart".$housetid." > ".$dumpfile);
		if (-e $dumpfile) {
			my $outfile = $selfpath."charts/".$system.".sql";
			open(INF, "<$dumpfile");
			open(OUF, ">$outfile");
			print OUF "SET autocommit=0;\n";
			my $tabname = "";
			while(<INF>) {
				my $inline = $_;
				chomp($inline);
				if ($inline =~ m/^\/\*/) {	# comment
					$inline = "";
				} elsif ($inline =~ m/^LOCK TABLES `(.+)`/) {
					$tabname = $1;
					unless ($tabname eq "sessions") {
						$inline .= "\n".'SET @DISABLE_TRIGGER_'.$tabname."=1;";
						$inline .= "\nDELETE FROM `".$tabname."`;";
					}
				} elsif (($inline =~ m/^UNLOCK TABLES/) && ($tabname ne "")) {
					$inline = 'SET @DISABLE_TRIGGER_'.$tabname."=NULL;\n".$inline;
				} elsif ($inline =~ m/^INSERT INTO `(.+)`/) {
					my $ttabname = $1;
					if (($ttabname eq "history_store") || ($ttabname eq "history_store_old") || ($ttabname eq "sessions")) {		# tables to not restore
						$inline = "";
					}
				}
				if ($inline ne "") {
					print OUF $inline."\n";
				}
			}
			print OUF "COMMIT;\n";
			close(OUF);
			close(INF);
		}
		unlink($dumpfile);
		$db->do("DELETE FROM smart".$housetid.".history_store");
		$db->do("DELETE FROM smart".$housetid.".history_store_old");
		print "error. already registered\n";
		$db->disconnect();
		exit;
	} else {
		$db->do("UPDATE systems SET connected = NOW(), ip_address = '$clientip', version = '$swversion' WHERE house_id = $houseid");
	}
}

my $rdsn = "DBI:mysql:smart".$housetid.":".$config{dbhost};
my $rdbuser = "dbuser".$housetid;
my $rdbpass = "dbpass".$housetid;
my $rdb = DBI->connect($rdsn, $rdbuser, $rdbpass);
if (! $rdb) {
	print "error. db missing 2\n";
	exit;
}

if ($action eq "unregister") {		# remove database and client from the cloud
	my $rdbid = sprintf("smart%05d", $houseid);
	$db->do("DROP DATABASE IF EXISTS $rdbid");
	$db->do("DELETE FROM systems WHERE house_id = $houseid");
	print "success\n$houseid unregistered\n";
}

if ($action eq "place") {		# get data from client
	if (exists $FORM{syncdata}) {
		my ($syncnt, $mintime, $maxtime) = (0, 0, 0);
		my @plines = split(/\n/,$FORM{syncdata});
		foreach my $line (@plines) {
			$line =~ s/\v//g;
			if ($line =~ m/^(\d+)$/) {		# sync lines count
				my $retcnt = $1;
				print "success.\n".$mintime."\t".$maxtime."\t".$retcnt."\t".$syncnt;
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
				$rdb->do('SET @DISABLE_TRIGGER_'.$dbname."=1");			# disable table trigger
				if (($dbact == 2) || ($dbact == 3)) {				# delete or update
					$rdb->do("DELETE FROM $dbname WHERE $dbidn = $dbidv");
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
					$rdb->do("INSERT INTO $dbname VALUES($insval)");
				}
				$rdb->do('SET @DISABLE_TRIGGER_'.$dbname."=NULL");		# enable table trigger
				$syncnt++;
			}
		}
	} else {
		print "error. data missing 4\n";
	}
}

if ($action eq "confirm") {		# confirm data sync for period
	if (exists $FORM{confirmation}) {
		my @confdata = split(/\t/,$FORM{confirmation});
		my ($datefrom, $dateto) = ($confdata[0] + 0, $confdata[1] + 0);
		$rdb->do("INSERT INTO history_store_old SELECT * FROM history_store WHERE timemark BETWEEN $datefrom AND $dateto");
		$rdb->do("DELETE FROM history_store WHERE timemark BETWEEN $datefrom AND $dateto");
		print "success\n";
	} else {
		print "error. data missing 3\n";
	}
}

if ($action eq "receive") {		# send data to client
	my $all = $rdb->selectall_arrayref("SELECT (timemark + 0), table_name, pk_date_dest, record_state FROM history_store WHERE record_state < 100 ORDER BY timemark");
	my $records = 0;
	foreach my $row (@$all) {
		my ($rtime, $rtab, $rid, $rst) = @$row;
		my ($rcol, $rcid, $rprn) = ("", "", "");
		if ($rid =~ m/^\<(.+)\>(\d+)\</) {
			$rcol = $1;
			$rcid = $2;
			$rprn = $rtab."\t".$rtime."\t".$rst."\t".$rcol."\t".$rcid;
			if (($rst == 1) || ($rst == 2)) {
				my $rcc = $rdb->selectall_arrayref("SELECT * FROM $rtab WHERE $rcol = $rcid");
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
			print $rprn."\n";
		}
		$records++;
	}
	undef $all;
	print $records."\n";			# number of records is last we show
}

# exit

$db->disconnect();
exit;
7;
