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

# This is for now redundant, but will keep it for now...
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

#open vpn
function runvpn {
  sudo /usr/bin/openvpn --config /etc/openvpn/mullvad_linux.conf --writepid /etc/openvpn/run.pid
}

#screenshot from terminal
function screenshot {
    if [ -z "$1" ]
    then
      echo "Please enter filename"
    else
      import -window root $1
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
    rm -r $HOME/.mozilla/firefox
    rm -r $HOME/.cache/mozilla/firefox
    rm -r $HOME/.cache/webkitgtk/applications/*
}
