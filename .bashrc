#
# ~/.bashrc
#

export EDITOR=vim
export BROWSER=dwb
export TRANSPARENCY=95

export PATH=${PATH}:~/bin
export PATH=${PATH}:~/.bin
export PATH=${PATH}:~/.scripts

export PATH=${PATH}:~/android/android-sdk-linux/tools
export PATH=${PATH}:~/android/android-sdk-linux/platform-tools
export JAVA_HOME='/usr/lib/jvm/java-7-openjdk' #override for android studio
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on' #fix for intellji

export PATH="$HOME/.dynamic-colors/bin:$PATH"

source ~/.scripts/functions.sh
source ~/.scripts/aliases.sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Change PS1 based on session.
if [ ! -n "$SSH_TTY" ]; then
  PS1="\[\033[35m\][\[\033[36m\]\u@\\h \\W\[\033[35m\]]\[\033[m\]\$ "
else
  PS1="SSH-[\[\033[0;31m\]\u@\\h \\W\[\033[m\]]\$ "
fi

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
