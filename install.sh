#!/bin/sh
set -eu

cd "$(dirname "$0")"

deno=""
if command -v deno > /dev/null 2>&1
then
  deno="deno"
else
  DENO_INSTALL="$HOME/.local"
  DENO_INSTALL="$DENO_INSTALL" sh -c "$(curl -fsSL https://deno.land/x/install/install.sh)"
  deno="$DENO_INSTALL/bin/deno"
fi

prefix="."
[ "${GITHUB_ACTIONS:-}" = "true" ] && prefix="https://raw.githubusercontent.com/mono0x/dotfiles"

exec "$deno" run --config "$prefix/deno.jsonc" --lock "$prefix/deno.lock" -A "$prefix/install/main.ts"
