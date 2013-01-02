#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Start ssh-agent
# eval `ssh-agent`

# make functions global
source $HOME/.scripts/functions.sh
