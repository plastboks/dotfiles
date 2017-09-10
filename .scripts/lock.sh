#!/bin/sh


#stop keychain
#/usr/bin/keychain -k all


# take screen shot and distort it
BG_FILE=/home/alex/.wallpaper.png
#scrot $BG_FILE && convert $BG_FILE -scale 4% -scale 2500% $BG_FILE
# activate locker
/usr/bin/i3lock -p default -n -f -c 000000 #-i $BG_FILE
