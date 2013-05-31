#!/bin/bash
RUBY_CONFIGURE_OPTS="--with-readline-dir=`brew --prefix readline` --with-openssl-dir=`brew --prefix openssl`" rbenv install 2.0.0-p195
rbenv global 2.0.0-p195
gem install bundler
rbenv rehash
