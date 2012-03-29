#!/bin/bash

bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
source ~/.rvm/scripts/rvm
rvm install 1.9.3
rvm install 1.8.7
rvm 1.9.3 --default

gem install bundler

