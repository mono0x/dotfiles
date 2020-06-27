#!/bin/sh
set -e

cd "$(cd "$(dirname "$0")/.."; pwd)"

shellcheck ./**/*.sh
(command -v zsh > /dev/null) && zsh -n .zshenv .zshrc
