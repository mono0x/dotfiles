#!/bin/sh
set -eu

deno=""
if command -v deno > /dev/null 2>&1
then
  deno="deno"
else
  DENO_INSTALL="$HOME/.local"
  DENO_INSTALL="$DENO_INSTALL" sh -c "$(curl -fsSL https://deno.land/x/install/install.sh)"
  deno="$DENO_INSTALL/bin/deno"
fi

prefix="$(dirname "$0")"
if [ ! -f "$prefix/install.ts" ]
then
  prefix="https://raw.githubusercontent.com/mono0x/dotfiles/main/"
fi

exec "$deno" run -A "$prefix/install.ts"
