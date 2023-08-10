#!/bin/bash

function run {
	if ! pgrep -x "$(basename "$1" | head -c 15)" 1>/dev/null; then
		"$@" &
	fi
}

# Wallpaper

feh --no-fehbg --bg-fill ~/.config/backgrounds/gruvbox_mojave.jpg &

# Start sxhkd to replace Qtile native key-bindings

run sxhkd -c ~/.config/qtile/sxhkd/sxhkdrc &

# Utility applications

run nm-applet &
blueman-applet &
