#!/bin/bash

for ip in 192.168.18.{1..255}
do
    { 
        ping $ip -c2 &> /dev/null
        if [ $? -eq 0 ];
	then
	    echo $ip is alive
	fi	
    } &
done
wait
#Or use `fping -a 192.168.18.1 192.168.18.255 -g`
exit 0
