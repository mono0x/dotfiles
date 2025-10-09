#!/bin/bash
set -eu

account="mono0x"

if [ "$(uname)" != "Darwin" ]; then
  echo "Error: Unsupported OS: $(uname)" >&2
  exit 1
fi

if [ -z "${HOME:-}" ]; then
  echo "Error: HOME environment variable not set" >&2
  exit 1
fi

homebrew_dir="/opt/homebrew"
brew="$homebrew_dir/bin/brew"

echo "Installing Homebrew"

if [ ! -f "$brew" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Installing and initializing chezmoi"

env -i HOME="$HOME" GITHUB_ACTIONS="${GITHUB_ACTIONS:-}" /bin/bash --noprofile --norc << EOF
eval \$("$brew" shellenv)
HOMEBREW_NO_AUTO_UPDATE=1 "$brew" install chezmoi
chezmoi init --verbose --apply $account
EOF
