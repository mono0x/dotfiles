#!/bin/sh
brew update
brew upgrade

brew install ansible
brew install exiftool
brew install git
brew install go --cross-compile-common
brew install gzip
brew install htop-osx
brew install nginx
brew install openssl
brew install peco/peco/peco
brew install postgresql
brew install rbenv
brew install readline
brew install ruby-build
brew install the_silver_searcher
brew install tig
brew install tmux
brew install wget
brew install xz
brew install zsh

brew install caskroom/cask/brew-cask
brew tap caskroom/versions

brew cask install appcleaner
brew cask install bittorrent-sync
brew cask install boot2docker
brew cask install dropbox
brew cask install firefox-ja
brew cask install google-chrome
brew cask install google-japanese-ime
brew cask install heroku-toolbelt
#brew cask install macvim-kaoriya
brew cask install mendeley-desktop
brew cask install onepassword
brew cask install skype
brew cask install vagrant
brew cask install virtualbox
#brew cask install vmware-fusion

brew cask cleanup
brew cleanup
