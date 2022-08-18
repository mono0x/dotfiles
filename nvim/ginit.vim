augroup gvimrc_loading
  autocmd!
augroup END

" font settings
if has("win32") 
  set guifont=Consolas:h12
  set guifontwide=MeiryoKe_Console:h12
elseif has("mac")
  set guifont=Ricty:h13
endif

if dein#tap('vim-colors-solarized')
  set background=light
  colorscheme solarized
endif

set lines=35
set columns=100

set guioptions-=T

set guitablabel=[%n]%t\ %m
