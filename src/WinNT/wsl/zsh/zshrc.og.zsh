#!/usr/bin/env zsh

# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples

# ZPLUG
export ZPLUG_HOME="$HOME/.config/zplug"
export ZPLUG_BIN="$ZPLUG_HOME/bin"
export ZPLUG_LOADFILE="$ZPLUG_HOME/packages.zsh"
export ZPLUG_CACHE_DIR="$ZPLUG_HOME/cache"
export ZPLUG_USE_CACHE=true
export ZPLUG_ERROR_LOG="$ZPLUG_HOME/error_zplug.log"
export ZPLUG_REPOS="$ZPLUG_HOME/repos"
export ZPLUG_PROTOCOL=HTTPS
export ZPLUG_FILTER=fzf-tmux:fzf:peco:percol:fzy:zaw

if [ -f "/usr/share/zplug/init.zsh" ]; then

  source "/usr/share/zplug/init.zsh"

  # Make sure to use double quotes
  zplug "zplug/zplug", hook-build:'zplug --self-manage'

  zplug "plugins/ubuntu", from:oh-my-zsh, if:"command -v apt >/dev/null 2>&1"

  # Set the priority when loading
  # e.g., zsh-syntax-highlighting must be loaded
  # after executing compinit command and sourcing other plugins
  # (If the defer tag is given 2 or above, run after compinit command)
  # zplug "zsh-users/zsh-syntax-highlighting", defer:2
  # zplug "unixorn/docker-helpers", from:gh-r, use:'docker-helpers.plugin.zsh'

  zplug "$HOME/.local/share/dragon", from:local, as:theme, use:'dragon.zsh-theme'

  zplug "/usr/share/zsh-autosuggestions", from:local, use:'zsh-autosuggestions.zsh', defer:1

  zplug "/usr/share/zsh-syntax-highlighting", from:local, use:'zsh-syntax-highlighting.zsh', defer:2

  zplug "zsh-users/zsh-history-substring-search", use:'zsh-history-substring-search.zsh', defer:3

  # Install plugins if there are plugins that have not been installed

  if ! zplug check; then
    # printf "Install? [y/N]: "
    # if read -q; then
    #     echo
    zplug install
  fi

  # Then, source plugins and add commands to $PATH
  zplug load
  # enable auto-suggestions based on the history
fi

setopt autocd # change directory just by typing its name
#setopt correct            # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt
# History configurations
HISTFILE="$HOME/.config/zsh_history"
HISTSIZE=5000
SAVEHIST=5000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

WORDCHARS=${WORDCHARS//\//} # Don't consider certain characters part of the word

# hide EOL sign ('%')
PROMPT_EOL_MARK=" "

# configure key keybindings
# Use the Emacs-like keybindings
bindkey -e

# Keybindings for substring search plugin. Maps up and down arrows.
bindkey -M main '^[OA' history-substring-search-up
bindkey -M main '^[OB' history-substring-search-down
bindkey -M main '^[[A' history-substring-search-up
bindkey -M main '^[[B' history-substring-search-up

# Keybindings for autosuggestions plugin
bindkey '^ ' autosuggest-accept
bindkey '^f' autosuggest-accept

bindkey ' ' magic-space                        # do history expansion on space
bindkey '^U' backward-kill-line                # ctrl + U
bindkey '^[[3;5~' kill-word                    # ctrl + Supr
bindkey '^[[3~' delete-char                    # delete
bindkey '^[[1;5C' end-of-line                  # ctrl + ->
bindkey '^[[1;5D' beginning-of-line            # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history # page up
bindkey '^[[6~' end-of-buffer-or-history       # page down
bindkey '^[[H' forward-word                    # home
bindkey '^[[F' end-of-line                     # end
bindkey '^Z' undo                              # ctrl + Z undo last action

# Keybindings for substring search plugin. Maps up and down arrows.
bindkey -M main '^[OA' history-substring-search-up
bindkey -M main '^[OB' history-substring-search-down
bindkey -M main '^[[A' history-substring-search-up
bindkey -M main '^[[B' history-substring-search-up

# configure `time` format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && emulate sh -c 'lesspipe'

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

configure_prompt() {
  prompt_symbol=㉿
  # Skull emoji for root terminal
  #[ "$EUID" -eq 0 ] && prompt_symbol=💀
  case "$PROMPT_ALTERNATIVE" in
  twoline)
    PROMPT=$'%F{%(#.blue.green)}┌──${debian_chroot:+($debian_chroot)─}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))─}(%B%F{%(#.red.blue)}%n'$prompt_symbol$'%m%b%F{%(#.blue.green)})-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]\n└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '
    # Right-side prompt with exit codes and background processes
    RPROMPT=$'%(?.. %? %F{red}%B⨯%b%F{reset})%(1j. %j %F{yellow}%B⚙%b%F{reset}.)'
    ;;
  oneline)
    PROMPT=$'${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%B%F{%(#.red.blue)}%n@%m%b%F{reset}:%B%F{%(#.blue.green)}%~%b%F{reset}%(#.#.$) '
    RPROMPT=
    ;;
  backtrack)
    PROMPT=$'${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%B%F{red}%n@%m%b%F{reset}:%B%F{blue}%~%b%F{reset}%(#.#.$) '
    RPROMPT=
    ;;
  esac
  unset prompt_symbol
}

