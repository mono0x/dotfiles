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
