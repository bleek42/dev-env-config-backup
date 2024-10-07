#!/usr/bin/env bash

# customizations to the default shell environment in /etc/profile.d
export EDITOR=/usr/bin/nvim
export LESSOPEN='| /usr/bin/lesspipe %s'
export LESSCLOSE='/usr/bin/lesspipe %s %s'

export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"

export XDG_DATA_DIRS="${XDG_DATA_HOME}:${XDG_DATA_DIRS:-/usr/local/share/applications:/usr/share/parrot-menu/applications}"
export XDG_CONFIG_DIRS="${XDG_CONFIG_HOME}:${XDG_CONFIG_DIRS:-/etc/xdg/lxqt:/etc/xdg:/usr/local/share:/usr/share}"

# Add /usr/local/sbin, /usr/sbin and /sbin to the PATH for all users
if ! echo "$PATH" | tr : '\n' | grep -q "^/sbin$"; then
    PATH="/usr/local/bin:/usr/bin:/bin:${PATH}"
fi

if ! echo "$PATH" | tr : '\n' | grep -q "^/sbin$"; then
    PATH="/usr/local/sbin:/usr/sbin:/sbin:${PATH}"
fi

#if [ -d "${HOME}/.local/bin" ]; then
#   PATH="${HOME}/.local/bin:${PATH}"
#fi

if [ -n "$WSL_INTEROP" ]; then

    declare -ag WSL_INTEROP_PATHS

    WIN_DIR=/mnt/c/Windows
    WIN_SYS32="${WIN_DIR}/System32"
    WIN_PROGRAMDATA=/mnt/c/ProgramData
    WIN_PROGRAMFILES="/mnt/c/Program Files"
    WIN_APPDATA=/mnt/c/Users/brand/AppData
    WIN_LOCAL_APPDATA="${WIN_APPDATA}/Local"

    BROWSER_PATH="${WIN_PROGRAMFILES}/Firefox Developer Edition"
    OMP_PATH="${WIN_APPDATA}/Local/Programs/oh-my-posh/bin"
    VSCODIUM_PATH="${WIN_PROGRAMFILES}/VSCodium/bin"
    USBPID_PATH="${WIN_PROGRAMFILES}/usbpid-win"
    DOCKER_PATH="${WIN_PROGRAMFILES}/Docker/resources/bin"
    WINGET_PKGS="${WIN_APPDATA}/Local/Microsoft/Packages"
    LAZYGIT_PATH="${WIN_GET_PKGS}/JesseDuffield.lazygit_Microsoft.Winget.Source_8wekyb3d8bbwe"
    VSCODE_PATH="${WIN_PROGRAMFILES}/Microsoft VS Code/bin"
    VSCODIUM_INSIDERS_PATH="${WIN_PROGRAMFILES}/VSCodium Insiders/bin"
    VCXSRV_PATH="${WIN_PROGRAMFILES}/VcXsrv"
    NEOVIDE_PATH="${WIN_PROGRAMFILES}/neovide"
    LUART_PATH="${WIN_PROGRAMFILES}/LuaRT/bin"
    WIN_LOCAL_APPS="${WIN_LOCAL_APPDATA}/Microsoft/WindowsApps"
    WIN_FILES_APP="${WIN_LOCAL_APPS}/Files_1y0xx7n9077q4"

    WSL_INTEROP_PATHS[0]="$WIN_SYS32"
    WSL_INTEROP_PATHS[1]="$WIN_DIR"
    WSL_INTEROP_PATHS[2]="$WIN_PROGRAMDATA"
    WSL_INTEROP_PATHS[3]="$WIN_PROGRAMFILES"
    WSL_INTEROP_PATHS[4]="$WIN_APPDATA"
    WSL_INTEROP_PATHS[5]="$WIN_LOCAL_APPDATA"
    WSL_INTEROP_PATHS[6]="$BROWSER_PATH"
    WSL_INTEROP_PATHS[7]="$VSCODE_PATH"
    WSL_INTEROP_PATHS[8]="$DOCKER_PATH"
    WSL_INTEROP_PATHS[9]="$WIN_FILES_APP"
    WSL_INTEROP_PATHS[10]="$VCXSRV_PATH"
    WSL_INTEROP_PATHS[11]="$USBPID_PATH"
    WSL_INTEROP_PATHS[12]="$NEOVIDE_PATH"
    WSL_INTEROP_PATHS[13]="$VSCODIUM_PATH"
    WSL_INTEROP_PATHS[14]="$VSCODIUM_INSIDERS_PATH"

    WINDOWS_PATH="${BROWSER_PATH}:${DOCKER_PATH}:${USBPID_PATH}:${WIN_FILES_APP}"
    WINDOWS_PATH="${WINDOWS_PATH}:${VSCODE_PATH}:${VSCODIUM_INSIDERS_PATH}:${NEOVIDE_PATH}:${VCXSRV_PATH}"

    PATH="${PATH}:${WINDOWS_PATH}"
    export WINDOWS_PATH

fi

export PATH

## if [ -d /opt/rust ]; then

## export RUSTUP_HOME=/opt/rust
## export CARGO_HOME=/opt/rust

## fi
