SHORT_HOST="${SHORT_HOST:-$HOST}"

zstyle ':omz:plugins:ssh-agent' lazy yes
zstyle ':omz:plugins:ssh-agent' quiet yes
zstyle ':omz:plugins:ssh-agent' lifetime 3h
zstyle ':omz:plugins:ssh-agent' agent-forwarding yes
zstyle ':omz:plugins:ssh-agent' identities id_ed25519_gh id_ed25519_gl
