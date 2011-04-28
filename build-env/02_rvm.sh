#!/bin/bash

bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)
source ~/.rvm/scripts/rvm
rvm install 1.9.2
rvm 1.9.2 --default

gem install bundler

