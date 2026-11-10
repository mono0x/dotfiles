#!/bin/sh
set -eu

install_extension() (
  repository=$1
  version=$2
  extensions=$(gh extension list)
  current=$(printf '%s\n' "$extensions" | awk -v repository="$repository" '$3 == repository { print $4; exit }')

  if [ "$current" = "$version" ]; then
    return
  fi

  if [ -n "$current" ]; then
    chronic gh extension remove "${repository##*/}"
  fi
  chronic gh extension install "$repository" --pin "$version"
)

install_extension github/gh-actions-lock v0.4.1
