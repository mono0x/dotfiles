#!/bin/sh
set -eu

if command -v brew > /dev/null 2>&1
then
  cd "${CHEZMOI_SOURCE_DIR:-$(dirname "$0")}/.."
  HOMEBREW_BUNDLE_CASK_SKIP="$([ "${GITHUB_ACTIONS:-""}" = "true" ] && echo 1 || echo 0)" brew bundle --no-upgrade
fi
