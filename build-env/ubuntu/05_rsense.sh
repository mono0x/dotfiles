#!/bin/sh
cd ~/dotfiles
curl http://cx4a.org/pub/rsense/rsense-0.3.tar.bz2 | tar jvxf -
mv rsense-0.3 rsense
ln -s ~/dotfiles/rsense/etc/rsense.vim ~/dotfiles/.vim/plugin/rsense.vim
cd rsense
ruby etc/config.rb > ~/.rsense