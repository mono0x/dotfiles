#!/bin/sh
set -eu

cd "$(dirname "$0")"

DENO_INSTALL="$HOME/.local"
command -v "$DENO_INSTALL/bin/deno" > /dev/null 2>&1 || \
  DENO_INSTALL="$DENO_INSTALL" sh -c "$(curl -fsSL https://deno.land/x/install/install.sh)"

exec "$DENO_INSTALL/bin/deno" run -A https://raw.githubusercontent.com/mono0x/dotfiles/main/install/main.ts
