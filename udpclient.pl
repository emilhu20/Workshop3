#!/usr/bin/perl
#udpclient.pl

use IO::Socket::INET;
use strict;

if ($#ARGV != 1 ) {
    print "udpclient <serverhost> <port>\n";
    exit;
}

my $host=$ARGV[0];
my $port=$ARGV[1];

# flush after every write
$| = 1;

my ($socket,$data);

#  We call IO::Socket::INET->new() to create the UDP Socket 
# and bind with the PeerAddr.
$socket = new IO::Socket::INET (
PeerAddr => "$host:$port",
Proto => 'udp'
) or die "ERROR in Socket Creation : $!\n";

#sending empty datagram to server 
$data = "[empty datagram]";
$socket->send($data);

#Receive the time datagram
$data = <$socket>;
print "Time in seconds : $data\n ";

sleep(10);
$socket->close();