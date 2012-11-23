#!/bin/sh

sudo sh -c '
  apt-get update &&
  apt-get upgrade -y &&
  apt-get install -y python-software-properties build-essential zsh vim curl htop tmux ufw tree exuberant-ctags tig unzip daemontools-run openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion clang
'

curl http://defunkt.io/hub/standalone -sLo ~/bin/hub && chmod +x ~/bin/hub
