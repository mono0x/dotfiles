
HISTFILE=$HOME/.zsh-history
HISTSIZE=1000000
SAVEHIST=$HISTSIZE

setopt interactive_comments

bindkey -v

bindkey "^D" delete-char
setopt ignore_eof

zle -A .backward-kill-word vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char

autoload -U compinit
compinit

fpath=(~/.zsh/zsh-completions $fpath)

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
case ${UID} in
0)
	PROMPT="
%{${fg[blue]}%}%/%{${reset_color}%} %1(v|%{${fg[green]}%}%1v%f|)%{${reset_color}%}
[%{${fg[blue]}%}%n@%m%{${reset_color}%}] %{${fg[blue]}%}#%{${reset_color}%} "
	PROMPT2="%B%{${fg[blue]}%}%_#%{${reset_color}%}%b "
	SPROMPT="%B%{${fg[blue]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
	#RPROMPT="%{${fg[blue]}%}[%/]%{${reset_color}%}"
	;;
*)
	PROMPT="
%{${fg[blue]}%}%/%{${reset_color}%} %1(v|%{${fg[green]}%}%1v%f|)%{${reset_color}%}
[%n@%m] %{${fg[blue]}%}#%{${reset_color}%} "
	PROMPT2="%B%{${fg[blue]}%}%_#%{${reset_color}%}%b "
	SPROMPT="%B%{${fg[blue]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
	#RPROMPT="%{${fg[blue]}%}[%/]%{${reset_color}%}"
	;;
esac

zstyle ':completion:*:default' menu select=1

setopt auto_list

setopt print_eight_bit

setopt prompt_subst

setopt share_history

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
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward

setopt noflowcontrol

bindkey '^q' push-input

alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=aunpack

alias sudo="sudo "
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
alias gs='git status'

alias b='bundle'
alias be='bundle exec'
alias bet='bundle exec thor'
alias ber='noglob bundle exec rake'
alias rake='noglob rake'
alias frbe='foreman run bundle exec'
alias frbet='foreman run bundle exec thor'

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
      command vim $args
      ;;
    *)
      command sudo $@
      ;;
  esac
}

_Z_CMD=j
source ~/.zsh/z/z.sh
precmd() {
  _z --add "$(pwd -P)"
}

source ~/.zsh/cdd/cdd
chpwd() {
  _cdd_chpwd
}
