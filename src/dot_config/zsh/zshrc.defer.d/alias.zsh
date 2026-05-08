alias sudo="sudo "
alias sudoe='sudo -e'
alias vi='nvim'

case "${OSTYPE}" in
darwin*)
  alias ls="ls -G"

  alias base64='gbase64'
  alias comm='LC_ALL=C gcomm'
  alias date='gdate'
  alias grep='LC_ALL=C ggrep'
  alias look='LC_ALL=C look'
  alias md5sum='gmd5sum'
  alias sed='gsed'
  alias sha1sum='gsha1sum'
  alias sha224sum='gsha224sum'
  alias sha256sum='gsha256sum'
  alias sha384sum='gsha384sum'
  alias sha512sum='gsha512sum'
  alias shuf='gshuf'
  alias sort='LC_ALL=C gsort'
  alias tail='gtail'
  alias uniq='LC_ALL=C guniq'
  alias wc='gwc'
  ;;
esac

alias ll='ls -l'
alias la='ls -A'
alias lla='ls -Al'

if ((${+commands[hub]})); then
  alias git='hub'
fi
alias g='git'
alias ga='git add'
alias gd='git di'
alias gf='git fetch --all'
alias gg='git grep -H --heading -I --line-number --break --show-function'
alias gl='git log'
alias gs='git status'
# Global alias by design: expands "M" to the default branch name in argument position (e.g. `git rebase M`).
alias -g M='"$(git-default-branch)"' # noka: ZC1771
alias k='kubectl'
alias ci='claude -p "Please commit this change."'

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
