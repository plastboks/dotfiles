#!/bin/sh
# 
# A simple script for mouse scroll emulation
#

MOUSENAME="Kensington      Kensington USB/PS2 Orbit" # The six spaces is important

# enable mouse scrolling for a mouse without scrollwheel
/usr/bin/xinput set-int-prop "${MOUSENAME}" "Evdev Wheel Emulation" 8 1

# bind scrolling to right mouse button
/usr/bin/xinput set-int-prop "${MOUSENAME}" "Evdev Wheel Emulation Button" 8 3

# emulate 3rd mouse button
/usr/bin/xinput set-int-prop "${MOUSENAME}" "Evdev Middle Button Emulation" 8 1
