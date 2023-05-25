#!/bin/bash

userresources=$HOME/.Xresources
# usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# Monitor arrangement

xrandr --output DP-3 --primary --auto --left-of eDP-1 --output DP-4 --auto --left-of DP-3

# Merge in defaults and keymaps

if [ -f "$sysresources" ]; then
	xrdb -merge "$sysresources"
fi

if [ -f "$sysmodmap" ]; then
	xmodmap "$sysmodmap"
fi

if [ -f "$userresources" ]; then
	xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
	xmodmap "$usermodmap"
fi

# Start programs

if [ -d /etc/X11/xinit/xinitrc.d ]; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

# Keyboard layout

setxkbmap -layout us -variant altgr-intl -option nodeadkeys

# Utility apps

unclutter -idle 5 -jitter 10 &
pulseaudio &

# Start WM

exec dbus-run-session /bin/qtile start
