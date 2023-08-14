# shellcheck disable=SC2148,2296

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# Session specific Environmental variables

# NOTE: Needs to be set first

source "$XDG_CONFIG_HOME/shell/common/interactive/session_env_vars.sh"


# Set cursor style

# Needs to be applied before Powerlevel10k instant prompt to ensure no noticeable delay.
echo -ne '\e[6 q\e]'  # Steady beam


# Powerlevel10k instant prompt

# NOTE: Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# History

export HISTSIZE=1000  # Max num saved internally
export SAVEHIST=2000  # Max num saved to file
[[ -d $XDG_STATE_HOME/zsh ]] || mkdir -p "$XDG_STATE_HOME/zsh"
export HISTFILE="$XDG_STATE_HOME/zsh/history"
setopt histignorespace  # Leading space hides cmd from hist.
unsetopt histignoredups  # Don't put duplicate cmd in hist if duplicate of previous cmd.
setopt histreduceblanks  # Remove superfluous blanks from cmd's in hist.


# Options

setopt autocd  # If issued cmd can't be exec as normal and is name of dir, cd into it.
setopt nomatch  # Print error on no match
setopt autoremoveslash  # Removing of trailing slash for dir from comp on ";" or "&".

unsetopt automenu  # Disable tab cycle completion options
unsetopt beep  # Beep on error
unsetopt extendedglob  # "~", "^", and "#" used for glob
unsetopt notify  # Report background job status immediately

bindkey -v  # Vi mode


# Completion

zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"


# LS_COLORS, etc & aliases

source "$XDG_CONFIG_HOME/shell/common/interactive/cmd_colors.sh"
source "$XDG_CONFIG_HOME/shell/common/interactive/aliases.sh"


# Functions and utils

source "$XDG_CONFIG_HOME/shell/common/functions.sh"
source "$XDG_CONFIG_HOME/shell/zsh/util/init.zsh"


# Runtime management

eval "$(rtx activate zsh)"


# Greeter

# NOTE: Source after `cmd_colors.sh`
# source "$XDG_CONFIG_HOME/shell/common/extras/greeter.sh"


# Right side prompt indentation

# WARNING: When `ZLE_RPROMPT_INDENT` is set to 0 there is a possibility of bugs in some
# terminal emulators, that causes the cursor to be positioned incorrectly.
# To ensure the bug is indeed not triggered you can conduct these tests.
#   -  Start by entering `$ PROMPT='X> ' RPROMPT='<X' zsh -df` then verify below:
#   1. When you prompt is empty, verify that the cursor is where it's supposed to be.
#      If there is no space between the end of left prompt and the cursor, you are
#      affected by the bug.
#   2. Press ctrl+r. The cursor must not move. If it does move to the right, you are
#      affected by the bug.
#   3. Type "ls<tab>". You should have "ls" on the screen with the cursor positioned
#      right after it. If the cursor is positioned on "s", you are affected by the bug.
export ZLE_RPROMPT_INDENT=0


# Plugins

# NOTE: Source last
source "$XDG_CONFIG_HOME/shell/zsh/plugins/plugins.zsh"
