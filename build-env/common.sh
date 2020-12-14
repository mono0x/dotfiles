#!/bin/sh
set -e

os=$(uname)

dir="$(cd "$(dirname "$0")/.."; pwd)"

cd "$dir"

git submodule init
git submodule sync --recursive
git submodule update --recursive

rcs='
  .asdfrc
  .gitconfig
  .gvimrc
  .ideavimrc
  .npmrc
  .peco
  .source-highlight
  .tigrc
  .tmux.conf
  .vim
  .vimrc
  .zshenv
  .zshrc
'
for rc in $rcs; do
  ln -sfn "$dir/$rc" "$HOME/$rc"
done
ln -sfn "$dir/.gitignore.global" "$HOME/.gitignore"

case "$os" in
Linux)
  ln -sfn "$dir/.gitconfig.linux" "$HOME/.gitconfig.platform"
  ;;
Darwin)
  ln -sfn "$dir/.gitconfig.macos" "$HOME/.gitconfig.platform"
  ln -sfn /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight
  ;;
esac

mkdir -p "$HOME/.config"

mkdir -p ~/.vimswap
[ -d ~/.vim/dein/repos/github.com/Shougo/dein.vim ] || git clone https://github.com/Shougo/dein.vim ~/.vim/dein/repos/github.com/Shougo/dein.vim

#[ -d ~/.asdf ] || git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.8

[ -d ~/.zinit ] || (mkdir -p "$HOME/.zinit" && git clone https://github.com/zdharma/zinit.git ~/.zinit/bin)
