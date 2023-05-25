loadcompletion() {
	# Loads functionality that would slow down shell startup if always loaded.
	case "$1" in
	"pyenv")
		# Loads completion for Pyenv
		export PYENV_ROOT="$HOME/.pyenv"
		command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
		eval "$(pyenv init -)"
		;;
	"pipenv")
		# Loads completion for Pipenv
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
		# Load NVM and completion
		export NVM_DIR="$HOME/.nvm"
		[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
		[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
		;;
	*)
		echo "Not a supported argument"
		;;
	esac
}
