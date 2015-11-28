#!/bin/sh

# -- DarkGray -- #
if [[ `hostname -s` = darkgray ]]; then
    /usr/bin/xrandr \
        --output VIRTUAL1 \
        --off --output DP3 \
        --off --output DP2 \
        --off --output DP1 \
        --off --output HDMI3 \
        --mode 1920x1200 --pos 3200x0 --rotate normal \
        --output HDMI2 --primary --mode 1920x1200 --pos 1280x0 --rotate normal \
        --output HDMI1 --mode 1280x960 --pos 0x240 --rotate normal \
        --output VGA1 --off
fi
