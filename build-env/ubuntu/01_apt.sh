#!/bin/sh

apt-get install -y python-software-properties

apt-get update
apt-get upgrade -y

apt-get install -y build-essential zsh git-core vim curl htop tmux ufw tree exuberant-ctags tig unzip
apt-get install -y daemontools-run
apt-get install -y openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion clang postgresql postgresql-server-dev-all
