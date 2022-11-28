# .zshrc
# vim: foldmethod=marker

# Compile {{{
if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi
# }}}

# Variables {{{
CPUARCH="$(uname -m)"
# }}}

# zinit {{{
source ~/.zinit/bin/zinit.zsh

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

if [ -f $HOME/.asdf/completions/_asdf ]; then
  zinit ice wait"0" lucid
  zinit snippet $HOME/.asdf/completions/_asdf
fi

if [ -f $HOME/google-cloud-sdk/completion.zsh.inc ]; then
  zinit ice wait"0" lucid
  zinit snippet $HOME/google-cloud-sdk/completion.zsh.inc
fi

zinit ice wait"0" as"completion" lucid
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zinit ice wait"0" as"completion" lucid
zinit snippet https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose

zinit light jonmosco/kube-ps1

# https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2894219
_zicompinit_custom() {
  setopt extendedglob local_options
  autoload -Uz compinit
  local zcd=${ZINIT[ZCOMPDUMP_PATH]:-${ZDOTDIR:-$HOME}/.zcompdump}
  local zcdc="$zcd.zwc"
  # Compile the completion dump to increase startup speed, if dump is newer or doesn't exist,
  # in the background as this is doesn't affect the current session
  if [[ -f "$zcd"(#qN.m+1) ]]; then
        compinit -i -d "$zcd"
        { rm -f "$zcdc" && zcompile "$zcd" } &!
  else
        compinit -C -d "$zcd"
        { [[ ! -f "$zcdc" || "$zcd" -nt "$zcdc" ]] && rm -f "$zcdc" && zcompile "$zcd" } &!
  fi
}

zinit wait lucid for \
 atinit"_zicompinit_custom; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions
# }}}

# Options {{{
setopt auto_list
setopt auto_pushd
setopt noflowcontrol
setopt print_eight_bit
setopt prompt_subst
setopt pushd_ignore_dups

export WORDCHARS="*?_-.[]~&;!#$%^(){}<>"

stty stop undef
# }}}

# History {{{
HISTFILE=$HOME/.zsh-history
HISTSIZE=10000
SAVEHIST=100000

setopt extended_glob
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt interactive_comments
setopt share_history

# http://mollifier.hatenablog.com/entry/20090728/p1
zshaddhistory() {
  local line=${1%%$'\n'}
  local cmd=${line%% *}

  [[ ${#line} -ge 4 ]]
}
# }}}

# Key {{{
bindkey -d
bindkey -e

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
# }}}

# Aliases {{{
alias sudo="sudo "
alias sudoe='sudo -e'
alias tmux='TERM=screen-256color tmux'
alias man='vs man'
alias vi='nvim'

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
  if which arch &> /dev/null; then
    alias exec-x86_64='arch -arch x86_64 '
    alias exec-arm64='arch -arch arm64 '

    if [ -f /opt/homebrew/bin/brew ]
    then
      alias brew='arch -arch arm64 /opt/homebrew/bin/brew'
      alias brew-x86_64='arch -arch x86_64 /usr/local/bin/brew'
    fi
  fi

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

if which hub &> /dev/null; then
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

# http://www.reddit.com/r/commandline/comments/12g76v/how_to_automatically_source_zshrc_in_all_open/
trap "source ~/.zshrc" USR1
alias source-zshrc-all="pkill -usr1 zsh"
# }}}

# fzf {{{
if which fzf &> /dev/null; then
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

# Functions {{{
# tmux
() {

vs() {
  if [ -n "${TMUX}" ]; then
    tmux split-window -h "exec $*"
  else
    command $*
  fi
}

sp() {
  if [ -n "${TMUX}" ]; then
    tmux split-window -v "exec $*"
  else
    command $*
  fi
}

quit() {
  command osascript -e "quit app \"$1\""
}

}

# }}}

# Environment variables {{{
export LESS='-R'
# }}}

#eval 'dircolors'
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# {{{
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

# Load local zshrc
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# Dedup PATH
path=($path)

# Starship
eval "$(starship init zsh)"

# Finish profiling {{{
if [ -n "$ZPROF" ]; then
  zprof
fi
# }}}
