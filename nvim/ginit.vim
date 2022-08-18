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

if dein#tap('solarized.nvim')
  set background=light
  colorscheme solarized
endif

" Highlight trailing spaces
highlight TrailingSpaces guibg=red

set lines=35
set columns=100

set guioptions-=T

set guitablabel=[%n]%t\ %m

" window transparency
if has('gui_win32') || has('gui_win64')
  autocmd gvimrc_loading FocusLost * set transparency=192
  autocmd gvimrc_loading FocusGained * set transparency=255
elseif has('gui_macvim')
  autocmd gvimrc_loading FocusLost * set transparency=25
  autocmd gvimrc_loading FocusGained * set transparency=0
endif
