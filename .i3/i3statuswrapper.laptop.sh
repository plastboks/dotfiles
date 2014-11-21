#!/bin/sh

# colors 

CHIG="#656565"
CLOW="#878787"
CSPC="#B2248F"

i3status --config ~/.i3status.conf | while :
do
    read line
    SL=$(xset -q|grep "Scroll Lock"| awk '{ print $12 }')
    TM=$( free -m | grep "Mem" | awk '{print $2}')
    UM=$( free -m | grep "Mem" | awk '{print $3}')
    KER=$(uname -r)
    CONDISK=$(grep -c "Vendor" /proc/scsi/scsi)
    CPUTEMP=$(sensors | grep "Physical id" | awk '{print $4}')
    FANSPEED=$(sensors | grep "fan1" | awk '{print $2}')
    CPUGOV=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
    CPUSPEED=$(grep "cpu MHz" /proc/cpuinfo | awk '{sum+=$4} END {printf "%04d", sum/NR}')
    BACKLIGHT=$(printf "%0.f" "$(xbacklight -get)")

    CPUS="[{ \"full_text\": \"$CPUSPEED MHz\", \"color\":\"$CHIG\" },"
    CPUG="{ \"full_text\": \"C.G: $CPUGOV\", \"color\":\"$CLOW\" },"
    FANS="{ \"full_text\": \"$FANSPEED RPM\", \"color\":\"$CLOW\" },"
    BL="{ \"full_text\": \"BL: $BACKLIGHT\", \"color\":\"$CLOW\" },"
    CT="{ \"full_text\": \"$CPUTEMP\", \"color\":\"$CHIG\" },"
    MEM="{ \"full_text\": \"$UM\/$TM(MB)\", \"color\":\"$CLOW\" },"
    KERNEL="{ \"full_text\": \"$KER\", \"color\":\"$CHIG\" },"
    CDISK="{ \"full_text\": \"Dsk: $CONDISK\", \"color\":\"$CLOW\" },"
   
    if [ $SL == "on" ]
    then
        SRL="{ \"full_text\": \"SL: $SL\", \"color\":\"$CSPC\" },"
    else
        SRL="{ \"full_text\": \"SL: $SL\", \"color\":\"$CHIG\" },"
    fi


    echo "${line/[/$CPUS $FANS $CT $MEM $SRL $BL}" || exit 1
done
