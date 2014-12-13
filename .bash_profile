#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# gpg agent
gpg-agent --daemon --enable-ssh-support --use-standard-socket

# source bashrc 
source $HOME/.bashrc
