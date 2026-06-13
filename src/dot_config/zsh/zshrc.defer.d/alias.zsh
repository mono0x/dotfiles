if ((${+commands[hub]})); then
  alias git='hub'
fi
# Global alias by design: expands "M" to the default branch name in argument position (e.g. `git rebase M`).
alias -g M='"$(git-default-branch)"' # noka: ZC1771

# https://yazi-rs.github.io/docs/quick-start/#shell-wrapper
if ((${+commands[yazi]})); then
  y() {
    local cwd tmp
    tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    command yazi "$@" --cwd-file="$tmp"
    # IFS= here is a per-command env override, not a global assignment; `local IFS= read` would stop read from running.
    IFS= read -r -d '' cwd <"$tmp" # noka: ZC1043
    [[ "$cwd" != "$PWD" ]] && [[ -d "$cwd" ]] && builtin cd -- "$cwd"
    rm -f -- "${tmp:?}"
  }
fi

# Aliases are the intended idiom in interactive zshrc (preserved in completion, history expansion,
# argument transparency); the rule targets scripts.
# noka: ZC1049
