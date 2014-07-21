# bell settings
/bin/sh ~/.scripts/bell.sh &

# keyboard settings
/bin/sh ~/.scripts/keyboard.sh &

# trackball settings
#/bin/sh ~/.scripts/trackball.sh & 

# monitors setup
/bin/sh ~/.screenlayout/default.sh &

# screensaver
xautolock -time 5 -locker 'sh ${HOME}/.scripts/lock.sh' & 

# start dunst
dunst &

# start redshift
redshift &

# start pulseaudio
pulseaudio --start &

# start xcompmgr
xcompmgr -c -C -t-5 -l-5 -r4.2 -o.55 &

# start urxvt server
urxvtd -q -f -o &

# xrdb
xrdb ~/.Xresources &

# start mutt notify
#/bin/sh ~/.scripts/mutt-notify.sh &

# gpg agent
if [ ! -f ~/.gpg-agent-info ]; then
  gpg-agent --daemon --enable-ssh-support --use-standard-socket --write-env-file
fi

# execute i3
exec i3
