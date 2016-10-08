# bell settings
belloff

# keyboard settings
keyboard

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
pulseaudio-dlna --codec wav --encoder-backend=ffmpeg --port 8081 &

# start xcompmgr
#xcompmgr -c -C -t-5 -l-5 -r4.2 -o.55 &

# straight out of compton
#compton --config ~/.compton.conf

# start urxvt server
urxvtd -q -f -o &

# xrdb
xrdb ~/.Xresources &

# dropbox
dropbox &

# social
slack &
telegram-desktop &

# autocutsel
autocutsel -fork &
autocutsel -selection PRIMARY -fork &

# set wallpaper
if [ ! -f ~/.wallpaper.png ]; then
    feh --bg-scale /usr/share/archlinux/wallpaper/archlinux-simplyblack.png
else
    feh --bg-scale ~/.wallpaper.png
fi

# execute i3
exec i3
