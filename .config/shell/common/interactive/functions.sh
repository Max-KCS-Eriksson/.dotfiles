# Load functionality that would slow down shell startup if always loaded.
loadcompletion() {
    case "$1" in
    "pipenv")
        # Load completion for Pipenv
        case "$SHELL" in
        "/bin/bash")
            eval "$(_PIPENV_COMPLETE=bash_source pipenv)"
            ;;
        "/bin/zsh")
            eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"
            ;;
        *)
            echo "Not a supported shell: $SHELL"
            ;;
        esac
        ;;
    *)
        echo "Not a supported argument"
        ;;
    esac
}

# Get directory of given filename upwards from cwd
findup() {
    path_name=$PWD
    while [[ "$path_name" != '' && ! -e "$path_name/$1" ]]; do
        path_name=${path_name%/*}
    done
    echo "$path_name"

    unset path_name
}

# `cd` into project root dir
cdr() {
    # Files indicating dir as project root dir
    anchor_files=(
        .bzr
        .citc
        .git
        .hg
        .node-version
        .python-version
        .go-version
        .ruby-version
        .lua-version
        .java-version
        .perl-version
        .php-version
        .tool-version
        .shorten_folder_marker
        .svn
        .terraform
        CVS
        Cargo.toml
        composer.json
        go.mod
        package.json
        stack.yaml
        Pipfile
        pom.xml
        settings.gradle
    )

    for anchor in "${anchor_files[@]}"; do
        anchor_dir=$(findup "$anchor")
        if [[ $anchor_dir != '' ]]; then
            cd "$anchor_dir" || return 1
        fi
    done

    unset anchor anchor_dir anchor_files
}
