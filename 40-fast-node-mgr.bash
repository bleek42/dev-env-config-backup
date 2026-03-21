#!/usr/bin/env sh

if command -v fnm >/dev/null 2>&1; then
    if [ -n "$ZSH_VERSION" ]; then
        eval "$(fnm env --use-on-cd --shell zsh)"
        autoload -Uz _fnm
        typeset -gA _comps

        for zusrlocaldir in /usr/local/share/zsh/*; do
            echo "$zusrlocaldir"
            case "${zusrlocaldir}" in
                vendor-completions)
                    echo "default fnm completions in /usr/local/share/zsh/vendor-completions"
                    fnm completions >| /usr/local/share/zsh/vendor-completions/_fnm &|
                ;;
                site-completions)
                    echo "default fnm completions in /usr/local/share/zsh/site-completions"
                    fnm completions >| /usr/local/share/zsh/site-completions/_fnm &|
                ;;
            esac
        done
        unset zusrlocaldir
    else
        eval "$(fnm env --use-on-cd --shell bash)"
    fi
else
  echo "Fast Node Manager (fnm) command not found: Please install fnm first..!"
fi

