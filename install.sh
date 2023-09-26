#!/bin/sh
set -eu

install_devcontainers() {
  sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --verbose mono0x
}

brew_install() {
  package="$1"

  if ! (brew list "$package" > /dev/null 2>&1)
  then
    echo "Installing $package..." >&2
    brew install "$package"
  else
    echo "$package is already installed." >&2
  fi
}

install_unix() {
  SUDO=''
  if [ "$(id -u)" -ne 0 ]
  then
    SUDO='sudo'
  fi

  if [ "$(uname)" = "Linux" ]
  then
    ${SUDO} apt-get install -y \
      build-essential \
      language-pack-en \
      libssl-dev \
      pkg-config \
      zsh
  fi

  prefix=""
  case "$(uname)" in
  Darwin)
    prefix="/opt/homebrew"
    ;;

  Linux)
    prefix="/home/linuxbrew/.linuxbrew"
    ;;
  esac

  if ! (command -v "$prefix/bin/brew" > /dev/null 2>&1)
  then
    echo "Installing Homebrew..." >&2
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  else
    echo "Homebrew is already installed." >&2
  fi

  set +u
  [ -z "${HOMEBREW_PREFIX}" ] && eval "$($prefix/bin/brew shellenv)"
  set -u

  if [ "$(uname)" = "Darwin" ]
  then
    brew_install zsh
  fi

  brew_install chezmoi
  brew_install sheldon

  echo "Applying dotfiles..." >&2
  chezmoi init --apply --verbose mono0x
}

case "$(uname)" in
Darwin|Linux)
  ;;
*)
  echo "Only Darwin or Linux is supported." >&2
  return 1
  ;;
esac

if ! (command -v git > /dev/null 2>&1)
then
  echo "git not found." >&2
  return 1
fi

if [ "${REMOTE_CONTAINERS:-}" = "true" ]
then
  echo "Running in a remote container." >&2
  install_devcontainers
  return 0
fi

install_unix
