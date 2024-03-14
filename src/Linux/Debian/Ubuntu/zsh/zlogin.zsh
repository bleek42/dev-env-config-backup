#!/usr/bin/env zsh

# ? ensure PATH entries remain unique after shell reload
# ? typeset -gU PATH FPATH CDPATH MANPATH path fpath cdpath manpath
typeset -xgUT SSH_ENV ssh_env

test -f "${HOME}"/.ssh/ssh_agent.env || touch "${HOME}"/.config/ssh_agent.env
ssh_env="${HOME}"/.ssh/ssh_agent.env

ssh_agent_load_env() {
    test -f "${ssh_env}" && source "${ssh_env}" >|/dev/null
}

ssh_agent_start() {

    ssh_agent_load_env

    ssh-agent -s | sed 's/^echo/#echo' >"${ssh_env}"
    for key in "${HOME}"/.ssh/id_*; do
        grep -q PRIVATE "$key" && ssh-add "$key"
    done
}

# # ? agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(
    ssh-add -l >|/dev/null 2>&1
    echo $?
)

# echo "$agent_run_state"

if test -f "$ssh_env"; then
    ssh_agent_load_env
else
    ssh_agent_start
fi

# unset ssh_env
# export ssh_env
