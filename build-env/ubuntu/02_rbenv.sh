#!/bin/bash

git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
mkdir -p ~/.rbenv/plugins
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv install 1.9.3-p194

rbenv global 1.9.3-p194

gem install bundler
