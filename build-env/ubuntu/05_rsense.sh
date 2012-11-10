#!/bin/sh
cd ~/dotfiles
curl http://cx4a.org/pub/rsense/rsense-0.3.tar.bz2 | tar jvxf -
mv rsense-0.3 rsense
cd rsense
ruby etc/config.rb > ~/.rsense
