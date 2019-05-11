#!/bin/sh
curDir=$(pwd)

if [ ! -d ~/.config ]; then
  mkdir ~/.config
fi

ln -s $1 $curDir/i3                      ~/.config/
ln -s $1 $curDir/i3status                ~/.config/
ln -s $1 $curDir/.vim                    ~/
ln -s $1 $curDir/.zshrc                  ~/
ln -s $1 $curDir/.keynavrc               ~/
ln -s $1 $curDir/deezer/deezer.desktop   ~/.local/share/applications/
ln -s $1 $curDir/.fehbg                  ~/

sudo ln -s $1 $curDir/deezer/deezer       /usr/bin/
