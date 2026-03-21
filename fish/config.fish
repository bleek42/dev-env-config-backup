#!/usr/bin/env fish

###?######################################################################################
###? Set fish shell variables initial values                                            ##
###?######################################################################################
## * Hide welcome message and ensure the fish shell is reported correctly
## * Set the shell environment variable to fish
set -Ux SHELL /usr/bin/fish
set fish_greeting

set VIRTUAL_ENV_DISABLE_PROMPT 0 ## * show / hide status of python virtual env on prompt

## * Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

### * Environment setup
## * Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
    source ~/.fish_profile
end

## * Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

### * Advanced command-not-found hook
if test -r /usr/share/doc/find-the-command/ftc.fish
    source /usr/share/doc/find-the-command/ftc.fish
end

## * The following section customizes colors and behavior for fzf, a command-line fuzzy finder
if type -q fzf
    ## * Define a custom header for fzf with key bindings and icons
    set __fzf_default_header "[^G: 󰱞 |^W:  |^SPC: 󰒅 |^A/^U: 󰒆 |^Y:  | ^O:  |^P:  |Alt+J/K: 󰏕/󰏔 |^F/^B: ↑/↓ |^E:  |^V: 󰨞]"

    ## * Set color scheme for foreground and background
    set __fzf_colors_fg_bg "fg:#33cfad,fg+:#46e253,bg:#121212,bg+:#231f32"

    ## * Set color scheme for highlighted text, info, and marked items
    set __fzf_colors_info_marker_hl "hl:#77c6d6,hl+:#3d9d47,info:#afaf87,marker:#5ed7d7"

    ## * Set color scheme for prompt, spinner, pointer, and header
    set __fzf_colors_prompt_icons "prompt:#03ff1c,spinner:#1081f2,pointer:#8dee0e,header:#87afaf"

    ## * Set color scheme for gutter and border
    set __fzf_colors_border "gutter:#1d1717,border:#4afbfb"

    ## * Set color scheme for labels and queries
    set __fzf_colors_label "label:#aeaeae,query:#d9d9d"

    ## * Combine all color definitions into a single variable for fzf
    set __fzf_default_colors "$__fzf_colors_fg_bg,$__fzf_colors_info_marker_hl,$__fzf_colors_prompt_icons,$__fzf_colors_border"

    ## * Set the default command for fzf to search directories and files, excluding .git
    set -Ux FZF_DEFAULT_COMMAND 'fd -td -tf --hidden --exclude=".git"'

    ## * Set various options for fzf, including interface behavior and key bindings
    set -Ux FZF_DEFAULT_OPTS '-m -e -i --ansi --cycle --sync --reverse --height=-1 --tail=10000 --header-first --header="[^G: 󰱞 |^W:  |^SPC: 󰒅 |^A/^U: 󰒆 |^Y:  | ^O:  |^P:  |Alt+J/K: 󰏕/󰏔 |^F/^B: ↑/↓ |^E:  |^V: 󰨞]" --preview-window="down:hidden:wrap:~4" --preview-border=thinblock --preview="([[ -f {} ]] && (bat -f {} || cat {})) || ([[ -d {} ]] && (lsd --color=always --tree -A -F -d {}) || tree -C -a -f -L {}) || echo {} 2> /dev/null | bat -f || echo {} 2> /dev/null | less -Rf" --color="fg:#33cfad,fg+:#46e253,bg:#121212,bg+:#231f32,hl:#77c6d6,hl+:#3d9d47,info:#afaf87,marker:#5ed7d7,prompt:#03ff1c,spinner:#1081f2,pointer:#8dee0e,header:#87afaf,gutter:#1d1717,border:#4afbfb" --history-size=10000 --prompt=" " --pointer="->" --marker="* " --select-1 --exit-0 --bind=tab:down --bind=ctrl-p:toggle-preview'

    # "
    #     -i \                                # Case-insensitive search
    #     -e \                                # Exact match
    #     -m \                                # Enable multi-select
    #     --ansi \                            # Enable ANSI color codes
    #     --cycle \                           # Enable cycling through results
    #     --sync \                            # Synchronous search
    #     --reverse \                         # Display results in reverse order
    #     --border=block \                    # Use block border style
    #     --info=inline \                     # Display info inline
    #     --height=60% \                      # Set height of fzf window
    #     --min-height=40 \                   # Minimum height of fzf window
    #     --tail=10000 \                      # Show last 10000 lines for preview
    #     --header-first \                    # Show header first
    #     --header='$__fzf_default_header' \  # Use the custom header defined earlier
    #     --color='$__fzf_default_colors' \ # Apply custom colors to fzf
    #     --history-size=10000 \         # Set history size for fzf
    #     --prompt=' ' \                # Set the prompt symbol
    #     --pointer='->' \               # Set pointer symbol
    #     --marker='*' \                 # Set marker symbol for selected items
    #     --select-1 \                   # Automatically select if there's only one match
    #     --bind='tab:down' \            # Bind Tab key to move down
    #     --bind='ctrl-p:toggle-preview' \ # Bind Ctrl+P to toggle preview
    #     --bind='ctrl-space:toggle+down' \ # Bind Ctrl+Space to toggle selection and move down
    #     --bind='ctrl-a:toggle-all' \   # Bind Ctrl+A to toggle all selections
    #     --bind='ctrl-u:deselect-all' \ # Bind Ctrl+U to deselect all
    #     --bind='ctrl-e:execute($EDITOR {+} < /dev/tty > /dev/tty)' \ # Bind Ctrl+E to execute editor with selected items
    #     --bind='ctrl-v:execute($VISUAL {+})' \ # Bind Ctrl+V to execute visual editor with selected items
    #     --bind='alt-j:preview-down' \  # Bind Alt+J to move preview down
    #     --bind='alt-k:preview-up' \    # Bind Alt+K to move preview up
    #     --bind='ctrl-f:preview-page-down' \ # Bind Ctrl+F to move preview page down
    #     --bind='ctrl-b:preview-page-up' \ # Bind Ctrl+B to move preview page up
    #     --bind='ctrl-o:accept-non-empty'  # Bind Ctrl+O to accept non-empty input"

