$ErrorActionPreference = "Stop"

Set-Location (Split-Path -Parent $PSCommandPath)

$env:DENO_INSTALL = "$env:USERPROFILE\.local"
if (-not (Test-Path "$env:DENO_INSTALL\bin\deno.exe")) {
  New-Item -ItemType Directory -Force -Path $env:DENO_INSTALL
  Invoke-RestMethod https://deno.land/install.ps1 | Invoke-Expression
}

$prefix = $env:GITHUB_ACTIONS -eq "true" `
  ?  "." `
  : "https://raw.githubusercontent.com/mono0x/dotfiles/main/"

. "$env:DENO_INSTALL\bin\deno.exe" run -A --config "$prefix/deno.jsonc" --lock "$prefix/deno.lock" "$prefix/install/main.ts"
