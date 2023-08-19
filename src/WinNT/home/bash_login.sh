#!/usr/bin/env bash

test -f "$HOME/.profile" && source "$HOME/.profile"
test -f "$HOME/.bashrc" && source "$HOME/.bashrc"

# Prefer US English & UTF-8 char encoding
export LC_ALL="en_US.UTF-8"
export LANG="en_US"
export MASTERPATH=$PATH

if command -v nvm >/dev/null 2>&1; then
    # NODE_PRESERVE_SYMLINKS=1
    eval "$(nvm on)"
    eval "$(nvm use lts)"
    if [ -z "$NODE_PATH" ]; then
        NODE_PATH="$(which node)"
    else
        NODE_PATH=$(which node):$NODE_PATH
    fi
    NODE_PATH="$NODE_PATH:$NVM_SYMLINK"
    NODE_EXE="$NODE_PATH/node.exe"
    # export NODE_PRESERVE_SYMLINKS
    export NODE_PATH
    export NODE_EXE
fi
