#!/usr/bin/perl -w
#tcpclient.pl

use strict;
use Socket;

# getting command-line arguments 
if ($#ARGV != 1 ) {
    print "usage: serverprogram <server> <port>\n";
    exit;
}

# capture arguments and initialize host and port
my $host = $ARGV[0];
my $port = $ARGV[1];

my $proto = getprotobyname('tcp');

# get the port address
my $iaddr = inet_aton($host); #inet_aton: ASCII to numeric 
my $paddr = sockaddr_in($port, $iaddr);

# create the socket, connect to the port
socket(SOCKET, PF_INET, SOCK_STREAM, $proto) or die "socket: $!\n";
connect(SOCKET, $paddr) or die "connect: $!\n";

#reads data from the server until end-of-file 
my $line;
while ($line = <SOCKET> )  
{
    print "Time in seconds : $line\n";
}
close SOCKET or die "close: $!";