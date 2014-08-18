#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.includes/aliases
source ~/.includes/exports
source ~/.includes/colors

source ~/.scripts/functions.sh
source ~/.scripts/git-prompt.sh


# Change PS1 based on session.
if [ ! -n "$SSH_TTY" ]; then
    PS1="\[$bldpur\][\[$txtcyn\]\u@\\h \\W\[$txtylw\]\$(__git_ps1)\[$bldpur\]]\[$txtrst\]$ "
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
