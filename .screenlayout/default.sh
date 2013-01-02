#!/bin/sh

# -- Gray -- #

if [[ `hostname -s` = gray ]]; then 
  /usr/bin/xrandr \
    --output VGA-1 --mode 1920x1080 --pos 0x0 --rotate normal \
    --output DVI-I-1 --mode 1920x1200 --pos 1920x0 --rotate normal \
    --output HDMI-1 --off
fi


# -- LightGray -- #

if [[ `hostname -s` = lightgray ]]; then
  /usr/bin/xrandr \
    --output VGA-1 --off \
    --output TV-1 --off 
    --output DVI-I-1 --mode 1680x1050 --pos 0x0 --rotate normal
fi
