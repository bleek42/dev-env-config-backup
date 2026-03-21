#!/usr/bin/env zsh

### * ZSH KEYBINDINGS ------------------------------------------------------------- #
### * http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html                   #
### * http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins      #
### * http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets  #
### * ###############################################################################

## ? to add other keys to this hash, see: man 5 terminfo
## ? Check if terminfo is available
zmodload zsh/terminfo

bindkey -e

# 'bindkey' '-s' '^[OM' '^M'
# 'bindkey' '-s' '^[Ok' '+'
# 'bindkey' '-s' '^[Om' '-'
# 'bindkey' '-s' '^[Oj' '*'
# 'bindkey' '-s' '^[Oo' '/'
# 'bindkey' '-s' '^[OX' '='
# 'bindkey' '-s' '^[OA' '^[[A'
# 'bindkey' '-s' '^[OB' '^[[B'
# 'bindkey' '-s' '^[OD' '^[[D'
# 'bindkey' '-s' '^[OC' '^[[C'
# 'bindkey' '-s' '^[OH' '^[[H'
# 'bindkey' '-s' '^[[1~' '^[[H'
# 'bindkey' '-s' '^[[7~' '^[[H'
# 'bindkey' '-s' '^[OF' '^[[F'
# 'bindkey' '-s' '^[[4~' '^[[F'
# 'bindkey' '-s' '^[[8~' '^[[F'
# 'bindkey' '-s' '^[[3\^' '^[[3;5~'
# 'bindkey' '-s' '^[^[[3~' '^[[3;3~'
# 'bindkey' '-s' '^[[1;9C' '^[[1;3C'
# 'bindkey' '-s' '^[^[[C' '^[[1;3C'
# 'bindkey' '-s' '^[[1;9D' '^[[1;3D'
# 'bindkey' '-s' '^[^[[D' '^[[1;3D'
# 'bindkey' '-s' '^[Od' '^[[1;5D'
# 'bindkey' '-s' '^[Oc' '^[[1;5C'

