#!/usr/bin/env zsh

_zsh_autosuggest_strategy_histdb_dir() {
    local query="
        select commands.argv from history
        left join commands on history.command_id = commands.rowid
        left join places on history.place_id = places.rowid
        where commands.argv LIKE '$(sql_escape $1)%'
        group by commands.argv, places.dir
        order by places.dir != '$(sql_escape $PWD)', count(*) desc
        limit 1
    "

    typeset -g suggestion
    suggestion=$(_histdb_query "$query")
}

alias histdbdir=_zsh_autosuggest_strategy_histdb_dir
