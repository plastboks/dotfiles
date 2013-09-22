#!/bin/sh

i3status --config ~/.i3status.conf | while :
do
    read line
    SL=$(xset -q|grep "Scroll Lock"| awk '{ print $12 }')
    TM=$( free -m | grep "Mem" | awk '{print $2}')
    UM=$( free -m | grep "buffers\/cache" | awk '{print $3}')
    CPUTEMP=$(sensors | grep "Core 0" | awk '{print $3}')
    if [ $SL == "on" ]
    then
        dat="[{ \"full_text\": \"SL: $SL\", \"color\":\"#FF8C00\" },"
    else
        dat="[{ \"full_text\": \"SL: $SL\", \"color\":\"#FF00FF\" },"
    fi
    MEM="{ \"full_text\": \"MEM: $TM\/$UM(MB)\", \"color\":\"#00FFFF\" },"
    CT="{ \"full_text\": \"CPU T: $CPUTEMP\", \"color\":\"#FFFF00\" },"
    echo "${line/[/$dat $MEM $CT}" || exit 1
done
