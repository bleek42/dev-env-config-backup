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

typeset -A key=(

    Up "${terminfo[kcuu1]}"
    Down "${terminfo[kcud1]}"
    Left "${terminfo[kcub1]}"
    Right "${terminfo[kcuf1]}"
    PageUp "${terminfo[kpp]}"
    PageDown "${terminfo[knp]}"
    Home "${terminfo[khome]}"
    End "${terminfo[kend]}"
    Insert "${terminfo[kich1]}"
    Delete "${terminfo[kdch1]}"
    Backspace "${terminfo[kbs]}"

    Ctrl+Up "${terminfo[kRI]}"
    Ctrl+Down "${terminfo[kRD]}"
    Ctrl+Left "${terminfo[kLFT]}"
    Ctrl+Right "${terminfo[kRIT]}"

    Shift+Tab "${terminfo[kcbt]}"

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

    Ctrl+Z '^z'

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

)


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

### ? configure key keybindings
# +---------------------------------+
# [PageUp] - Up a line of history
if [[ -n "${key[PageUp]}" ]]; then
    bindkey -M emacs "${key[PageUp]}" up-line-or-history
    bindkey -M viins "${key[PageUp]}" up-line-or-history
    bindkey -M vicmd "${key[PageUp]}" up-line-or-history
fi

# [PageDown] - Down a line of history
if [[ -n "${key[PageDown]}" ]]; then
    bindkey -M emacs "${key[PageDown]}" down-line-or-history
    bindkey -M viins "${key[PageDown]}" down-line-or-history
    bindkey -M vicmd "${key[PageDown]}" down-line-or-history
fi

# Start typing + [Up-Arrow] - find history forward
bindkey -M emacs "^[[A" history-search-multi-word
bindkey -M viins "^[[A" history-search-multi-word
bindkey -M vicmd "^[[A" history-search-multi-word

if [[ -n "${key[Up]}" ]]; then
    bindkey -M emacs "${key[Up]}" history-search-multi-word
    bindkey -M viins "${key[Up]}" history-search-multi-word
    bindkey -M vicmd "${key[Up]}" history-search-multi-word
fi

# Start typing + [Down-Arrow] - find history backward
bindkey -M emacs "^[[B" history-search-multi-word-backwards
bindkey -M viins "^[[B" history-search-multi-word-backwards
bindkey -M vicmd "^[[B" history-search-multi-word-backwards

if [[ -n "${key[Down]}" ]]; then
    bindkey -M emacs "${key[Down]}" history-search-multi-word-backwards
    bindkey -M viins "${key[Down]}" history-search-multi-word-backwards
    bindkey -M vicmd "${key[Down]}" history-search-multi-word-backwards
fi

# [Home] - Go to beginning of line
if [[ -n "${key[Home]}" ]]; then
    bindkey -M emacs "${key[Home]}" beginning-of-line
    bindkey -M viins "${key[Home]}" beginning-of-line
    bindkey -M vicmd "${key[Home]}" beginning-of-line
fi
# [End] - Go to end of line
if [[ -n "${key[End]}" ]]; then
    bindkey -M emacs "${key[End]}" end-of-line
    bindkey -M viins "${key[End]}" end-of-line
    bindkey -M vicmd "${key[End]}" end-of-line
fi

# [ShiftTab] - move through the completion menu backwards
if [[ -n "${key[Shift + Tab]}" ]]; then
    bindkey -M viins "${key[Shift+Tab]}" reverse-menu-complete
    bindkey -M vicmd "${key[Shift+Tab]}" reverse-menu-complete
    bindkey -M emacs "${key[Shift+Tab]}" reverse-menu-complete
fi

# [Backspace] - delete backward
bindkey -M emacs '^?' backward-delete-char
bindkey -M viins '^?' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char

# [Delete] - delete forward
if [[ -n "${key[Delete]}" ]]; then
    bindkey -M emacs "${key[Delete]}" delete-char
    bindkey -M viins "${key[Delete]}" delete-char
    bindkey -M vicmd "${key[Delete]}" delete-char
else
    bindkey -M emacs "^[[3~" delete-char
    bindkey -M viins "^[[3~" delete-char
    bindkey -M vicmd "^[[3~" delete-char

    bindkey -M emacs "^[3;5~" delete-char
    bindkey -M viins "^[3;5~" delete-char
    bindkey -M vicmd "^[3;5~" delete-char
fi

# [Ctrl-Delete] - delete whole forward-word
bindkey -M emacs '^[[3;5~' kill-word
bindkey -M viins '^[[3;5~' kill-word
bindkey -M vicmd '^[[3;5~' kill-word

# [Ctrl-RightArrow] - move forward one word
bindkey -M emacs '^[[1;5C' forward-word
bindkey -M viins '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey -M emacs '^[[1;5D' backward-word
bindkey -M viins '^[[1;5D' backward-word
bindkey -M vicmd '^[[1;5D' backward-word

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

bindkey -M emacs "${key[Ctrl+Z]}" fancy-ctrl-z
bindkey -M vicmd "${key[Ctrl+Z]}" fancy-ctrl-z

# bindkey -M emacs "${key[Ctrl+Right]}"
# zle -N alias-expansion _expand_alias
# bindkey -M emacs '^a' alias-expansion
# bindkey -M emacs '^Xa' alias-expansion
# bindkey -M viins '^a' alias-expansion
# bindkey -M viins '^Xa' alias-expansion

# bindkey -M emacs '\ew' kill-region ## ! [Esc-w] - Kill from the cursor to the mark
# bindkey -M vicmd '\ew' kill-region

# bindkey -s '\el' 'ls\n'                          # [Esc-l] - run command: ls
# bindkey -M emacs '^r' history-incremental-search-backward # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
# bindkey -M vicmd '^r' history-incremental-search-backward

# bindkey ' ' magic-space                          # [Space] - don't do history expansion

## ! Edit the current command line in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M emacs '\C-x\C-e' edit-command-line
bindkey -M vicmd '\C-x\C-e' edit-command-line

# file rename magick
bindkey -M emacs "^[m" copy-prev-shell-word
bindkey -M vicmd "^[m" copy-prev-shell-word

bindkey -M emacs '^h' _complete_help
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
# bindkey '^[^[[C' emacs-forward-word
# bindkey '^[^[[D' emacs-backward-word
#
# bindkey -s '^X^Z' '%-^M'
# bindkey '^[e' expand-cmd-path
# bindkey '^[^I' reverse-menu-complete
# bindkey '^X^N' accept-and-infer-next-history
# bindkey '^W' kill-region
# bindkey '^I' complete-word
## Fix weird sequence that rxvt produces
# bindkey -s '^[[Z' '\t'
