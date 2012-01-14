
" font settings
if has("win32")
  set guifont=Consolas:h10
  set guifont=MeiryoKe_Gothic:h10:cSHIFTJIS
elseif has("mac")
  set guifont=Menlo:h13
endif

let g:molokai_original = 1
colorscheme molokai

set lines=35
set columns=100

set guioptions-=T

set guitablabel=[%n]%t\ %m

