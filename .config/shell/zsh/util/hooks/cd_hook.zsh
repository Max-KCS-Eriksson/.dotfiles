#!/bin/zsh

_cd_hook() {
    if [[ "$PWD" != "$HOME" ]]; then
        # List dir content differently depending on number of files/dirs
        if [[ "$(ls -1 | wc -l)" -le 16 ]]; then
           ls -AlFh
        else
            ls -AF
        fi

        # Allow running of commands or enabeling functions when entering dir.
        if [[ -f ./.auto ]]; then
            echo -e '\n Sourcing ".auto" file'
            source ./.auto
        fi
    fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd _cd_hook
