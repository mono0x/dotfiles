#!/bin/sh
ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"
ln -s /usr/local/Library/Contributions/brew_zsh_completion.zsh /usr/local/share/zsh/site-functions/_brew
brew install hub
