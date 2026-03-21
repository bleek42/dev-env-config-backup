#!/usr/bin/env bash

function mcfly_init() {

	if command -v mcfly >/dev/null 2>&1; then
		export MCFLY_FUZZY=true
		export MCFLY_RESULTS=20
		export MCFLY_INTERFACE_VIEW=BOTTOM
		export MCFLY_RESULTS_SORT=LAST_RUN

		case "${SHELL}" in
		*zsh*)
			# echo "zsh detected, initializing mcfly..."
			eval "$(mcfly init zsh)"
			;;
		*bash*)
			# echo "bash detected, initializing mcfly..."
			eval "$(mcfly init bash)"
			;;
		*)
			echo "ERROR: unsupported shell detected, unable to initialize mcfly..."
			;;
		esac

	else
		echo "ERROR: mcfly executable not in PATH, unable to initialize mcfly..."

	fi

}
