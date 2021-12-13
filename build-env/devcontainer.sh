#!/bin/sh
set -e

mv $HOME/.bashrc $HOME/.bashrc.default

dotfiles_root="$(cd "$(dirname "$0")/.."; pwd)"

cd "$dotfiles_root"

rcs='
  .bashrc
  .gitconfig
'
for rc in $rcs; do
  ln -sfn "$dotfiles_root/$rc" "$HOME/$rc"
done
ln -sfn "$dotfiles_root/.gitignore.global" "$HOME/.gitignore"
ln -sfn "$dotfiles_root/.gitconfig.linux" "$HOME/.gitconfig.platform"
