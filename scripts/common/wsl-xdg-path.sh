#!/usr/bin/env sh
# customizations to the default shell environment in /etc/profile.d
export EDITOR=/usr/bin/nvim
export LESSOPEN='| /usr/bin/lesspipe %s'
export LESSCLOSE='/usr/bin/lesspipe %s %s'

# Add /usr/local/sbin, /usr/sbin and /sbin to the PATH for all users
if ! echo "$PATH" | tr : '\n' | grep -q "^/sbin$"; then
    PATH="/usr/local/sbin:/usr/sbin:/sbin:${PATH}"
fi

if [ -d "${HOME}/.local/bin" ]; then
    PATH="${PATH}:${HOME}/.local/bin"
fi

if ! echo "$PATH" | tr : '\n' | grep -q "^/sbin$"; then
	PATH="/usr/local/bin:/usr/bin:/bin:${PATH}"
fi

if [ -e "$WSL_INTEROP" ]; then
	WIN_DIR='/mnt/c/Windows'
	WIN_SYS32='/mnt/c/Windows/System32'
	WIN_PROGRAMFILES='/mnt/c/Program Files'
	WIN_PROGRAMDATA='/mnt/c/ProgramData'
	WIN_APPDATA='/mnt/c/Users/brand/AppData'

	BROWSER_PATH="${WIN_PROGRAMFILES}/Firefox Developer Edition"
	OMP_PATH="${WIN_APPDATA}/Local/Programs/oh-my-posh/bin"
	VSCODE_PATH="${WIN_PROGRAMFILES}/Microsoft VS Code/bin"
	VSCODIUM_PATH="${WIN_PROGRAMFILES}/VSCodium/bin"
	WIN_USBPID="${WIN_PROGRAMFILES}/usbpid-win"
	WIN_DOCKER_PATH="'${WIN_PROGRAMFILES}/Docker/resources/bin"
	WIN_GET_PKGS="${WIN_APPDATA}/Local/Microsoft/Packages"
	WIN_LAZYGIT_PATH="${WIN_GET_PKGS}/JesseDuffield.lazygit_Microsoft.Winget.Source_8wekyb3d8bbwe"
	
	VSCODIUM_INSDRS_PATH="${WIN_PROGRAMFILES}/VSCodium Insiders/bin"
	VCXSRV_PATH="${WIN_PROGRAMFILES}/VcXsrv"
	NEOVIDE_PATH="${WIN_PROGRAMFILES}/neovide"
	LUART_PATH="${WIN_PROGRAMFILES}/LuaRT/bin"
	MELD_PATH="${WIN_PROGRAMFILES}/Meld"

	WINDOWS_PATH="${WIN_DIR}:${WIN_SYS32}:${WIN_DOCKER_PATH}:${BROWSER_PATH}:${WIN_USBPID}:${VCXSRV_PATH}:${VSCODE_PATH}:${VSCODIUM_PATH}:${NEOVIDE_PATH}:${LUART_PATH}:${MELD_PATH}:${WIN_LAZYGIT_PATH}"

	PATH="${PATH}:${WINDOWS_PATH}"
fi

export PATH

export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share:/usr/share}:${XDG_DATA_HOME}"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CONFIG_DIRS="${XDG_CONFIG_DIRS:-/etc/xdg}:${XDG_CONFIG_HOME}"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

export RUSTUP_HOME="$HOME/.config/rustup"
export CARGO_HOME="$HOME/.config/cargo"
