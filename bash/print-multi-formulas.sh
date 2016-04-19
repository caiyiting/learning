#!/bin/bash

for i in `seq 1 9`
do
    for j in `seq 1 $i`
    do
        printf  "${j}x${i}=$(($i*$j))\t"
    done
    echo
done

exit 0
