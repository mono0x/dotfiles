#!/bin/sh

git submodule update --init

dir=$(cd $(dirname $0)/.. && pwd)

ln -s  $dir/.gdbinit    ~
ln -fs $dir/.gitconfig  ~
case "${OSTYPE}" in
linux*)
  ln -fs $dir/.gitconfig.linux ~/.gitconfig.local
  ;;
darwin*)
  ln -fs $dir/.gitconfig.osx ~/.gitconfig.local
  ;;
esac
ln -sf  $dir/.gitignore.global ~/.gitignore
ln -sf  $dir/.gvimrc     ~
ln -sf  $dir/.tmux.conf  ~
ln -sf  $dir/.vim        ~
ln -sf  $dir/.vimrc      ~
ln -sf  $dir/.zsh        ~
ln -sf  $dir/.zshenv     ~
ln -sf  $dir/.zshrc      ~
ln -sf  $dir/.tigrc      ~

mkdir ~/.vimswap
mkdir ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
