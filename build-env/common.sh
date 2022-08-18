#!/bin/sh
set -e

os=$(uname)

dotfiles_root="$(cd "$(dirname "$0")/.."; pwd)"

mkdir -p "$HOME/bin"
mkdir -p "$HOME/.config"

cd "$dotfiles_root"

git submodule init
git submodule sync --recursive
git submodule update --recursive

rcs='
  .asdfrc
  .gitconfig
  .ideavimrc
  .npmrc
  .peco
  .source-highlight
  .tigrc
  .tmux.conf
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
      ln -sfn "$path" "$HOME/bin/diff-highlight"
      break
    fi
  done
  ;;
esac

ln -sfn "$dotfiles_root/nvim" "$HOME/.config/nvim"

[ -d ~/.asdf ] || git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0

[ -d ~/.zinit ] || (mkdir -p "$HOME/.zinit" && git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin)
