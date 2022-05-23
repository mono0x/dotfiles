# .zshenv
# vim: foldmethod=marker

# Start profiling {{{
# ZPROF=1 zsh -i -c exit
if [ -n "$ZPROF" ]; then
  zmodload zsh/zprof && zprof
fi
# }}}

# Variable {{{
CPUARCH="$(uname -m)"
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
  path=(/opt/homebrew/bin(N-/) /opt/homebrew/sbin(N-/) /usr/local/bin(N-/) /usr/local/sbin (N-/) $path)
  manpath=(/opt/homebrew/share/man(N-/) /usr/local/share/man(N-/) $manpath)
  infopath=(/opt/homebrew/share/info(N-/) /usr/local/share/info(N-/) $infopath)
  ;;
esac

# [ -e /home/linuxbrew/.linuxbrew/bin/brew ] && /home/linuxbrew/.linuxbrew/bin/brew shellenv
if [ -e /home/linuxbrew/.linuxbrew/bin/brew ]
then
  export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew";
  export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar";
  export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew";
  export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin${PATH+:$PATH}";
  export MANPATH="/home/linuxbrew/.linuxbrew/share/man${MANPATH+:$MANPATH}:";
  export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH}";
fi

case "${OSTYPE}" in
darwin*)
  case "${CPUARCH}" in
  x86_64*)
    # [ -e /usr/local/bin/brew ] && /usr/local/bin/brew shellenv
    if [ -e /usr/local/bin/brew ]
    then
      export HOMEBREW_PREFIX="/usr/local";
      export HOMEBREW_CELLAR="/usr/local/Cellar";
      export HOMEBREW_REPOSITORY="/usr/local/Homebrew";
    fi
    ;;
  arm64*)
    # [ -e /opt/homebrew/bin/brew ] && /opt/homebrew/bin/brew shellenv
    if [ -e /opt/homebrew/bin/brew ]
    then
      export HOMEBREW_PREFIX="/opt/homebrew";
      export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
      export HOMEBREW_REPOSITORY="/opt/homebrew";
    fi
    ;;
  esac
  ;;
esac

if [ ! -x "$EDITOR" ]; then
  export EDITOR=vim
fi

export DOTFILES_DIR=$(dirname $(readlink $HOME/.zshenv))

path=($HOME/google-cloud-sdk/bin(N-/) $HOME/.krew(N-/) $path)
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
