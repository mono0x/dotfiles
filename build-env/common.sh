#!/bin/sh

dir=$(cd $(dirname $0)/.. && pwd)

cd $dir
git submodule init
git submodule sync --recursive
git submodule update --recursive

rcs='
  .ctags
  .gdbinit
  .gitconfig
  .gitignore.global
  .globalrc
  .gvimrc
  .myclirc
  .npmrc
  .peco
  .pgclirc
  .replyrc
  .source-highlight
  .tmux.conf
  .vim
  .vimrc
  .wgetrc
  .zsh
  .zshenv
  .zshrc
  .tigrc
  .ideavimrc
'
for rc in $rcs; do
  ln -sf $dir/$rc ~
done
ln -sf $dir/.gitignore.global ~/.gitignore

case "${OSTYPE}" in
linux*)
  ln -sf $dir/.gitconfig.linux ~/.gitconfig.platform
  ;;
darwin*)
  ln -sf $dir/.gitconfig.osx ~/.gitconfig.platform
  ;;
esac

mkdir -p ~/.vimswap
[ -d ~/.vim/dein/repos/github.com/Shougo/dein.vim ] || git clone https://github.com/Shougo/dein.vim ~/.vim/dein/repos/github.com/Shougo/dein.vim
