$ErrorActionPreference = "Stop"

$dir = (Get-Item $PSScriptRoot).parent.parent.FullName

New-Item -ItemType SymbolicLink -Force -Path (Join-Path ${Home} .gitconfig) -Target (Join-Path ${dir} .gitconfig -Resolve)
New-Item -ItemType SymbolicLink -Force -Path (Join-Path ${Home} .gitconfig.platform) -Target (Join-Path ${dir} .gitconfig.windows -Resolve)
New-Item -ItemType SymbolicLink -Force -Path (Join-Path ${Home} .gitignore) -Target (Join-Path ${dir} .gitignore.global -Resolve)

New-Item -ItemType Directory -Force -Path (Split-Path $PROFILE.CurrentUserCurrentHost -Parent)

$userProfile = (Join-Path ${dir} user_profile.ps1 -Resolve)
Write-Output ". `"${userProfile}`"" > $PROFILE.CurrentUserCurrentHost

New-Item -ItemType SymbolicLink -Force -Path (Join-Path ${Env:LOCALAPPDATA} nvim) -Target (Join-Path ${dir} nvim -Resolve)
