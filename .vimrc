
set nocompatible

set t_Co=256
syntax enable

let g:molokai_original = 1
"colorscheme molokai
let g:guicolorscheme_color_table = {'bg' : 'Black', 'fg' : 'Grey'}
if !has("gui_running")
  au VimEnter * GuiColorScheme molokai
endif

" Status line
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#455354 guibg=fg 
augroup END

if has("win32")
  source ~/vimfiles/pathogen/autoload/pathogen.vim
else
  source ~/.vim/pathogen/autoload/pathogen.vim
endif
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype on
filetype indent on
filetype plugin on

if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  unlet s:enc_euc
  unlet s:enc_jis
endif
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
set fileformats=unix,dos,mac

if exists('&ambiwidth')
  set ambiwidth=double
endif

set nobackup
set nowritebackup
if has("win32")
  set directory=~/vimswap
else
  set directory=~/.vimswap
endif
set history=100

set autoindent
set tabstop=2
set shiftwidth=2
set expandtab

set incsearch
set hlsearch
set ignorecase
set smartcase

noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap <Down> gj
noremap <Up> gk

set statusline=%<[%n]%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%=%l,%c%V%8P

set laststatus=2

set showcmd

set cursorline

set whichwrap=b,s,h,l,<,>,[,]

set virtualedit+=block

set wildmenu

set showmatch

set showmode

set number

set hidden

set list
set listchars=tab:>\ ,extends:>,precedes:<

" neocomplcache
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_smart_case=1
let g:neocomplcache_enable_camel_case_completion=1
let g:neocomplcache_enable_underbar_completion=1
let g:neocomplcache_min_keyword_length=3
let g:neocomplcache_same_filetype_lists={}
let g:neocomplcache_same_filetype_lists['c']='cpp'
let g:neocomplcache_same_filetype_lists['cpp']='c'
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

" unite
let g:unite_enable_start_insert=1
nnoremap <silent> <C-f> :<C-u>UniteWithCurrentDir -buffer-name=files file_mru bookmark file<CR>
nnoremap [unite] <Nop>
nmap <C-u> [unite]
nnoremap <silent> [unite]h :<C-u>Unite -buffer-name=help help<CR>
nnoremap <silent> [unite]o :<C-u>Unite -buffer-name=outline outline<CR>

nnoremap <C-w><C-w> :<C-u>Unite -buffer-name=files buffer<CR>
nnoremap <C-w>n :bn<CR>
nnoremap <C-w>p :bp<CR>
nnoremap <C-w>d :bd<CR>
nnoremap <C-w>h <C-w>h:call <SID>good_width()<Cr>
nnoremap <C-w>l <C-w>l:call <SID>good_width()<Cr>
nnoremap <C-w>H <C-w>H:call <SID>good_width()<Cr>
nnoremap <C-w>L <C-w>L:call <SID>good_width()<Cr>
function! s:good_width()
  if winwidth(0) < 84
    vertical resize 84
  endif
endfunction

if has('clipboard')
  set clipboard=unnamed
  nnoremap y "+y
  nnoremap p "+p
  vnoremap y "+y
  vnoremap p "+p
endif

imap <C-d> <Delete>
imap <C-f> <Right>
imap <C-b> <Left>

" IME
set iminsert=0
set imsearch=0
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" Command-window
nnoremap <sid>(command-line-enter) q:
xnoremap <sid>(command-line-enter) q:
nnoremap <sid>(command-line-norange) q:<C-u>

nmap :  <sid>(command-line-enter)
xmap :  <sid>(command-line-enter)

autocmd CmdwinEnter * call s:init_cmdwin()
function! s:init_cmdwin()
  nnoremap <buffer> q :<C-u>quit<CR>
  nnoremap <buffer> <TAB> :<C-u>quit<CR>
  inoremap <buffer><expr><CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
  inoremap <buffer><expr><C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
  inoremap <buffer><expr><BS> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"

  " Completion.
  inoremap <buffer><expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

  startinsert!
endfunction

" Gtags
map <C-g> :Gtags 
map <C-i> :Gtags -f %<CR>
map <C-j> :GtagsCursor<CR>

" template
if has("win32")
  au BufNewFile *.rb 0r ~/vimfiles/template/template.rb
  au BufNewFile *.html,*.rhtml 0r ~/vimfiles/template/template.html
else
  au BufNewFile *.rb 0r ~/.vim/template/template.rb
  au BufNewFile *.html,*.rhtml 0r ~/.vim/template/template.html
endif

" Automatic `:!chmod +x %`.
" https://gist.github.com/791189
autocmd vimrc BufWritePost *
\     if getline(1) =~# '^#!'
\   |   !chmod +x %
\   | endif

