#!/bin/zsh

_cd_hook() {
    if [[ "$(pwd)" != "$HOME" ]]; then
        if [[ "$(ls -1 | wc -l)" -le 16 ]]; then
           ls -AlFh
        else
            ls -AF
        fi

        # Allow running of auto commands per dir
        if [[ -f ./.auto ]]; then
            echo -e '\nRunning auto commands'
            source ./.auto
        fi
    fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd _cd_hook
