#!/usr/bin/perl
#tcpserver.pl

# importing modules 
use strict; # used to compile and requires all variables are of type "my" 
use Socket;

# getting command-arguments 
if ($#ARGV != 0) {
    print "usage: serverprogram <port>\n"; #prints in case of too many or too few command line-arguments 
    exit;
}

# capture the argument into variables and initializing the port and protocol 
my $port = $ARGV[0];
my $proto = getprotobyname('tcp');


# create a socket
socket(SERVER, PF_INET, SOCK_STREAM, $proto) or die "socket: $!\n";
setsockopt(SERVER, SOL_SOCKET, SO_REUSEADDR, 1) or die "setsock: $!\n"; #setsockopt ensures port is immediately reusable

# grab a port on this machine
my $paddr = sockaddr_in($port, INADDR_ANY); #sockaddr_in() obtains a port in the server

# bind to a port = inserts the ssocket into the port
# listen() causes the server to begin listening to the port
bind(SERVER, $paddr) or die "bind: $!\n";
listen(SERVER, SOMAXCONN) or die "listen: $!\n"; #SOMAXCONN = maximum queue lenth 
print "Server waiting for client connection on port $port .\n";


# Once server starts listening to the port, it can accept client connections
my $client_addr;
while ($client_addr = accept(CLIENT, SERVER)) #CLIENT = new socket (interpret like a file handler)
{
    # find out who connected
    my ($client_port, $client_ip) = sockaddr_in($client_addr); 
    my $client_ipnum = inet_ntoa($client_ip);                   
    my $client_host = gethostbyaddr($client_ip, AF_INET); #return value from accept(): internet address of the client

    #Time gives seconds from 1970 to now
    my $send_time = time() + 2208988800; #2208988800 is seconds from 1900 to 1970
    print "$send_time\n";

    # print who has connected
    print "got a connection from: $client_host","[$client_ipnum] ";

    # send them a message, close connection
    print CLIENT "$send_time\n";
    close CLIENT;
 }