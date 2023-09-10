# customizations to the default shell environment in /etc/profile.d
export LANG="en_US.UTF-8"
export EDITOR='/usr/bin/nvim'
export VISUAL='code'
export LESSOPEN='| /usr/bin/lesspipe %s'
export LESSCLOSE='/usr/bin/lesspipe %s %s'
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="/usr/share:/usr/local/share:$XDG_DATA_HOME"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export RUSTUP_HOME="$HOME/.local/share/rustup"
export CARGO_HOME="$HOME/.local/share/cargo"
export MANPATH="/usr/man:/usr/share/man:/usr/local/man:$HOME/.local/share/man:/usr/X11R6/man:/opt/man"

# Add /usr/local/sbin, /usr/sbin and /sbin to the PATH for all users
if ! echo "$PATH" | tr : '\n' | grep -q "^/sbin$"; then
    PATH="/usr/local/sbin:/usr/sbin:/sbin:$PATH"
fi

if [ -e "$WSL_INTEROP" ]; then
    PATH="/mnt/c/Windows/System32:/mnt/c/Program Files (x86)/NVIDIA Corporation/PhysX/Common:/mnt/c/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v12.1/bin:/mnt/c/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v12.1/libnvvp:/mnt/c/Program Files/usbipd-win:/mnt/c/Users/brand/AppData/Local/Programs/Microsoft VS Code/bin:/mnt/c/Program Files/Docker/resources/bin:/mnt/c/Users/brand/AppData/Local/Programs/VSCodium Insiders/bin:/mnt/c/Program Files/dotnet:/mnt/c/Program Files/VcXsrv:/mnt/c/Program Files (x86)/Windows Kits/10/Windows Performance Toolkit:$PATH"
fi

export PATH
