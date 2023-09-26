#!/bin/sh
set -eu
cd "$HOME/.local/share/chezmoi"
# Calling with absolute path for the case where $HOME/bin is not set in PATH
GOSS_USE_ALPHA=1 "$HOME/bin/goss" validate
