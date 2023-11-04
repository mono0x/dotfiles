" .vimrc
" vim: foldmethod=marker

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

" leader {{{
let g:mapleader = ' '
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
set noswapfile
set history=100
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
set scrolloff=10
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

" Surround {{{
let g:surround_no_mappings = 1

nmap <unique> ds     <Plug>Dsurround
nmap <unique> cs     <Plug>Csurround
nmap <unique> ys     <Plug>Ysurround
nmap <unique> yS     <Plug>Ysurround$
nmap <unique> yss    <Plug>Yssurround
nmap <unique> ygs    <Plug>Ygsurround
nmap <unique> ygS    <Plug>Ygsurround$
nmap <unique> ygss   <Plug>Ygssurround
nmap <unique> ygsgs  <Plug>Ygssurround
xmap <unique> s      <Plug>Vsurround
xmap <unique> S      <Plug>VSurround
xmap <unique> gs     <Plug>Vgsurround
xmap <unique> gS     <Plug>VgSurround
imap <unique> <C-S>  <Plug>Isurround
imap <unique> <C-G>s <Plug>Isurround
imap <unique> <C-G>S <Plug>ISurround
" }}}

" solarized {{{
set background=light
let g:solarized_termcolors=16
let g:solarized_termtrans=1
let g:solarized_italic=0
autocmd vimrc_loading VimEnter * nested colorscheme solarized
" }}}

" Terminal {{{
if has('nvim')
  tnoremap <silent> <Esc> <C-\><C-n>
endif
" }}}

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

filetype plugin indent on
syntax on

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

let g:copilot_filetypes = {
  \   'gitcommit': v:true,
  \ }
