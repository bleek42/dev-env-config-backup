#!/usr/bin/env zsh

typeset -gx SHELLRCD="${XDG_CONFIG_HOME:-${HOME}/.config}/rc.d"

if [[ $(awk -F= '/^NAME/{print $2}' /etc/os-release) == *Ubuntu* ]]; then
    skip_global_compinit=1
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

typeset -gx ZPFX="${ZI[HOME_DIR]}/programs"
ZI[MAN_DIR]="${ZPFX}/man"
