#!/bin/sh
set -eu

if command -v brew > /dev/null 2>&1
then
  cd "${CHEZMOI_SOURCE_DIR:-$(dirname "$0")}/.."
  if [ "${GITHUB_ACTIONS:-""}" = "true" ]
  then
    export HOMEBREW_BUNDLE_CASK_SKIP=1
  fi
  brew bundle --no-upgrade
fi
