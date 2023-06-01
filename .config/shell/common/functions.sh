# Enables the `nvm` function.
# Node is required by some programs and packages, like Pyright LSP. It is there for
# more practical to always have NVM enabled, at the cost of slow startup.
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Enable `jenv`
eval "$(jenv init -)"

# Load functionality that would slow down shell startup if always loaded.
loadcompletion() {
	case "$1" in
	"pyenv")
		# Load completion for Pyenv
		export PYENV_ROOT="$HOME/.pyenv"
		command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
		eval "$(pyenv init -)"
		;;
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
	"nvm")
		# Load NVM completion
		[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
		;;
	*)
		echo "Not a supported argument"
		;;
	esac
}
