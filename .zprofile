# Get aliases and functions etc.

[ -f "$HOME"/.zshrc ] && . "$HOME"/.zshrc


# Environmental variables

source "$HOME/.config/shell/common/login/env_vars.sh"
source "$XDG_CONFIG_HOME/shell/common/login/paths.sh"


# Show greeter on next interactive shell

# HACK: File is read in "$HOME/.zshrc"
echo 1 >"$XDG_STATE_HOME/zsh/.show_greeter"



# StartX

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    startx
fi
