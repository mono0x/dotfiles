#!/bin/bash

git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
mkdir -p ~/.rbenv/plugins
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv install 1.8.7-p371
rbenv install 2.0.0-p195

rbenv global 2.0.0-p195

gem install bundler
