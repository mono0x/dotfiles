setopt auto_list
setopt auto_pushd
setopt noflowcontrol
setopt print_eight_bit
# Required by prompt themes that embed $(...) for dynamic content.
setopt prompt_subst # noka: ZC1967
setopt pushd_ignore_dups

export WORDCHARS="*?_-.[]~&;!#$%^(){}<>"

# Unbind ^S (flow-control XOFF) at the tty driver so it never freezes output and stays
# available to bindkey; noflowcontrol above covers ZLE only, not foreground commands.
# Read the tty explicitly: stdin is /dev/null while an instant prompt is active.
stty stop undef <$TTY
