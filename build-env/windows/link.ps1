dir = "${PSScriptRoot}\..\.."
New-Item -ItemType SymbolicLink -Force -Path ${Home}\.gitconfig -Target "${dir}\.gitconfig"
New-Item -ItemType SymbolicLink -Force -Path ${Home}\.gitconfig.platform -Target "${dir}\.gitconfig.windows"
New-Item -ItemType SymbolicLink -Force -Path ${Home}\.gitignore -Target "${dir}\.gitignore.global"
New-Item -ItemType Directory -Force -Path ${Home}\AppData\Roaming\Code\User
New-Item -ItemType SymbolicLink -Force -Path ${Home}\AppData\Roaming\Code\User\settings.json -Target "${dir}\vscode\settings.json"