typeset -gA keys=(
    Up '^[[A'
    Down '^[[B'
    Right '^[[C'
    Left '^[[D'
    Home '^[[H'
    End '^[[F'
    Insert '^[[2~'
    Delete '^[[3~'
    PageUp '^[[5~'
    PageDown '^[[6~'
    Backspace '^?'

    F1 "${terminfo[kf1]}"
    F2 "${terminfo[kf2]}"
    F3 "${terminfo[kf3]}"
    F4 "${terminfo[kf4]}"
    F5 "${terminfo[kf5]}"
    F6 "${terminfo[kf6]}"
    F7 "${terminfo[kf7]}"
    F8 "${terminfo[kf8]}"
    F9 "${terminfo[kf9]}"
    F10 "${terminfo[kf10]}"
    F11 "${terminfo[kf11]}"
    F12 "${terminfo[kf12]}"

    Shift+Up '^[[1;2A'
    Shift+Down '^[[1;2B'
    Shift+Right '^[[1;2C'
    Shift+Left '^[[1;2D'
    Shift+End '^[[1;2F'
    Shift+Home '^[[1;2H'
    Shift+Insert '^[[2;2~'
    Shift+Delete '^[[3;2~'
    Shift+PageUp '^[[5;2~'
    Shift+PageDown '^[[6;2~'
    Shift+Backspace '^?'
    Shift+Tab '^[[Z'

    Alt+Up '^[[1;3A'
    Alt+Down '^[[1;3B'
    Alt+Right '^[[1;3C'
    Alt+Left '^[[1;3D'
    Alt+End '^[[1;3F'
    Alt+Home '^[[1;3H'
    Alt+Insert '^[[2;3~'
    Alt+Delete '^[[3;3~'
    Alt+PageUp '^[[5;3~'
    Alt+PageDown '^[[6;3~'
    Alt+Backspace '^[^?'

    Alt+Shift+Up '^[[1;4A'
    Alt+Shift+Down '^[[1;4B'
    Alt+Shift+Right '^[[1;4C'
    Alt+Shift+Left '^[[1;4D'
    Alt+Shift+End '^[[1;4F'
    Alt+Shift+Home '^[[1;4H'
    Alt+Shift+Insert '^[[2;4~'
    Alt+Shift+Delete '^[[3;4~'
    Alt+Shift+PageUp '^[[5;4~'
    Alt+Shift+PageDown '^[[6;4~'
    Alt+Shift+Backspace '^[^H'

    Ctrl+Up '^[[1;5A'
    Ctrl+Down '^[[1;5B'
    Ctrl+Right '^[[1;5C'
    Ctrl+Left '^[[1;5D'
    Ctrl+Home '^[[1;5H'
    Ctrl+End '^[[1;5F'
    Ctrl+Insert '^[[2;5~'
    Ctrl+Delete '^[[3;5~'
    Ctrl+PageUp '^[[5;5~'
    Ctrl+PageDown '^[[6;5~'
    Ctrl+Backspace '^H'
    Ctrl+Z '^Z'

    Ctrl+Shift+Up '^[[1;6A'
    Ctrl+Shift+Down '^[[1;6B'
    Ctrl+Shift+Right '^[[1;6C'
    Ctrl+Shift+Left '^[[1;6D'
    Ctrl+Shift+Home '^[[1;6H'
    Ctrl+Shift+End '^[[1;6F'
    Ctrl+Shift+Insert '^[[2;6~'
    Ctrl+Shift+Delete '^[[3;6~'
    Ctrl+Shift+PageUp '^[[5;6~'
    Ctrl+Shift+PageDown '^[[6;6~'
    Ctrl+Shift+Backspace '^?'

    Ctrl+Alt+Up '^[[1;7A'
    Ctrl+Alt+Down '^[[1;7B'
    Ctrl+Alt+Right '^[[1;7C'
    Ctrl+Alt+Left '^[[1;7D'
    Ctrl+Alt+Home '^[[1;7H'
    Ctrl+Alt+End '^[[1;7F'
    Ctrl+Alt+Insert '^[[2;7~'
    Ctrl+Alt+Delete '^[[3;7~'
    Ctrl+Alt+PageUp '^[[5;7~'
    Ctrl+Alt+PageDown '^[[6;7~'
    Ctrl+Alt+Backspace '^[^H'

    Ctrl+Alt+Shift+Up '^[[1;8A'
    Ctrl+Alt+Shift+Down '^[[1;8B'
    Ctrl+Alt+Shift+Right '^[[1;8C'
    Ctrl+Alt+Shift+Left '^[[1;8D'
    Ctrl+Alt+Shift+Home '^[[1;8H'
    Ctrl+Alt+Shift+End '^[[1;8F'
    Ctrl+Alt+Shift+Insert '^[[2;8~'
    Ctrl+Alt+Shift+Delete '^[[3;8~'
    Ctrl+Alt+Shift+PageUp '^[[5;8~'
    Ctrl+Alt+Shift+PageDown '^[[6;8~'
    Ctrl+Alt+Shift+Backspace '^?'
)

# bindkey "${keys[Home]}" .beginning-of-line
# bindkey "${keys[End]}" .end-of-line
# bindkey "${keys[Insert]}" .overwrite-mode
# bindkey "${keys[Backspace]}" .backward-delete-char
# bindkey "${keys[Delete]}" .delete-char
# bindkey "${keys[Up]}" .up-line-or-history
# bindkey "${keys[Down]}" .down-line-or-history
# bindkey "${keys[Left]}" .backward-char
# bindkey "${keys[Right]}" .forward-char
# bindkey "${keys[PageUp]}" .beginning-of-buffer-or-history
# bindkey "${keys[PageDown]}" .end-of-buffer-or-history
# bindkey "${keys[Shift+Tab]}" .reverse-menu-complete
# bindkey "${keys[Ctrl+Left]}" .backward-word
# bindkey "${keys[Ctrl+Right]}" .forward-word

# Alt+Up '^[[1;3A'
# Alt+Down '^[[1;3B'
# Alt+Right '^[[1;3C'
# Alt+Left '^[[1;3D'
# Alt+End '^[[1;3F'
# Alt+Home '^[[1;3H'
# Alt+Insert '^[[2;3~'
# Alt+Delete '^[[3;3~'
# Alt+PageUp '^[[5;3~'
# Alt+PageDown '^[[6;3~'
# Alt+Backspace '^[^?'

