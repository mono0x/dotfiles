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
if [ ! -f "$prefix/install/main.ts" ]
then
  dir="$(mktemp --tmpdir -d dotfiles.XXXXXX)"
  mkdir -p "$dir/install"
  for file in install/main.ts deno.jsonc deno.lock
  do
    curl -fsSL "https://raw.githubusercontent.com/mono0x/dotfiles/main/$file" -o "$dir/$file"
  done
  prefix="$dir"
fi

exec "$deno" run --config "$prefix/deno.jsonc" --lock "$prefix/deno.lock" -A "$prefix/install/main.ts"
