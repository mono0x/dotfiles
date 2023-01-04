$ErrorActionPreference = "Stop"

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
  Invoke-RestMethod get.scoop.sh | Invoke-Expression
}

scoop import https://raw.githubusercontent.com/mono0x/dotfiles/main/scoopfile.json

$dotfiles_dir = Join-Path $env:USERPROFILE dotfiles
if (-not (Test-Path $dotfiles_dir)) {
  git clone https://github.com/mono0x/dotfiles $dotfiles_dir
}
Set-Location $dotfiles_dir

winget import winget.json

& .\build-env\setup.ps1
