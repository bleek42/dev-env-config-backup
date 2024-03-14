#!/usr/bin/env sh
# customizations to the default shell environment in /etc/profile.d
export EDITOR=/usr/bin/nvim
# export VISUAL=/usr/bin/nvim
export LESSOPEN='| /usr/bin/lesspipe %s'
export LESSCLOSE='/usr/bin/lesspipe %s %s'

export XDG_STATE_HOME="${HOME}/.local/state"

XDG_DATA_HOME="${HOME}/.local/share"
XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share:/usr/share}:${XDG_DATA_HOME}"

XDG_CONFIG_HOME="${HOME}/.config"
XDG_CONFIG_DIRS="${XDG_CONFIG_DIRS:-/etc:/etc/xdg}:${XDG_CONFIG_HOME}"

XDG_CACHE_HOME="${HOME}/.cache"
XDG_CACHE_DIRS="${XDG_CACHE_DIRS:-/var/cache}:${XDG_CACHE_HOME}"

export RUSTUP_HOME="${HOME}/.local/bin/rustup"
export CARGO_HOME="${HOME}/.local/bin/cargo"

PATH="/usr/local/bin:/usr/bin:/bin:${PATH}"

# Add /usr/local/sbin, /usr/sbin and /sbin to the PATH for all users
if ! echo "$PATH" | tr : '\n' | grep -q "^/sbin$"; then
  PATH="/usr/local/sbin:/usr/sbin:/sbin:${PATH}"
fi

if [ -d "${HOME}/.local/bin" ]; then
  PATH="${PATH}:${HOME}/.local/bin"
fi

if [ -e "$WSL_INTEROP" ]; then
  WINDOWS_PATH='/mnt/c/Windows:/mnt/c/Windows/System32:/mnt/c/Program Files/usbipd-win:/mnt/c/Program Files/VSCodium/bin:/mnt/c/Program Files/Docker/resources/bin:/mnt/c/Program Files/VSCodium Insiders/bin:/mnt/c/Program Files/neovide:/mnt/c/Program Files/dotnet:/mnt/c/Program Files/VcXsrv:/mnt/c/Users/brand/AppData/Local/Programs/Microsoft VS Code/bin'

  PATH="${PATH}:${WINDOWS_PATH}"
fi

export PATH
