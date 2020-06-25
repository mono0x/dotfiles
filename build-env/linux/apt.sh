#!/bin/sh
set -e

SUDO=''
if [ $(id -u) -ne 0 ]
then
    SUDO='sudo'
fi

${SUDO} apt-get install -y build-essential
