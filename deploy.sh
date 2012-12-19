#!/bin/bash

SCRIPT=`readlink -f $0`
DOTPATH=`dirname $SCRIPT`

# i3status
rm $HOME/.i3status.conf
ln -s $DOTPATH/.i3status.conf $HOME

# i3
rm -rf $HOME/.i3
ln -s $DOTPATH/.i3 $HOME

# xinitrc
rm -r $HOME/.xinitrc
ln -s $DOTPATH/.xinitrc $HOME

# mplayer
rm -r $HOME/.mplayer
ln -s $DOTPATH/.mplayer $HOME

# vim
rm -r $HOME/.vimrc 
ln -s $DOTPATH/.vimrc $HOME

# mutt
rm -r $HOME/.mutt
ln -s $DOTPATH/.mutt $HOME

# Xkbmap
rm -r $HOME/.Xkbmap
ln -s $DOTPATH/.Xkbmap $HOME

# Xdefaults
rm -r $HOME/.Xdefaults
ln -s $DOTPATH/.Xdefaults $HOME

# TMUX
rm -r $HOME/.tmux.conf
ln -s $DOTPATH/.tmux.conf $HOME


