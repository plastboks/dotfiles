#!/bin/sh

i3status --config ~/.i3status.conf | while :
do
    read line
    SL=$(xset -q|grep "Scroll Lock"| awk '{ print $12 }')
    TM=$( free -m | grep "Mem" | awk '{print $2}')
    UM=$( free -m | grep "buffers\/cache" | awk '{print $3}')
    KER=$(uname -r)
    CONDISK=$(grep -c "Vendor" /proc/scsi/scsi)
    CPUTEMP=$(sensors | grep "Physical id" | awk '{print $4}')
    CPUGOV=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
    CPUSPEED=$(grep "cpu MHz" /proc/cpuinfo | awk '{sum+=$4} END {printf "%04d", sum/NR}')
    
    MEM="[{ \"full_text\": \"M: $UM\/$TM(MB)\", \"color\":\"#00FFFF\" },"
    CPUS="{ \"full_text\": \"C.S: $CPUSPEED MHz\", \"color\":\"#666666\" },"
    CPUG="{ \"full_text\": \"C.G: $CPUGOV\", \"color\":\"#7FFFG4\" },"
    CT="{ \"full_text\": \"C.T: $CPUTEMP\", \"color\":\"#FFFF00\" },"
    KERNEL="{ \"full_text\": \"$KER\", \"color\":\"#4D4DDC\" },"
    CDISK="{ \"full_text\": \"Dsk: $CONDISK\", \"color\":\"#D2691E\" },"

    if [ $SL == "on" ]
    then
        SRL="{ \"full_text\": \"SL: $SL\", \"color\":\"#FF8C00\" },"
    else
        SRL="{ \"full_text\": \"SL: $SL\", \"color\":\"#FF00FF\" },"
    fi


    echo "${line/[/$MEM $SRL}" || exit 1
done
