#!/bin/bash

SCRIPT=`readlink -f $0`
DOTPATH=`dirname $SCRIPT`

# config dir
if [! -d $HOME/.config ]; then
  mkdir $HOME/.config
fi

# downloads dir
if [! -d $HOME/downloads ]; then 
  mkdir -p $HOME/downloads/tmp
fi

# bash files
rm $HOME/.bashrc
ln -s $DOTPATH/.bashrc $HOME
rm $HOME/.bash_profile
ln -s $DOTPATH/.bash_profile $HOME

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

# Newsbeuter
rm -r $HOME/.newsbeuter
ln -s $DOTPATH/.newsbeuter $HOME

# Luakit
rm -r $HOME/.config/luakit
ln -s $DOTPATH/.config/luakit $HOME/.config

# pcmanfm
rm -r $HOME/.config/pcmanfm
ln -s $DOTPATH/.config/pcmanfm $HOME/.config

# GTK setup
rm -r $HOME/.gtkrc-2.0
ln -s $DOTPATH/.gtkrc-2.0 $HOME

# Screenlayout
rm -r $HOME/.screenlayout
ln -s $DOTPATH/.screenlayout $HOME
