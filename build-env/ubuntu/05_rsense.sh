#!/bin/sh
cd ~/dotfiles
curl http://cx4a.org/pub/rsense/rsense-0.3.tar.bz2 | tar vzxf -
mv rsense-0.3 rsense
ln -s ~/dotfiles/rsense/etc/rsense.vim ~/dotfiles/.vim/plugin/rsense.vim
