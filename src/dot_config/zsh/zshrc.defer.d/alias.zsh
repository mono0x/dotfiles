# Global alias by design: expands "M" to the default branch name in argument position (e.g. `git rebase M`).
alias -g M='"$(git-default-branch)"' # noka: ZC1771

abbr ci="commit"
abbr cl="claude"
abbr g="git"
abbr ga="git add"
abbr gd="git di"
abbr gf="git fetch --all"
abbr gg="git grep -H --heading -I --line-number --break --show-function"
abbr gl="git log"
abbr gs="git status"
abbr k="kubectl"
abbr la="ls -A"
abbr ll="ls -l"
abbr lla="ls -Al"

abbr import-git-aliases --prefix "git "

ZSH_AUTOSUGGEST_STRATEGY=(abbreviations $ZSH_AUTOSUGGEST_STRATEGY)

# Workaround for fast-abbr-highlighting (FAH) v0.1.5.
#
# Symptom: abbr keys whose name is not a real command/function (e.g. `ci`, `gs`)
# briefly turn green when typed, then immediately revert to fast-syntax-highlighting
# (FSH)'s unknown-token red.
#
# Cause: zsh-autosuggestions wraps widgets on every precmd, so once FSH has wrapped
# the autosuggestions chain, autosuggestions re-wraps on top (bound_2 over bound_1).
# This double layer makes `_zsh_highlight` fire multiple times per keystroke. FAH
# guards its parser with `LBUFFER == PRIOR_LBUFFER`, so on the 2nd+ call it skips
# the abbr match and falls through to `_orig_zsh_highlight` (FSH), which then
# repaints the buffer based on FSH's own `_ZSH_HIGHLIGHT_PRIOR_BUFFER` cache.
# FAH never updates that cache on a successful match, so FSH considers the buffer
# changed and re-highlights it as unknown-token, clobbering FAH's green.
#
# Fix: after each call to FAH's wrapper, if FAH matched (PREV_MATCHED=1), sync
# FSH's cache marker to the current buffer so the next call sees "no change" and
# skips re-highlighting.
if ((${+functions[_orig_zsh_highlight]} && ${+functions[_zsh_highlight]})); then
  functions -c _zsh_highlight _fah_outer_orig
  _zsh_highlight() {
    _fah_outer_orig "$@"
    local ret=$?
    ((${FAST_ABBR_HIGHLIGHT[PREV_MATCHED]:-0})) && _ZSH_HIGHLIGHT_PRIOR_BUFFER=$BUFFER
    return $ret
  }
fi

# Aliases are the intended idiom in interactive zshrc (preserved in completion, history expansion,
# argument transparency); the rule targets scripts.
# noka: ZC1049
