#!/bin/sh
curDir=$(pwd)

if [ ! -d ~/.config ]; then
  mkdir ~/.config
fi
if [ ! -d ~/.config/gtk-3.0 ]; then
  mkdir ~/.config/gtk-3.0
fi

ln -s $1 $curDir/i3                   ~/.config/
ln -s $1 $curDir/i3status             ~/.config/
ln -s $1 $curDir/gtk-3.0/settings.ini ~/.config/gtk-3.0/
ln -s $1 $curDir/.vim                 ~/
ln -s $1 $curDir/.Xresources          ~/
ln -s $1 $curDir/.zshrc               ~/
ln -s $1 $curDir/.keynavrc            ~/
