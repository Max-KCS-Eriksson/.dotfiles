#!/usr/bin/env bash

# Shadow commands

# Ask before overwrite/delete
alias mv="mv -iv"
alias rm="rm -iv"
alias cp="cp -iv"

# Color output
alias ls="ls -F --color=auto"
alias dir="dir --color=auto"
alias vdir="vdir --color=auto"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# Ignore files in output
alias tree="tree --filesfirst -F -I '.git/|.gitignore|*_env/|.venv/|__pycache__/|*.egg-info/|build/'"

# Clean home
alias wget=wget --hsts-file='$XDG_DATA_HOME/wget-hsts'
alias mvn='mvn -gs $XDG_CONFIG_HOME/maven/settings.xml'

# Hide from history
alias mpv=" mpv"
alias feh=" feh"

# Ease of use
alias poweroff="sudo poweroff"
alias reboot="sudo reboot"

# Shorthand aliases

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Move up dir tree
dots=".."
target="cd .."
for ((i = 0; i < 10; i++)); do
    alias "$dots=$target"
    dots+="."
    target+="/.."
done
unset dots target

# Change dir to git root
alias cdg='cd $(git rev-parse --show-toplevel)'

# List dir contents
alias ll="ls -AlFh"
alias la="ls -AF"
alias l="ls -CF"

# Clear
alias c="clear"
alias cll="clear; ll"

# Text editing
alias v="nvim"
alias v.="nvim ."

# Search, filter, and copy output
alias gr="grep -i"
alias fzp="fzf --preview 'bat --color=always {}'"
alias xcc="xclip -selection clipboard"

# Terminal
_thisTerm=$(basename "/""$(ps -o cmd -f -p "$(cat /proc/"$$"/stat | cut -d \  -f 4)" | tail -1 | sed 's/ .*$//')")
export _thisTerm
if [[ "$_thisTerm" == 'xfce4-terminal' ]]; then
    _termCmd='xfce4-terminal --working-directory='
elif [[ "$_thisTerm" == 'wezterm-gui' ]]; then
    _termCmd='wezterm start --cwd '
fi
alias another="$_termCmd"'$PWD'
export _termCmd

# Input settings
alias keyus="setxkbmap -layout us -variant altgr-intl -option nodeadkeys"

# Manage dotfiles & other bare git repos.
alias dot="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias rice="/usr/bin/git --git-dir=$HOME/.rice --work-tree=$HOME"
