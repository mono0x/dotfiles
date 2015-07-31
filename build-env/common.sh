#!/bin/sh

dir=$(cd $(dirname $0)/.. && pwd)

cd $dir
git submodule init
git submodule sync
git submodule update

ln -sf $dir/.ctags            ~
ln -sf $dir/.gdbinit          ~
ln -sf $dir/.gitconfig        ~
ln -sf $dir/.gitignore.global ~/.gitignore
ln -sf $dir/.globalrc         ~
ln -sf $dir/.gvimrc           ~
ln -sf $dir/.myclirc          ~
ln -sf $dir/.peco             ~
ln -sf $dir/.replyrc          ~
ln -sf $dir/.source-highlight ~
ln -sf $dir/.tmux.conf        ~
ln -sf $dir/.vim              ~
ln -sf $dir/.vimrc            ~
ln -sf $dir/.wgetrc           ~
ln -sf $dir/.zsh              ~
ln -sf $dir/.zshenv           ~
ln -sf $dir/.zshrc            ~
ln -sf $dir/.tigrc            ~
ln -sf $dir/.ideavimrc        ~
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
