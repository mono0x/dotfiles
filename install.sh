#!/bin/sh
set -eux

cd "$(dirname "$0")"

if ! (command -v git > /dev/null 2>&1)
then
  echo "git not found." >&2
  return 1
fi

if [ "${REMOTE_CONTAINERS:-}" = "true" ]
then
  echo "Running in a remote container." >&2
  sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --verbose mono0x
  exit
fi

HOMEBREW_INSTALL=""
case "$(uname)" in
Darwin)
  HOMEBREW_INSTALL="/opt/homebrew"
  ;;

Linux)
  HOMEBREW_INSTALL="/home/linuxbrew/.linuxbrew"
  ;;
esac
DENO_INSTALL="$HOME/.local"
CHEZMOI_INSTALL="$HOME/.local/bin"

command -v "$HOMEBREW_INSTALL/bin/brew" > /dev/null 2>&1 || \
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

command -v "$DENO_INSTALL/bin/deno" > /dev/null 2>&1 || \
  DENO_INSTALL="$DENO_INSTALL" sh -c "$(curl -fsSL https://deno.land/x/install/install.sh)"

command -v "$CHEZMOI_INSTALL/chezmoi" > /dev/null 2>&1 || \
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$CHEZMOI_INSTALL"

if [ "$(uname)" = "Linux" ]
then
  "$DENO_INSTALL/bin/deno" run -A _install/apt-install.ts \
    build-essential \
    language-pack-en \
    libssl-dev \
    pkg-config \
    zsh
fi

env -i HOME="$HOME" sh <<EOS
  eval "$($HOMEBREW_INSTALL/bin/brew shellenv)"
  [ -d "$HOME/.local/share/chezmoi" ] || "$CHEZMOI_INSTALL/chezmoi" init --verbose --apply mono0x
EOS
