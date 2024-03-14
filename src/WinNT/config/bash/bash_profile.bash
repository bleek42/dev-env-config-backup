#!/usr/bin/env bash

env=~/.ssh/agent.env

agent_load_env() { test -f "$env" && . "$env" >|/dev/null; }

agent_start() {
    (
        umask 077
        ssh-agent >|"$env"
    )
    . "$env" >|/dev/null
}

agent_load_env

# ? agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(
    ssh-add -l >|/dev/null 2>&1
    echo $?
)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env

# # check if user home "~/" doesn't have dir called ".config", make it if so
# [[ ! -d ~/.config ]] && mkdir ~/.config
# ? XDG_* env vars are a universal specification for Unix/Linux operating systems: Windows usually has own sort of spec to do this with $APPDATA, $LOCALAPPDATA, used for setting things like users for standard inital user folders like "MyDocuments" & other user specific start up stuff. We can imitate $XDG_XDG_CONFIG_HOME here because why not? Often, ~/.config/ may already have been created for you via some other software you have.
test -d "${HOME}"/.config || mkdir -p "${HOME}"/.config

export XDG_CONFIG_HOME="${HOME}"/.config
export LESS='-F -i -J -M -R -W -x4 -X -z-4'
export PAGER='less'
export EDITOR='nvim'
export VISUAL='code'
export BROWSER='firefox'
export COLORTERM="truecolor"
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[5m'        # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# export NODE_PRESERVE_SYMLINKS=1
export DISPLAY="$(hostname)":0

extract() {
    # Usage: extract file "opening marker" "closing marker"
    while IFS=$'\n' read -r line; do
        [[ $extract && $line != "$3" ]] &&
            printf '%s\n' "$line"

        [[ $line == "$2" ]] && extract=1
        [[ $line == "$3" ]] && extract=
    done <"$1"
}

test -f "${HOME}"/.bashrc && source "${HOME}/.bashrc"

# later make your own bash scripts & command aliases, put them in ~/.config/bash, make sure they all end in file type .sh or change the below code: will be sourced & applied on every terminal/bash sesh
if test -d "${XDG_CONFIG_HOME}"/bash/functions; then
    for src in "${XDG_CONFIG_HOME}"/bash/functions/**/*.sh; do
        source "$src"
    done
    unset src
fi

# if command -v volta >/dev/null 2>&1; then
#     eval "$(volta setup)"
# fi

if command -v node >/dev/null 2>&1; then
    NODE_PATH="${NODE_PATH:=$(which node)}"
    test -n "$NODE_PATH" && export NODE_PATH
fi

if command -v pnpm >/dev/null 2>&1; then
    PNPM_HOME="$(which pnpm)"
    test -n "$PNPM_HOME" && export PNPM_HOME
fi

if command -v direnv >/dev/null 2>&1; then
    eval "$(
        direnv hook bash && direnv allow
    )"
fi

test -n "$WT_SESSION" && export TERM_PROGRAM="wterm"

tty_current="$(tty)"

# * display system info with git-bash-specific config
# ? only when launching your 1st & 2nd interactive terminal/bash shell sessions
# ? can track sessions with checking for existence of incremented file written at '/dev/cons<0|1'
# ? never if session is in integrated VS Code terminal
shopt -s nocaseglob
if [[ $TERM_PROGRAM != *vscode* ]] &&
    test "$tty_current" -ef '/dev/cons0' ||
    test "$tty_current" -ef '/dev/cons1'; then

    fastfetch -c "${HOME}"/.config/fastfetch/git-bash.jsonc
fi
shopt -u nocaseglob

if command -v oh-my-posh >/dev/null 2>&1; then
    case "$TERM_PROGRAM" in
    "wterm")
        eval "$(oh-my-posh init bash --config "${HOME}"/.bleek-lambda.omp.json)"
        ;;
    *)
        eval "$(oh-my-posh init bash --config "${POSH_THEMES_PATH}"/stelbent.minimal.omp.json)"
        ;;
    esac

fi
