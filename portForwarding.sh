#!/bin/bash

IPTBL=iptables

IF_IN=br0
PORT_IN=8000

IP_OUT=192.168.10.10
PORT_OUT=80

echo "1" > /proc/sys/net/ipv4/ip_forward

$IPTBL -I PREROUTING 1 -t nat -p tcp --dport $PORT_IN -j DNAT --to-destination ${IP_OUT}:${PORT_OUT}
$IPTBL -I FORWARD 1 -p tcp -d $IP_OUT --dport $PORT_OUT -j ACCEPT
$IPTBL -I PREROUTING 1 -t nat -p udp --dport $PORT_IN -j DNAT --to-destination ${IP_OUT}:${PORT_OUT}
$IPTBL -I FORWARD 1 -p udp -d $IP_OUT --dport $PORT_OUT -j ACCEPT

IF_IN=br0
PORT_IN=8443

IP_OUT=192.168.10.10
PORT_OUT=443

$IPTBL -I PREROUTING 1 -t nat -p tcp --dport $PORT_IN -j DNAT --to-destination ${IP_OUT}:${PORT_OUT}
$IPTBL -I FORWARD 1 -p tcp -d $IP_OUT --dport $PORT_OUT -j ACCEPT
$IPTBL -I PREROUTING 1 -t nat -p udp --dport $PORT_IN -j DNAT --to-destination ${IP_OUT}:${PORT_OUT}
$IPTBL -I FORWARD 1 -p udp -d $IP_OUT --dport $PORT_OUT -j ACCEPT

$IPTBL -I POSTROUTING 1 -t nat -j MASQUERADE