# .zshenv
# vim: foldmethod=marker

# Start profiling {{{
# ZPROF=1 zsh -i -c exit
if [ -n "$ZPROF" ]; then
  zmodload zsh/zprof && zprof
fi
# }}}

# PATH {{{
unsetopt GLOBAL_RCS

typeset -U path cdpath fpath manpath

case "${OSTYPE}" in
darwin*)
  # local
  path=(/usr/local/bin(N-/) /usr/local/sbin(N-/) $path)
  # sbin
  path=(/sbin(N-/) /usr/sbin(N-/) $path)
  # Python
  path=($HOME/Library/Python/3.7/bin(N-/) $path)
  ;;
esac

if [ ! -x "$EDITOR" ]; then
  export EDITOR=vim
fi

export DOTFILES_DIR=$(dirname $(readlink $HOME/.zshenv))

source $DOTFILES_DIR/shell/homebrew.sh

path=($HOME/google-cloud-sdk/bin(N-/) $HOME/.krew/bin(N-/) $path)
path=($HOME/bin(N-/) $DOTFILES_DIR/bin(N-/) $path)
if [[ $LANG != 'ja_JP.UTF-8' && $LANG != 'en_US.UTF-8' ]]; then
  export LANG=en_US.UTF-8
fi
if [[ -z $LC_ALL ]]; then
  export LC_ALL=en_US.UTF-8
fi
# }}}

# asdf {{{
[ -f $HOME/.asdf/asdf.sh ] && source $HOME/.asdf/asdf.sh
# }}}

export GOPATH=$HOME
