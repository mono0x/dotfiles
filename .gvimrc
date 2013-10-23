
" font settings
if has("win32")
  set guifont=Ricty:h12
elseif has("mac")
  set guifont=Menlo:h13
else
  set guifont=Ricty\ 12
endif

if neobundle#is_installed('vim-colors-solarized')
  set background=light
  colorscheme solarized
endif

" Highlight trailing spaces
highlight TrailingSpaces guibg=red ctermbg=red
match TrailingSpaces /\s\+$/
autocmd WinEnter * match TrailingSpaces /\s\+$/

set lines=35
set columns=100

set guioptions-=T

set guitablabel=[%n]%t\ %m

