#!/bin/sh

apt-get install -y python-software-properties

add-apt-repository ppa:nginx/stable

apt-get update
apt-get upgrade -y

apt-get install -y build-essential zsh git-core vim curl htop tmux ufw tree exuberant-ctags
apt-get install -y daemontools-run
apt-get install -y bison openssl libreadline6 libreadline6-dev zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev

apt-get install -y nginx-full


