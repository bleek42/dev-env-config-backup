#!/usr/bin/env bash

# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
# umask 022

# if [ -f "$HOME/.profile" ]; then
#     . "$HOME/.profile"
# fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) PATH="$PNPM_HOME:$PATH" ;;
esac

# export PATH="$PATH:/mnt/c/Windows/System32:/mnt/c/Program Files (x86)/NVIDIA Corporation/PhysX/Common:/mnt/c/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v12.1/bin:/mnt/c/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v12.1/libnvvp:/mnt/c/Program Files/usbipd-win:/mnt/c/Users/brand/AppData/Local/Programs/Microsoft VS Code/bin:/mnt/c/Program Files/Docker/Docker/resources/bin:/mnt/c/Users/brand/AppData/Local/Programs/VSCodium Insiders/bin:/mnt/c/Program Files/dotnet:/mnt/c/Program Files/VcXsrv:/mnt/c/Program Files (x86)/Windows Kits/10/Windows Performance Toolkit"

NODE_PATH="$PNPM_HOME/nodejs"
# WSL_IPV4=$(hostname -I | awk '{print $1}' | awk '{printf $0}')
# export WSL_IPV4

export PNPM_HOME NODE_PATH

if command -v keychain >/dev/null 2>&1; then
    eval "$(keychain --confhost --systemd --nogui --inherit any --dir --absolute "${HOME}"/.config/keychain --env "${HOME}"/.config/keychain/"${HOST}"-sh)"
fi
