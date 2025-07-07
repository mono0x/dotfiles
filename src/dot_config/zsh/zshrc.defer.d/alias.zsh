alias sudo="sudo "
alias sudoe='sudo -e'
alias vi='nvim'
alias cc='sandbox-claude'
alias cz='chezmoi'

case "${OSTYPE}" in
linux*)
  alias ls="ls --color"

  alias comm='LC_ALL=C comm'
  alias grep='LC_ALL=C grep'
  alias look='LC_ALL=C look'
  alias sort='LC_ALL=C sort'
  alias uniq='LC_ALL=C uniq'
  ;;
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

if (( $+commands[hub] )); then
  alias git='hub'
fi
alias g='git'
alias ga='git add'
alias gd='git di'
alias gf='git fetch --all'
alias gg='git grep -H --heading -I --line-number --break --show-function'
alias gl='git log'
# https://zenn.dev/tatsugon/articles/default-git-checkout-main-or-master
alias gm='git checkout $(git symbolic-ref refs/remotes/origin/HEAD | sed "s@^refs/remotes/origin/@@")'
alias gs='git status'
alias k='kubectl'
