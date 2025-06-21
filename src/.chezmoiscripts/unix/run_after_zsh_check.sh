#!/bin/sh
set -eu
for file in \
  "$HOME"/.config/zsh/.zshrc \
  "$HOME"/.config/zsh/functions/* \
  "$HOME"/.config/zsh/zshrc.d/* \
  "$HOME"/.config/zsh/zshrc.defer.d/* \
  "$HOME"/.zprofile \
  "$HOME"/.zshenv
do
  # `zsh --no-exec` only accepts single file
  zsh --no-exec "$file"
done
