# Global alias by design: expands "M" to the default branch name in argument position (e.g. `git rebase M`).
alias -g M='"$(git-default-branch)"' # noka: ZC1771

# Aliases are the intended idiom in interactive zshrc (preserved in completion, history expansion,
# argument transparency); the rule targets scripts.
# noka: ZC1049
