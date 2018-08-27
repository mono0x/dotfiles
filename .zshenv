# .zshenv
# vim: foldmethod=marker

# PATH {{{
typeset -U path cdpath fpath manpath

case "${OSTYPE}" in
linux*)
  # TeX Live
  path=(/usr/local/texlive/2012/bin/i386-linux(N-/) $path)
  ;;
darwin*)
  # Heroku Toolbelt
  path=(/usr/local/heroku/bin(N-/) $path)
  # sbin
  path=(/sbin(N-/) $path)
  # MacVim
  macvim_dir=/Applications/MacVim.app/Contents/MacOS
  macvim="$macvim_dir/Vim"
  if [ -x "$macvim" ]; then
    export EDITOR=$macvim
    alias vim=$macvim
    alias vimdiff="$macvim_dir/vimdiff"
  fi
  # node
  path=($HOME/.node/bin(N-/) $path)
  ;;
esac

if [ ! -x "$EDITOR" ]; then
  export EDITOR=vim
fi

path=($HOME/bin(N-/) $HOME/dotfiles/bin(N-/) /usr/local/sbin(N-/) /usr/local/bin(N-/) $path)
if [[ $LANG != 'ja_JP.UTF-8' && $LANG != 'en_US.UTF-8' ]]; then
  export LANG=en_US.UTF-8
fi
if [[ -z $LC_ALL ]]; then
  export LC_ALL=en_US.UTF-8
fi
# }}}

# rbenv {{{
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
  path=($RBENV_ROOT/shims $RBENV_ROOT/bin $path)
}
rbenv_init
unfunction rbenv_init
# }}}

# plenv {{{
path=($HOME/.plenv/bin(N-/) $HOME/.plenv/shims(N-/) $path)
# }}}

# rust {{{
path=($HOME/.cargo/bin $path)
# }}}

export GOPATH=$HOME
