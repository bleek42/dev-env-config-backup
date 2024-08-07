#!/usr/bin/env zsh

builtin emulate -L zsh ${=${options[xtrace]:#off}:+-o xtrace}
builtin setopt extended_glob warn_create_global typeset_silent

if (( $+commands[eza] )); then
  typeset enable_autocd=0
  typeset -ga eza_params

  alias ls='eza --git --icons --smart-group --group-directories-first --time-style=long-iso --color-scale=all'
  alias la='eza -l -a -b -h -i -m -u -H -S -U'
  alias ll='eza -A --header --long --git --icons --smart-group --group-directories-first --time-style=long-iso --color-scale=all'
  alias ld='eza --git --icons --smart-group -D --time-style=long-iso --color-scale=all'
  alias lfs='eza -l -h -A -x -@ --only-files --created --modified --git --icons --smart-group --group-directories-first --time-style=long-iso --color-scale=all'
  alias lsx='eza -lbhHigUmuSa@'
  alias lsmod='eza --all --header --long --sort=modified --git --icons --smart-group --group-directories-first --time-style=long-iso --color-scale=all'
  alias tree='eza --tree --no-git --git --icons --smart-group --group-directories-first --time-style=long-iso --color-scale=all'
  alias ltree='eza --tree --all --no-git --git --icons --smart-group --group-directories-first --time-style=long-iso --color-scale=all'

  [[ "$AUTOCD" = <-> ]] && enable_autocd="$AUTOCD"
  if [[ "$enable_autocd" == "1" ]]; then
    # Function for cd auto list directories

    →auto-eza() {
        command eza --git --icons --smart-group --group-directories-first --time-style=long-iso --color-scale=all;
      }

    [[ $chpwd_functions[(r)→auto-eza] == →auto-eza ]] || chpwd_functions=( →auto-eza $chpwd_functions )
  fi
  return 0
else
  print "Please install eza before using this plugin." >&2
  return 1
fi
