#!/bin/sh
cd $HOME
export CYGWIN=nodosfilewarning
export LC_ALL=$LANG
export PATH=/usr/local/bin:/usr/bin:/usr/sbin:$PATH
export GIT_SSH=~/bin/putty-0.60/plink.exe
export GIT_EDITOR=~/bin/vim/gvim.exe
exec /bin/zsh -i -l
