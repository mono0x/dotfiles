# Global alias by design: expands "M" to the default branch name in argument position (e.g. `git rebase M`).
# TODO(zsh 5.10): use '${ git-default-branch }' to skip the subshell fork. Keep it unquoted:
# "${ ... }" keeps the trailing newline, while the unquoted form strips it and doesn't word-split.
alias -g M='"$(git-default-branch)"' # noka: ZC1771

# Aliases are the intended idiom in interactive zshrc (preserved in completion, history expansion,
# argument transparency); the rule targets scripts.
# noka: ZC1049
