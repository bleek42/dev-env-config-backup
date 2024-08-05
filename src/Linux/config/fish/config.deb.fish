#!/usr/bin/env fish

## ? Set values
## ? Hide welcome message
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT 1
set -x MANPAGER "sh -c 'col -bx | bat -l man -p -f'"

## ? Set PostgreSQL environment vars

## ? Export variable need for qt-theme
if type qtile >>/dev/null 2>&1
    set -x QT_QPA_PLATFORMTHEME qt5ct
end

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

## ? Environment setup
## ? Apply .profile: use this to put fish compatible .profile stuff in
if test -f "$HOME/.fish_profile"
    source "$HOME/.fish_profile"
end

# Add "$HOME/.local/bin" to PATH
if test -d "$HOME/.local/bin" && not contains -- "$HOME/.local/bin" $PATH
    fish_add_path "$HOME/.local/bin"
end


# Apply .profile: use this to put fish compatible .profile stuff in
if test -f $HOME/.config/fish/functions/fish_prompt.fish
    source $HOME/.config/fish/functions/fish_prompt.fish
end

## ? Starship prompt
# if status --is-interactive && type -q starship
#    source ("/usr/bin/starship" init fish --print-full-init | psub)
# end


## ? Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

## ? Useful aliases

## ? Replace ls with eza
if type -q eza
    alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
    alias la='eza -a --color=always --group-directories-first --icons' # all files and dirs
    alias ll='eza -l --color=always --group-directories-first --icons' # long format
    alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
    alias l.="eza -a | egrep '^\.'" # show only dotfiles
    alias ip="ip -color"
end

## ? Replace some more things with better alternatives

# alias bat='batcat --style header --style rules --style snip --style changes --style header'

[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru'

# Common use
alias grubup="sudo update-grub"

alias tarnow='tar -acf '
alias untar='tar -xvf '
alias wget='wget -c '

alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

alias upd='/usr/bin/update'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias hw='hwinfo --short' # Hardware Info

if type -q pacman
    alias pacrm="sudo pacman -Rdd"
    alias pacfixdb="sudo rm /var/lib/pacman/db.lck"
    alias pacbig="expac -H M '%m\t%n' | sort -h | nl" # Sort installed packages according to size in MB
    alias pacgitpkgs='pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages
    alias paclean='sudo pacman -Rns (pacman -Qtdq)'
    alias pacrip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
end

# Get fastest mirrors
if type -q reflector
    alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
    alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
    alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
    alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
end
# terminal pastebin
alias tb='nc termbin.com 9999'

# Cleanup orphaned packages

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# shorten systemctl
alias sysctl="systemctl"

# Recent installed packages

# posgresql script formatter
# alias pgfmt="pg_format"

## ? Run fastfetch if session is interactive
if status --is-interactive && type -q fastfetch
    fastfetch
end

if test -f $HOME/.local/share/icons-in-terminal/icons.fish
    source $HOME/.local/share/icons-in-terminal/icons.fish
end
## ? Advanced command-not-found hook
if test -f /usr/share/doc/find-the-command/ftc.fish
    source /usr/share/doc/find-the-command/ftc.fish
end
