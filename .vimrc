" .vimrc
" vim: foldmethod=marker

" dylib {{{
if has('nvim')
  if has('win32')
    " TODO
  elseif has('mac')
    let g:python3_host_prog='/usr/local/bin/python3'
  endif
else
  if has('win32')
    if has('win64')
      let path=fnamemodify('~\AppData\Local\Programs\Python\Python36\python36.dll', ':p')
    else
      let path=fnamemodify('~\AppData\Local\Programs\Python\Python36-32\python36.dll', ':p')
    endif
    if filereadable(path)
      execute 'set pythonthreedll='.path
    endif
  elseif has('mac')
    if filereadable('/usr/local/Frameworks/Python.framework/Versions/3.6/lib/libpython3.6m.dylib')
      set pythondll= " Disable Python2
      set pythonthreedll=/usr/local/Frameworks/Python.framework/Versions/3.6/lib/libpython3.6m.dylib
    endif

    if filereadable('/usr/local/lib/liblua.dylib')
      set luadll=/usr/local/lib/liblua.dylib
    endif
  endif
endif
" }}}

" Disable default plugins {{{
" http://lambdalisue.hatenablog.com/entry/2015/12/25/000046
let g:loaded_gzip              = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:loaded_rrhelper          = 1
let g:loaded_2html_plugin      = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1
" }}}

" matchit {{{
if filereadable(expand('$VIMRUNTIME/macros/matchit.vim'))
  source $VIMRUNTIME/macros/matchit.vim
endif
" }}}

" Base {{{
augroup vimrc_loading
  autocmd!
augroup END
" }}}

" terminal {{{
set lazyredraw
set ttyfast
" }}}

" leader {{{
let g:mapleader = ' '
" }}}

" spell checker {{{
set spelllang=en,cjk
nnoremap <silent> <Leader>s :<C-u>setlocal spell!<CR>
" }}}

" Highlight trailing spaces {{{
function! s:highlight_trailing_spaces(insert)
  if &filetype ==# 'unite'
    return
  endif
  if expand('%:t') ==# '[Command Line]'
    return
  endif
  highlight TrailingSpaces ctermbg=red guibg=red
  if a:insert
    match TrailingSpaces /\S\zs\s\+$/
  else
    match TrailingSpaces /\s\+$/
  endif
endfunction
autocmd vimrc_loading BufNew,BufRead * call s:highlight_trailing_spaces(0)
autocmd vimrc_loading InsertEnter * call s:highlight_trailing_spaces(1)
autocmd vimrc_loading InsertLeave * call s:highlight_trailing_spaces(0)
" }}}

" wrapping {{{
set textwidth=0
" force textwidth=0
autocmd vimrc_loading FileType text setlocal textwidth=0
" }}}

" Encoding {{{
set encoding=utf-8
if has('win32')
  set termencoding=cp932
endif
if has('kaoriya')
  set fileencodings=guess
else
  set fileencodings=utf-8,cp932,euc-jp
endif
set fileformats=unix,dos,mac
" }}}

" Backup and history {{{
set nobackup
set noundofile
set nowritebackup
set directory=~/.vimswap//
set history=100
" }}}

" Help {{{
function! s:help_settings()
  nnoremap <buffer> q :<C-u>q<CR>
endfunction
autocmd vimrc_loading FileType help call s:help_settings()
" }}}

" Indent {{{
set autoindent
set expandtab
set shiftround
set shiftwidth=2
set smarttab
set softtabstop=2
set tabstop=8

let g:vim_indent_cont=2
" }}}

" Search {{{
set hlsearch
set ignorecase
set incsearch
set smartcase
" }}}

" Movements {{{
noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap <Down> gj
noremap <Up> gk
set whichwrap=b,s,h,l,<,>,[,]
set virtualedit+=block

nnoremap Y y$

imap <C-b> <Left>
imap <C-f> <Right>
imap <C-d> <Delete>
" }}}

