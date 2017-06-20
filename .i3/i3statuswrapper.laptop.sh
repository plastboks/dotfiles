#!/bin/sh

# colors 

CHIG="#656565"
CLOW="#878787"
CSPC="#B2248F"

i3status --config ~/.i3status.conf | while :
do
    read line

    COLOR1="#668066"
    COLOR2="#7A997A"
    COLOR3="#B2248F"

    SL=$(xset -q|grep "Scroll Lock"| awk '{ print $12 }')
    TM=$( free -m | grep "Mem" | awk '{print $2}')
    UM=$( free -m | grep "Mem" | awk '{print $3}')
    #KER=$(uname -r)
    #CONDISK=$(grep -c "Vendor" /proc/scsi/scsi)
    CPUTEMP=$(sensors coretemp-isa-0000 | grep "Physical id" | awk '{print $4}')
    FANSPEED=$(sensors thinkpad-isa-0000 | grep "fan1" | awk '{print $2}')
    CPUGOV=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
    CPUSPEED=$(grep "cpu MHz" /proc/cpuinfo | awk '{sum+=$4} END {printf "%04d", sum/NR}')
    BACKLIGHT=$(printf "%0.f" "$(xbacklight -get)")

    START='['

    CPUS='{ "full_text": "C.S: '$CPUSPEED' MHz", "color": "'$COLOR1'" },'
    CPUG='{ "full_text": "C.G: '$CPUGOV'", "color": "'$COLOR2'" },'
    CT='{ "full_text": "C.T: '$CPUTEMP'", "color": "'$COLOR1'" },'
    MEM='{ "full_text": "M: '$UM'/'$TM'(MB)", "color": "'$COLOR2'" },'
    #KERNEL='{ "full_text": "'$KER'", "color": "'$COLOR1'" },'
    #CDISK='{ "full_text": "Dsk: '$CONDISK'", "color": "'$COLOR2'" },'
    FANS='{ "full_text": "'$FANSPEED' RPM", "color": "'$CLOW'" },'
    BL='{ "full_text": "BL: '$BACKLIGHT'", "color": "'$CLOW'" },'
   
    if [ $SL == "on" ]
    then
        SRL='{ "full_text": "SL: '$SL'", "color": "'$COLOR3'" },'
    else
        SRL='{ "full_text": "SL: '$SL'", "color": "'$COLOR1'" },'
    fi

    echo "${line/[/ $START $CPUS $CPUG $FANS $CT $MEM $SRL $BL}" || exit 1
done
