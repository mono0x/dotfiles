
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

case ${UID} in
0)
	PROMPT="
%{${fg[blue]}%}%/%{${reset_color}%}
[%{${fg[blue]}%}%n@%m%{${reset_color}%}] %{${fg[blue]}%}#%{${reset_color}%} "
	PROMPT2="%B%{${fg[blue]}%}%_#%{${reset_color}%}%b "
	SPROMPT="%B%{${fg[blue]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
	#RPROMPT="%{${fg[blue]}%}[%/]%{${reset_color}%}"
	;;
*)
	PROMPT="
%{${fg[blue]}%}%/%{${reset_color}%}
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

setopt complete_aliases
alias sudo="sudo "
alias ls="ls --color"

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

