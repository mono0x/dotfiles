$ErrorActionPreference = "Stop"

$deno = "deno"
if (-not (Get-Command deno -ErrorAction SilentlyContinue)) {
  $env:DENO_INSTALL = "$env:USERPROFILE\.local"
  Invoke-RestMethod https://deno.land/install.ps1 | Invoke-Expression
  $deno = "$env:DENO_INSTALL\bin\deno.exe"
}


$prefix = Split-Path -Parent $PSCommandPath
if (-not (Test-Path "$prefix\install.ts")) {
  $prefix = "https://raw.githubusercontent.com/mono0x/dotfiles/main/"
}

. "$deno" run -A "$prefix/install.ts"
