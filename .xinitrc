# bell settings
/bin/sh ~/.scripts/bell.sh &

# keyboard settings
/bin/sh ~/.scripts/keyboard.sh &

# trackball settings
#/bin/sh ~/.scripts/trackball.sh & 

# screensaver
/usr/bin/xautolock -time 5 -locker 'sh ${HOME}/.scripts/lock.sh' & 

# monitors setup
/bin/sh ~/.screenlayout/default.sh &

# start dunst
/usr/bin/dunst &

# start redshift
/usr/bin/redshift &

# start pulseaudio
/usr/bin/pulseaudio --start &

# start xcompmgr
/usr/bin/xcompmgr -c -C -t-5 -l-5 -r4.2 -o.55 &

# start mutt notify
#/bin/sh ~/.scripts/mutt-notify.sh &

# gpg agent
if [ ! -f ~/.gpg-agent-info ]; then
  gpg-agent --daemon --enable-ssh-support --use-standard-socket --write-env-file
fi

# execute i3
exec i3
