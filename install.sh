#!/bin/sh
set -eu

install_devcontainers() {
  sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --verbose mono0x
}

install_unix() {
  SUDO=''
  if [ "$(id -u)" -ne 0 ]
  then
    SUDO='sudo'
  fi

  case "$(uname)" in
  Linux)
    ${SUDO} apt-get install -y \
      build-essential \
      libssl-dev \
      pkg-config
    ;;
  esac

  if ! (command -v brew > /dev/null 2>&1)
  then
    echo "Installing Homebrew..." >&2
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    case "$(uname)" in
    Darwin)
      eval "$(/opt/homebrew/bin/brew shellenv)"
      ;;
    Linux)
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
      ;;
    esac
  else
    echo "Homebrew is already installed." >&2
  fi

  for package in chezmoi zsh
  do
    if ! (brew list "$package" > /dev/null 2>&1)
    then
      echo "Installing $package..." >&2
      brew install "$package"
    else
      echo "$package is already installed." >&2
    fi
  done

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
