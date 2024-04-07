# Preferred editor
export EDITOR=nvim
export VISUAL=nvim

# XDG directories
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state

# Clean HOME
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export XCURSOR_PATH=/usr/share/icons:$XDG_DATA_HOME/icons
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

# Bat
export BAT_THEME="gruvbox-dark"
export BAT_PAGER="/bin/less"

# Neorg
export NEORG_HOME="$HOME/Documents/neorg"

# Used for opening anoter terminal in CWD
export _termCmd='xfce4-terminal --working-directory='
