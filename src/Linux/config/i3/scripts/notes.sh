#!/usr/bin/env sh

# path:   /home/klassiker/.local/share/repos/i3/i3_notes.sh
# author: klassiker [mrdotx]
# github: https://github.com/mrdotx/i3
# date:   2024-05-07T09:29:09+0200

# i3 helper
. ~/.config/i3/scripts/helper.sh

open() {
    $BROWSER "http://m625q/wiki/$1.html"
}

title="notes"
table_width=43
table_width1=$((table_width + 4))
message="
$(i3_table "$table_width" "header" "wiki")
$(i3_table "$table_width" "w" "󰠮" "vimwiki")
$(i3_table "$table_width1" "t" "󰠮" "├─ todos")
$(i3_table "$table_width1" "i" "󰠮" "├─ ideas")
$(i3_table "$table_width1" "n" "󰠮" "├─ network")
$(i3_table "$table_width1" "b" "󰠮" "└─ bash")

[<b>q</b>]uit, [<b>return</b>], [<b>escape</b>], [<b>super+shift+/</b>]"

case "$1" in
    --vimwiki)
        [ -n "$2" ] \
            && open "$2" \
            && return

        open "index"
        ;;
    --kill)
        i3_notify 1 "$title"
        ;;
    *)
        i3_notify 0 "$title" "$message"
        ;;
esac
