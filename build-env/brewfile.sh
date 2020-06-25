#!/bin/sh
set -e

brew update
brew upgrade

case "${OSTYPE}" in
darwin*)
  brew install autoconf
  brew install automake
  brew install cmake
  brew install coreutils
  brew install curl
  brew install exiftool
  brew install findutils
  brew install gpg
  brew install gnu-sed
  brew install grep
  brew install gzip
  brew install hub
  brew install mas
  brew install rsync
  brew install unzip
  brew install wget
  ;;
esac

brew install colordiff
brew install editorconfig
brew install ghq
brew install git
brew install htop
brew install jq
brew install mercurial
brew install peco
brew install source-highlight
brew install the_silver_searcher
brew install tig
brew install tmux
brew install xz
brew install zsh

brew cleanup
