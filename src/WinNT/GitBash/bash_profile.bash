#!/usr/bin/env bash

export LESS='-F -i -J -M -R -W -x4 -X -z-4'
export EDITOR='micro'
export VISUAL='code'
export COLORTERM="truecolor"
export BROWSER='/c/Program\ Files/Mozilla\ Firefox/firefox.exe'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[5m'        # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

export NODE_PRESERVE_SYMLINKS=1

if command -v ssh-agent >/dev/null 2>&1 && test -d "${HOME}"/.ssh; then
  eval "$(ssh-agent -s)"
  ssh-add -l "${HOME}"/.ssh >/dev/null 2>&1
fi

# # check if user home "~/" doesn't have dir called ".config", make it if so
# [[ ! -d ~/.config ]] && mkdir ~/.config
# ? XDG_* env vars are a universal specification for Unix/Linux operating systems: Windows usually has own sort of spec to do this with $APPDATA, $LOCALAPPDATA, used for setting things like users for standard inital user folders like "MyDocuments" & other user specific start up stuff. We can imitate $XDG_CONFIG_DIR here because why not? Often, ~/.config/ may already have been created for you via some other software you have.
[[ -d "${HOME}"/.config ]] && export CONFIG_DIR="${HOME}"/.config

test -f "${HOME}"/.profile && source "${HOME}"/.profile
test -f "${HOME}"/.bashrc && source "${HOME}/.bashrc"
test -z "${MSYS_DIR}" && export MSYS_DIR="${LOCALAPPDATA}"/Git

# later make your own bash scripts & command aliases, put them in ~/.config/bash, make sure they all end in file type .sh or change the below code: will be sourced & applied on every terminal/bash sesh
if [[ -d "${CONFIG_DIR}"/bash/functions ]]; then
  for src in "${CONFIG_DIR}"/bash/functions/**/*.sh; do
    source "$src"
  done
  unset src
fi
# test -f "$HOME/.bash_login" && source "$HOME/.bash_login"
# echo "$MSYSYSTEM_CHOST"
if [[ $TERM_PROGRAM != "vscode" ]]; then
  export TERM_PROGRAM="wterm"
  export MICRO_TRUECOLOR=1

  export DISPLAY="$(hostname)":0

fi

if command -v volta >/dev/null 2>&1; then
  eval "$(volta setup)"
fi

if command -v node >/dev/null 2>&1; then
  NODE_PATH="$(which node)"
  test -n "$NODE_PATH" && export NODE_PATH
fi

if command -v pnpm >/dev/null 2>&1; then
  PNPM_HOME="$(which pnpm)"
  test -n "$PNPM_HOME" && export PNPM_HOME
fi

[[ $(tty) = /dev/cons0 ]] && [[ $TERM_PROGRAM != 'vscode' ]] && [[ $(command -v neofetch) ]] && neofetch

if [[ $- = *i* ]] && [[ $(command -v oh-my-posh) ]]; then
  case "$TERM_PROGRAM" in
  "wterm")
    eval "$(oh-my-posh init bash --config "${HOME}"/.bleek-lambda.omp.json)"
    ;;
  "vscode")
    eval "$(oh-my-posh init bash --config "${POSH_THEMES_PATH}"/stelbent.minimal.omp.json)"
    ;;
  *) source "${HOME}"/.config/bash/prompt.bash ;;
  esac

fi

# loop through all files in $HOME/Documents & echo them out
# for file in "$HOME"/Documents/*; do echo "$file"; done
