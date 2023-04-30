unsetopt GLOBAL_RCS

typeset -U path cdpath fpath manpath

case "${OSTYPE}" in
darwin*)
  # local
  path=(/usr/local/bin(N-/) /usr/local/sbin(N-/) $path)
  # sbin
  path=(/sbin(N-/) /usr/sbin(N-/) $path)
  ;;
esac

path=(
  $HOME/google-cloud-sdk/bin(N-/)
  $HOME/.krew/bin(N-/)
  $HOME/bin(N-/)
  /Applications/WezTerm.app/Contents/MacOS(N-/)
  $path
)

fpath=(
  $XDG_CONFIG_HOME/zsh/functions(N-/)
  $fpath
)

if [ ! -x "$EDITOR" ]; then
  export EDITOR=vim
fi

export LESS='-R'

if [[ $LANG != 'ja_JP.UTF-8' && $LANG != 'en_US.UTF-8' ]]; then
  export LANG=en_US.UTF-8
fi
if [[ -z "$LC_ALL" ]]; then
  export LC_ALL=en_US.UTF-8
fi

export GOPATH=$HOME
