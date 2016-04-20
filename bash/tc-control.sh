#!/bin/bash
TC="/sbin/tc"
LAN_IFACE="eth1"
INTERNAL_add1="192.168.1.192"
INTERNAL_add2="192.168.1.240"
INTERNAL_add3="192.168.1.109"
INTERNAL_add4="192.168.1.69"
INTERNAL_add5="192.168.1.49"
INTERNAL_add6="192.168.1.239"
INTERNAL_add7="192.168.1.169"
INTERNAL_add8="192.168.1.181"
INTERNAL_add9="192.168.1.120"
INTERNAL_add10="192.168.1.173"
INTERNAL_add11="192.168.1.82"
INTERNAL_add12="192.168.1.136"
$TC qdisc del dev $LAN_IFACE root
$TC qdisc add dev $LAN_IFACE root handle 1:0 cbq bandwidth 100Mbit avpkt 1000 cell 8
$TC class add dev $LAN_IFACE parent 1:0 classid 1:1 cbq bandwidth 100Mbit rate 4Mbit weight 6Mbit prio 8 allot 1514 cell 8 maxburst 20 avpkt 1000 bounded
#$TC class add dev $LAN_IFACE parent 1:1 classid 1:2 cbq bandwidth 100Mbit rate 1500kbit weight 2Mbit prio 6 allot 1514 cell 8 maxburst 20 avpkt 1000
$TC class add dev $LAN_IFACE parent 1:1 classid 1:2 cbq bandwidth 100Mbit rate 1600kbit weight 3Mbit prio 7 allot 1514 cell 8 maxburst 20 avpkt 1000 bounded
#$TC qdisc add dev $LAN_IFACE parent 1:2 handle 20: sfq
$TC qdisc add dev $LAN_IFACE parent 1:2 handle 30: sfq
#$TC filter add dev $LAN_IFACE parent 1:0 protocol ip prio 2 u32 match ip dst $ERP1 flowid 1:2
#$TC filter add dev $LAN_IFACE parent 1:0 protocol ip prio 2 u32 match ip dst $ERP2 flowid 1:2
$TC filter add dev $LAN_IFACE parent 1:0 protocol ip prio 1 u32 match ip dst $INTERNAL_add1 flowid 1:2
$TC filter add dev $LAN_IFACE parent 1:0 protocol ip prio 1 u32 match ip dst $INTERNAL_add2 flowid 1:2
$TC filter add dev $LAN_IFACE parent 1:0 protocol ip prio 1 u32 match ip dst $INTERNAL_add3 flowid 1:2
$TC filter add dev $LAN_IFACE parent 1:0 protocol ip prio 1 u32 match ip dst $INTERNAL_add4 flowid 1:2
$TC filter add dev $LAN_IFACE parent 1:0 protocol ip prio 1 u32 match ip dst $INTERNAL_add5 flowid 1:2
$TC filter add dev $LAN_IFACE parent 1:0 protocol ip prio 1 u32 match ip dst $INTERNAL_add6 flowid 1:2
$TC filter add dev $LAN_IFACE parent 1:0 protocol ip prio 1 u32 match ip dst $INTERNAL_add7 flowid 1:2
$TC filter add dev $LAN_IFACE parent 1:0 protocol ip prio 1 u32 match ip dst $INTERNAL_add8 flowid 1:2
$TC filter add dev $LAN_IFACE parent 1:0 protocol ip prio 1 u32 match ip dst $INTERNAL_add9 flowid 1:2
$TC filter add dev $LAN_IFACE parent 1:0 protocol ip prio 1 u32 match ip dst $INTERNAL_add10 flowid 1:2
$TC filter add dev $LAN_IFACE parent 1:0 protocol ip prio 1 u32 match ip dst $INTERNAL_add11 flowid 1:2
$TC filter add dev $LAN_IFACE parent 1:0 protocol ip prio 1 u32 match ip dst $INTERNAL_add12 flowid 1:2
