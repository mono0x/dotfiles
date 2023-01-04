$ErrorActionPreference = "Stop"

if ($env:SKIP_PACKAGE_INSTALLATION -eq $null) {
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
  if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
  }

  scoop install git
}

$dotfiles_dir = Join-Path $env:USERPROFILE dotfiles
if (-not (Test-Path $dotfiles_dir)) {
  git clone https://github.com/mono0x/dotfiles $dotfiles_dir
}
Set-Location $dotfiles_dir

if ($env:SKIP_PACKAGE_INSTALLATION -eq $null) {
  scoop import https://raw.githubusercontent.com/mono0x/dotfiles/main/scoopfile.json
  winget import winget.json
}

& .\build-env\setup.ps1
