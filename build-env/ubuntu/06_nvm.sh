#!/bin/zsh
git clone https://github.com/creationix/nvm.git ~/.nvm
source ~/.nvm/nvm.sh
nvm install 0.11
nvm use 0.11
nvm alias default 0.11
npm install -g jshint
npm install -g bower
