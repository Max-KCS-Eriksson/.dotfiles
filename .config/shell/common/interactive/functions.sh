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
