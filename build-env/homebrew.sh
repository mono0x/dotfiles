#!/bin/sh
[ ! -f /usr/local/bin/brew -a ! -f /home/linuxbrew/.linuxbrew/bin/brew ] && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
