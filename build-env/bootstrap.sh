#!/bin/sh
if [ ! -x "$(command -v git > /dev/null)" ]
then
  echo "git not found." >&2
  exit 1
fi

dotfiles_parent="$HOME/src/github.com/mono0x"
dotfiles_dir="$dotfiles_parent/dotfiles"

if [ ! -d "$dotfiles_dir" ]
then
  mkdir -p "$dotfiles_parent"
  git clone https://github.com/mono0x/dotfiles "$dotfiles_dir"
fi
