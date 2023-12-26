#!/usr/bin/perl

use strict;
use IO::Socket::UNIX qw( SOCK_STREAM SOMAXCONN );

my $socket_path = '/tmp/hvac-action';
unlink($socket_path);

my $listner = IO::Socket::UNIX->new(
   Type   => SOCK_STREAM,
   Local  => $socket_path,
   Listen => SOMAXCONN,
)
   or die("Can't create server socket: $!\n");

chmod 0777, $socket_path;
# chown scalar getpwnam('nobody'), 0, $socket_path;

my $socket = $listner->accept()
   or die("Can't accept connection: $!\n");

chomp( my $line = <$socket> );
print qq{received "$line"\n};
print $socket "Test passed";

