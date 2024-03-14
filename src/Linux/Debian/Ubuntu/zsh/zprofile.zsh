#!/usr/bin/env zsh

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
# echo "$HOME/.profile"
test -f "${HOME}/.profile" && emulate sh -c '. "${HOME}/.profile"'
test -f "${HOME}/.config/rc.d/zsh/functions.sh" && source "${HOME}/.config/rc.d/zsh/functions.sh"
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

# pnpm
# export PNPM_HOME="/home/bleek42/.local/share/pnpm"
case ":$path:" in
*":$pnpm_home:"*) ;;
*) path=($pnpm_home $path) ;;
esac

export PATH
# pnpm end