# The following block is surrounded by two delimiters.
# These delimiters must not be modified. Thanks.
# START KALI CONFIG VARIABLES
PROMPT_ALTERNATIVE=twoline
NEWLINE_BEFORE_PROMPT=yes
# STOP KALI CONFIG VARIABLES

if [ "$color_prompt" = yes ]; then
  # override default virtualenv indicator in prompt
  VIRTUAL_ENV_DISABLE_PROMPT=1

  configure_prompt
fi

toggle_oneline_prompt() {
  if [ "$PROMPT_ALTERNATIVE" = oneline ]; then
    PROMPT_ALTERNATIVE=twoline
  else
    PROMPT_ALTERNATIVE=oneline
  fi
  configure_prompt
  zle reset-prompt
}

zle -N toggle_oneline_prompt
bindkey ^P toggle_oneline_prompt

if ! command -v zplug >/dev/null 2>&1; then
  [ ! -f "/usr/share/zsh-syntax-highlighting/zsh-autosuggestions.zsh" ] || source "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  [ ! -f "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] || source "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  # PROMPT='${debian_chroot:+($debian_chroot)}%n@%m:%~%(#.#.$) '

fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt* | Eterm | aterm | kterm | gnome* | alacritty)
  TERM_TITLE=$'\e]0;${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%n@%m: %~\a'
  ;;
*) ;;
esac

# enable syntax-highlighting
unset color_prompt force_color_prompt

precmd() {
  # Print the previously configured title
  print -Pnr -- "$TERM_TITLE"

  # Print a new line before the prompt, but only if it is not the first line
  if [ "$NEWLINE_BEFORE_PROMPT" = yes ]; then
    if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
      _NEW_LINE_BEFORE_PROMPT=1
    else
      print ""
    fi
  fi
}

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias diff='diff --color=auto'
  alias ip='ip --color=auto'

  export LESS_TERMCAP_mb=$'\E[1;31m'  # begin blink
  export LESS_TERMCAP_md=$'\E[1;36m'  # begin bold
  export LESS_TERMCAP_me=$'\E[0m'     # reset bold/blink
  export LESS_TERMCAP_so=$'\E[01;33m' # begin reverse video
  export LESS_TERMCAP_se=$'\E[0m'     # reset reverse video
  export LESS_TERMCAP_us=$'\E[1;32m'  # begin underline
  export LESS_TERMCAP_ue=$'\E[0m'     # reset underline

  # Take advantage of $LS_COLORS for completion as well
  # zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
  # zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
fi

[ -d "$zsh_plugin_dir/zsh-syntax-highlighting" ] && [ -f "~/.config/zsh-syntax-color-vars.zsh" ] && source "~/.config/zsh-syntax-color-vars.zsh"

# enable completion features
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

if zplug check "/usr/share/zsh-autosuggestions"; then
  # Gray color for autosuggestions
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=247'
fi

if zplug check "/usr/share/zsh-syntax-highlighting"; then
  source "$HOME/.config/zsh-syntax-color-vars.zsh"
fi

# force zsh to show the complete history
alias history='history 0'
alias plz='sudo'
# some more ls aliases
alias ll='ls -l --color=auto'
alias la='ls -A --color=auto'
alias lcf='ls -CF --color=auto'
alias rsyncxav='rsync --archive --acls --xattrs --hard-links --verbose --progress'

# enable command-not-found if installed
if [ -f /etc/zsh_command_not_found ]; then
  source /etc/zsh_command_not_found
fi

# zstyle ':completion:*' menu select
fpath+="$HOME/.config/.zfunc"
