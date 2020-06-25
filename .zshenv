# .zshenv
# vim: foldmethod=marker

# Start profiling {{
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
  # sbin
  path=(/sbin(N-/) /usr/sbin(N-/) $path)
  # Python
  path=($HOME/Library/Python/3.7/bin(N-/) $path)
  # Homebrew
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_NO_AUTO_UPDATE=1
  ;;
esac

if [ ! -x "$EDITOR" ]; then
  export EDITOR=vim
fi

path=($HOME/google-cloud-sdk/bin(N-/) $path)
path=($HOME/bin(N-/) $(dirname $(readlink $HOME/.zshenv))/bin(N-/) /usr/local/sbin(N-/) /usr/local/bin(N-/) $path)
if [[ $LANG != 'ja_JP.UTF-8' && $LANG != 'en_US.UTF-8' ]]; then
  export LANG=en_US.UTF-8
fi
if [[ -z $LC_ALL ]]; then
  export LC_ALL=en_US.UTF-8
fi
# }}}

# asdf {{{
source $HOME/.asdf/asdf.sh
# }}}

export GOPATH=$HOME