" Appearances {{{
set colorcolumn=112
set cursorline
set display=lastline
set hidden
set list
set listchars=tab:>\ ,extends:>,precedes:<
set matchtime=1
set nonumber
set noshowmatch
set pumheight=10
set synmaxcol=256
set wildmenu

set cmdheight=1
set laststatus=2
set showcmd
set statusline=%<[%n]%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%=%l,%c%V%8P

set t_Co=256

augroup vimrc_loading
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
  autocmd InsertEnter * setlocal nocursorline
  autocmd InsertLeave * setlocal cursorline

  autocmd VimEnter,ColorScheme * highlight MatchParen guibg=#fdf6e3 ctermbg=15
augroup END

if exists('&ambiwidth')
  set ambiwidth=double
endif
" }}}

" Edit {{{
set backspace=indent,eol,start
set infercase
set updatetime=1000
set wildignore=*.exe,*.dll,*.class,*.jpg,*.jpeg,*.png,*.gif

" Automatic nopaste
autocmd vimrc_loading InsertLeave * if &paste | set nopaste mouse=a | echo 'nopaste' | endif

" Reset cursor position in COMMIT_EDITMSG
autocmd vimrc_loading BufReadPost COMMIT_EDITMSG exec "normal! gg"

nnoremap <silent> <Leader>w :<C-u>w<CR>

" Remove comment leaders when joining lines
set formatoptions+=j

" Clipboard
if has('clipboard')
  if has('unnamedplus')
    set clipboard=unnamedplus,unnamed
  else
    set clipboard=unnamed
  endif
endif
" }}}

" Window {{{
nnoremap <C-w>n :bn<CR>
nnoremap <C-w>p :bp<CR>
nnoremap <C-w>d :bd<CR>
nnoremap <C-w>h <C-w>h:call <SID>good_width()<Cr>
nnoremap <C-w>l <C-w>l:call <SID>good_width()<Cr>
nnoremap <C-w>H <C-w>H:call <SID>good_width()<Cr>
nnoremap <C-w>L <C-w>L:call <SID>good_width()<Cr>
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l
function! s:good_width()
  if &filetype == 'unite'
    return
  endif
  if &filetype == 'fugitiveblame'
    return
  endif
  if winwidth(0) < 84
    vertical resize 84
  endif
endfunction
" }}}

" IME {{{
set iminsert=0
set imsearch=0
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
" }}}

" Command-window {{{
nnoremap <sid>(command-line-enter) q:
xnoremap <sid>(command-line-enter) q:
nnoremap <sid>(command-line-norange) q:<C-u>

nmap :  <sid>(command-line-enter)
xmap :  <sid>(command-line-enter)

autocmd vimrc_loading CmdwinEnter * call s:init_cmdwin()
function! s:init_cmdwin()
  setlocal colorcolumn=
  setlocal nonumber

  nnoremap <buffer> q :<C-u>quit<CR>
  nnoremap <buffer> <TAB> :<C-u>quit<CR>
  inoremap <buffer><expr><CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
  inoremap <buffer><expr><C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
  inoremap <buffer><expr><BS> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"

  " Completion.
  inoremap <buffer><expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

  startinsert!
endfunction
" }}}

" Terminal {{{
if has('nvim')
  tnoremap <silent> <Esc> <C-\><C-n>
endif
" }}}

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

" dein.vim {{{
filetype off

if has('win32')
  set rtp^=$HOME/.vim,$HOME/.vim/after
endif

if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.vim/dein')
let s:dein_repos_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repos_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repos_dir
  endif
  execute 'set runtimepath^=' . s:dein_repos_dir
endif

if dein#load_state(s:dein_dir)
  let s:toml = expand('~/.vim/dein.toml')
  let s:lazy_toml = expand('~/.vim/dein_lazy.toml')

  call dein#begin(s:dein_dir, [ $MYVIMRC, s:toml, s:lazy_toml, ])

  call dein#load_toml(s:toml, { 'lazy': 0 })
  call dein#load_toml(s:lazy_toml, { 'lazy': 1 })

  call dein#end()
  call dein#save_state()
