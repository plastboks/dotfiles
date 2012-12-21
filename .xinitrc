# disable the annonying bell
set bell-style none &
/usr/bin/xset b off &

# set cursor speed
/usr/bin/xset r rate 280 160 &

# screensaver
/usr/bin/xautolock -time 5 -locker 'i3lock --color=000000' & 

# keyboard repeat and delay
/usr/bin/xset r rate 280 160 &

# Autostart the Dropbox deamon
#sleep 2s && ~/.dropbox-dist/dropboxd &

# keyboard settings
/usr/bin/setxkbmap -option grp:shift_toggle,grp_led:scroll us,no &
/usr/bin/setxkbmap -option ctrl:nocaps &

# setup monitors
/bin/sh ~/.screenlayout/default.sh &

# start dunst
/usr/bin/dunst &

# start mutt notify
/bin/sh ~/.scripts/mutt-notify.sh &

# ssh
eval `ssh-agent`
exec ssh-add

# execute i3
exec i3
