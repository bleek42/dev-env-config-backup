#!/usr/bin/env bash

NODE_PATH=$(which node)
export NODE_EXE="$NODE_PATH"/node.exe
export NODE_PATH

test -f "$HOME"/.profile && source "$HOME"/.profile
test -f "$HOME"/.bashrc && source "$HOME"/.bashrc

if [ -n "$WT_SESSION" ]; then
	export DISPLAY=:0
	export COLORTERM="truecolor"
	export INIT_WT_SESSION="$WT_SESSION"
	export TERM_PROGRAM="MS-WinTerm"-
fi

if command -v neofetch >/dev/null 2>&1 && [ "$(tty)" = /dev/cons0 ]; then
	neofetch
fi

if command -v oh-my-posh >/dev/null 2>&1; then
	alias omp='oh-my-posh'
	case $TERM_PROGRAM in
	"MS-WinTerm")
		eval "$(oh-my-posh init bash --config "${HOME}"/.custom-lambda-gen.omp.json)"
		;;
	*)
		eval "$(oh-my-posh init bash --config "${POSH_THEMES_PATH}"/tokyo.omp.json)"
		;;
	esac
fi
