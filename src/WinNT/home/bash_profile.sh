#!/usr/bin/env bash

export LESS='-F -i -J -M -R -W -x4 -X -z-4'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

export GPT_AUTH="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"

test -z "${MSYS_DIR}" && export MSYS_DIR="$LOCALAPPDATA/Git"
test -f "$HOME/.profile" && source "$HOME/.profile"
test -f "$HOME/.bashrc" && source "$HOME/.bashrc"
# test -f "$HOME/.bash_login" && source "$HOME/.bash_login"
# echo "$MSYSYSTEM_CHOST"
if [ -n "$WT_SESSION" ]; then
  DISPLAY="$(hostname)$MSYSTEM_CHOST:0"
  export TERM_PROGRAM="wterm"
  export COLORTERM="truecolor"
  export MICRO_TRUECOLOR=1
  export DISPLAY
fi

if command -v volta >/dev/null 2>&1; then
  eval "$(volta setup)"
  # export PNPM_HOME="C:\Users\brand\AppData\Local\Volta\tools\image\packages\pnpm\pnpm"
  NODE_PATH=$(volta which node)
  PATH="$PATH":"$NODE_PATH"
  export PATH NODE_PATH
fi

if [[ $- == *i* ]] && command -v oh-my-posh >/dev/null 2>&1; then

  case $TERM_PROGRAM in
  "wterm")
    eval "$(oh-my-posh init bash --config "${HOME}"/.bleek-lambda.omp.json)"
    ;;
  "vscode")
    eval "$(oh-my-posh init bash --config "${POSH_THEMES_PATH}"/emodipt-extend.omp.json)"
    ;;
  *) source "$HOME/.config/bash/prompt.bash" ;;
  esac

  if [[ "$(tty)" = "/dev/cons0" ]] && command -v neofetch >/dev/null 2>&1; then
    neofetch
  fi

fi
