#!/bin/sh

dir=$(cd "$(dirname $0)/.."; pwd)

cd "$dir"
git submodule init
git submodule sync --recursive
git submodule update --recursive

rcs='
  .asdfrc
  .ctags
  .gdbinit
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

case "${OSTYPE}" in
linux*)
  ln -sfn "$dir/.gitconfig.linux" "$HOME/.gitconfig.platform"
  ;;
darwin*)
  ln -sfn "$dir/.gitconfig.macos" "$HOME/.gitconfig.platform"
  ln -sfn /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight
  ;;
esac

mkdir -p $HOME/.config

ln -sfn "$dir/.vim" "$HOME/.config/nvim"
ln -sfn "$dir/.vimrc" "$HOME/.config/nvim/init.vim"

mkdir -p ~/.vimswap
[ -d ~/.vim/dein/repos/github.com/Shougo/dein.vim ] || git clone https://github.com/Shougo/dein.vim ~/.vim/dein/repos/github.com/Shougo/dein.vim

[ -d ~/.asdf ] || git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.2

[ -d ~/.zplugin ] || (mkdir ~/.zplugin && git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin)

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
