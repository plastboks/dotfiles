#!/bin/bash
#
# Some simple functions to make life easier
#


# PDF merge function using ghostscript
function pdfmerge() {
  gs "-dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=./$@ $*"
}


# pacman update (because i am a lazy motherfu**er)
function pacman-upgrade() {
  sudo pacman -Syu
}


# sshfs mount with fixed arguments
function sshrfs() {
  sshfs -o workaround=rename -o cache=yes -o uid=$(id -u) -o gid=$(id -g) $1: $2
}


# This is for now redundant, but will keep it for now...
function ssh-add-all() {
  eval `ssh-agent`
  for file in `ls $HOME/.ssh/id_* | grep -v .pub`; do
    ssh-add $file
  done
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

