# dotfiles

![test](https://github.com/mono0x/dotfiles/workflows/test/badge.svg)

## Setup

### Darwin / Ubuntu

```sh
# Ubuntu
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y unzip

git clone https://github.com/mono0x/dotfiles ~/.local/share/chezmoi
~/.local/share/chezmoi/install.sh

chsh -s /opt/homebrew/bin/zsh # Darwin
chsh -s /usr/bin/zsh # Ubuntu
```

### Windows

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod https://raw.githubusercontent.com/mono0x/dotfiles/main/install.ps1 | Invoke-Expression
```

### Devcontainers

Add the following settings to the `settings.json`.

```json
{
  "dotfiles.repository": "mono0x/dotfiles",
  "dotfiles.targetPath": "~/.local/share/chezmoi",
  "dotfiles.installCommand": "~/.local/share/chezmoi/install.sh"
}
```
