#!/usr/bin/env zsh

setopt typeset_silent

export COLORTERM="${COLORTERM:-truecolor}"
export PAGER=/usr/bin/less
export LESS='-Rfd'
export MANPAGER="sh -c 'col -bx | bat -f -l=man'"
export MANROFFOPT="-c"

:   "${CLICOLOR:=1}"
:   "${TIMEFMT:=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'}"
:   "${SHELLRCD:=${HOME}/.config/rc.d}"
:   "${ZSHELLRCD:=${HOME}/.config/rc.d/zsh}"
:   "${ZSH_CACHE_DIR:=${HOME}/.cache/zsh}"


test -d "$ZSH_CACHE_DIR" || \
    mkdir -p "$ZSH_CACHE_DIR"

test -d "$SHELLRCD" || \
    mkdir -p "$SHELLRCD"

## ! Set fpath w/ users custom functions, if it exists
test -d "${ZSHELLRCD}/functions" && \
	fpath=( "${ZSHELLRCD}/functions" "${fpath[@]}" )

if [[ -d ${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/bin ]]; then

    typeset -gA ZI
	ZI[HOME_DIR]="${XDG_DATA_HOME:-${HOME}/.local/share}/zsh"
	ZI[CONFIG_DIR]="${XDG_CONFIG_HOME:-${HOME}/.config}/rc.d/zsh"
	ZI[CACHE_DIR]="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh"
	ZI[BIN_DIR]="${ZI[HOME_DIR]}/bin"
	ZI[PLUGINS_DIR]="${ZI[HOME_DIR]}/plugins"
	ZI[SNIPPETS_DIR]="${ZI[HOME_DIR]}/snippets"
	ZI[COMPLETIONS_DIR]="${ZI[HOME_DIR]}/completions"
	ZI[ZMODULES_DIR]="${ZI[HOME_DIR]}/zmodules"
	ZI[ZCOMPDUMP_PATH]="${ZI[CACHE_DIR]}/zcompdump"
	ZI[LOG_DIR]="${ZI[CACHE_DIR]}/logs"

	typeset -g ZPFX="${ZI[HOME_DIR]}/programs"
    ZI[MAN_DIR]="${ZPFX}/man"
	ZI[OPTIMIZE_OUT_DISK_ACCESSES]=1

	typeset -axU manpath=( "${ZI[MAN_DIR]}" "${manpath[@]}" )

fi
