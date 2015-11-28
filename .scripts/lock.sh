#!/bin/sh


#stop keychain
#/usr/bin/keychain -k all


# take screen shot and distort it
BG_FILE=/tmp/screen_locked.png
scrot $BG_FILE && convert $BG_FILE -scale 4% -scale 2500% $BG_FILE
# activate locker
/usr/bin/i3lock -i $BG_FILE -p default -d -n -f
