#!/bin/sh
set -e

brew update
brew upgrade

brew install ansible
brew install cmigemo
brew install colordiff
brew install coreutils
brew install dep
brew install editorconfig
brew install exiftool
brew install findutils
brew install fswatch
brew install ghq
brew install git --with-pcre2
brew install global --with-exuberant-ctags --with-pygments --with-sqlite3
brew install gnu-sed
brew install go --cross-compile-common
brew install grep
brew install gzip
brew install htop
brew install hub
brew install kubernetes-cli
brew install lua
brew install luajit
brew install mas
brew install mercurial
brew install neovim/neovim/neovim
brew install nginx
brew install node
brew install openssl
brew install peco
brew install postgresql
brew install python3
brew install rbenv
brew install readline
brew install reattach-to-user-namespace
brew install rsync
brew install ruby-build
brew install source-highlight
brew install the_silver_searcher
brew install tig
brew install tmux
brew install wget
brew install xz
brew install zsh --without-etcdir

brew cleanup