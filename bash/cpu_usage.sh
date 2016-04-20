#!/bin/bash

SECS=180
UNIT_TIME=60

STEPS=$(( $SECS / $UNIT_TIME ))
echo "Watching CPU Usage...;"

for((i=0;i<$STEPS;i++))
do
    ps -eo comm,pcpu | tail -n +2 >> /tmp/cpu_usage.$$
    sleep $UNIT_TIME
done

echo command and cpu:

cat /tmp/cpu_usage.$$ | \
awk '
{ process[$1]+=$2; }
END{
    for(i in process)
    { 
        printf( "%-20s %s\n", i , process[i]);
    }
}' | sort -nrk 2 | head

rm /tmp/cpu_usage.$$

exit 0
