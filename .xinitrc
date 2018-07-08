#!/bin/bash

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# bell settings
belloff

# monitors setup
/bin/sh ~/.screenlayout/default.sh &

/usr/bin/xset b off
/usr/bin/xset r rate 280 160
/usr/bin/setxkbmap -option grp:shift_toggle,grp_led:scroll us,no
/usr/bin/setxkbmap -option ctrl:nocaps

# screensaver
#xautolock -time 5 -locker 'sh ${HOME}/.scripts/lock.sh' &
xautolock -time 5 -locker slock &


# backlight
if [[ -f ~/.backlight ]]; then
    xbacklight -set $(cat ~/.backlight)
fi

# execute i3
exec i3
