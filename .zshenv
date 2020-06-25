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

# [ -e /usr/local/bin/brew ] && /usr/local/bin/brew shellenv
if [ -e /usr/local/bin/brew ]
then
  export HOMEBREW_PREFIX="/usr/local";
  export HOMEBREW_CELLAR="/usr/local/Cellar";
  export HOMEBREW_REPOSITORY="/usr/local/Homebrew";
  export PATH="/usr/local/bin:/usr/local/sbin${PATH+:$PATH}";
  export MANPATH="/usr/local/share/man${MANPATH+:$MANPATH}:";
  export INFOPATH="/usr/local/share/info:${INFOPATH}";
fi

if [ ! -x "$EDITOR" ]; then
  export EDITOR=vim
fi

export DOTFILES_DIR=$(dirname $(readlink $HOME/.zshenv))

path=($HOME/google-cloud-sdk/bin(N-/) $path)
path=($HOME/bin(N-/) $DOTFILES_DIR/bin(N-/) $path)
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
