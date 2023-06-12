plugins="$HOME/.local/share/zsh/plugins"
config="$HOME/.config/shell/zsh/plugins"
[[ ! -d ${plugins} ]] && mkdir -p ${plugins}
[[ ! -d ${config} ]] && mkdir -p ${config}

# Prompt
# To customize prompt, run `p10k configure` or edit ${config}/p10k/p10k.zsh.
if [[ ! -d ${plugins}/p10k ]]; then
    echo ''
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${plugins}/p10k
    echo "\n[\e[1;33m!!\e[0m] Restart of shell is needed"
else
    source ${plugins}/p10k/powerlevel10k.zsh-theme
    [[ ! -f ${config}/p10k/p10k.zsh ]] || source ${config}/p10k/p10k.zsh  # NOTE: Source after theme
    typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet  # WARNING: Suppresses warnings
fi

# Autopairs
if [[ ! -d ${plugins}/zsh-autopair ]]; then
    echo ''
    git clone https://github.com/hlissner/zsh-autopair ${plugins}/zsh-autopair
    echo "\n[\e[1;33m!!\e[0m] Restart of shell is needed"
else
    source ${plugins}/zsh-autopair/autopair.zsh
autopair-init
fi

# Vi(m) mode
if [[ ! -d ${plugins}/zsh-vi-mode ]]; then
    echo ''
    git clone https://github.com/jeffreytse/zsh-vi-mode.git ${plugins}/zsh-vi-mode
    echo "\n[\e[1;33m!!\e[0m] Restart of shell is needed"
else
    source ${plugins}/zsh-vi-mode/zsh-vi-mode.plugin.zsh
fi

# Syntax highlighting
# Customize syntax highlighting by editing ${config}/fsh/${theme}.ini
# NOTE: Must be sourced last

theme='fsh'  # Name of theme file (without file extension) to use for customization.

if [[ ! -d ${plugins}/fsh ]]; then
    echo ''
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ${plugins}/fsh
    echo "\n[\e[1;33m!!\e[0m] Restart of shell is needed"
else
    source ${plugins}/fsh/fast-syntax-highlighting.plugin.zsh
    user_themes=${config}/fsh
    if [[ -f ${user_themes}/${theme}.ini ]]; then
        # Ensure latest theme updates are applied
        fast-theme ${user_themes}/${theme} -q  # OPTIMIZE: Might be slow
    else
        default_themes=${plugins}/fsh/themes
        [[ ! -d ${user_themes} ]] && mkdir ${user_themes}
        cat ${default_themes}/default.ini > ${user_themes}/${theme}.ini  # Using `cp` is to verbose
        echo "[\e[1;33m!!\e[0m] Created \e[0;34m${user_themes}/\e[1;35m${theme}.ini\e[0m to be used for configuring syntax highlighting"
    fi
fi

unset theme
unset user_themes
unset default_themes

unset plugins
unset config
