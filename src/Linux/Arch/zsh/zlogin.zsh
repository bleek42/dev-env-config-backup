#!/usr/bin/env zsh

if [[ -z $SSH_AUTH_SOCK ]]; then

    [[ $(type -w ssh_agent_start) == *function* ]] && \
        ssh_agent_start

	[[ $(type -w ssh_load_key) == *function* ]] && \
		ssh_load_key id_ed25519_sk

fi
