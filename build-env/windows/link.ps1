New-Item -ItemType SymbolicLink -Force -Path ${Home}\.gitconfig -Target ${Home}\dotfiles\.gitconfig
New-Item -ItemType SymbolicLink -Force -Path ${Home}\.gitconfig.platform -Target ${Home}\dotfiles\.gitconfig.windows
New-Item -ItemType SymbolicLink -Force -Path ${Home}\.gitignore -Target ${Home}\dotfiles\.gitignore.global
New-Item -ItemType SymbolicLink -Force -Path ${Home}\AppData\Roaming\Code\User\settings.json -Target ${Home}\dotfiles\vscode\settings.json
