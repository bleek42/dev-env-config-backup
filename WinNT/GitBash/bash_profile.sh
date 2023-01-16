#!/usr/bin/bash
test -f ~/.bashrc && source ~/.bashrc

# OhMyPosh! terminal prompt alias, custom prompt style in easy JSON config file formats
# Check if we are running in an interactive terminal, print system info to screen & init
# OhMyPosh config ".omp.json" file in users home dir
# check if the cmd.exe exists in users $PATH
# If we're in Windows Terminal, advertise true-color support.
if [ -n "$WT_SESSION" ]; then
  export COLORTERM='truecolor'
  if command -v neofetch >/dev/null 2>&1; then
    alias nfetch='neofetch'
    neofetch --w3m --size 60% --distro_shorthand off
  else
    echo "cannot find neofetch.exe..."
  fi

  if command -v oh-my-posh >/dev/null 2>&1; then
    alias omp='oh-my-posh'
    eval "$(oh-my-posh prompt init bash --config "${HOME}"/.custom.omp.json)"
  else
    echo "cannot find oh-my-posh.exe..."
  fi
fi
