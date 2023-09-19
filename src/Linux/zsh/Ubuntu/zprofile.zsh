#!/usr/bin/env zsh

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
# echo "$HOME/.profile"
[[ -f "$HOME/.profile" ]] && emulate sh -c '. "$HOME/.profile"'

WSL_IPV4="$(hostname -I | awk '{print $1}' | awk '{printf $0}')"
[[ -n "$WSL_IPV4" ]] && export WSL_IPV4

PNPM_HOME="$HOME/.local/share/pnpm"
# pnpmsyste
case ":$path:" in
*":$PNPM_HOME:"*) ;;
*) path=($PNPM_HOME $path) ;;
esac

NODE_PATH="${NODE_PATH:-$PNPM_HOME}/node"

export PNPM_HOME NODE_PATH

# pnpm end