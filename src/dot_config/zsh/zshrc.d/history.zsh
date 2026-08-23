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

# Applied when lines are written to HISTFILE, so matches stay in the session
# history (reusable with ^p) but out of the file.
# ?(#c,3): up to 3 characters. (cd|ls)(| *): cd/ls alone or with arguments.
HISTORY_IGNORE='(?(#c,3)|(cd|ls)(| *))'
