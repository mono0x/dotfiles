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
linux*)
  # TeX Live
  path=(/usr/local/texlive/2012/bin/i386-linux(N-/) $path)
  ;;
darwin*)
  # sbin
  path=(/sbin(N-/) /usr/sbin(N-/) $path)
  # MacVim
  macvim_dir=/Applications/MacVim.app/Contents/MacOS
  macvim="$macvim_dir/Vim"
  if [ -x "$macvim" ]; then
    export EDITOR=$macvim
    alias vim=$macvim
    alias vimdiff="$macvim_dir/vimdiff"
  fi
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
path=($HOME/bin(N-/) $HOME/dotfiles/bin(N-/) /usr/local/sbin(N-/) /usr/local/bin(N-/) $path)
if [[ $LANG != 'ja_JP.UTF-8' && $LANG != 'en_US.UTF-8' ]]; then
  export LANG=en_US.UTF-8
fi
if [[ -z $LC_ALL ]]; then
  export LC_ALL=en_US.UTF-8
fi
# }}}

# rust {{{
path=($HOME/.cargo/bin $path)
# }}}

# asdf {{{
source $HOME/.asdf/asdf.sh
# }}}

export GOPATH=$HOME
