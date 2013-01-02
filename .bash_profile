#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# source bashrc 
source $HOME/.bashrc

if [[ ! -f $HOME/.keychain/$HOSTNAME-sh ]]; then
  keychain_all
fi

# source keychain
keychain_source
