#!/usr/bin/perl -w

use strict;
use Socket;
use IO::Handle;
use Fcntl;


my $sock = shift;
if (not defined $sock) {
	$sock = $ENV{'HACKABOT_SOCK'}
}
if (not defined $sock) {
	die "Socket location unknown!\n"
}

my $addr = sockaddr_un($sock);

socket(CONN,PF_UNIX,SOCK_STREAM,0);
connect(CONN, $addr);
my $line;
CONN->autoflush(1);
while(<>) {
	print CONN "$_";
}
shutdown(CONN,1);
while($line = <CONN>) {
	print $line;
}
shutdown(CONN,2);
close CONN;

