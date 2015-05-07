#!/bin/sh

i3status --config ~/.i3status.conf | while :
do
    read line

    COLOR1="#668066"
    COLOR2="#7A997A"
    COLOR3="#B2248F"

    SL=$(xset -q|grep "Scroll Lock"| awk '{ print $12 }')
    TM=$( free -m | grep "Mem" | awk '{print $2}')
    UM=$( free -m | grep "Mem" | awk '{print $3}')
    KER=$(uname -r)
    CONDISK=$(grep -c "Vendor" /proc/scsi/scsi)
    CPUTEMP=$(sensors | grep "Physical id" | awk '{print $4}')
    CPUGOV=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
    CPUSPEED=$(grep "cpu MHz" /proc/cpuinfo | awk '{sum+=$4} END {printf "%04d", sum/NR}')
    
    CPUS='[{ "full_text": "C.S: '$CPUSPEED' MHz", "color": "'$COLOR1'" },'
    CPUG='{ "full_text": "C.G: '$CPUGOV'", "color": "'$COLOR2'" },'
    CT='{ "full_text": "C.T: '$CPUTEMP'", "color": "'$COLOR1'" },'
    MEM='{ "full_text": "M: '$UM'/'$TM'(MB)", "color": "'$COLOR2'" },'
    KERNEL='{ "full_text": "'$KER'", "color": "'$COLOR1'" },'
    CDISK='{ "full_text": "Dsk: '$CONDISK'", "color": "'$COLOR2'" },'

    if [ $SL == "on" ]
    then
        SRL='{ "full_text": "SL: '$SL'", "color": "'$COLOR3'" },'
    else
        SRL='{ "full_text": "SL: '$SL'", "color": "'$COLOR1'" },'
    fi

    echo "${line/[/$CPUS $CPUG $CT $MEM $KERNEL $CDISK $SRL}" || exit 1
done
