setopt auto_list
setopt auto_pushd
setopt noflowcontrol
setopt print_eight_bit
# Required by prompt themes that embed $(...) for dynamic content.
setopt prompt_subst # noka: ZC1967
setopt pushd_ignore_dups

export WORDCHARS="*?_-.[]~&;!#$%^(){}<>"

stty stop undef
