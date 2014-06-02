#
# ~/.bashrc
#

export EDITOR='vim'
export PATH=${PATH}:~/bin
export PATH=${PATH}:~/.scripts
export PATH=${PATH}:~/android/android-sdk-linux/tools
export PATH=${PATH}:~/android/android-sdk-linux/platform-tools

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ ! -n "$SSH_TTY" ]; then
  PS1="\[\033[35m\][\[\033[36m\]\u@\\h \\W\[\033[35m\]]\[\033[m\]\$ "
else
  PS1="SSH-[\[\033[0;31m\]\u@\\h \\W\[\033[m\]]\$ "
fi

source ~/.scripts/functions.sh
source ~/.scripts/aliases.sh

# gpg-agent create
function gac {
  rm ~/.gpg-agent-info
  /usr/bin/gpg-agent --daemon --enable-ssh-support --use-standard-socket --write-env-file
}

# gpg-agent read 
function gar {
  eval $(cat ~/.gpg-agent-info)
  eval $(cut -d= -f 1 < ~/.gpg-agent-info | xargs echo export)
}

# gpg-agent (only for local users)
if [ ! -n "$SSH_TTY" ]; then
    if [ ! -f ~/.gpg-agent-info ]; then
      gac
    else
      gar
    fi
fi

# tmux / color terms
#export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM="screen-256color"

# Change the window title of X terminals 
if [[ $TERM =~ "xterm|*rxvt*" ]]; then
    # set -o functrace
    trap 'set_title' DEBUG
fi
