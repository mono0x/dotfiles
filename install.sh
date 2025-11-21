#!/bin/bash
# Since this script is downloaded from GitHub and executed directly,
# it must not depend on other files in the repository until chezmoi is run.
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

HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"

echo "Installing Homebrew"

if [ ! -f "$HOMEBREW_PREFIX/bin/brew" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Installing and initializing chezmoi"

env -i \
  HOME="$HOME" \
  HOMEBREW_NO_AUTO_UPDATE=1 \
  HOMEBREW_PREFIX="$HOMEBREW_PREFIX" \
  GITHUB_ACCOUNT="$account" \
  GITHUB_ACTIONS="${GITHUB_ACTIONS:-}" \
/bin/bash --noprofile --norc << 'EOF'
eval "$(/usr/libexec/path_helper -s)"
eval "$("$HOMEBREW_PREFIX/bin/brew" shellenv)"
"$HOMEBREW_PREFIX/bin/brew" install chezmoi
chezmoi init --verbose --apply "$GITHUB_ACCOUNT"
EOF
