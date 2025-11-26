#!/bin/sh
set -eu
for file in \
  "$HOME"/.config/zsh/.zshrc \
  "$HOME"/.config/zsh/zshrc.d/*.zsh \
  "$HOME"/.config/zsh/zshrc.defer.d/*.zsh \
  $(find "$HOME/.config/zsh/functions" -type f -name '_*' ! -name '*.zwc' 2>/dev/null) \
  "$HOME"/.zprofile \
  "$HOME"/.zshenv
do
  # `zsh --no-exec` only accepts single file
  echo "zsh --no-exec $file"
  zsh --no-exec "$file"
done
