#!/bin/sh

dir=$(cd "$(dirname $0)/.."; pwd)

cd "$dir"
git submodule init
git submodule sync --recursive
git submodule update --recursive

rcs='
  .ctags
  .gdbinit
  .gitconfig
  .globalrc
  .gvimrc
  .ideavimrc
  .myclirc
  .npmrc
  .peco
  .pgclirc
  .replyrc
  .source-highlight
  .tigrc
  .tmux.conf
  .vim
  .vimrc
  .wgetrc
  .zsh
  .zshenv
  .zshrc
'
for rc in $rcs; do
  ln -sfn "$dir/$rc" "$HOME/$rc"
done
ln -sfn "$dir/.gitignore.global" "$HOME/.gitignore"

case "${OSTYPE}" in
linux*)
  ln -sfn "$dir/.gitconfig.linux" "$HOME/.gitconfig.platform"
  ;;
darwin*)
  ln -sfn "$dir/.gitconfig.osx" "$HOME/.gitconfig.platform"
  ;;
esac

ln -sfn "$dir/.vim" "$HOME/.config/nvim"
ln -sfn "$dir/.vimrc" "$HOME/.config/nvim/init.vim"

mkdir -p ~/.vimswap
[ -d ~/.vim/dein/repos/github.com/Shougo/dein.vim ] || git clone https://github.com/Shougo/dein.vim ~/.vim/dein/repos/github.com/Shougo/dein.vim

[ -d ~/.asdf ] || git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.2

case "${OSTYPE}" in
linux*)
  code_dir="$HOME/.config/Code/User"
  ;;
darwin*)
  code_dir="$HOME/Library/Application Support/Code/User"
  ;;
esac

mkdir -p "$code_dir"
ln -sfn $dir/vscode/settings.json "$code_dir/settings.json"
