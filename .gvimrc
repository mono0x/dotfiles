augroup gvimrc_loading
  autocmd!
augroup END

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
highlight TrailingSpaces guibg=red

set lines=35
set columns=100

set guioptions-=T

set guitablabel=[%n]%t\ %m

" window transparency
if has('win32') || has('win64') || has('mac')
  autocmd gvimrc_loading FocusLost * set transparency=192
  autocmd gvimrc_loading FocusGained * set transparency=240
  autocmd gvimrc_loading GuiEnter * set transparency=240
endif
