#!/usr/bin/env zsh

setopt typeset_silent

export COLORTERM=truecolor
export CLICOLOR=1
export LESSOPEN="|~/.lessfilter %s 2>&-"
export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'
export MANPAGER=$'/bin/sh -c \'col -b | bat -p -l man\''

ZSH_CACHE_DIR="${ZSH_CACHE_DIR:-${HOME}/.cache/zsh}"
SHELLRCD="${XDG_CONFIG_HOME:-${HOME}/.config}/rc.d"

if [[ $(awk -F= '/^NAME/{print $2}' /etc/os-release) == *Ubuntu* ]]; then
    skip_global_compinit=1
fi

if [[ -f ${SHELLRCD}/common/ls_colors.sh ]]; then
    source "${SHELLRCD}/common/ls_colors.sh"
fi

typeset -Ag ZI

ZI[OPTIMIZE_OUT_DISK_ACCESSES]=1

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
