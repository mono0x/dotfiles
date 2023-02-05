$ErrorActionPreference = "Stop"

$root = (Get-Item $PSScriptRoot).parent.FullName
$conf = Join-Path ${root} conf

New-Item -ItemType SymbolicLink -Force -Path (Join-Path ${Home} .gitconfig) -Target (Join-Path ${conf} .gitconfig -Resolve)
New-Item -ItemType SymbolicLink -Force -Path (Join-Path ${Home} .gitconfig.platform) -Target (Join-Path ${conf} .gitconfig.windows -Resolve)
New-Item -ItemType SymbolicLink -Force -Path (Join-Path ${Home} .gitignore) -Target (Join-Path ${conf} .gitignore.global -Resolve)

New-Item -ItemType Directory -Force -Path (Split-Path $PROFILE.CurrentUserCurrentHost -Parent)

$userProfile = (Join-Path ${root} user_profile.ps1 -Resolve)
Write-Output ". `"${userProfile}`"" > $PROFILE.CurrentUserCurrentHost

New-Item -ItemType SymbolicLink -Force -Path (Join-Path ${Env:LOCALAPPDATA} nvim) -Target (Join-Path ${conf} nvim -Resolve)

New-Item -ItemType SymbolicLink -Force -Path (Join-Path ${Home} .wezterm.lua) -Target (Join-Path ${conf} .wezterm.lua -Resolve)

New-Item -ItemType Directory -Force -Path (Join-Path ${Home} .config)
New-Item -ItemType SymbolicLink -Force -Path (Join-Path ${Home} .config starship.toml) -Target (Join-Path ${conf} .config starship.toml -Resolve)
