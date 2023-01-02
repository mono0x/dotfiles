#!/bin/sh
set -eu

if ! command -v git 2>&1 > /dev/null
then
  echo "git not found." >&2
  return 1
fi

dotfiles_parent="$HOME/src/github.com/mono0x"
dotfiles_dir="$dotfiles_parent/dotfiles"

if [ ! -d "$dotfiles_dir" ]
then
  echo "Cloning mono0x/dotfiles..." >&2
  mkdir -p "$dotfiles_parent"
  git clone https://github.com/mono0x/dotfiles "$dotfiles_dir"
fi

# Homebrew
if ! command -v brew 2>&1 > /dev/null
then
  echo "Installing Homebrew..." >&2
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  . "$dotfiles_dir/bin/homebrew.sh"
fi

brew install zx

sh "$dotfiles_dir/build-env/asdf.sh"
zx "$dotfiles_dir/build-env/common.mjs"
sh "$dotfiles_dir/build-env/brewfile.sh"
