# Aliases {{{
alias sudo="sudo "
alias sudoe='sudo -e'
alias vi='nvim'
alias cz='chezmoi'

case "${OSTYPE}" in
linux*)
  alias ls="ls --color"

  alias comm='LC_ALL=C comm'
  alias grep='LC_ALL=C grep'
  alias look='LC_ALL=C look'
  alias sort='LC_ALL=C sort'
  alias uniq='LC_ALL=C uniq'
  ;;
darwin*)
  alias ls="ls -G"

  alias base64='gbase64'
  alias comm='LC_ALL=C gcomm'
  alias date='gdate'
  alias grep='LC_ALL=C ggrep'
  alias look='LC_ALL=C look'
  alias md5sum='gmd5sum'
  alias sed='gsed'
  alias sha1sum='gsha1sum'
  alias sha224sum='gsha224sum'
  alias sha256sum='gsha256sum'
  alias sha384sum='gsha384sum'
  alias sha512sum='gsha512sum'
  alias shuf='gshuf'
  alias sort='LC_ALL=C gsort'
  alias tail='gtail'
  alias uniq='LC_ALL=C guniq'
  alias wc='gwc'
  ;;
esac
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -Al'

if (( $+commands[hub] )); then
  alias git='hub'
fi
alias g='git'
alias ga='git add'
alias gd='git di'
alias gf='git fetch --all'
alias gg='git grep -H --heading -I --line-number --break --show-function'
alias gl='git log'
alias gs='git status'
alias k='kubectl'
# }}}

# fzf {{{
if (( $+commands[fzf] ))
then
  fzf-cd() {
    local selected_dir=$(ghq list | fzf --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
      BUFFER="cd ${GOPATH}/src/${selected_dir}"
      zle accept-line
    fi
    zle redisplay
  }
  zle -N fzf-cd
  bindkey '^s' fzf-cd
fi
# }}}

# LS_COLORS {{{
#eval 'dircolors'
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# }}}

# 1Password {{{
# https://1password.community/discussion/128023/ssh-agent-on-windows-subsystem-for-linux
if [ -n "${WSL_DISTRO_NAME:-}" ] \
  && type socat > /dev/null && type npiperelay.exe > /dev/null # check socat and npiperelay.exe are installed
then
  # Configure ssh forwarding
  export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
  # need `ps -ww` to get non-truncated command for matching
  # use square brackets to generate a regex match for the process we want but that doesn't match the grep command running it!
  ALREADY_RUNNING=$(ps -auxww | grep -q "[n]piperelay.exe -ei -s //./pipe/openssh-ssh-agent"; echo $?)
  if [[ $ALREADY_RUNNING != "0" ]]; then
    if [[ -S $SSH_AUTH_SOCK ]]; then
      # not expecting the socket to exist as the forwarding command isn't running (http://www.tldp.org/LDP/abs/html/fto.html)
      echo "removing previous socket..."
      rm $SSH_AUTH_SOCK
    fi
    echo "Starting SSH-Agent relay..."
    # setsid to force new session to keep running
    # set socat to listen on $SSH_AUTH_SOCK and forward to npiperelay which then forwards to openssh-ssh-agent on windows
    (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
  fi
fi
# }}}
