#!/bin/sh
set -e

brew update
brew upgrade

brew install ansible
brew install cmigemo
brew install coreutils
brew install exiftool
brew install findutils
brew install fswatch
brew install git --with-pcre
brew install global --with-exuberant-ctags --with-pygments --with-sqlite3
brew install go --cross-compile-common
brew install homebrew/dupes/grep
brew install htop-osx
brew install lua
brew install luajit
brew install mercurial
brew install nginx
brew install node --without-npm
brew install openssl
brew install peco/peco/peco
brew install postgresql
brew install rbenv
brew install readline
brew install reattach-to-user-namespace
brew install ruby-build
brew install source-highlight
brew install the_silver_searcher
brew install tig
brew install tmux
brew install wget
brew install xz
brew install zsh --without-etcdir

brew install caskroom/cask/brew-cask
brew tap caskroom/versions

brew cask install appcleaner
brew cask install dropbox
#brew cask install firefox-ja
brew cask install google-chrome
brew cask install google-japanese-ime
brew cask install heroku-toolbelt
#brew cask install macvim-kaoriya
brew cask install 1password
#brew cask install vagrant
#brew cask install virtualbox
#brew cask install vmware-fusion

brew cask cleanup
brew cleanup
