#!/usr/bin/env zsh
if (( $+commands[fd] ))
then
  for file in \
    ~/.config/zsh/.zprofile \
    ~/.config/zsh/.zshrc \
    ~/.zshenv \
    $(fd -t f -e zsh . ~/.config/zsh) \
    $(fd -t f '^_\w+$' ~/.config/zsh/functions) \
    $(fd -t f -e zsh . ~/.local/share/sheldon)
  do
    echo "zcompile $file"
    zcompile "$file"
  done
fi
