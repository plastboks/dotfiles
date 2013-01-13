#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# aliases
alias ls='ls --color=auto'
alias cpa='rsync -aP'
alias enable_alert='PS1="$PS1\a"'

PS1='[\u@\h \W]\$ '


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


# keychain add
function keychain_all {
  read -p "Load ssh keys [y/N] " -n 1 -r
  if [[ $REPLY =~ [Yy]$ ]]; then
    # load keys in ~/.ssh
    for file in `ls $HOME/.ssh/id_* | grep -v .pub`; do
      /usr/bin/keychain $file
    done
    # try to load keys in ~/keys
    if [[ -d $HOME/keys ]]; then
      for file in `ls $HOME/keys/id_* | grep -v .pub`; do
        /usr/bin/keychain $file
      done
    fi
    # source the result
    keychain_source
  fi
}


# keychain append
function keychain_append {
  # load additional keys into keychain
  if [[ -d $HOME/keys ]]; then
    for file in `ls $HOME/keys/id_* | grep -v .pub`; do
      /usr/bin/keychain $file
    done
  fi
}


# keychain stop
function keychain_stop {
  /usr/bin/keychain -k all
}


# keychain source
function keychain_source { 
  CHAINFILE=$HOME/.keychain/$HOSTNAME-sh
  if [[ -f $CHAINFILE ]]; then
    source $HOME/.keychain/$HOSTNAME-sh > /dev/null
    source $HOME/.keychain/$HOSTNAME-sh-gpg > /dev/null
  else
    printf "\nThere does not seem to be a ${CHANFILE}. Maybe run keychain?\n"
  fi
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

# if keychain has been killed then restart it
#if [[ ! -f $HOME/.keychain/$HOSTNAME-sh ]]; then
#  keychain_all
#fi

eval `gpg-agent --daemon --use-standard-socket`

# source keychain
#keychain_source

