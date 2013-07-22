#!/bin/bash

git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
mkdir -p ~/.rbenv/plugins
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init - bash)"

rbenv install 2.0.0-p247
rbenv global 2.0.0-p247

gem install bundler
