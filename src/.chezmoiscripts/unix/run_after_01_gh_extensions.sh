#!/bin/sh
set -eu

if [ -z "${GH_TOKEN:-}" ] && [ -z "${GITHUB_TOKEN:-}" ]; then
  if ! GH_TOKEN=$(gh auth token --hostname github.com); then
    printf '%s\n' 'Skipping gh extensions until GitHub authentication is available. Rerun chezmoi apply after authenticating.' >&2
    exit 0
  fi
  export GH_TOKEN
fi

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
install_extension babarot/gh-infra v0.20.0
