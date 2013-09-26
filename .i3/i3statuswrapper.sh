#!/bin/sh

i3status --config ~/.i3status.conf | while :
do
    read line
    SL=$(xset -q|grep "Scroll Lock"| awk '{ print $12 }')
    TM=$( free -m | grep "Mem" | awk '{print $2}')
    UM=$( free -m | grep "buffers\/cache" | awk '{print $3}')
    CPUTEMP=$(sensors | grep "Physical id" | awk '{print $4}')
    CPUGOV=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
    CPUSPEED=$(grep "cpu MHz" /proc/cpuinfo | awk '{sum+=$4} END {printf "%04d", sum/NR}')
    
    CPUS="[{ \"full_text\": \"CPU S: $CPUSPEED MHz\", \"color\":\"#666666\" },"
    if [ $SL == "on" ]
    then
        dat="{ \"full_text\": \"SL: $SL\", \"color\":\"#FF8C00\" },"
    else
        dat="{ \"full_text\": \"SL: $SL\", \"color\":\"#FF00FF\" },"
    fi
    MEM="{ \"full_text\": \"MEM: $UM\/$TM(MB)\", \"color\":\"#00FFFF\" },"
    CT="{ \"full_text\": \"CPU T: $CPUTEMP\", \"color\":\"#FFFF00\" },"
    CPUG="{ \"full_text\": \"CPU G: $CPUGOV\", \"color\":\"#7FFFG4\" },"
    echo "${line/[/$CPUS $CPUG $dat $MEM $CT }" || exit 1
done
