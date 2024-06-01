$ErrorActionPreference = "Stop"

# https://stackoverflow.com/questions/34559553/create-a-temporary-directory-in-powershell
function New-TemporaryDirectory {
  $parent = [System.IO.Path]::GetTempPath()
  $name = [System.IO.Path]::GetRandomFileName()
  New-Item -ItemType Directory -Path (Join-Path $parent $name)
}

$env:DENO_INSTALL = "$env:USERPROFILE\.local"
if (-not (Test-Path "$env:DENO_INSTALL\bin\deno.exe")) {
  New-Item -ItemType Directory -Force -Path $env:DENO_INSTALL
  Invoke-RestMethod https://deno.land/install.ps1 | Invoke-Expression
}

$prefix = Split-Path -Parent $PSCommandPath
if (-not (Test-Path "$prefix\install\main.ts")) {
  $dir = New-TemporaryDirectory
  New-Item -ItemType Directory -Force -Path "$dir\install"
  foreach ($file in "install/main.ts", "deno.jsonc", "deno.lock") {
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mono0x/dotfiles/main/$file" -OutFile "$dir\$file"
  }
  $prefix = $dir
}

. "$env:DENO_INSTALL\bin\deno.exe" run -A --config "$prefix/deno.jsonc" --lock "$prefix/deno.lock" "$prefix/install/main.ts"