endif

autocmd vimrc_loading VimEnter * call dein#call_hook('post_source')

filetype plugin indent on
syntax on
" }}}

if dein#tap('lightline.vim') " {{{
  set noshowmode

  let g:lightline = {
    \   'colorscheme': 'solarized',
    \   'active': {
    \     'left': [
    \       [ 'mode', 'paste', ],
    \       [ 'fugitive', 'readonly', 'filename', ],
    \     ],
    \     'right': [
    \        [ 'lineinfo' ],
    \        [ 'percent' ],
    \        [ 'fileformat', 'fileencoding', 'filetype' ]
    \     ],
    \   },
    \   'component_function': {
    \     'fugitive': 'MyFugitive',
    \     'filename': 'MyFilename',
    \   },
    \ }

  function! MyFugitive()
    return exists('*fugitive#head') && strlen(fugitive#head()) ? fugitive#head() : ''
  endfunction

  function! MyFilename()
    return ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
      \ ('' != MyModified() ? ' ' . MyModified() : '')
  endfunction

  function! MyModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
  endfunction
endif " }}}

if dein#tap('neocomplete.vim') " {{{
  set completeopt-=preview

  let g:neocomplete#enable_at_startup=1
  let g:neocomplete#enable_smart_case=1
  let g:neocomplete#sources#syntax#min_keyword_length=3
  inoremap <expr><C-g> neocomplete#undo_completion()
  inoremap <expr><C-l> neocomplete#complete_common_string()
  inoremap <expr><C-x><C-f> neocomplete#start_manual_complete('file')
  augroup vimrc_loading
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType typescript setlocal omnifunc=TSScompleteFunc
  augroup END
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns={}
  endif
  let g:neocomplete#sources#omni#input_patterns.c='[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplete#sources#omni#input_patterns.cpp='[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
  let g:neocomplete#sources#omni#input_patterns.objc='[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplete#sources#omni#input_patterns.objcpp='[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
  let g:neocomplete#sources#omni#input_patterns.perl='\h\w*->\|\h\w*::'
  "let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
  let g:neocomplete#sources#omni#input_patterns.typescript = '\h\w*\|[^. \t]\.\w*'
endif " }}}

if dein#tap('deoplete.nvim') " {{{
  set completeopt-=preview

  let g:deoplete#enable_at_startup=1
  let g:deoplete#enable_smart_case=1

  augroup vimrc_loading
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType typescript setlocal omnifunc=TSScompleteFunc
  augroup END
  if !exists('g:deoplete#omni_patterns')
    let g:deoplete#omni_patterns={}
  endif
  let g:deoplete#omni_patterns.c='[^.[:digit:] *\t]\%(\.\|->\)'
  let g:deoplete#omni_patterns.cpp='[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
  let g:deoplete#omni_patterns.objc='[^.[:digit:] *\t]\%(\.\|->\)'
  let g:deoplete#omni_patterns.objcpp='[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
  let g:deoplete#omni_patterns.perl='\h\w*->\|\h\w*::'
  "let g:deoplete#omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
  let g:deoplete#omni_patterns.typescript = '\h\w*\|[^. \t]\.\w*'
endif " }}}

if dein#tap('vim-go') " {{{
  let g:go_fmt_fail_silently = 1
  let g:go_term_enabled = 1
  let g:go_highlight_build_constraints = 1
  let g:go_auto_type_info = 1

  function! s:go_settings()
    autocmd! BufWritePre <buffer> GoImports
    nmap <buffer> K <Plug>(go-doc)
    nmap <buffer> <C-j> <Plug>(go-def)
  endfunction
  autocmd vimrc_loading FileType go call s:go_settings()

  function! s:godoc_settings()
    nnoremap <buffer> q :<C-u>q<CR>
  endfunction
  autocmd vimrc_loading FileType godoc call s:godoc_settings()
endif " }}}
