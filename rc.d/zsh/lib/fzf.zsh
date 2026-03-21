#!/usr/bin/env zsh

export default FZF_DEFAULT_COMMAND='ag -S -l -f --hidden -g'
# export FZF_DEFAULT_COMMAND='fd -td -tf --hidden --exclude=".git" --exclude="node_modules"'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='rg --files --no-ignore --hidden --follow --glob "!**/.git/*"'

# # Auto-completion
# # ---------------
# # You may want to set up an alternative default source for fzf
# # For example, to use the silver searcher ag:
# ? export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
# # To use the command fd (https://github.com/sharkdp/fd):
# ? export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
# # Use ripgrep to improve fzf's performance
# ? export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!**/.git/*"'
# # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# # - The first argument to the function is the base path to start searching
# # - The environment variable $FZF_TMUX_HEIGHT has default value 40%

_fzf_comprun() {
    local command=$1
    shiftq

    case "${command}" in
    cd | zd)
        fd --hidden -td --exclude=".git" --exclude="node_modules" . | fzf --preview='lsd --tree -I=".git" -aA  -d {}' "$@"
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
        fd --td --hidden --follow --exclude=".git" --exclude="node_modules" . "$1"
    fi
}

# # Advanced customization of fzf options via _fzf_comprun function
# # - The first argument to the function is the name of the command.
# # - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
    local command="$1"
    shift

    case "${command}" in
    cd | zd)
        fzf --preview 'command tree -C {} | head -200' "$@"
        ;;
    export | unset) ;;
    esac
}

# --preview '([[ -f {} ]] && ( bat -f {} || cat {})) ||
#         ([[ -d {} ]] && (tree \"\.git\" {} || tree -aCI \"\.git\" {} | less info -n -q)) {}'

#export FD_DEFAULT_COMMAND='fdfind --hidden -exclude ".git" --follow -f'
#export AG_DEFAULT_COMMAND=''
#export RG_DEFAULT_COMMAND='rg --column --line-number --no-heading --color=always --smart-case'

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

# # export FZF_DEFAULT_COMMAND='fd -H -L -i -g ""'
# # export FZF_DEFAULT_COMMAND='ag -S -f --hidden --ignore "*.git" -g ""'

__fzf_default_header="[^G: 󰱞 |^W:  |^SPC: 󰒅 |^A/^U: 󰒆 |^Y:  | ^O:  |^P:  |Alt+J/K: 󰏕/󰏔 |^F/^B: ↑/↓ |^E: ${editor_symbol} |^V: ${visual_symbol}]"

# # __fzf_default_colors='fg:#f0f0f0,bg:#252c31,bg+:#005f5f,hl:#87d75f,gutter:#252c31'
# # __fzf_default_info_colors='query:#ffffff,prompt:#f0f0f0,pointer:#dfaf00,marker:#00d7d7'

__fzf_histfile="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/fzf-histfile"

__fzf_preview_files='lsd --color=always -1 -aA -F -L --extensionsort --group-dirs=first '
__fzf_preview_dirs='lsd --color=always --tree --blocks=permission,user,size,date,name -a -d'
__fzf_default_preview="([[ -f {} ]] && (command bat -f {} || command cat {})) || \
                            ([[ -d {} ]] && (command lsd --color=always --tree -a -d {}) || command tree -C -a -f -L 2 {}) || \
                            echo {} 2> /dev/null | command bat -f -p || echo {} 2> /dev/null | command less -R"


# __fzf_colors_fg_bg="fg:#33cfad,fg+:#46e253,bg:#121212,bg+:#231f32"
# __fzf_colors_info_marker_hl="hl:#77c6d6,hl+:#3d9d47,info:#afaf87,marker:#5ed7d7"
# __fzf_colors_prompt_icons="prompt:#03ff1c,spinner:#1081f2,pointer:#8dee0e,header:#87afaf"
# __fzf_colors_border="gutter:#2d1717,border:#4afbfb"
# __fzf_colors_label="label:#aeaeae,query:#d10d9d"

__fzf_colors="fg:39,fg+:51,bg:233,bg+:235,list-fg:135,list-bg:235,selected-fg:118,selected-bg:234,preview-fg:47,preview-bg:235,preview-border:69"
__fzf_colors+=",hl:116,hl+:71,selected-hl:75,info:144,marker:80,current-fg:82,current-bg:235"
__fzf_colors+=",prompt:47,spinner:45,pointer:48,header:51,input-fg:154,input-bg:234,header-fg:135,header-bg:235"
__fzf_colors+=",gutter:234,border:51,list-border:51,input-border:123,scrollbar:154,info:189"
__fzf_colors+=",label:145,query:121,ghost:151,separator:152,gap-line:152"

# __fzf_default_colors="${__fzf_colors_fg_bg},${__fzf_colors_info_marker_hl},${__fzf_colors_prompt_icons},${__fzf_colors_border}"

# # icons
# ? '    ▶ ∷ '

export FZF_DEFAULT_OPTS="-m \
                -e \
                --raw \
                --ansi \
                --cycle \
                --sync \
                --wrap-word \
                --reverse \
                --track \
                --highlight-line \
                --color='${__fzf_colors}' \
                --ghost=∷ \
                --tabstop=4 \
                --layout=reverse-list \
                --border=block \
                --info=inline-right \
                --tail=60000 \
                --height=~60% \
                --min-height=40 \
                --preview-window=right,border-sharp,hidden,wrap-word \
                --prompt=' ' \
                --pointer='▶ '\
                --marker=' ' \
                --marker-multi-line='󰾂  ' \
                --header='${__fzf_default_header}' \
                --header-first \
                --header-lines=2 \
                --header-border=rounded \
                --header-label=' 󰌏 ' \
                --header-label-pos=40 \
                --input-border=bold \
                --list-border=sharp \
                --scheme=history \
                --history='${__fzf_histfile}' \
                --history-size=40000 \
                --select-1 \
                --bind='ctrl-p:toggle-preview' \
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

# --tmux=bottom,100%,50%,border-sharp \

# # fzf settings. Uses fdfind for a faster alternative to `find`.
# # Preview file content using  bat (https://github.com/sharkdp/)bat
export FZF_CTRL_T_COMMAND='rg --column --line-number --no-heading --color=always --smart-case ""'
export FZF_CTRL_T_OPTS="--height=75% \
                        --border=sharp \
                        --reverse \
                        --prompt='∷ ' \
                        --pointer=' ' \
                        --marker='*'
                    "

#export FZF_CTRL_R_OPTS="\
#              --preview 'echo {}' --preview-window 'down:~4:wrap' \
#        --header-first --header 'Press CTRL-Y to copy command into clipboard' \
#              --color 'header:italic' --inline-info \
#              --bind 'ctrl-/:toggle-preview' \
#              --bind 'ctrl-x:execute-silent(echo -n {2..} | pbcopy)+abort'"

# # use fdfind for finding directories and files
#export FZF_CHANGE_DIR_FIND_COMMAND="$FZF_DEFAULT_COMMAND"
#export FZF_INSERT_DIR_COMMAND="$FZF_DEFAULT_COMMAND"
#export FZF_INSERT_FILES_COMMAND="$FZF_DEFAULT_COMMAND"
#export FZF_EDIT_FILES_COMMAND="$FZF_DEFAULT_COMMAND"
#export FZF_ALT_C_COMMAND="${FZF_DEFAULT_COMMAND}"

## ? ## # Print tree structure in the preview window
export FZF_ALT_C_COMMAND="${FZF_CTRL_T_COMMAND}"
export FZF_ALT_C_OPTS="${FZF_CTRL_T_OPTS}"
