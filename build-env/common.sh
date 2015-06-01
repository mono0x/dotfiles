#!/bin/sh

git submodule update --init

dir=$(cd $(dirname $0)/.. && pwd)

ln -s  $dir/.gdbinit    ~
ln -fs $dir/.gitconfig  ~
case "${OSTYPE}" in
linux*)
  ln -fs $dir/.gitconfig.linux ~/.gitconfig.platform
  ;;
darwin*)
  ln -fs $dir/.gitconfig.osx ~/.gitconfig.platform
  ;;
esac
ln -sf  $dir/.gitignore.global ~/.gitignore
ln -sf  $dir/.globalrc   ~
ln -sf  $dir/.gvimrc     ~
ln -sf  $dir/.peco       ~
ln -sf  $dir/.replyrc    ~
ln -sf  $dir/.tmux.conf  ~
ln -sf  $dir/.vim        ~
ln -sf  $dir/.vimrc      ~
ln -sf  $dir/.zsh        ~
ln -sf  $dir/.zshenv     ~
ln -sf  $dir/.zshrc      ~
ln -sf  $dir/.tigrc      ~
ln -sf  $dir/.ideavimrc  ~

mkdir ~/.vimswap
mkdir ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
