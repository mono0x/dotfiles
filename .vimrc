
set nocompatible
filetype off

if has('win32')
  set rtp+=$HOME/.vim,$HOME/.vim/after
endif

if has('vim_starting')
  set rtp+=$HOME/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
NeoBundle 'Shougo/neobundle.vim'

NeoBundle 'sudo.vim'

NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'sgur/unite-git_grep'
NeoBundle 'Shougo/vimproc', {
  \   'build': {
  \     'windows': 'echo "Sorry, cannot update vimproc binary file in Windows."',
  \     'mac': 'make -f make_mac.mak',
  \     'unix': 'make -f make_unix.mak',
  \   },
  \ }
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Rip-Rip/clang_complete'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/echodoc'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'othree/html5.vim'
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'bdd/vim-scala'
NeoBundle 'hallison/vim-markdown'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'sophacles/vim-processing'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'thinca/vim-template'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/mkdpreview-vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'chikatoike/activefix.vim'
NeoBundle 'kana/vim-tabpagecd'
NeoBundle 'thinca/vim-ref'
NeoBundle 'taka84u9/vim-ref-ri'
NeoBundle 'thinca/vim-visualstar'
NeoBundle 'tpope/vim-surround'
NeoBundle 'bkad/CamelCaseMotion'
NeoBundle 'evanmiller/nginx-vim-syntax'
NeoBundle 'thinca/vim-poslist'

NeoBundle 'mono0x/molokai'

set t_Co=256
syntax enable

filetype plugin indent on

let g:molokai_original = 1
colorscheme molokai

if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
endif

" leader
let mapleader = ' '

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#34352D ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#43443A ctermbg=239

" Highlight trailing spaces
highlight TrailingSpaces guibg=red ctermbg=red
match TrailingSpaces /\s\+$/
autocmd WinEnter * match TrailingSpaces /\s\+$/

set encoding=utf-8
if has('win32')
  set termencoding=cp932
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
set directory=~/.vimswap//
set history=100

set notagbsearch

set autoindent
set tabstop=2
set shiftwidth=2
set expandtab

set incsearch
set hlsearch
set ignorecase
set smartcase
noremap <ESC><ESC> :nohlsearch<CR>

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

" RSense
let g:rsenseHome=$RSENSE_HOME
let g:rsenseUseOmniFunc=1

" clang_complete
let g:clang_complete_auto=0

" neocomplcache
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_smart_case=1
let g:neocomplcache_enable_camel_case_completion=1
let g:neocomplcache_enable_underbar_completion=1
let g:neocomplcache_min_keyword_length=3
let g:neocomplcache_force_overwrite_completefunc=1
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns={}
endif
if !has('win32')
  let g:neocomplcache_omni_patterns['ruby']='[^. *\t]\.\w*\|\h\w*::'
endif
let g:neocomplcache_omni_patterns['cpp']='[^.[:digit:] *\t]\%(\.\|->\)\|::'
let g:neocomplcache_same_filetype_lists={}
let g:neocomplcache_same_filetype_lists['c']='cpp'
let g:neocomplcache_same_filetype_lists['cpp']='c'
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

" unite
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
nnoremap <silent> <C-f> :<C-u>UniteWithCurrentDir -buffer-name=files buffer_tab file_mru bookmark file file/new<CR>
nnoremap [unite] <Nop>
nmap <Leader>u [unite]
nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=files file_rec/async<CR>
nnoremap <silent> [unite]h :<C-u>Unite -buffer-name=help help<CR>
nnoremap <silent> [unite]o :<C-u>Unite -buffer-name=outline outline<CR>
nnoremap <silent> [unite]g :<C-u>Unite -no-quit vcs_grep<CR>
nnoremap <silent> [unite]G :<C-u>Unite -no-quit grep<CR>
nnoremap <silent> [unite]t :<C-u>Unite tab:no-current<CR>
nnoremap <silent> [unite]r :<C-u>UniteResume<CR>
nnoremap <silent> [unite]p :<C-u>Unite history/yank<CR>

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
  set clipboard=unnamedplus,unnamed
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

" Zencoding
let g:user_zen_settings = {
  \'indentation': '  ',
  \}

" echodoc
let g:echodoc_enable_at_startup = 1

" syntastic
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 2

" vim-ref
function! s:ref_ruby_settings()
  nnoremap <silent><buffer> [unite]k :<C-u>Unite ref/ri<CR>
  nnoremap <silent><buffer> K :<C-u>call ref#jump('normal', 'ri')<CR>
  vnoremap <silent><buffer> K :<C-u>call ref#jump('visual', 'ri')<CR>
endfunction
autocmd FileType ruby call s:ref_ruby_settings()

" Alignta
xnoremap <silent> <Leader>t: :Alignta <<0 \ /1<CR>
xnoremap <silent> <Leader>t, :Alignta << -e ,<CR>
xnoremap <silent> <Leader>t= :Alignta << -e =<CR>
xnoremap <silent> <Leader>t> :Alignta << -e =><CR>

xnoremap <silent> <Leader>T: :Alignta >>0 \ /1<CR>
xnoremap <silent> <Leader>T, :Alignta >> -e ,<CR>
xnoremap <silent> <Leader>T= :Alignta >> -e =<CR>
xnoremap <silent> <Leader>T> :Alignta >> -e =><CR>

" poslist
map <C-o> <Plug>(poslist-prev-pos)
map <C-i> <Plug>(poslist-next-pos)
