#!/bin/sh
set -eu
cd "${CHEZMOI_SOURCE_DIR:-$(dirname "$0")}/.."
brew bundle --no-upgrade
