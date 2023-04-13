$ErrorActionPreference = "Stop"

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

if ($env:SKIP_SCOOP -ne "true") {
  if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
  }
  scoop install git
  scoop install chezmoi
}

chezmoi init --apply --verbose mono0x
