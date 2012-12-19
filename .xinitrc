# disable the annonying bell
set bell-style none &
xset b off &

# set cursor speed
xset r rate 280 160 &

# execute i3
exec i3

# screensaver
sleep 2s && /usr/bin/xautolock -time 5 -locker 'i3lock --color=000000' & 

# keyboard repeat and delay
sleep 2s && /usr/bin/xset r rate 280 160 &

# Autostart the Dropbox deamon
#sleep 2s && ~/.dropbox-dist/dropboxd &

