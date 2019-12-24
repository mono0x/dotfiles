#!/bin/sh
defaults write com.apple.HIToolbox AppleGlobalTextInputProperties -dict TextInputGlobalPropertyPerContextInput 1
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
