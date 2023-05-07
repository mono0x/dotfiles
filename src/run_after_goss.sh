#!/bin/sh
set -eu
cd "$HOME/.local/share/chezmoi"
GOSS_USE_ALPHA=1 goss validate
