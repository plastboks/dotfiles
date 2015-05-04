#!/bin/bash

if [ -z "$1" ]
then
    echo "=> Please supply destination directory"
    exit 1
fi

rsync -avz --delete --one-file-system $HOME $1/$HOSTNAME/
