#!/bin/sh

SECONDS_TO_WAIT=2
OUTPUT_MODE="544-1920x1200"

printf "=> Restarting Bumblebeed, and waiting $SECONDS_TO_WAIT seconds\n"
sudo systemctl restart bumblebeed.service
sleep $SECONDS_TO_WAIT
printf "=> Init optirun, and force intel-virtual-output to restart\n"
optirun true 
intel-virtual-output -S
printf "=> Setting up external monitor with output mode: $OUTPUT_MODE\n"
xrandr --output VIRTUAL2 --mode VIRTUAL2.$OUTPUT_MODE --pos 0x0 --rotate normal \
       --output eDP1 --primary --mode 1920x1080 --pos 1920x120 --rotate normal
