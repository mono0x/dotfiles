# dotfiles

![test](https://github.com/mono0x/dotfiles/workflows/test/badge.svg)

## Setup

### Windows

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Developer Mode
start ms-settings:developers

# Winget
irm https://raw.githubusercontent.com/mono0x/dotfiles/main/build-env/windows/winget.ps1 | iex
```
