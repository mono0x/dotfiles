typeset -U PATH

export PATH=$HOME/bin:$HOME/dotfiles/bin:$PATH
if [[ $LANG != 'ja_JP.UTF-8' && $LANG != 'en_US.UTF-8' ]]; then
  export LANG=en_US.UTF-8
  export LC_ALL=en_US.UTF-8
fi

# http://blog.uu59.org/2014-01-06-fast-rbenv.html
rbenv_init() {
  # eval "$(rbenv init - --no-rehash)" is crazy slow (it takes arround 100ms)
  # below style took ~2ms
  export RBENV_SHELL=zsh
  export RBENV_ROOT=$HOME/.rbenv
  rbenv() {
    local command
    command="$1"
    if [ "$#" -gt 0 ]; then
      shift
    fi

    case "$command" in
    rehash|shell)
      eval "`rbenv "sh-$command" "$@"`";;
    *)
      command rbenv "$command" "$@";;
    esac
  }
  export PATH=$RBENV_ROOT/bin:$PATH
  path=($RBENV_ROOT/shims $path)
}
rbenv_init
unfunction rbenv_init

export RSENSE_HOME=$HOME/dotfiles/rsense

if [[ -f ~/.nvm/nvm.sh ]]; then
  source ~/.nvm/nvm.sh
  nvm use v0.8.11 >/dev/null 2>&1
fi

case "${OSTYPE}" in
linux*)
  # TeX Live
  export PATH="/usr/local/texlive/2012/bin/i386-linux:$PATH"
  ;;
darwin*)
  # Heroku Toolbelt
  export PATH="/usr/local/heroku/bin:$PATH"
  # sbin
  export PATH="/sbin:$PATH"
  # MacVim
  if [[ -f /Applications/MacVim.app/Contents/MacOS/Vim ]]; then
    alias vim=/Applications/MacVim.app/Contents/MacOS/Vim
  fi
  ;;
esac

export GOPATH=$HOME
