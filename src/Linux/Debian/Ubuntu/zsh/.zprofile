#!/usr/bin/env zsh

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
# echo "$HOME/.profile"
test -f "${HOME}/.profile" && emulate sh -c '. "${HOME}/.profile"'
test -d "${HOME}/.local/bin" || mkdir -p "${HOME}/.local/bin"

if [[ -n $WSL_INTEROP ]]; then
    export BROWSER='/mnt/c/Program Files/Firefox Developer Edition/firefox.exe'
fi

export VIRTUAL_ENV_DISABLE_PROMPT=1
export LESS_ADVANCED_PREPROCESSOR=1
export LESS='-R -F -i -J -M -W -x4 -z4'
export PAGER='/usr/bin/less'
export LESSOPEN="|~/.lessfilter %s 2>&-"
export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'
export MANPAGER=$'/bin/sh -c \'col -b | bat -p -l man\''

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
