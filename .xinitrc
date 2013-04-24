# bell script
/bin/sh ~/.scripts/bell.sh &

# screensaver
xautolock -time 5 -locker 'sh ${HOME}/.scripts/lock.sh' & 

# Only run on darkgray during testing period.
if [[ `hostname -s` = darkgray ]]; then
  /bin/sh ~/.scripts/phonedetect.sh &
fi

# keyboard settings
/bin/sh ~/.scripts/keyboard.sh &

# mouse settings
/bin/sh ~/.scripts/mouse.sh & 

# setup monitors
/bin/sh ~/.screenlayout/default.sh &

# start dunst
/usr/bin/dunst &

# start mutt notify
#/bin/sh ~/.scripts/mutt-notify.sh &

# gpg agent
if [ ! -f ~/.gpg-agent-info ]; then
  gpg-agent --daemon --enable-ssh-support --use-standard-socket --write-env-file
fi

# execute i3
exec i3
