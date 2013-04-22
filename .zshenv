
export PATH=$HOME/bin:$PATH
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

if [ -d ${HOME}/.rbenv  ] ; then
  export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
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
  ;;
esac

