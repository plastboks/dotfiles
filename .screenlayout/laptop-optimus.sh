#!/bin/sh
xrandr --output VIRTUAL1 --off \
       --output VIRTUAL2 --off \
       --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
