# Workshop3
(This README.md is for running the applications in GNS3 - Feel free to do it any other way) 

First create a project with one ethernet switch and two nodes and connect them. 
Now log into the console for each node and configure the nodes to an IP address. A node can be configured in GNS3 using the commands:

$ip addr add 10.0.0.1/24 dev eth0  
$ip link set eth0 up

(The commands are dependent on which IP address you prefer and the ethernet link you have used to connect the switch and nodes). 


Then create the files in the console and copy the content of the corresponding scripts in this repository into these files:
For TCP:
$nano tcpserver.pl
$nano tcpclient.pl

For UDP:
$nano udpserver.pl 
$nano udpclient.pl

(It is here you can decide which node shall act as the server and which node that shall act as the client) 


Now you can run the application in the console by using the command
For TCP:
$perl -w tcpserver.pl <port number>
$perl -w tcpclient.pl <server host> <port number>

For UDP:
$perl -w udpserver.pl <port number>
$perl -w udpclient.pl <server host> <port number>

