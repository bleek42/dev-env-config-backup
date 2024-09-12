#!/usr/bin/env zsh

export ZDOTDIR="$HOME"

setopt typeset_silent

# skip_global_compinit=1

# if [[ $(awk -F= '/^NAME/{print $2}' /etc/os-release) == *Ubuntu* ]]; then
# fi

export COLORTERM=truecolor
export CLICOLOR=1
export SHORT_HOST="${HOST:0.8}"
export LESSOPEN='|~/.lessfilter %s 2>&-'
export TIMEFMT="\\nreal\\t%E\\nuser\\t%U\\nsys\\t%S\\ncpu\\t%P"
export MANPAGER="sh -c 'col -bx | bat -f -l man'"
export MANROFFOPT='-c'

export SHELLRCD="${XDG_CONFIG_HOME:-${HOME}/.config}/rc.d"
export ZSH_CONFIG_DIR="${SHELLRCD}/zsh"
export ZSH_CACHE_DIR="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh"
export ZSH_DATA_DIR="${XDG_DATA_HOME:-${HOME}/.local/share}/zsh"

if [[ -f "${SHELLRCD}/common/ls_colors/one-dark.sh" ]]; then
    source "${SHELLRCD}/common/ls_colors/one-dark.sh"
fi

if [[ -d "${ZSH_CONFIG_DIR}/functions" ]]; then
    fpath=( "${ZSH_CONFIG_DIR}/functions" $fpath )
fi

if [[ -d ${ZSH_DATA_DIR}/bin ]]; then

    source "${ZSH_DATA_DIR}/bin/zi.zsh"
    autoload -Uz _zi
    (( ${+_comps} )) && _comps[zi]=_zi

    typeset -gA ZI
    ZI[HOME_DIR]="$ZSH_DATA_DIR"
    ZI[CONFIG_DIR]="$ZSH_CONFIG_DIR"
    ZI[CACHE_DIR]="$ZSH_CACHE_DIR"
    ZI[BIN_DIR]="${ZI[HOME_DIR]}/bin"
    ZI[PLUGINS_DIR]="${ZI[HOME_DIR]}/plugins"
    ZI[SNIPPETS_DIR]="${ZI[HOME_DIR]}/snippets"
    ZI[COMPLETIONS_DIR]="${ZI[HOME_DIR]}/completions"
    ZI[ZMODULES_DIR]="${ZI[HOME_DIR]}/zmodules"
    ZI[ZCOMPDUMP_PATH]="${ZI[CACHE_DIR]}/zcompdump"
    ZI[LOG_DIR]="${ZI[CACHE_DIR]}/logs"

    if [[ -d "${ZI[ZMODULES_DIR]}/zpmod/Src" ]]; then
        module_path+=( "${ZI[ZMODULES_DIR]}/zpmod/Src" )
        zmodload zi/zpmod
    fi

    typeset -x ZPFX="${ZI[HOME_DIR]}/programs"
    ZI[MAN_DIR]="${ZPFX}/man"
    ZI[OPTIMIZE_OUT_DISK_ACCESSES]=1

    export MANPATH=":${ZI[MAN_DIR]}"

# else

#     # ZDOTDIR=
#     ZDOTDIR="${ZDOTDIR:+$ZSH_CONFIG_DIR}"
#     ZDOTDIR="${ZDOTDIR:+$ZSH_DATA_DIR}"

#     export ZDOTDIR

fi
