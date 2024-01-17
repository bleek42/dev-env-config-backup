#!/usr/bin/env zsh
#!/usr/bin/env bash

## bashrc is loaded/sourced everytime you start an interactive bash session in the terminal by default
## add this code at the top if you already have an existing ~/.bashrc file in your users home directory

# load any ssh keys that are in $HOME/.ssh so we dont need to enter in our passphrase everytime
agent_load_env() {
        test -f "$env" && . "$env" >|/dev/null
}

agent_start() {
        (umask 077 ssh-agent >|"$env") . "$env" >|/dev/null
}

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(
        ssh-add -l >|/dev/null 2>&1
        echo $?
)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
        agent_start
        ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
        ssh-add
fi

unset env

# case/switch bash statement that checks if is interactive shell, returns & stops loading script if it is not
case $- in
*i*)
    # ? special tty (or teletypewriter) characteristics: setting to single combination for "sane" defaults
    stty sane ;;

*) return ;;
esac

# set zsh options
setopt nonomatch         # hide error message if there is no match for the pattern
setopt notify            # report the status of background jobs immediately
setopt prompt_subst      # enable command substitution in prompt
setopt sh_word_split     # split fields on unquoted parameter expansions (bash compatibility)
setopt numeric_glob_sort # sort filenames numerically when it makes sense
setopt flow_control      # use Ctrl+S / Ctrl+Q to stop and continue flow

setopt glob_dots
setopt null_glob
setopt extended_glob
# History configurations
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share
setopt appendhistory
setopt histignorealldups
setopt histignorespace
setopt histreduceblanks

HISTFILE="$HOME/.cache/zhistory"
HISTSIZE=8000
SAVEHIST=8000
ZCOMPDUMP="$HOME/.cache/zcompdump"

# Make dot key autoexpand "..." to "../.." and so on
_zsh-dot() {
  if [[ ${LBUFFER} = *.. ]]; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}
zle -N _zsh-dot

bindkey . _zsh-dot

## ? configure key keybindings/autoload zsh modules
# ? Fullscreen command line edit
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# Enable run-help module
autoload -z run-help
alias help='run-help'

# enable bracketed paste
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

# enable url-quote-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Enable functions from archive plugin
# fpath+="$ZDOTDIR/plugins/archive"
autoload -Uz archive lsarchive unarchive

# load colors
autoload -Uz colors && colors

zmodload zsh/terminfo
bindkey -e # emacs key bindings
# typeset -A key

bindkey '^Xh' _complete_help
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

# enable zsh command autocompletion features
zmodload zsh/complist
autoload -U compinit && compinit -C

# Allow you to select in a menu
zstyle ':completion:*' menu select
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:default' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*' verbose true
zstyle ':completion:*' complete true
zstyle ':completion:*:*' sort true
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path '${ZCOMPDUMP}'

autoload -Uz bashcompinit && bashcompinit

# ═══════════════════════════════════════
# COMMAND ALIASES
# ═══════════════════════════════════════
# cd into usr home, sys root dir
alias gohome='cd ~'
alias goroot='cd /'

# ═══════════════════════════════════════
# FILE MANAGEMENT ALIASES
# ═══════════════════════════════════════
# don't clobber files & destroy the OS with intetactive flag added by default now
alias cp='cp -i'
alias mv='mv -i'
alias rm="rm -I --preserve-root"
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# Show full paths of files in current directory
alias paths='ls -d $PWD/*'

### Make ls suck less!
# --show-control-chars: help showing Korean or accented characters
alias ls='ls -F --color=$"DIRCOLORS" --show-control-chars'

# shows permissions on files/folders (read,write,xecute) use chown/chmod to chage permission deny errs or add sudo to front of any commnad in MacOS/Linux, install gsudo with winget pkg mgr
alias ll='ls -l'

# Show hidden files, .dotfiles like .git/ in repos or in home folder like .ssh/
alias la='ls -a'

# Show file size, permissions, date, etc.
alias ll='ls -lvhs'
alias lll='ls -alvhs'

# Show only directories
alias l.='ls -d */'

# sort files by size, showing biggest at the bottom
alias lsort="ls -alSr | tr -s ' ' | cut -d ' ' -f 5,9"

# typo corrections
alias l='ls'
alias s='ls'
alias sl='ls'

# make directory and any parent directories needed like mkdir bootcamp/challenge-14/original-reponame-for-dem-ezpoints
alias mkdir='mkdir -p'

# easier directory jumping: just use ... to go back 3 folders
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# typo fix
alias cd..='cd ..'

# ═══════════════════════════════════════
# GIT ALIASES
# ═══════════════════════════════════════

alias gitadd='git add .' # for yous that forget about that space bar, add all changes in repo
alias gitpush='git push' # add origin + branch/you-are-on NOT main
