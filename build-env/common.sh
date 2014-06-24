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
ln -s  $dir/.gitignore.global ~/.gitignore
ln -s  $dir/.gvimrc     ~
ln -s  $dir/.tmux.conf  ~
ln -s  $dir/.vim        ~
ln -s  $dir/.vimrc      ~
ln -s  $dir/.zsh        ~
ln -s  $dir/.zshenv     ~
ln -s  $dir/.zshrc      ~
ln -s  $dir/.tigrc      ~

ln -s  $dir/bin         ~

mkdir ~/.vimswap
mkdir ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
