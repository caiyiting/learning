#!/bin/bash

#Moniter a directory
#INSTALLATION: sudo apt-get install inotify-tools -y

path=$1

if [ $# -eq 0 ]
then
    echo "Usage: watchdir.sh directory"
    exit 1
fi

if [ ! -d $1 ]
then
    echo "$1 not a directory"
    exit 1
fi

inotifywait -m -r -e create,move,delete $path -q
#-e[access,modify,attrib,move,create,open,close,delete]

exit 0
