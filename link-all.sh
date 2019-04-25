#!/bin/sh
curDir=$(pwd)

if [ ! -d ~/.config ]; then
  mkdir ~/.config
fi

ln -si $curDir/i3          ~/.config/
ln -si $curDir/.vim        ~/
ln -si $curDir/.Xresources ~/
ln -si $curDir/.zshrc      ~/
ln -si $curDir/.keynavrc   ~/
