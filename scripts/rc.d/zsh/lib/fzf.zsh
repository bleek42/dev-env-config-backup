#!/usr/bin/env zsh

if [[ -z $FZF_DEFAULT_COMMAND ]]; then
    if (( ${+commands[fd]} )); then
        FZF_DEFAULT_COMMAND='fd --td --tf --hidden --exclude ".git"'
    elif (( ${+commands[rg]} )); then
        FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
    elif (( ${+commands[ag]} )); then
        FZF_DEFAULT_COMMAND='ag -l --hidden -g "" --ignore ".git"'
    else
        FZF_DEFAULT_COMMAND='find . -path "*/\.*" -prune -o -print'
    fi
fi

export FZF_DEFAULT_COMMAND

_fzf_comprun() {
    local command=$1
    shift

    case "${command}" in
    cd | zd)
        fd --hidden --td --exclude=".git" . | fzf --preview='lsd --tree -I=".git" -aA  -d {}' "$@"
        ;;
    export | set | unset | typeset)
        fzf --preview="eval 'echo \$'{}" "$@"
        ;;
    ssh | scp | sftp | rsh)
        fzf --preview='dig {}' "$@"
        ;;
    *)
        fzf --preview='bat -f -n {}' "$@"
        ;;
    esac
}

_fzf_compgen_path() {
    if command -v rg >/dev/null 2>&1; then
        rg --files --glob="!.git" . "$1"
    fi
}

_fzf_compgen_dir() {
    if command -v fd >/dev/null 2>&1; then
        fd --td --hidden --follow --exclude=".git" . "$1"
    fi
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
    local command="$1"
    shift

    case "${command}" in
    cd | zd)
        fzf --preview 'tree -C {} | head -200' "$@"
        ;;
    export | unset) ;;
    esac
}

# --preview '([[ -f {} ]] && ( bat -f {} || cat {}))
#             ||
#         ([[ -d {} ]] && (tree \"\.git\" {} || tree -aCI \"\.git\" {} | less info -n -q)) {}'

# export FD_DEFAULT_COMMAND='fdfind --hidden -exclude ".git" --follow -f'
# export AG_DEFAULT_COMMAND=''
# export RG_DEFAULT_COMMAND='rg --column --line-number --no-heading --color=always --smart-case'

typeset -g editor_symbol visual_symbol

case "${EDITOR}" in
*nvim*)
    editor_symbol=' '
    ;;
*vim*)
    editor_symbol=' '
    ;;
*)
    editor_symbol='󱔽 '
    ;;
esac

case "${VISUAL}" in
*codium* | *code*)
    visual_symbol='󰨞 '
    ;;
*)
    visual_symbol='󰘙 '
    ;;
esac

# export FZF_DEFAULT_COMMAND='fd -H -L -i -g ""'
export FZF_DEFAULT_COMMAND='ag -S -f --hidden --ignore "*.git" -g ""'

__fzf_default_header="[^G: 󰱞 |^W:  |^SPC: 󰒅 |^A/^U: 󰒆 |^Y:  | ^O:  |^?:  |Alt+J/K: 󰏕/󰏔 |^F/^B: ↑/↓ |^E: ${editor_symbol} |^V: ${visual_symbol}]"

# __fzf_default_colors='fg:#f0f0f0,bg:#252c31,bg+:#005f5f,hl:#87d75f,gutter:#252c31'
# __fzf_default_info_colors='query:#ffffff,prompt:#f0f0f0,pointer:#dfaf00,marker:#00d7d7'

__fzf_histfile="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/fzf-histfile"

__fzf_preview_files='lsd --color=always -1 -aA -F -L --extensionsort --group-dirs=first '
__fzf_preview_dirs='lsd --color=always --tree --blocks=permission,user,size,date,name -a -d'
__fzf_default_preview="([[ -f {} ]] && (bat -f {} || cat {})) || \
                            ([[ -d {} ]] && (lsd --color=always --tree -A -F -d {}) || tree -C -a -f -L 2 {}) || \
                            echo {} 2> /dev/null | bat -f || echo {} 2> /dev/null | less -Rf"

__fzf_colors_fg_bg="fg:#33cfad,fg+:#46e253,bg:#121212,bg+:#231f32"
__fzf_colors_info_marker_hl="hl:#77c6d6,hl+:#3d9d47,info:#afaf87,marker:#5ed7d7"
__fzf_colors_prompt_icons="prompt:#03ff1c,spinner:#1081f2,pointer:#8dee0e,header:#87afaf"
__fzf_colors_border="gutter:#1d1717,border:#4afbfb"
__fzf_colors_label="label:#aeaeae,query:#d9d9d"

__fzf_default_colors="${__fzf_colors_fg_bg},${__fzf_colors_info_marker_hl},${__fzf_colors_prompt_icons},${__fzf_colors_border}"

export FZF_DEFAULT_OPTS="-i \
                -e \
                -m \
                --ansi \
                --cycle \
                --sync \
                --info='inline' \
                --border=sharp \
                --reverse \
                --height='60%' \
                --min-height='54' \
                --padding='2' \
                --margin='1' \
                --header-first \
                --header='${__fzf_default_header}' \
                --preview-window='down:50%:hidden:border-sharp:wrap:~4' \
                --preview='${__fzf_default_preview}'
                --color='${__fzf_default_colors}' \
                --history='${__fzf_histfile}' \
                --history-size=8000 \
                --prompt='' \
                --pointer='->' \
                --marker='*' \
                --select-1 \
                --exit-0 \
                --bind='ctrl-/:toggle-preview' \
                --bind='ctrl-space:toggle+down' \
                --bind='ctrl-a:toggle-all' \
                --bind='ctrl-u:deselect-all' \
                --bind='ctrl-e:execute($EDITOR {+} < /dev/tty > /dev/tty)' \
                --bind='ctrl-v:execute($VISUAL {+})' \
                --bind='alt-j:preview-down' \
                --bind='alt-k:preview-up' \
                --bind='ctrl-f:preview-page-down' \
                --bind='ctrl-b:preview-page-up' \
                --bind='ctrl-o:accept-non-empty'
            "

# --color='${__fzf_colors_info_marker_hl}'
# fzf settings. Uses fdfind for a faster alternative to `find`.
# Preview file content using  bat (https://github.com/sharkdp/)bat
export FZF_CTRL_T_COMMAND='rg --column --line-number --no-heading --color=always --smart-case ""'
export FZF_CTRL_T_OPTS="--height=60% \
                        --border=sharp \
                        --reverse \
                        --prompt='∷ ' \
                        --pointer='▶ ' \
                        --marker='*'
                    "

# ? to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
# export FZF_CTRL_R_OPTS="\
#               --preview 'echo {}' --preview-window 'down:~4:wrap' \
#         --header-first --header 'Press CTRL-Y to copy command into clipboard' \
#               --color 'header:italic' --inline-info \
#               --bind 'ctrl-/:toggle-preview' \
#               --bind 'ctrl-x:execute-silent(echo -n {2..} | pbcopy)+abort'"

# use fdfind for finding directories and files
# export FZF_CHANGE_DIR_FIND_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_INSERT_DIR_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_INSERT_FILES_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_EDIT_FILES_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_ALT_C_COMMAND="${FZF_DEFAULT_COMMAND}"

# # Print tree structure in the preview window
export FZF_ALT_C_COMMAND="${FZF_CTRL_T_COMMAND}"
export FZF_ALT_C_OPTS="${FZF_CTRL_T_OPTS}"