# Alt+Shift+Up '^[[1;4A'
# Alt+Shift+Down '^[[1;4B'
# Alt+Shift+Right '^[[1;4C'
# Alt+Shift+Left '^[[1;4D'
# Alt+Shift+End '^[[1;4F'
# Alt+Shift+Home '^[[1;4H'
# Alt+Shift+Insert '^[[2;4~'
# Alt+Shift+Delete '^[[3;4~'
# Alt+Shift+PageUp '^[[5;4~'
# Alt+Shift+PageDown '^[[6;4~'
# Alt+Shift+Backspace '^[^H'

# Ctrl+Up '^[[1;2c'
# Ctrl+PageUp '^[[5;5~'
# Ctrl+PageDown '^[[6;5~'
# Ctrl+Home '^[[1;5H'
# Ctrl+End '^[[1;5F'
# Ctrl+Insert '^[[2;5~'
# Ctrl+Delete '^[[3;5~'
# Ctrl+Backspace '^H'

# Ctrl+Shift+Up '^[[1;6A'
# Ctrl+Shift+Down '^[[1;6B'
# Ctrl+Shift+Right '^[[1;6C'
# Ctrl+Shift+Left '^[[1;6D'
# Ctrl+Shift+Home '^[[1;6H'
# Ctrl+Shift+End '^[[1;6F'
# Ctrl+Shift+Insert '^[[2;6~'
# Ctrl+Shift+Delete '^[[3;6~'
# Ctrl+Shift+PageUp '^[[5;6~'
# Ctrl+Shift+PageDown '^[[6;6~'
# Ctrl+Shift+Backspace '^?'

# Ctrl+Alt+Up '^[[1;7A'
# Ctrl+Alt+Down '^[[1;7B'
# Ctrl+Alt+Right '^[[1;7C'
# Ctrl+Alt+Left '^[[1;7D'
# Ctrl+Alt+Home '^[[1;7H'
# Ctrl+Alt+End '^[[1;7F'
# Ctrl+Alt+Insert '^[[2;7~'
# Ctrl+Alt+Delete '^[[3;7~'
# Ctrl+Alt+PageUp '^[[5;7~'
# Ctrl+Alt+PageDown '^[[6;7~'
# Ctrl+Alt+Backspace '^[^H'

# Ctrl+Alt+Shift+Up '^[[1;8A'
# Ctrl+Alt+Shift+Down '^[[1;8B'
# Ctrl+Alt+Shift+Right '^[[1;8C'
# Ctrl+Alt+Shift+Left '^[[1;8D'
# Ctrl+Alt+Shift+Home '^[[1;8H'
# Ctrl+Alt+Shift+End '^[[1;8F'
# Ctrl+Alt+Shift+Insert '^[[2;8~'
# Ctrl+Alt+Shift+Delete '^[[3;8~'
# Ctrl+Alt+Shift+PageUp '^[[5;8~'
# Ctrl+Alt+Shift+PageDown '^[[6;8~'
# Ctrl+Alt+Shift+Backspace '^?'

# # bindkey '^I' expand-or-complete-prefix # tab comp

# # Keybindings for substring search plugin. Maps up and down arrows.
# bindkey -M main '^[OA' history-substring-search-up
# bindkey -M main '^[OB' history-substring-search-down
# set variable identifying the chroot you work in (used in the prompt below)

### ? configure keys keybindings
# +---------------------------------+
# [PageUp] - Up a line of history
if [[ -n "${keys[PageUp]}" ]]; then
    bindkey -M emacs "${keys[PageUp]}" up-line-or-history
    bindkey -M viins "${keys[PageUp]}" up-line-or-history
    bindkey -M vicmd "${keys[PageUp]}" up-line-or-history
fi

# [PageDown] - Down a line of history
if [[ -n "${keys[PageDown]}" ]]; then
    bindkey -M emacs "${keys[PageDown]}" down-line-or-history
    bindkey -M viins "${keys[PageDown]}" down-line-or-history
    bindkey -M vicmd "${keys[PageDown]}" down-line-or-history
fi

# Start typing + [Up-Arrow] - find history forward
# bindkey -M emacs "^[[A" history-search-multi-word
# bindkey -M viins "^[[A" history-search-multi-word
# bindkey -M vicmd "^[[A" history-search-multi-word

if [[ -n "${keys[Up]}" ]]; then
    bindkey -M emacs "${keys[Up]}" history-search-multi-word
    bindkey -M viins "${keys[Up]}" history-search-multi-word
    bindkey -M vicmd "${keys[Up]}" history-search-multi-word
