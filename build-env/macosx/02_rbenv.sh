#!/bin/bash
RUBY_CONFIGURE_OPTS="--with-readline-dir=`brew --prefix readline` --with-openssl-dir=`brew --prefix openssl`" rbenv install 2.0.0-p0
gem install bundler --pre
rbenv rehash
