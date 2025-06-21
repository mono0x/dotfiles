#!/bin/sh
set -eu
zsh --no-exec \
  "$HOME/.config/zsh/.zshrc" \
  "$HOME/.config/zsh/functions/*" \
  "$HOME/.config/zsh/zshrc.d/*" \
  "$HOME/.config/zsh/zshrc.defer.d/*" \
  "$HOME/.zprofile" \
  "$HOME/.zshenv"
