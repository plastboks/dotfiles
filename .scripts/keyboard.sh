#!/bin/sh
#
# A simple script for setting up the keyboard (the way I like it).
#

# keyboard repeat and delay
/usr/bin/xset r rate 280 160 

# keyboard settings
/usr/bin/setxkbmap -option grp:shift_toggle,grp_led:scroll us,no
/usr/bin/setxkbmap -option ctrl:nocaps

