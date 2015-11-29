#!/bin/bash
#
# Some simple functions to make life easier
#


# PDF merge function using ghostscript
function pdfmerge() {
  gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=$1 ${*:2}
}


# sshfs mount with fixed arguments
function sshrfs() {
  sshfs -o workaround=rename -o cache=yes -o uid=$(id -u) -o gid=$(id -g) $1: $2
}


# No ugly whitespaces
function noUglyWhitespace {
  for f in $1; do mv "$f" `echo $f | tr ' ' '_'`; done
}


# This is redundant, but will keep it for now...
function sshAddAll() {
  eval `ssh-agent`
  for file in `ls $HOME/.ssh/id_* | grep -v .pub`; do
    ssh-add $file
  done
}


# network card up
function wifiup {
  WIRELESSDEVICE=`ip a | egrep -i 'mq' | awk '/:/ { sub(":", "", $2); print $2 }'`
  sudo ip link set $WIRELESSDEVICE up
}


# network card up
function wifidown {
  WIRELESSDEVICE=`ip a | egrep -i 'mq' | awk '/:/ { sub(":", "", $2); print $2 }'`
  sudo ip link set $WIRELESSDEVICE down
}


# network manager nmcli wrapper function
function wificonnect {
  # usage: wificonnect ssid password
  /usr/bin/nmcli dev wifi con $1 password $2 name $1
}


# network manager nmcli wrapper function
function wifidisconnect {
  /usr/bin/nmcli nm wifi off
}


# simple network scan
function wifiscan {
  WIRELESSDEVICE=`ip a | egrep -i 'mq' | awk '/:/ { sub(":", "", $2); print $2 }'`
  sudo iw dev $WIRELESSDEVICE scan | egrep -i --color 'SSID|signal'
}


# webcamtest
function webcamtest {
  /usr/bin/mplayer tv:// -tv driver=v4l2:width=352:height=288  
}


# openvpn
function runvpn {
  sudo /usr/bin/openvpn --config \
      /etc/openvpn/mullvad_linux.conf --writepid /etc/openvpn/run.pid
}

# pptp vpn
function runvpnpptpdebug {
    if [ -z "$1" ]
    then
      echo "Please enter pptp connection name"
    else
       sudo pon $1 debug dump logfd 2 nodetach
    fi
}


#screenshot from terminal
function screenshot {
    if [ -z "$1" ]
    then
      echo "Please enter filename"
    else
      import -window root $1
      sxiv $1
    fi
}


# tail follow with color highlight
#
# usage: 
# tailfc file foo # highlight foo
# tailfc file "(foo|bar)" # highlight the strings foo and bar
# tailfc file "\b((foo|bar)\b" # highlight the words foo and bar
# tailfc file ".*\b((foo|bar)\b.*" highlight the whole line that contains the words foo or bar
# 
function tailfc {
    tail -f $1 | perl -pe "s/$2/\e[1;31;43m$&\e[0m/g"
}


# clean pesky webcache
function cleanwebcache {
    if [ -d "$HOME/.mozilla/firefox" ]; then
        echo "Deleting ~/.mozilla/firefox"
        rm -r $HOME/.mozilla/firefox
    fi
    if [ -d "$HOME/.cache/mozilla/firefox" ]; then
        echo "Deleting ~/.cache/mozilla/firefox"
        rm -r $HOME/.cache/mozilla/firefox
    fi
    if [ -d "$HOME/.cache/webkitgtk/applications" ]; then
        echo "Deleting ~/.cache/webkitgtk/applications"
        rm -r $HOME/.cache/webkitgtk/applications
    fi
    if [ -d "$HOME/.local/share/webkit" ]; then
        echo "Deleting ~/.local/share/webkit"
        rm -r $HOME/.local/share/webkit
    fi
}


# btrfs defrag
function defrag {
    sudo btrfs filesystem defragment -r -v /
}


# just a random string generator
function randomstring {
    if [ -z "$1" ] || [[ $1 != [0-9]* ]]
    then
        echo "Please enter char length (integer)"
    else
        cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $1 | head -n 1
    fi
}


# belloff
function belloff {
    set bell-style none
    /usr/bin/xset b off
}


# keyboard settings
function keyboard {
    # keyboard repeat and delay
    /usr/bin/xset r rate 280 160 

    # keyboard settings
    /usr/bin/setxkbmap -option grp:shift_toggle,grp_led:scroll us,no
    /usr/bin/setxkbmap -option ctrl:nocaps
}