fi

# Start typing + [Down-Arrow] - find history backward
bindkey -M emacs "^[[B" history-search-multi-word-backwards
bindkey -M viins "^[[B" history-search-multi-word-backwards
bindkey -M vicmd "^[[B" history-search-multi-word-backwards

if [[ -n "${keys[Down]}" ]]; then
    bindkey -M emacs "${keys[Down]}" history-search-multi-word-backwards
    bindkey -M viins "${keys[Down]}" history-search-multi-word-backwards
    bindkey -M vicmd "${keys[Down]}" history-search-multi-word-backwards
fi

# [Home] - Go to beginning of line
if [[ -n "${keys[Home]}" ]]; then
    bindkey -M emacs "${keys[Home]}" beginning-of-line
    bindkey -M viins "${keys[Home]}" beginning-of-line
    bindkey -M vicmd "${keys[Home]}" beginning-of-line
fi
# [End] - Go to end of line
if [[ -n "${keys[End]}" ]]; then
    bindkey -M emacs "${keys[End]}" end-of-line
    bindkey -M viins "${keys[End]}" end-of-line
    bindkey -M vicmd "${keys[End]}" end-of-line
fi

# [ShiftTab] - move through the completion menu backwards
if [[ -n "${keys[Shift+Tab]}" ]]; then
    bindkey -M viins "${keys[Shift+Tab]}" reverse-menu-complete
    bindkey -M vicmd "${keys[Shift+Tab]}" reverse-menu-complete
    bindkey -M emacs "${keys[Shift+Tab]}" reverse-menu-complete
fi

# # [Backspace] - delete backward
# bindkey -M emacs '^?' backward-delete-char
# bindkey -M viins '^?' backward-delete-char
# bindkey -M vicmd '^?' backward-delete-char

# [Delete] - delete forward
if [[ -n "${keys[Delete]}" ]]; then
    bindkey -M emacs "${keys[Delete]}" delete-char
    bindkey -M viins "${keys[Delete]}" delete-char
    bindkey -M vicmd "${keys[Delete]}" delete-char
else
    bindkey -M emacs "^[[3~" delete-char
    bindkey -M viins "^[[3~" delete-char
    bindkey -M vicmd "^[[3~" delete-char

    bindkey -M emacs "^[3;5~" delete-char
    bindkey -M viins "^[3;5~" delete-char
    bindkey -M vicmd "^[3;5~" delete-char
fi

# [Ctrl-Delete] - delete whole forward-word
if [[ -n "${keys[Ctrl+Delete]}" ]]; then
    bindkey -M emacs "${keys[Ctrl+Delete]}" kill-word
    bindkey -M viins "${keys[Ctrl+Delete]}" kill-word
    bindkey -M vicmd "${keys[Ctrl+Delete]}" kill-word
fi

# [Ctrl-RightArrow] - move forward one word
if [[ -n "${keys[Ctrl+Right]}" ]]; then
    bindkey -M emacs "${keys[Ctrl+Right]}" forward-word
    bindkey -M viins "${keys[Ctrl+Right]}" forward-word
    bindkey -M vicmd "${keys[Ctrl+Right]}" forward-word
fi

# [Ctrl-LeftArrow] - move backward one word
if [[ -n "${keys[Ctrl+Left]}" ]]; then
    bindkey -M emacs "${keys[Ctrl+Left]}" backard-word
    bindkey -M viins "${keys[Ctrl+Left]}" backard-word
    bindkey -M vicmd "${keys[Ctrl+Left]}" backard-word
fi

# | Simply mapping escape sequences |
# # +---------------------------------+

