if command -v keychain >/dev/null 2>&1; then
  eval "$(keychain -k mine)"
fi

if [ "$SHLVL" = 1 ]; then
  clear -q
fi