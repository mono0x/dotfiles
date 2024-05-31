#!/bin/bash
set -eu

dir="$(mktemp --tmpdir -d dotfiles.XXXXXX)"
cd "$dir"
trap '{ rm -f -- "$dir"; }' EXIT

target=""
case "$(uname)" in
  Darwin)
    target="aarch64-apple-darwin"
    ;;
  Linux)
    target="x86_64-unknown-linux-gnu"
    ;;
esac
if [ -z "$target" ]; then
  echo "Unsupported platform: $(uname)"
  exit 1
fi
url="https://github.com/mono0x/dotfiles/releases/latest/download/bootstrap-$target"

curl -L -o bootstrap "$url"
chmod +x bootstrap

./bootstrap
