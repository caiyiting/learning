#!/bin/bash
mkdir log
status_tracert(){
for ip in $(cat ip.txt)
        do
{
        ping -i 0.1 -c 10 $ip > $ip.tmp
        value="$(cat $ip.tmp |grep loss |awk '{print $6}' |awk -F'[%]+' '{print $1}')"
        datatime="$(date +"%Y-%m-%d-%T")"
                if [ "$value" -ge "10" ]
                then    traceroute $ip -I -d -n > log/$datatime-$ip.txt
                else     echo "$datatime NetWork Is OK" >log/network.txt
        fi
}&
done
wait
}

while ((1))
do
        status_tracert
        sleep 1
done
