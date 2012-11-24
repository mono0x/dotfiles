
" font settings
if has("win32")
  set guifont=Consolas:h10
elseif has("mac")
  set guifont=Menlo:h13
endif

if neobundle#is_installed('molokai')
  let g:molokai_original = 1
  colorscheme molokai
endif

" Highlight trailing spaces
highlight TrailingSpaces guibg=red ctermbg=red
match TrailingSpaces /\s\+$/
autocmd WinEnter * match TrailingSpaces /\s\+$/

set lines=35
set columns=100

set guioptions-=T

set guitablabel=[%n]%t\ %m