end

### ? Functions
## * Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
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

## * Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

## * Copy DIR1 DIR2
function cp_dir
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | string trim --right --chars=/)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

### * Useful aliases

## * Common use
alias cd.. 'cd ..'
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias ...... 'cd ../../../../..'
alias dir 'dir --color=auto'
alias vdir 'vdir --color=auto'
alias ugrep 'ugrep --color=auto'
alias egrep 'ugrep -E'
alias fgrep 'ugrep -F'

alias hw 'hwinfo --short' ## * Hardware Info
alias grubup 'sudo update-grub'

alias ip 'ip -color'

alias psmem 'ps auxf | sort -nr -k 4'
alias psmem10 'ps auxf | sort -nr -k 4 | head -10'

alias tarnow 'tar -acf '
alias untarz 'tar -zxvf '
alias wgetc 'wget -c '

alias plz sudo
alias termbin 'nc termbin.com 9999'

## * Get the error messages from journalctl
alias journctlerr 'journalctl -p 3 -xb'

alias xhostroot 'xhost si:localuser:root'

## * Replace ls with eza
if type -q eza
    alias ls 'eza -al --color=always --group-directories-first --icons' ## * preferred listing
    alias la 'eza -a --color=always --group-directories-first --icons' ## * all files and dirs
    alias ll 'eza -l --color=always --group-directories-first --icons' ## * long format
    alias lt 'eza -aT --color=always --group-directories-first --icons' ## * tree listing
    alias l. 'eza -ald --color=always --group-directories-first --icons .*' ## * show only dotfiles
end

## * Replace some more things with better alternatives
if type -q bat
    alias cat 'bat --style header --style snip --style changes --style header'
end

if type -q radeontop
    alias radeontop='radeontop --color -T'
end

if type -q pacman
    alias manpac 'man pacman'
    alias pacmans 'sudo pacman -S'
    alias pacmanrmd 'sudo pacman -Rdd'
    alias pacrmdns 'sudo pacman -Rns'
    alias pacqgit 'pacman -Q | grep -i "\-git" | wc -l' ## * List amount of -git packages
    alias pacfix 'sudo rm /var/lib/pacman/db.lck'

    if type -q pacdiff and type -q meld
        alias pacdiff 'sudo -H DIFFPROG=meld pacdiff'
    end

    ## * Get fastest, latest pacman mirrors
    if type -q reflector
        alias mirrorf 'sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist'
        alias mirrora 'sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist'
        alias mirrord 'sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist'
        alias mirrors 'sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist'
    end

    if type -q expac
        ## * Recent installed packages
        alias pacrip 'expac --timefmt="%Y-%m-%d %T" "%l\t%n %v" | sort | tail -200 | nl'
        alias pacbig 'expac -H M "%m\t%n" | sort -h | nl' ## * Sort installed packages according to size in MB (expac must be installed)

    end

    if type -q garuda-update
        alias garudaupd /usr/bin/garuda-update
        alias garudaupda '/usr/bin/garuda-update -a'
    end

    if type -q paru
        if not type -q yay
            alias yay paru
        end

        alias parus 'paru -S'
        alias parurmd 'paru -Rdd'
        alias parurmns 'paru -Rns'
    end

end

if type -q zoxide
    ## * Recent installed packages
    zoxide init fish --cmd zd | source
end

### * Run fastfetch if session is interactive
if status --is-interactive

    ## * batpipe, a bat-based preprocessor for less and bat.
    ## * https://github.com/eth-p/bat-extras
    ## * To use batpipe, eval the output of this command in your shell init script.
    if type -q bat
        if type -q batpipe
            eval (batpipe)
        end

        if type -q batman
            source (batman --export-env | psub)
        end
    end

    if type -q tmux
        set -Ux fish_tmux_autostart true
    end

    if type -q fastfetch
        set fish_greeting fastfetch
        fastfetch
    end

    ### * Starship prompt
    if type -q starship and test $TERM = foot
        source (starship init fish --print-full-init | psub)
    end

end
