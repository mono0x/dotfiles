# https://yazi-rs.github.io/docs/quick-start/#shell-wrapper
if ((${+commands[yazi]})); then
  y() {
    local cwd tmp
    tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    command yazi "$@" --cwd-file="$tmp"
    # IFS= here is a per-command env override, not a global assignment; `local IFS= read` would stop read from running.
    IFS= read -r -d '' cwd <"$tmp" # noka: ZC1043
    [[ "$cwd" != "$PWD" ]] && [[ -d "$cwd" ]] && builtin cd -- "$cwd"
    rm -f -- "${tmp:?}" # noka: ZC1059
  }
fi
