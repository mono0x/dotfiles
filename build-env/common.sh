#!/bin/sh

dir=$(cd $(dirname $0)/.. && pwd)

cd $dir
git submodule init
git submodule sync
git submodule update

rcs='
  .ctags
  .gdbinit
  .gitconfig
  .gitignore.global
  .globalrc
  .gvimrc
  .myclirc
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
[ -d ~/.vim/bundle/neobundle.vim ] || git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
