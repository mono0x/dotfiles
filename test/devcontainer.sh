#!/bin/sh
set -xeu

cd "$(cd "$(dirname "$0")/.."; pwd)"

./build-env/devcontainer.sh

(command -v zsh > /dev/null) && zsh -i -c exit
