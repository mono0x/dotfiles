#!/bin/sh
ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"
ln -s /usr/local/Library/Contributions/brew_zsh_completion.zsh /usr/local/share/zsh/site-functions/_brew
brew install hub
brew install readline openssl curl-ca-bundle
brew link readline --force
brew link openssl --force
cp /usr/local/Cellar/curl-ca-bundle/1.87/share/ca-bundle.crt /usr/local/etc/openssl/cert.pem
