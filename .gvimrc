
" font settings
if has("win32")
  set guifont=Consolas:h10
  set guifont=MeiryoKe_Gothic:h10:cSHIFTJIS
elseif has("mac")
  set guifont=Menlo:h13
endif

let g:molokai_original = 1
colorscheme molokai

augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#455354 guibg=fg 
augroup END

set lines=35
set columns=100

set guioptions-=T

set guitablabel=[%n]%t\ %m

