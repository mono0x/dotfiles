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
# hist_ignore_space (above) lets sensitive commands opt out.
setopt share_history # noka: ZC1928

# http://mollifier.hatenablog.com/entry/20090728/p1
# Return 2 keeps the line in the session history (reusable with ^p) but out of HISTFILE.
_history_no_save() {
  local line=${1%%$'\n'}
  ((${#line} >= 4)) || return 2
  [[ $line != (cd|ls)(|' '*) ]] || return 2
}
autoload -Uz add-zsh-hook
add-zsh-hook zshaddhistory _history_no_save
