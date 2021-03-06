#!/bin/sh
set -eu

SUDO=''
if [ $(id -u) -ne 0 ]
then
  SUDO='sudo'
fi

${SUDO} apt-get install -y \
  build-essential \
  libssl-dev \
  pkg-config
