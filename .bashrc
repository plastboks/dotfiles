#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# aliases
alias ls='ls --color=auto'
alias cpa='rsync -aP'

PS1='[\u@\h \W]\$ '


# PDF merge function using ghostscript
pdfmerge() {
  gs "-dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=./$@ $*"
}


# sshfs mount with fixed arguments
sshrfs() {
  sshfs -o workaround=rename -o cache=yes -o uid=$(id -u) -o gid=$(id -g) $1: $2
}


# This is for now redundant, but will keep it for now...
ssh-add-all() {
  eval `ssh-agent`
  for file in `ls $HOME/.ssh/id_* | grep -v .pub`; do
    ssh-add $file
  done
}


# keychain add
function keychain_all {
  for file in `ls $HOME/.ssh/id_* | grep -v .pub`; do
    /usr/bin/keychain $file
  done

  if [[ -d $HOME/keys ]]; then
    for file in `ls $HOME/keys/id_* | grep -v .pub`; do
      /usr/bin/keychain $file
    done
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
  if [[ -f $CHAINFILE $]]; then
    source $HOME/.keychain/$HOSTNAME-sh > /dev/null
  else
    echo "There does not seem to be a ${CHANFILE}. Maybe run keychain?"
  fi
}


# if keychain has been killed then restart it
if [[ ! -f $HOME/.keychain/$HOSTNAME-sh ]]; then
  keychain_all
fi


# source keychain
keychain_source

