#!/bin/sh
cd $HOME
export CYGWIN=nodosfilewarning
export LC_ALL=$LANG
export PATH=/usr/local/bin:/usr/bin:/usr/sbin:$PATH
exec /bin/zsh
