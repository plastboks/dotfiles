#
# ~/.bashrc
#

export EDITOR='vim'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


PS1="[\[\033[36m\]\u@\\h \\W\[\033[m\]]\$ "


source ~/.scripts/functions.sh
source ~/.scripts/aliases.sh


# gpg-agent create
function gac {
  /usr/bin/gpg-agent --daemon --enable-ssh-support --use-standard-socket --write-env-file
}


# gpg-agent read 
function gar {
  eval $(cat ~/.gpg-agent-info)
  eval $(cut -d= -f 1 < ~/.gpg-agent-info | xargs echo export)
}


# gpg-agent
if [ ! -f ~/.gpg-agent-info ]; then
  gac
else
  gar
fi
