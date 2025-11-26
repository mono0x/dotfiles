#!/bin/sh
set -eu
cd "$HOME/.local/share/chezmoi"
GOSS_USE_ALPHA=1 mise exec github:goss-org/goss -- goss validate --format documentation
