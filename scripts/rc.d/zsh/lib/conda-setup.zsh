# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(${HOME}/.local/share/zsh/plugins/pyenv/versions/miniconda3-latest/bin/conda 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${HOME}/.local/share/zsh/plugins/pyenv/versions/miniconda3-latest/etc/profile.d/conda.sh" ]; then
        source "${HOME}/.local/share/zsh/plugins/pyenv/versions/miniconda3-latest/etc/profile.d/conda.sh"
    else
        export PATH="${HOME}/.local/share/zsh/plugins/pyenv/versions/miniconda3-latest/bin:${PATH}"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
