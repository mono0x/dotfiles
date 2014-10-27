
HISTFILE=$HOME/.zsh-history
HISTSIZE=1000000
SAVEHIST=$HISTSIZE

setopt interactive_comments
setopt extended_glob

bindkey -v

bindkey "^D" delete-char
setopt ignore_eof

zle -A .backward-kill-word vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char

dotzsh=$HOME/.zsh
fpath=($dotzsh/cd-gitroot $dotzsh/z $dotzsh/zsh-completions/src $fpath)
unset dotzsh

autoload -U compinit
compinit

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

setopt auto_list

setopt print_eight_bit

setopt prompt_subst

setopt share_history

setopt hist_ignore_all_dups
setopt hist_ignore_dups

setopt auto_pushd
setopt pushd_ignore_dups

#eval 'dircolors'
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

if which peco > /dev/null; then
  peco-history() {
      local tac
      if which tac > /dev/null; then
          tac="tac"
      else
          tac="tail -r"
      fi
      BUFFER=$(\history -n 1 | \
          eval $tac | \
          peco --query "$LBUFFER")
      CURSOR=$#BUFFER
      zle clear-screen
  }
  zle -N peco-history
  bindkey "^R" peco-history
else
  bindkey "^R" history-incremental-pattern-search-backward
  bindkey "^S" history-incremental-pattern-search-forward
fi

setopt noflowcontrol

bindkey '^q' push-input

alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=aunpack

alias sudo="sudo "
alias tmux='TERM=screen-256color tmux'
alias vi='vim'

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

if which hub &> /dev/null; then
  alias git='hub'
  compdef hub=git
fi
alias g='git'
alias ga='git add'
alias gbr='git branch'
alias gci='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gl='git log --graph'
alias gg='git grep -H --no-index --heading -I --line-number --break'
alias gs='git status'

alias b='bundle'
alias be='bundle exec'
alias bet='bundle exec thor'
alias ber='noglob bundle exec rake'
alias rake='noglob rake'
alias frbe='foreman run bundle exec'
alias frbet='foreman run bundle exec thor'
alias frber='foreman run bundle exec rake'

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

tn() {
  local dt
  dt=`date '+%m/%d %H:%M:%S'`
  $*
  t update "done: $* => $? ($dt)" > /dev/null 2>&1
}

_Z_CMD=j source ~/.zsh/z/z.sh

autoload -Uz cd-gitroot
alias u=cd-gitroot

# rbenv
rbenvsudo() {
  executable=$1
  shift 1
  command sudo PATH=$PATH $(rbenv which $executable) $*
}

# tmux
update_tmux_environment() {
  if [ -n "${TMUX}" ]; then
    local _tmux_env
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

change-repository() {
  cd $(ghq list -p | peco)
  zle accept-line
  zle clear-screen
}
zle -N change-repository
bindkey "^F" change-repository

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
