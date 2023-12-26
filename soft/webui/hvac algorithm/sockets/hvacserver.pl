#!/usr/bin/perl

use POSIX;
use strict;
use IO::Socket::UNIX qw( SOCK_STREAM SOMAXCONN );
use DBI;
use Log::Log4perl qw(:easy);
use Mail::Sender;

$Mail::Sender::NO_X_MAILER = 1;

my $socket_path = '/tmp/hvac-action';
unlink($socket_path);

my $listner = IO::Socket::UNIX->new(
	Type   => SOCK_STREAM,
	Local  => $socket_path,
	Listen => SOMAXCONN,
) or die ("Can't create server socket: $!\n");

chmod 0777, $socket_path;

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

my $version = (exists $config{version})?$config{version}:"15.1.8a";
my $logpath = (exists $config{logpath})?$config{logpath}:"./";		# path for storing logs and private files
my $logfile = $logpath."hvac_process.log";
my $apchans = $selfpath."charts/apchanlist";		# saved in permanent place now

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

# main cycle

prdate("HVAC Action server $version started");
my $running = 1;
while ($running) {
	next unless my $connection = $listner->accept;
	$connection->autoflush(1);
	while (my $line = <$connection>) {
		chomp($line);
		print $connection "$line";
		prdate("Parent got $line");
		if ($line =~ m/^exit/) {	# command to stop server
			$running = 0;
			next;
		}
		$SIG{CHLD} = "IGNORE";		# autoreaper?
		my $pid = fork;			# start separate process on signal
		if (!defined $pid) {
			prdate("Cannot fork: $!");
			next;
		} elsif ($pid == 0) {		# child process here
			my $netconf = "/etc/network/interfaces";
			my $dnsconf = "/etc/resolvconf/resolv.conf.d/tail";
			my $logger = get_logger("Bar::Twix");
			my $dbh = $db->clone();
			$db->{InactiveDestroy} = 1;
			my ($tnow) = $dbh->selectrow_array("SELECT NOW()");
			prdate("Child started. DB time $tnow");

			my ($dbid, $rtable, $rtid, $ctype, $cprio) = $dbh->selectrow_array("SELECT id, ref_table, ref_id, type_, priority FROM hvac_actions ORDER BY id DESC LIMIT 1");
			if (($dbid ne "") && ($dbid ne "NULL")) {
				prdate("Processing action type $ctype");
				$dbh->do("DELETE FROM hvac_actions WHERE id = $dbid");
				if ($ctype == 1) {				# LAN settings changed
					my ($ndbid, $dns1, $dns2, $lanip, $langw, $lannm, $ldhcp) = $dbh->selectrow_array("SELECT id, dns1, dns2, lan_ip, lan_gateway, lan_netmask, lan_dhcp FROM networks ORDER BY id DESC LIMIT 1");
					{					# dns update
						open(DNS, ">$dnsconf");
						if ($dns1 ne "") {
							print DNS "nameserver ".$dns1."\n";
						}
						if ($dns2 ne "") {
							print DNS "nameserver ".$dns2."\n";
						}
						close(DNS);
					}
					{					# networking update
						my $nconf = "auto eth0\n";
						if ($ldhcp == 1) {		# dhcp on
							$nconf .= "allow-hotplug eth0\n";
							$nconf .= "iface eth0 inet dhcp\n";
						} elsif ($ldhcp == 0) {		# static
							$nconf .= "iface eth0 inet static\n";
							$nconf .= "    address $lanip\n";
							$nconf .= "    netmask $lannm\n";
							$nconf .= "    gateway $langw\n";
						}
						$nconf .= "    up iptables-restore < /etc/iptables.ipv4.nat\n\n";		# double CR to detect section end
						my $onconf = "";
						my $skipflag = 0;
						open(NET, "<$netconf");
						while(<NET>) {
							my $netline = $_;
							chomp($netline);
							if (($netline =~ m/^auto eth0/) || ($netline =~ m/^iface eth0/)) {
								$skipflag++;
							}
							if ($skipflag) {			# skip old eth0 config
								if ($netline eq "") {
									$skipflag = 0;
									$onconf .= $nconf;
								}
							} else {
								$onconf .= $netline."\n";
							}
						}
						close(NET);
						open(NET, ">$netconf");
						print NET $onconf;
						close(NET);
					}
				} elsif ($ctype == 2) {				# wifi scan
					prdate("WiFi Scan started");
					my $wanapres = `/sbin/iwlist wlan1 scan`;
					prdate("WiFi Scan finished");
					open(APS, ">$apchans");
					my @wanaprep = split(/\n/, $wanapres);
					my ($wanch, $wanes) = ("", "");
					foreach my $wanapline (@wanaprep) {
						if ($wanapline =~ m/Channel:(\d+)/) {		# channel
							$wanch = $1;
						} elsif ($wanapline =~ m/SSID:\"(.+)\"/) {	# name
							$wanes = $1;
							print APS $wanch.": ".$wanes."\n";
						}
					}
					close(APS);
				} elsif ($ctype == 3) {				# wan client restart
					my $wanrest = $selfpath."wan_restart1.sh";
					prdate("WAN Restart stage 1");
					my $mesg = `$wanrest`;
					$wanrest = $selfpath."wan_restart2.sh";
					prdate("WAN Restart stage 2");
					$mesg = `$wanrest`;
					prdate("WAN Restart finished");
				} elsif ($ctype == 4) {				# wan AP restart
					my $wanrest = $selfpath."wan0_stop.sh";
					prdate("WAN Restart stage 1");
					my $mesg = `$wanrest`;
					$wanrest = $selfpath."wan0_start.sh";
					prdate("WAN Restart stage 2");
					$mesg = `$wanrest`;
					prdate("WAN Restart finished");
				} elsif ($ctype == 5) {				# notification email
					my %HVAC = ();
					{
						my $all = $dbh->selectall_arrayref("SELECT option_,value_ FROM hvac WHERE submenu > 0");		# read HVAC config
						foreach my $row (@$all) {
							my ($opt, $val) = @$row;
							$HVAC{$opt} = $val;
						}
					}

					my $smtpserv = 'smtp.ase-energy.ca';
					my $smtpport = '3535';
					my $mailfrom = 'ASE RetroSAVE Support<retrosave_support@ase-energy.ca>';
					my $smtpuser = 'retrosave_support@ase-energy.ca';
					my $smtppass = 'LaLaLa14';
                                
					my %algroup = ("alarms_retrosave", "0", "alarms_zigbee", "1", "alarms_system", "2", "alarms_networks", "3", "alarms_pressure", "4", "registrations", "5");
					my @altypet = ("type_", "type_", "type_", "type_", "type_", "event_type");
					my @altdesc = ("RetroSAVE", "Zigbee", "System", "Networks", "Pressure", "Remote Registration");
					my @sevdesc = ("Event", "Alarm", "Emergency");
					my @sewdesc = ("Green", "Yellow", "Red");
					my @semails = ("", "", "");				# 0 = Green, 1 = Yellow, 2 = Red
					if ($HVAC{"system.notifications_email"} == 1) {
						my $all = $dbh->selectall_arrayref("SELECT id, email, phone, severity FROM notifications ORDER BY id");
						foreach my $row (@$all) {
							my ($noid, $email, $phone, $sever) = @$row;
							if ((length($email)) && (defined($email))) {		# is it email?
								if ($sever & 1) {				# events
									$semails[0] .= ($semails[0] eq "")?$email:(", ".$email);
								}
								if ($sever & 2) {				# alarms
									$semails[1] .= ($semails[1] eq "")?$email:(", ".$email);
								}
								if ($sever & 4) {				# emergency
									$semails[2] .= ($semails[2] eq "")?$email:(", ".$email);
								}
							}
						}
						undef $all;
					
						if (exists $algroup{$rtable}) {
							my $arectype = $algroup{$rtable};
							my $artypetab = $altypet[$arectype];
							my ($recid, $recupd, $rectype) = $dbh->selectrow_array("SELECT id, updated, $artypetab FROM $rtable WHERE id = $rtid");
							unless ($recid eq "") {
								my ($alstat, $aldesc, $alsev) = $dbh->selectrow_array("SELECT status, description, severity FROM alarms_types WHERE type_ = $arectype AND alarm_id = $rectype");
								if ($alstat == 1) {				# status enabled
									my $mailsubj = "RetroSAVE Smart Controller ".$sevdesc[$alsev]." Notification";
									my $mailtext = "Automatic notification from ASE RetroSAVE Smart Controller '".$HVAC{"system.description"}."' #".$HVAC{"system.house_id"}."\nCreated at: $recupd\nSeverity: ".$sewdesc[$alsev]." (".$sevdesc[$alsev].")\nDescription: $aldesc\n";
									if ($semails[$alsev] ne "") {
										my $sender = new Mail::Sender {smtp => $smtpserv, port => $smtpport, from => $mailfrom, auth => 'LOGIN', authid => $smtpuser, authpwd => $smtppass};
										unless ($sender < 0) {
											$sender->OpenMultipart({to => $semails[$alsev], subject => $mailsubj});
											$sender->Body({charset => 'windows-1251', encoding => '8bit', ctype => 'text/plain', msg => $mailtext});
											$sender->Close;
											prdate("Notification sent to ".$semails[$alsev]);
										} else {
											prdate("Mailserver $smtpserv error");
										}
									} else {
										prdate("Emails list is empty");
									}
								} else {
									prdate("Disabled alarm type $rectype");
								}
							} else {
								prdate("Referred record $rtid not found");
							}
						} else {
							prdate("Referred table $rtable not found");
						}
					} else {
						prdate("Email notifications disabled");
					}
				} elsif ($ctype == 6) {				# bypass switch toggle interrupt
					my ($recid, $rectp, $recst) = $dbh->selectrow_array("SELECT id, type_, status FROM $rtable WHERE id = $rtid");
					if ($recst == 1) {			# switch toggled ON
						prdate("Bypass mode on");
						$dbh->do("INSERT INTO relays VALUES (NULL, NOW(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)");	# reset all relays
					} elsif ($recst == 0) {
						prdate("Bypass mode off");
					}
				} elsif ($ctype == 7) {				# restart HVAC and MD
					my $wanrest = $selfpath."wan_restart1.sh";
					prdate("HVAC and MuxDemux Restart");
					my $mesg = `/usr/bin/killall sc`;		# shutdown muxdemux
					$running = 0;					# shutdown HVAC
					next;
				} elsif ($ctype == 0) {				# generic table update
				}
			} else {
				prdate("No action requested");
			}

			($tnow) = $dbh->selectrow_array("SELECT NOW()");
			prdate("Child closed. DB time $tnow");
			undef $dbh;
			exit;
		}
	}
}

# logger print

sub prdate {
	my $logtxt = $_[0];
	$logger->debug($logtxt);
	print $logtxt."\n";
}

$db->disconnect();
exit;
7;
