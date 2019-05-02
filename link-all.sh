#!/bin/sh
curDir=$(pwd)

if [ ! -d ~/.config ]; then
  mkdir ~/.config
fi

ln -s $1 $curDir/i3                   ~/.config/
ln -s $1 $curDir/i3status             ~/.config/
ln -s $1 $curDir/.vim                 ~/
ln -s $1 $curDir/.Xresources          ~/
ln -s $1 $curDir/.zshrc               ~/
ln -s $1 $curDir/.keynavrc            ~/
ln -s $1 $curDir/deezer.desktop       ~/.local/share/applications/
