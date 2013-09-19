#!/bin/sh

i3status --config ~/.i3status.conf | while :
do
    read line
    SL=$(xset -q|grep "Scroll Lock"| awk '{ print $12 }')
    if [ $SL == "on" ]
    then
        dat="[{ \"full_text\": \"SL: $SL\", \"color\":\"#009E00\" },"
    else
        dat="[{ \"full_text\": \"SL: $SL\", \"color\":\"#C60101\" },"
    fi
    echo "${line/[/$dat}" || exit 1
done
