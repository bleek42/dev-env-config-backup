#!/usr/bin/env zsh

if [[ -x $(command -v command) ]] && [[ $SHLVL = 1 ]]; then
    echo "clearing console..."
    clear_console -q
fi
