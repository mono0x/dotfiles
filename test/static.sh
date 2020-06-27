#!/bin/sh
set -e

cd $(cd "$(dirname $0)/.."; pwd)

shellcheck **/*.sh
zsh -n .zshenv .zshrc
