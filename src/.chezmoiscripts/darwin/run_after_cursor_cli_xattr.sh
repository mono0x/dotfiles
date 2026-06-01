#!/bin/sh
set -eu

# Strip Gatekeeper quarantine from Homebrew-installed Cursor CLI binaries.
# https://forum.cursor.com/t/cursor-cli-installation-method-zsh-vs-bash/158601
cursor_cli_caskroom="$(brew --prefix)/Caskroom/cursor-cli"
if [ -d "$cursor_cli_caskroom" ]; then
  /usr/bin/xattr -cr "$cursor_cli_caskroom"
fi
