#!/usr/bin/perl
#udpserver.pl

#use strict;
use IO::Socket::INET;

# flush after every write
$| = 1;

my ($socket,$received_data);
my ($peeraddress,$peerport);

if ($#ARGV != 0 ) {
    print "tpudpserver <port>\n";
    exit;
}

# capture the arguments into variables
my $port=$ARGV[0];

# we call IO::Socket::INET->new() to create the UDP Socket and bound 
# to specific port number mentioned in LocalPort and there is no need to provide 
# LocalAddr explicitly as in TCPServer.
$socket = new IO::Socket::INET (
LocalPort => $port,
Proto => 'udp',
) or die "ERROR in Socket Creation : $!\n";

# Listen on port $port
print "Server is running on port: $port\n";

while(1)
{
# receive the empty datagram.
$socket->recv($recieved_data,1024);

#get the peerhost and peerport at which the recent data received.
$peeraddress = $socket->peerhost();
$peerport = $socket->peerport();
print "($peeraddress , $peerport) said : $recieved_data\n";

#send a datagram containing the time as a 32 bit binary number to the client at which the read/write operations done recently.
my $send_time = time() + 2208988800; #2208988800 is seconds from 1900 to 1970

$data = "$send_time\n";
$socket->send($data);
}

$socket->close() or die "close: $!";