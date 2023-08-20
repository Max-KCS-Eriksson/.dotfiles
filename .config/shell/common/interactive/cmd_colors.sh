#!/usr/bin/env bash

# ls colors by file extension
_LS_COLORS=$_LS_COLORS:'di=1;34:tw=30;42:ow=1;37;42:st=37;44:'
_LS_COLORS=$_LS_COLORS:'*.json=0;36:*.yaml=0;36:*.yml=0;36:*.toml=0;36:*.xml=0;36'
_LS_COLORS=$_LS_COLORS:'*.sh=0;92:*.zsh=0;92:'
_LS_COLORS=$_LS_COLORS:'*.gitignore=0;37:*.dockerignore=0;37:'
_LS_COLORS=$_LS_COLORS:'*Dockerfile=0;35:*.env=0;35:'
_LS_COLORS=$_LS_COLORS:'*.py=0;93:*.lua=0;34:'
_LS_COLORS=$_LS_COLORS:'*.go=0;34:*.mod=0;37:'
_LS_COLORS=$_LS_COLORS:'*.java=0;31:*.class=0;32:'
_LS_COLORS=$_LS_COLORS:'*.html=0;31:*.css=0;34:*.js=0;93:'
_LS_COLORS=$_LS_COLORS:'*.jpg=0;35:*jpeg=0;35:*.png=0;35:'
_LS_COLORS=$_LS_COLORS:'*.md=0;95:*.norg=0;35:*.txt=0;95:'
_LS_COLORS=$_LS_COLORS:'*.sql=1;31:'
_LS_COLORS=$_LS_COLORS:'*.gpg=1;31:'
_LS_COLORS=$_LS_COLORS:'*.bak=1;31:'
export LS_COLORS=$_LS_COLORS
unset _LS_COLORS

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
