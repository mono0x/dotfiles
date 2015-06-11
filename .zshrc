# .zshrc
# vim: foldmethod=marker

# Options {{{
setopt auto_list
setopt auto_pushd
setopt noflowcontrol
setopt print_eight_bit
setopt prompt_subst
setopt pushd_ignore_dups

export WORDCHARS="*?_-.[]~&;!#$%^(){}<>"

stty -ixon
# }}}

# History {{{
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

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

# Completions {{{
dotzsh=$HOME/.zsh
fpath=($dotzsh/cd-gitroot $dotzsh/z $dotzsh/zsh-completions/src $GOPATH/src/github.com/motemen/ghq/zsh $fpath)
unset dotzsh

autoload -U compinit
compinit
# }}}

# Prompt {{{
autoload colors
colors

autoload -Uz add-zsh-hook

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn):*' branchformat '%b:r%r'

autoload -Uz is-at-least
if is-at-least 4.3.10; then
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"
  zstyle ':vcs_info:git:*' unstagedstr "-"
  zstyle ':vcs_info:git:*' formats '(%s)-[%b] %c%u'
  zstyle ':vcs_info:git:*' actionformats '(%s)-[%b|%a] %c%u'
fi

update_vcs_info_message() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

add-zsh-hook precmd update_vcs_info_message

local HOST_COLOR='%{${reset_color}%}'
[ -f ~/.zshrc.color ] && source ~/.zshrc.color

case ${UID} in
0)
  local USER_COLOR='%{${fg[red]}%}'
  local MARK_COLOR='%{${fg[red]}%}'
  ;;
*)
  local USER_COLOR='%{${reset_color}%}'
  local MARK_COLOR='%{${fg[blue]}%}'
esac

PROMPT="
%{${fg[blue]}%}%/%{${reset_color}%} %1(v|%{${fg[green]}%}%1v%f|)%{${reset_color}%}
[${USER_COLOR}%n%{${reset_color}%}@${HOST_COLOR}%m%{${reset_color}%}] %{${MARK_COLOR}%}%#%{${reset_color}%} "
PROMPT2="%B%{${fg[blue]}%}%_#%{${reset_color}%}%b "
SPROMPT="%B%{${fg[blue]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
#RPROMPT="%{${fg[blue]}%}[%/]%{${reset_color}%}"

zstyle ':completion:*' use-cache true
zstyle ':completion:*:default' menu select=1
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
alias tmux='TERM=screen-256color tmux'
alias vi='vim'
alias v='vim'

case "${OSTYPE}" in
linux*)
  alias ls="ls --color"
  ;;
darwin*)
  alias ls="ls -G"
  ;;
esac
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -Al'

if which hub &> /dev/null; then
  alias git='hub'
  compdef hub=git
fi
alias g='git'
alias ga='git add'
alias gbr='git br'
alias gci='git ci'
alias gco='git co'
alias gd='git di'
alias gl='git log --graph'
alias gg='git grep -H --heading -I --line-number --break'
alias gs='git status'

alias b='bundle'
alias be='bundle exec'
alias bet='bundle exec thor'
alias ber='noglob bundle exec rake'
alias rake='noglob rake'

# http://www.reddit.com/r/commandline/comments/12g76v/how_to_automatically_source_zshrc_in_all_open/
trap "source ~/.zshrc" USR1
alias source-zshrc-all="pkill -usr1 zsh"

case "${OSTYPE}" in
cygwin*)
  alias vi=gvim
  alias vim=gvim
  ;;
esac

sudo() {
  local args
  case $1 in
    vi|vim)
      args=()
      for arg in $@[2,-1]
      do
        if [ $arg[1] = '-' ]; then
          args[$(( 1+$#args ))]=$arg
        else
          args[$(( 1+$#args ))]="sudo:$arg"
        fi
      done
      vim $args
      ;;
    *)
      command sudo $@
      ;;
  esac
}

_Z_CMD=j source ~/.zsh/z/z.sh

autoload -Uz cd-gitroot
alias u=cd-gitroot
# }}}

# Peco {{{
if which peco &> /dev/null; then
  peco-cd() {
    local selected_dir=$(ghq list | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
      BUFFER="cd ${GOPATH}/src/${selected_dir}"
      zle accept-line
    fi
    zle redisplay
  }
  zle -N peco-cd
  bindkey '^s' peco-cd

  peco-git-hash() {
    local selected_hash=$(git log --date=short --pretty='format:%h %cd %s' --branches 2>/dev/null | peco 2>/dev/null | awk '{print $1}')
    if [ -n "$selected_hash" ]; then
      BUFFER="$BUFFER$selected_hash"
      CURSOR="$#BUFFER"
    fi
    zle redisplay
  }
  zle -N peco-git-hash
  bindkey '^g' peco-git-hash
fi
# }}}

# Functions {{{
# sudo with rbenv
rbenvsudo() {
  local executable
  executable=$1
  shift 1
  command sudo PATH=$PATH $(rbenv which $executable) $*
}

# Notify to Twitter
n() {
  local dt
  dt=`date '+%m/%d %H:%M:%S'`
  $*
  t update "done: $* => $? ($dt)" > /dev/null 2>&1
}

# update environment variables
update_tmux_environment() {
  local _tmux_env
  if [ -n "${TMUX}" ]; then
    _tmux_env=$( tmux show-environment )
    if [ "${_tmux_env}" != "${_expected_tmux_env}" ]; then
      eval $( echo "${_tmux_env}" | \
        sed -e '/^-/!{ s/=/="/; s/$/"/; s/^/export /; }' \
        -e 's/^-/unset /' \
        -e 's/$/;/' )
      _expected_tmux_env="${_tmux_env}"
    fi
  fi
}
add-zsh-hook precmd update_tmux_environment
# }}}

# External scripts {{{
# rbenv
if [[ -f /usr/local/Cellar/rbenv/0.4.0/completions/rbenv.zsh ]]; then
  source /usr/local/Cellar/rbenv/0.4.0/completions/rbenv.zsh
elif [[ -f $HOME/.rbenv/completions/rbenv.zsh ]]; then
  source "$HOME/.rbenv/completions/rbenv.zsh"
else
  return
fi

# plenv
if which plenv > /dev/null; then eval "$(plenv init -)"; fi

if which dnvm.sh &> /dev/null; then
  source dnvm.sh
fi
# }}}

#eval 'dircolors'
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Load local zshrc
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
