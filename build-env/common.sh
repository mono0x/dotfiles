#!/bin/sh
set -e

os=$(uname)

dotfiles_root="$(cd "$(dirname "$0")/.."; pwd)"

cd "$dotfiles_root"

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
  ln -sfn "$dotfiles_root/$rc" "$HOME/$rc"
done
ln -sfn "$dotfiles_root/.gitignore.global" "$HOME/.gitignore"

case "$os" in
Linux)
  ln -sfn "$dotfiles_root/.gitconfig.linux" "$HOME/.gitconfig.platform"
  ;;
Darwin)
  ln -sfn "$dotfiles_root/.gitconfig.macos" "$HOME/.gitconfig.platform"
  for path in /opt/homebrew/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/share/git-core/contrib/diff-highlight/diff-highlight
  do
    if [ -f "$path" ]
    then
      ln -sfn "$path" "$dotfiles_root/bin/diff-highlight"
      break
    fi
  done
  ;;
esac

mkdir -p "$HOME/.config"

mkdir -p ~/.vimswap
[ -d ~/.vim/dein/repos/github.com/Shougo/dein.vim ] || git clone https://github.com/Shougo/dein.vim ~/.vim/dein/repos/github.com/Shougo/dein.vim

[ -d ~/.asdf ] || git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0

[ -d ~/.zinit ] || (mkdir -p "$HOME/.zinit" && git clone https://github.com/zdharma/zinit.git ~/.zinit/bin)
