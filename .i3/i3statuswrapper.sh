#!/bin/sh

i3status --config ~/.i3status.conf | while :
do
    read line
    SL=$(xset -q|grep "Scroll Lock"| awk '{ print $12 }')
    TM=$( free -m | grep "Mem" | awk '{print $2}')
    UM=$( free -m | grep "Mem" | awk '{print $6}')
    KER=$(uname -r)
    CONDISK=$(grep -c "Vendor" /proc/scsi/scsi)
    CPUTEMP=$(sensors | grep "Physical id" | awk '{print $4}')
    CPUGOV=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
    CPUSPEED=$(grep "cpu MHz" /proc/cpuinfo | awk '{sum+=$4} END {printf "%04d", sum/NR}')
    
    CPUS="[{ \"full_text\": \"C.S: $CPUSPEED MHz\", \"color\":\"#335C85\" },"
    CPUG="{ \"full_text\": \"C.G: $CPUGOV\", \"color\":\"#194775\" },"
    CT="{ \"full_text\": \"C.T: $CPUTEMP\", \"color\":\"#335C85\" },"
    MEM="{ \"full_text\": \"M: $UM\/$TM(MB)\", \"color\":\"#194775\" },"
    KERNEL="{ \"full_text\": \"$KER\", \"color\":\"#335C85\" },"
    CDISK="{ \"full_text\": \"Dsk: $CONDISK\", \"color\":\"#194775\" },"

    if [ $SL == "on" ]
    then
        SRL="{ \"full_text\": \"SL: $SL\", \"color\":\"#B2248F\" },"
    else
        SRL="{ \"full_text\": \"SL: $SL\", \"color\":\"#335C85\" },"
    fi


    echo "${line/[/$CPUS $CPUG $CT $MEM $KERNEL $CDISK $SRL}" || exit 1
done
