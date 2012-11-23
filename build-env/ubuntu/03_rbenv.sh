#!/bin/bash

git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
mkdir -p ~/.rbenv/plugins
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv install 1.8.7-p370
rbenv install 1.9.3-p286

rbenv global 1.9.3-p286

gem install bundler
