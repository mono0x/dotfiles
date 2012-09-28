#!/bin/zsh
git clone https://github.com/creationix/nvm.git ~/.nvm
source ~/.nvm/nvm.sh
nvm install v0.8.11
nvm use v0.8.11
npm install -g jshint
