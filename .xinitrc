# bell settings
belloff

# monitors setup
/bin/sh ~/.screenlayout/default.sh &

/usr/bin/xset b off
/usr/bin/xset r rate 280 160
/usr/bin/setxkbmap -option grp:shift_toggle,grp_led:scroll us,no
/usr/bin/setxkbmap -option ctrl:nocaps

# screensaver
xautolock -time 5 -locker 'sh ${HOME}/.scripts/lock.sh' & 

# backlight
if [[ -f ~/.backlight ]]; then
    xbacklight -set $(cat ~/.backlight)
fi

# xrdb
xrdb ~/.Xresources &

# execute i3
exec i3
