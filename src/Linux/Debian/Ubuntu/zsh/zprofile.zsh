#!/usr/bin/env zsh

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
# echo "$HOME/.profile"
[[ -f ${HOME}/.profile ]] && emulate sh -c '. "${HOME}/.profile"'

if [[ -z ${debian_chroot:-} ]] && [[ -r /etc/debian_chroot ]]; then
    debian_chroot="$(cat /etc/debian_chroot)"
fi

if [[ -n $WSL_INTEROP ]]; then
    export BROWSER='/mnt/c/Program Files/Firefox Developer Edition/firefox.exe'
fi

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/conda/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/opt/conda/etc/profile.d/conda.sh" ]; then
#         . "/opt/conda/etc/profile.d/conda.sh"
#     else
#         export PATH="/opt/conda/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<
