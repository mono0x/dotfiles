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
HISTFILE="$XDG_STATE_HOME/zsh_history"
HISTSIZE=100000
SAVEHIST=1000000

setopt append_history
setopt extended_glob
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
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

# Starship {{{
if (( $+commands[starship] )); then
  # eval "$(starship init zsh)"
  source <(starship init zsh --print-full-init)
fi
# }}}