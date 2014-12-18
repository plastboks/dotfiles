#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# gpg agent
gpg-agent --daemon --enable-ssh-support --use-standard-socket > /dev/null

# source bashrc 
source $HOME/.bashrc
