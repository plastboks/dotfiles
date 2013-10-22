#!/bin/bash

SCRIPT=`readlink -f $0`
DOTPATH=`dirname $SCRIPT`
CONFIGDIR=$HOME/.config
DOWNLOADSDIR=$HOME/downloads

# config dir
if [ -d $CONFIGDIR ]; then
  echo "${CONFIGDIR} exists"
else
  mkdir $CONFIGDIR
fi

# bin dir
rm -r $HOME/.bin
ln -s $DOTPATH/.bin $HOME

# scripts
rm -r $HOME/.scripts
ln -s $DOTPATH/.scripts $HOME

# bash files
rm $HOME/.bashrc
ln -s $DOTPATH/.bashrc $HOME
rm $HOME/.bash_profile
ln -s $DOTPATH/.bash_profile $HOME

# gnupg
rm -r $HOME/.gnupg
ln -s $DOTPATH/.gnupg $HOME

# i3
rm -rf $HOME/.i3
ln -s $DOTPATH/.i3 $HOME

# i3status
printf "\n"
read -p "Laptop (different i3status) [y/N]" -n 1 -r
if [[ $REPLY =~ [Yy]$ ]]; then
  rm $HOME/.i3status.conf
  ln -s $DOTPATH/.i3status.conf.laptop $HOME/.i3status.conf
  ln -s $DOTPATH/.i3/config.laptop $DOTPATH/.i3/config
else 
  rm $HOME/.i3status.conf
  ln -s $DOTPATH/.i3status.conf $HOME
  ln -s $DOTPATH/.i3/config.main $DOTPATH/.i3/config
fi


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
# leave out the mutt homedir for now.
#rm -r $HOME/.mutt
#ln -s $DOTPATH/.mutt $HOME
rm -r $HOME/.muttrc
ln -s $DOTPATH/.muttrc $HOME
rm -r $HOME/.mailcap
ln -s $DOTPATH/.mailcap $HOME

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

# Irssi
rm -r $HOME/.irssi
ln -s $DOTPATH/.irssi $HOME

# Luakit
rm -r $HOME/.config/luakit
ln -s $DOTPATH/.config/luakit $HOME/.config/luakit

# Uzbl
rm -r $HOME/.config/uzbl
ln -s $DOTPATH/.config/uzbl $HOME/.config/uzbl

# dwb
rm -r $HOME/.config/dwb
ln -s $DOTPATH/.config/dwb $HOME/.config/dwb

# fontconfig
rm -r $HOME/.config/fontconfig
ln -s $DOTPATH/.config/fontconfig $HOME/.config/fontconfig

# pcmanfm
rm -r $HOME/.config/pcmanfm
ln -s $DOTPATH/.config/pcmanfm $HOME/.config/pcmanfm

# GTK setup
rm -r $HOME/.gtkrc-2.0
ln -s $DOTPATH/.gtkrc-2.0 $HOME

# Screenlayout
rm -r $HOME/.screenlayout
ln -s $DOTPATH/.screenlayout $HOME

# dunst
rm -r $HOME/.config/dunst
ln -s $DOTPATH/.config/dunst $HOME/.config/dunst

# asound
#rm -r $HOME/.asoundrc
#ln -s $DOTPATH/.asoundrc $HOME
