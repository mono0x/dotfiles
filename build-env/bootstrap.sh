#!/bin/sh
set -eu

if ! (command -v git > /dev/null 2>&1)
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
cd "$dotfiles_dir"

# apt
case "$(uname)" in
Linux)
  sh "./build-env/linux/apt.sh"
  ;;
esac

# Homebrew
if ! (command -v brew > /dev/null 2>&1)
then
  echo "Installing Homebrew..." >&2
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

if [ -z "$SKIP_PACKAGE_INSTALLATION" ]; then
  zsh -c "source ./bin/homebrew.sh && brew bundle"
fi

./build-env/setup.ts
# Run setup-asdf.ts using a new zsh process to reflect .zshenv
zsh -c "./build-env/setup-asdf.ts"
