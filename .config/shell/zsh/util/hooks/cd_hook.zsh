#!/bin/zsh

_cd_hook() {
    if [[ "$(pwd)" != "$HOME" ]]; then
        ll
    fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd _cd_hook

