#!/bin/sh

# Prevent GTK apps from starting enormously slow
# Souce: https://bbs.archlinux.org/viewtopic.php?pid=1705410#p1705410
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

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
