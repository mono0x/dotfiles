# dotfiles

![CI](https://github.com/mono0x/dotfiles/actions/workflows/ci.yml/badge.svg)

## Setup

```sh
# Setup Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

git clone https://github.com/mono0x/dotfiles ~/.local/share/chezmoi
brew install mise
mise -C ~/.local/share/chezmoi trust
mise -C ~/.local/share/chezmoi bootstrap
```
