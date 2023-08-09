#!/usr/bin/env bash

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Add default flags to commands.
alias mv="mv -iv"
alias rm="rm -iv"
alias cp="cp -iv"
alias ls="ls -F --color=auto"
alias dir="dir --color=auto"
alias vdir="vdir --color=auto"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias tree="tree --dirsfirst -F -I '.git/|.gitignore|*_env/|__pycache__/|*.egg-info/|build/'"

# Hide from history
alias mpv=" mpv"
alias feh=" feh"

# Quality of life command aliases.
alias poweroff="sudo poweroff"
alias reboot="sudo reboot"

dots=".."
target="cd .."
for ((i = 0; i < 10; i++)); do
	alias "$dots=$target"
	dots+="."
	target+="/.."
done
unset dots target

alias cdgr='cd $(git rev-parse --show-toplevel)'

alias ll="ls -AlFh"
alias la="ls -AF"
alias l="ls -CF"

alias c="clear"
alias cll="clear; ll"

alias gr="grep"

alias v="nvim"
alias v.="nvim ."

alias fzp="fzf --preview 'bat --color=always {}'"
alias xcc="xclip -selection clipboard"

# Terminal
_thisTerm=$(basename "/""$(ps -o cmd -f -p "$(cat /proc/"$$"/stat | cut -d \  -f 4)" | tail -1 | sed 's/ .*$//')")
export _thisTerm

_termCmd=''
if [[ "$_thisTerm" == "xfce4-terminal" ]]; then
	_termCmd='xfce4-terminal --working-directory='
elif [[ "$_thisTerm" == "wezterm-gui" ]]; then
	_termCmd='wezterm start --cwd '
fi

if [[ $_termCmd != '' ]]; then
	alias another="$_termCmd"'$PWD'

	# HACK: Used for spawning another terminal from Neovim
	export _termCmd
else
	unset _termCmd
fi

# Input settings
alias keyus="setxkbmap -layout us -variant altgr-intl -option nodeadkeys"

# Manage dotfiles & other bare git repos.
alias dot="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias rice="/usr/bin/git --git-dir=$HOME/.rice --work-tree=$HOME"
