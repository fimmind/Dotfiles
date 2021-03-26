#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

[[ -f $sysresources    ]] && xrdb -merge $sysresources
[[ -f $sysmodmap       ]] && xmodmap $sysmodmap
[[ -f "$userresources" ]] && xrdb -merge "$userresources"
[[ -f "$usermodmap"    ]] && xmodmap "$usermodmap"

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon -rx &

keynav &
unclutter &
exec bspwm
