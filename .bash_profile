#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# gpg agent
if [ ! -f ~/.gpg-agent-info ]; then
  gpg-agent --daemon --enable-ssh-support --use-standard-socket --write-env-file
fi

# source bashrc 
source $HOME/.bashrc