# trackball settings
function trackball {
    MOUSENAME="Kensington      Kensington USB/PS2 Orbit" # The six spaces is important

    # enable mouse scrolling for a mouse without scrollwheel
    /usr/bin/xinput set-int-prop "${MOUSENAME}" "Evdev Wheel Emulation" 8 1

    # bind scrolling to right mouse button
    /usr/bin/xinput set-int-prop "${MOUSENAME}" "Evdev Wheel Emulation Button" 8 3

    # emulate 3rd mouse button
    /usr/bin/xinput set-int-prop "${MOUSENAME}" "Evdev Middle Button Emulation" 8 1
}


# touchpad toggle
function touchpadtoggle {
    SYNSTATE=$(synclient -l | grep TouchpadOff | awk '{ print $3 }')

    # change to other state
    if [ $SYNSTATE = 0 ]; then
        synclient touchpadoff=1
    elif [ $SYNSTATE = 1 ]; then
        synclient touchpadoff=0
    else
        echo "Couldn't get touchpad status from synclient"
        exit 1
    fi
}


# terminal colors
function term_colors {
    ( x=`tput op` y=`printf %$((${COLUMNS}-6))s`;
    for i in {0..256};
    do
        o=00$i;
        echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;
        done )
}


# gpg ssh agent
function gpg-ssh {
    killall -9 gpg-agent
    gpg-agent --daemon --enable-ssh-support --use-standard-socket 2>/dev/null
}


# This script was yanked from archlinux forum post 101413.
# Thanks to user Foucault for supplying it.
# 
# Example script usage:
#   `flag2ogg.sh 'file' 'quality'`
#
# Example usage is for multiple files in a directory: 
#   `for file in *.flac; do flac2ogg.sh $file QUALITY; done`
#
# Quality is typical 6 for CDs, (Higher is better).
#
# Archlinux package vorbis-tools is needed for oggenc.
#
function flac2ogg {
    file=${1/.flac/}
    qual=$2
    echo "File: $file.flac"
    echo "Quality: $qual"
    title=`metaflac --show-tag="title" "$file.flac" | sed -e "s/title=//gI"`
    artist=`metaflac --show-tag="artist" "$file.flac" | sed -e "s/artist=//gI"`
    album=`metaflac --show-tag="album" "$file.flac" | sed -e "s/album=//gI"`
    date=`metaflac --show-tag="date" "$file.flac" | sed -e "s/date=//gI"`
    genre=`metaflac --show-tag="genre" "$file.flac" | sed -e "s/genre=//gI"`
    track=`metaflac --show-tag="tracknumber" "$file.flac" | sed -e "s/tracknumber=//gI"`

    flac -c -d "$file.flac" | oggenc -t "$title" \
                                     -a "$artist" \
                                     -G "$genre" \
                                     -l "$album" \
                                     -d "$date" \
                                     -n "$track" \
                                     -o $file.ogg \
                                     -q $qual -
}


# mp3 to ogg
#
# usage example: `for f in *.mp3; do ~/.scripts/mp32ogg.sh $f; done`
function mp32ogg {
    filename=$(basename "$1")
    file="${filename%.*}"
    echo "File: $file.mp3"

    ARTIST=`eyeD3 "$file.mp3" | grep "artist" | sed -s 's/artist: //g'`
    echo "Artist: "$ARTIST
    TITLE=`eyeD3 "$file.mp3" | grep "title" | sed -s 's/title: //g'`
    echo "Title: "$TITLE
    GENRE=`eyeD3 "$file.mp3" | grep "genre" | grep "genre" | awk -F : '{print $NF}' | sed -e 's/^[ \t]*//'`
    echo "Genre: "$GENRE
    YEAR=`eyeD3 "$file.mp3" | grep "recording date" | sed -s 's/recording date: //g'`
    echo "Year: "$YEAR
    TRACK=`eyeD3 "$file.mp3" | grep "track" | awk '{print $2}'`
    echo "Track: "$TRACK
    LABEL=`eyeD3 "$file.mp3" | grep "album" | sed -s 's/title: //g'`
    echo "Album: "$LABEL

    lame --decode "$file.mp3" - | oggenc --resample 22050 \
                                         -a "$ARTIST" \
                                         -t "$TITLE" \
                                         -l "$LABEL" \
                                         -G "$GENRE" \
                                         -d "$YEAR" \
                                         -N "$TRACK" \
                                         -o "$file.ogg" -
    printf "\n"
}


# image distort
function distort {

    if [ -z "$2" ]; then
        echo "Usage: $0 <imagefile> <percent>"
        return
    fi

    file=$1
    percent=$2
    let "upscale = 10000/$percent"

    echo $file
    echo $percent
    echo $upscale

    convert $file -scale "$percent%" -scale "$upscale%" $file

}
