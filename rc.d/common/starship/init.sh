#!/usr/bin/env bash

if [ -n "$ZSH_VERSION" ]; then
    eval "$(starship init zsh --print-full-init)"
elif [ -n "$BASH_VERSION" ]; then
    eval "$(starship init bash --print-full-init)"
elif [ -n "$FISH_VERSION" ]; then
    eval "$(starship init fish)"
else
    echo "ERROR: unsupported shell detected, unable to initialize starship..."
fi

