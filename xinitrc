#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

[[ -f $sysresources    ]] && xrdb -merge $sysresources
[[ -f $sysmodmap       ]] && xmodmap $sysmodmap
[[ -f "$userresources" ]] && xrdb -merge "$userresources"
[[ -f "$usermodmap"    ]] && xmodmap "$usermodmap"

browser-sync start &
keynav &
unclutter &
spotifyd --volume-normalisation &
xsetroot -solid \#303030
fish -c ru
exec spectrwm