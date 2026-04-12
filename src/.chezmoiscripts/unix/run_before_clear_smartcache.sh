#!/bin/sh
set -eu

# zsh-smartcache caches the output of `mise activate zsh`, which includes a
# hardcoded PATH snapshot taken at the time of caching. This means any PATH
# entries added after the cache was created (e.g. new app in .zshenv) will be
# silently dropped when mise rewrites PATH on shell startup.
# Clearing the cache on each `chezmoi apply` ensures mise re-evaluates PATH
# from the current environment after dotfiles are updated.
rm -rf "${XDG_CACHE_HOME:-$HOME/.cache}/zsh-smartcache"
