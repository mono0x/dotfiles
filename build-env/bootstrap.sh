#!/bin/sh
if [ ! -x "$(which git 2> /dev/null)" ]
then
  echo "git not found." >&2
  exit 1
fi

dotfiles_parent="$HOME/src/github.com/mono0x"
dotfiles_dir="$dotfiles_parent/dotfiles"

mkdir -p "$dotfiles_parent"
git clone https://github.com/mono0x/dotfiles "$dotfiles_dir"
