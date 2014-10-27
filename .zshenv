
export PATH=$HOME/bin:$HOME/dotfiles/bin:$PATH
if [[ $LANG != 'ja_JP.UTF-8' && $LANG != 'en_US.UTF-8' ]]; then
  export LANG=en_US.UTF-8
  export LC_ALL=en_US.UTF-8
fi

if [ -d ${HOME}/.rbenv  ] ; then
  export PATH=$HOME/.rbenv/bin:$PATH
  # http://blog.uu59.org/2014-01-06-fast-rbenv.html
  rbenv_init() {
    # eval "$(rbenv init - --no-rehash)" is crazy slow (it takes arround 100ms)
    # below style took ~2ms
    export RBENV_SHELL=zsh
    if [[ -f /usr/local/Cellar/rbenv/0.4.0/completions/rbenv.zsh ]]; then
      source /usr/local/Cellar/rbenv/0.4.0/completions/rbenv.zsh
    else
      source "$HOME/.rbenv/completions/rbenv.zsh"
    fi
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
    path=($HOME/.rbenv/shims $path)
  }
  rbenv_init
  unfunction rbenv_init
fi

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
  # Command Line Tools
  export PATH="/Library/Developer/CommandLineTools/usr/bin:$PATH"
  ;;
esac

export GOPATH=$HOME
