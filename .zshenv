#!/usr/bin/env zsh

setopt typeset_silent

export COLORTERM="${COLORTERM:-truecolor}"
export PAGER=/usr/bin/less
export LESS='-KL --wordwrap'
export MANPAGER="/usr/bin/sh -c 'col -bx | bat -f -n -lman'"
export MANROFFOPT="-c"

:   "${CLICOLOR:=1}"
:   "${TIMEFMT:=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'}"
:   "${SHELLRCD:=${HOME}/.config/rc.d}"
:   "${ZSHELLRCD:=${SHELLRCD}/zsh}"
:   "${ZSH_CACHE_DIR:=${HOME}/.cache/zsh}"


test -d "$ZSH_CACHE_DIR" || \
    command mkdir -p "$ZSH_CACHE_DIR"

test -d "$SHELLRCD" || \
    command mkdir -p "$SHELLRCD"

# ! Set fpath w/ users custom functions, if it exists
test -d "${ZSHELLRCD}/functions" && \
	fpath=( "${ZSHELLRCD}/functions" "${fpath[@]}" )

if command -v nnn >/dev/null 2>&1; then

    test -d "${XDG_CONFIG_HOME:-$HOME/.config}/nnn" || \
        mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/nnn"

    test -d "${XDG_CACHE_HOME:-$HOME/.cache}/nnn" || \
        mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/nnn"

    export NNN_OPTS="irxHN"
    export NNN_PLUG='p:preview-tui;o:fzopen;m:nmount;x:!chmod +x "$nnn";'
    export NNN_SEL="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/sel"
    export NNN_OPENER="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/plugins/nuke"

    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_FIFO="${XDG_CACHE_HOME:-$HOME/.cache}/nnn/tmp.fifo"

    test -f "$NNN_SEL" || \
        touch "$NNN_SEL"

fi

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
