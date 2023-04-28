#!/usr/bin/env zsh
for f in \
  $HOME/.config/zsh/**/*.zsh \
  $HOME/.zshenv \
  $HOME/.zshrc
do
  zcompile $f
done