# 'bindkey' '-s' '^[OM'    '^M'
# 'bindkey' '-s' '^[Ok'    '+'
# 'bindkey' '-s' '^[Om'    '-'
# 'bindkey' '-s' '^[Oj'    '*'
# 'bindkey' '-s' '^[Oo'    '/'
# 'bindkey' '-s' '^[OX'    '='
# 'bindkey' '-s' '^[OA'    '^[[A'
# 'bindkey' '-s' '^[OB'    '^[[B'
# 'bindkey' '-s' '^[OD'    '^[[D'
# 'bindkey' '-s' '^[OC'    '^[[C'
# 'bindkey' '-s' '^[OH'    '^[[H'
# 'bindkey' '-s' '^[[1~'   '^[[H'
# 'bindkey' '-s' '^[[7~'   '^[[H'
# 'bindkey' '-s' '^[OF'    '^[[F'
# 'bindkey' '-s' '^[[4~'   '^[[F'
# 'bindkey' '-s' '^[[8~'   '^[[F'
# 'bindkey' '-s' '^[[3\^'  '^[[3;5~'
# 'bindkey' '-s' '^[^[[3~' '^[[3;3~'
# 'bindkey' '-s' '^[[1;9C' '^[[1;3C'
# 'bindkey' '-s' '^[^[[C'  '^[[1;3C'
# 'bindkey' '-s' '^[[1;9D' '^[[1;3D'
# 'bindkey' '-s' '^[^[[D'  '^[[1;3D'
# 'bindkey' '-s' '^[Od'    '^[[1;5D'
# 'bindkey' '-s' '^[Oc'    '^[[1;5C'

# create a zkbd compatible hash;

fancy-ctrl-z() {
    if [[ $#BUFFER -eq 0 ]]; then
        BUFFER="fg"
        zle accept-line -w
    else
        zle push-input -w
        zle clear-screen -w
    fi
}

zle -N fancy-ctrl-z

bindkey -M emacs "${keys[Ctrl+Z]}" fancy-ctrl-z
bindkey -M vicmd "${keys[Ctrl+Z]}" fancy-ctrl-z

# bindkey -M emacs "${keys[Ctrl+Right]}"
zle -N alias-expansion _expand_alias
bindkey -M emacs '^a' alias-expansion
bindkey -M emacs '^Xa' alias-expansion
bindkey -M viins '^a' alias-expansion
bindkey -M viins '^Xa' alias-expansion

# bindkey -M emacs '\ew' kill-region ## ! [Esc-w] - Kill from the cursor to the mark
# bindkey -M vicmd '\ew' kill-region

bindkey -s '\el' 'ls -a\n'                          # [Esc-l] - run command: ls
# bindkey -M emacs '^r' history-incremental-search-backward # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
# bindkey -M vicmd '^r' history-incremental-search-backward

# bindkey -M emacs ' ' magic-space                          # [Space] - don't do history expansion
tmux-which-key() {
    command -v tmux &> /dev/null && tmux show-wk-menu-root
}
zle -N tmux-which-key

bindkey -M emacs "${keys[F1]}" tmux-which-key
bindkey -M viins "${keys[F1]}" tmux-which-key
bindkey -M vicmd "${keys[F1]}" tmux-which-key
bindkey -M vicmd " " tmux-which-key

## ! Edit the current command line in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M emacs '\C-x\C-e' edit-command-line
bindkey -M vicmd '\C-x\C-e' edit-command-line

# file rename magick
bindkey -M emacs '^[m' copy-prev-shell-word
bindkey -M vicmd '^[m' copy-prev-shell-word

bindkey -M emacs '^h' _complete_help
bindkey -M viins '^h' _complete_help

# bindkey ' ' magic-space                        # do history expansion on space
# bindkey '^U' backward-kill-line                # ctrl + U
# bindkey '^[[3;5~' kill-word                    # ctrl + Supr
# bindkey '^[[3~' delete-char                    # delete
# bindkey '^[[1;5C' end-of-line                  # ctrl + ->
# bindkey '^[[1;5D' beginning-of-line            # ctrl + <-
# bindkey '^[[5~' beginning-of-buffer-or-history # page up
# bindkey '^[[6~' end-of-buffer-or-history       # page down
# bindkey '^[[H' forward-word                    # home
# bindkey '^[[F' end-of-line                     # end
# bindkey '^Z' undo                              # ctrl + Z undo last action

# bindkey '^[[A' up-line-or-search
# bindkey '^[[B' down-line-or-search
bindkey -M emacs '^[[1;5C' emacs-forward-word
bindkey -M emacs '^[[1;5D' emacs-backward-word
#
# bindkey -s '^X^Z' '%-^M'
# bindkey '^[e' expand-cmd-path
# bindkey '^[^I' reverse-menu-complete
# bindkey '^X^N' accept-and-infer-next-history
# bindkey '^W' kill-region
# bindkey '^I' complete-word
## Fix weird sequence that rxvt produces
bindkey -s '^[[Z' '\t'
