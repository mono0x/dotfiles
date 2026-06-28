#!/bin/sh
set -eu
cd "$HOME/.local/share/chezmoi"
GOSS_USE_ALPHA=1 mise exec -- chronic goss validate --format documentation
