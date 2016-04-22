#!/bin/bash

if [ ! $# -eq 1 ]
then 
    echo "Usage:./download.sh file"
    exit -1
fi

if [ ! -f $1 ]
then
    echo $1 is not a file!
    exit -1
fi

for url in `cat $1`
do
    curl -O $url --progress
done

exit 0
