#!/bin/sh

git submodule update --init

ln -s  $PWD/.gdbinit    ~
ln -fs $PWD/.gitconfig  ~
case "${OSTYPE}" in
linux*)
  ln -fs $PWD/.gitconfig.linux ~/.gitconfig.local
  ;;
darwin*)
  ln -fs $PWD/.gitconfig.osx ~/.gitconfig.local
  ;;
esac
ln -s  $PWD/.gitignore.global ~/.gitignore
ln -s  $PWD/.gvimrc     ~
ln -s  $PWD/.tmux.conf  ~
ln -s  $PWD/.vim        ~
ln -s  $PWD/.vimrc      ~
ln -s  $PWD/.zsh        ~
ln -s  $PWD/.zshenv     ~
ln -s  $PWD/.zshrc      ~
ln -s  $PWD/.tigrc      ~

mkdir ~/bin
mkdir ~/.vimswap
mkdir ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
