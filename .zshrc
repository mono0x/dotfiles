
export LANG=ja_JP.UTF-8

HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000

bindkey -v

bindkey "^D" delete-char
setopt ignore_eof

zle -A .backward-kill-word vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char

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

setopt noflowcontrol

bindkey '^q' push-input

alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=aunpack

alias sudo="sudo "
alias ls="ls --color"
alias ll='ls -l'
alias la='ls -A'

alias g='git'
alias ga='git add'
alias gbr='git branch'
alias gci='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gl='git log --graph'
alias gs='git status'

