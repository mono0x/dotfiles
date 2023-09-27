#!/bin/sh

cd "${CHEZMOI_SOURCE_DIR:-$(dirname $0)}/.."

prefix=""
case "$(uname)" in
  Darwin)
    prefix="/opt/homebrew"
  ;;

  Linux)
    prefix="/home/linuxbrew/.linuxbrew"
  ;;
esac

"$prefix/bin/brew" bundle --no-upgrade
