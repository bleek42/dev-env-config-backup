# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.
# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
# umask 022
is_system_running="$(systemctl status ssh.service)"
echo "$is_system_running"

if [[ -n "$(command -v keychain)" ]] && [[ "$is_system_running" =~ "running" ]]; then
    eval "$(keychain --systemd --confhost --inherit any --gpg2 --timeout 300 --dir "${HOME}"/.config/keychain --absolute --env "${HOME}"/.config/keychain/"${HOST}"-sh)"
else
    eval "$(keychain --nogui --confhost --inherit any --gpg2 --timeout 300 --dir "${HOME}"/.config/keychain --absolute --env "${HOME}"/.config/keychain/"${HOST}"-sh)"
fi

PULSE_SERVER=tcp:"$(tr </etc/resolv.conf | grep nameserver | awk '{print $2; exit;}')":1
export PULSE_SERVER

WSL_IPV4="$(hostname -I | awk '{print $1}' | awk '{printf $0}')"
export WSL_IPV4

export DISPLAY="${HOST}":0
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

export LIBGL_ALWAYS_INDIRECT=1 #GWSL
