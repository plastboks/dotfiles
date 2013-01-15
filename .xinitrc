# disable the annonying bell
set bell-style none &
/usr/bin/xset b off &

# set cursor speed
/usr/bin/xset r rate 280 160 &

# screensaver
xautolock -time 5 -locker 'sh ${HOME}/.scripts/lock.sh' & 

# keyboard repeat and delay
/usr/bin/xset r rate 280 160 &

# keyboard settings
/usr/bin/setxkbmap -option grp:shift_toggle,grp_led:scroll us,no &
/usr/bin/setxkbmap -option ctrl:nocaps &

# mouse settings
/bin/sh ~/.scripts/mouse.sh & 

# setup monitors
/bin/sh ~/.screenlayout/default.sh &

# start dunst
/usr/bin/dunst &

# start mutt notify
/bin/sh ~/.scripts/mutt-notify.sh &

# gpg agent
eval `gpg-agent --daemon --enable-ssh-support --use-standard-socket`

# execute i3
exec i3
