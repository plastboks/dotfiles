#!/bin/sh


if [[ `hostname -s` = gray ]]; then 
  /usr/bin/xrandr \
    --output VGA-1 --mode 1920x1080 --pos 0x0 --rotate normal \
    --output DVI-I-1 --mode 1920x1200 --pos 1920x0 --rotate normal \
    --output HDMI-1 --off
fi

