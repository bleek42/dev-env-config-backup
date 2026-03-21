#!/usr/bin/env sh

prepend_path() {
    if [ -z "$1" ]; then
        # echo "Cannot prepend null directory to PATH" 1>&2
        return 1
    fi

    case ":$1:" in
    *":$PATH:"*)
        PATH="${1}:${PATH}"
        ;;
    *)
        # echo "Cannot prepend $1 to PATH..!" 1>&2
        return 1
        ;;
    esac

    return 0
}

append_path() {
    if [ -z "$1" ]; then
        # echo "Cannot append null directory to PATH" 1>&2
        return 1
    fi

    case ":$1:" in
    *":$PATH:"*)
        PATH="${PATH}:${1}"
        ;;
    *)
        # echo "Cannot append $1 to PATH..!" 1>&2
        return 1
        ;;
    esac

    return 0
}

: "${LESS_TERMCAP_mb:-$'\E[01;31m'}"    # Begins blinking.
: "${LESS_TERMCAP_md:-$'\E[01;31m'}"    # Begins bold.
: "${LESS_TERMCAP_me:-$'\E[0m'}"        # Ends mode.
: "${LESS_TERMCAP_se:-$'\E[0m'}"        # Ends standout-mode.
: "${LESS_TERMCAP_so:-$'\E[00;47;30m'}" # Begins standout-mode.
: "${LESS_TERMCAP_ue:-$'\E[0m'}"        # Ends underline.
: "${LESS_TERMCAP_us:-$'\E[01;32m'}"    # Begins underline.

export PAGER="${PAGER:-/usr/bin/less}"
export MANPAGER="${MANPAGER:-/usr/bin/less}"

export LESS="${LESS:-'-KRf'}"
LESSOPEN="| /usr/bin/lesspipe %s"
if test -x ~/.lessfilter; then
    LESSOPEN="|~/.lessfilter %s 2>&-"
fi
export LESSOPEN
export LESSCLOSE="${LESSCLOSE:-'/usr/bin/lesspipe %s %s'}"

if [ -d "${HOME}/.local/bin" ]; then
    prepend_path "${HOME}/.local/bin"
fi
export PATH

if command -v nnn >/dev/null 2>&1; then

    test -d "${XDG_CONFIG_HOME:-$HOME/.config}/nnn" || \
        mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/nnn"

    test -d "${XDG_CACHE_HOME:-$HOME/.cache}/nnn" || \
        mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/nnn"

    export NNN_OPTS="irxHN"
    export NNN_PLUG='p:preview-tui;o:fzopen;m:nmount;x:!chmod +x $nnn'
    export NNN_SEL="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/sel"
    export NNN_OPENER="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/plugins/nuke"
    export NNN_TMPFILE="${XDG_CACHE_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_FIFO="${XDG_CACHE_HOME:-$HOME/.cache}/nnn/tmp.fifo"

    test -f "$NNN_SEL" || \
        touch "$NNN_SEL"

fi

#if command -v fzf >/dev/null 2>&1; then
#  OPENER="${OPENER:-$HOME/.config/common/fzf/open.sh}"
#   TERMINAL="${TERMINAL:-/usr/bin/foot}"
#    STARTING_DIR="${STARTING_DIR:-/tmp}"
#fi
