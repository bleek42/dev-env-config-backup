#!/usr/bin/env zsh

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 022

# eval "$(keychain -k all --quiet)"
## /etc/ssh/ssh_host_ed25519_key /etc/ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_rsa_key
# eval "$(keychain -k mine)"
if command -v keychain >/dev/null 2>&1; then
  # ssh_keychain="$HOME/.config/keychain"
  is_system_running="$(systemctl is-system-running)"
  echo $is_system_running
  # --nogui --gpg2
  [[ "$is_system_running" =~ "running" ]] &&
    eval "$(keychain --confhost --nogui --systemd --inherit any --dir ~/.config/keychain --absolute --env ~/.config/keychain/${HOST}-sh --eval id_ed25519_gh id_ed25519_work)" ||
    eval "$(keychain --confhost --nogui --inherit any --dir ~/.config/keychain --absolute --env ~/.config/keychain/${HOST}-sh --eval id_ed25519_gh id_ed25519_work)"

  # echo "systemd is running..."
  # print -P "$(systemctl is-system-running)"
# else
#   # echo "systemd not running..."
#   # print -P "$(systemctl is-system-running)"
#   source "$HOME/.config/shells.d/zsh/run-ssh-agent.zsh"

#   zstyle ':omz:plugins:ssh-agent' agent-forwarding yes
#   zstyle ':omz:plugins:ssh-agent' quiet yes
#   zstyle ':omz:plugins:ssh-agent' lazy yes
#   zstyle ':omz:plugins:ssh-agent' lifetime '6h'
#   zstyle ':omz:plugins:ssh-agent' identities id_ed25519_gh id_ed25519_work
#   # zstyle :omz:plugins:ssh-agent helper '$SSH_ASKPASS'
fi

WSL_IPV4="$(hostname -I | awk '{print $1}' | awk '{printf $0}')"
[[ -n "$WSL_IPV4" ]] && export WSL_IPV4

export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0          #GWSL
export PULSE_SERVER=tcp:$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):1 #GWSL
export LIBGL_ALWAYS_INDIRECT=1                                                                #GWSL
export GTK_THEME='Kali-Purple-Dark'
export GDK_SCALE=1       #GWSL
export QT_SCALE_FACTOR=1 #GWSL

PNPM_HOME="$HOME/.local/share/pnpm"
# pnpmsyste
case ":$path:" in
*":$PNPM_HOME:"*) ;;
*) path=($PNPM_HOME $path) ;;
esac

NODE_PATH="${NODE_PATH:-}${PNPM_HOME}/node"
# echo $NODE_PATH
export PNPM_HOME NODE_PATH

# pnpm end

#  LIBGL_ALWAYS_INDIRECT=1 #GWSL
#  GTK_THEME='Kali-Purple-Dark'
#  GDK_SCALE=1                                                                            #GWSL
#  QT_SCALE_FACTOR=1                                                                      #GWSL
#  DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0          #GWSL
#  PULSE_SERVER=tcp:$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):1 #GWSL
