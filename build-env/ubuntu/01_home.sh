#!/bin/sh

ln -s ~/dotfiles/.gitconfig  ~
ln -s ~/dotfiles/.gvimrc     ~
ln -s ~/dotfiles/.tmux.conf  ~
ln -s ~/dotfiles/.vim        ~
ln -s ~/dotfiles/.vimrc      ~
ln -s ~/dotfiles/.zsh        ~
ln -s ~/dotfiles/.zshenv     ~
ln -s ~/dotfiles/.zshrc      ~

mkdir ~/bin
mkdir ~/.vimswap
mkdir ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim