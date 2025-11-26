#!/usr/bin/env zsh
# rm -f ~/.zshenv.zwc ~/.config/zsh/.*.zwc ~/.config/zsh/**/*.zwc ~/.local/share/sheldon/**/*.zwc
for file in \
  ~/.zshenv ~/.config/zsh/.zprofile ~/.config/zsh/.zshrc \
  $(find ~/.config/zsh ~/.local/share/sheldon -type f -name '*.zsh' 2>/dev/null) \
  $(find ~/.config/zsh/functions -type f -name '_*' ! -name '*.zwc' 2>/dev/null)
do
  echo "zcompile $file"
  zcompile "$file"
done
