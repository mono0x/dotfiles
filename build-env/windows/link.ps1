Set-PSDebug -Trace 1
$PSScriptRoot
$dir = (Get-Item $PSScriptRoot).parent.parent
$dir.FullName
New-Item -ItemType SymbolicLink -Force -Path (Join-Path ${Home} .gitconfig) -Target (Join-Path ${dir} .gitconfig)
New-Item -ItemType SymbolicLink -Force -Path (Join-Path ${Home} .gitconfig.platform) -Target (Join-Path ${dir} .gitconfig.windows)
New-Item -ItemType SymbolicLink -Force -Path (Join-Path ${Home} .gitignore) -Target (Join-Path ${dir} .gitignore.global)
New-Item -ItemType Directory -Force -Path (Join-Path ${Home} AppData\Roaming\Code\User)
New-Item -ItemType SymbolicLink -Force -Path (Join-Path ${Home} AppData\Roaming\Code\User\settings.json) -Target (Join-Path ${dir} vscode\settings.json)
