#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# make functions global
source $HOME/.scripts/functions.sh

# keychain add
function keychain_all {
  
  # startup keychain
  for file in `ls $HOME/.ssh/id_* | grep -v .pub`; do
    /usr/bin/keychain $file
  done

  # load additional keys into keychain
  if [[ -d $HOME/keys ]]; then
    for file in `ls $HOME/keys/id_* | grep -v .pub`; do
      /usr/bin/keychain $file
    done
  fi

}

# keychain stop
function keychain_stop {
  /usr/bin/keychain -k
}

if [[ ! -f $HOME/.keychain/$HOSTNAME-sh ]]; then
  keychain_all
fi

# source keychain
source $HOME/.keychain/$HOSTNAME-sh > /dev/null
