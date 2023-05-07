#!/bin/sh
set -eu
cd "$HOME/.local/share/chezmoi"
goss validate
