#!/usr/bin/env zsh

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 022

# eval "$(keychain -k all --quiet)"
## /etc/ssh/ssh_host_ed25519_key /etc/ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_rsa_key
# eval "$(keychain -k mine)"
if command -v keychain >/dev/null 2>&1; then
  ssh_keychain="${HOME}/.config/keychain"
  is_system_running="$(systemctl is-system-running)"

  # --nogui --gpg2
  [[ "$is_system_running" =~ "running" ]] &&
    eval "$(keychain --systemd --inherit any --dir "${ssh_keychain}" --absolute --env "${ssh_keychain}/${HOST}-sh" --eval)" ||
    eval "$(keychain --inherit any --dir "${ssh_keychain}" --absolute --env "${ssh_keychain}/${HOST}-sh" --eval)"
fi

PNPM_HOME="$HOME/.local/share/pnpm"
# pnpm
case ":$path:" in
*":$PNPM_HOME:"*) ;;
*) path=($PNPM_HOME $path) ;;
esac

NODE_PATH="$PNPM_HOME/node"
export PNPM_HOME NODE_PATH
# pnpm end
