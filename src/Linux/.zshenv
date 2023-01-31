#!/usr/bin/env zsh

### EXPORT ###

# If you come from bash you might have to change your $PATH.
export PATH="/usr/bin:usr/local/bin:$HOME/.bin:/$HOME/.local:$PATH"
export EDITOR='micro'
export VISUAL='codium'
export PAGER='most'
export LANG="en_US.UTF-8"
export MANPATH="/usr/local/man:$MANPATH"

if command -v fnm >/dev/null 2>&1; then
  export PATH="/run/user/1000/fnm_multishells/62123_1674754532727/bin":$PATH
  export FNM_NODE_DIST_MIRROR="https://nodejs.org/dist"
  export FNM_VERSION_FILE_STRATEGY="local"
  export FNM_MULTISHELL_PATH="/run/user/1000/fnm_multishells/62123_1674754532727"
  export FNM_DIR="/home/bleek/.local/share/fnm"
  export FNM_LOGLEVEL="info"
  export FNM_ARCH="x64"
  rehash
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
