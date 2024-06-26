# dotfiles

![test](https://github.com/mono0x/dotfiles/workflows/test/badge.svg)

## Setup

### Darwin / Ubuntu

```sh
# Ubuntu
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y unzip

# Common
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mono0x/dotfiles/main/install.sh)"

# Ubuntu
chsh -s /usr/bin/zsh

# Darwin
sudo vi /etc/shells
# Append /opt/homebrew/bin/zsh
chsh -s /opt/homebrew/bin/zsh
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
