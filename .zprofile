# Get aliases and functions etc.

[ -f "$HOME"/.zshrc ] && . "$HOME"/.zshrc


# Environmental variables

source "$HOME/.config/shell/common/login/env_vars.sh"
source "$HOME/.config/shell/common/login/paths.sh"


# StartX

[[ $(ps -e | grep startx) == '' ]] && startx
