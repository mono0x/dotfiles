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
  if a:insert
    match TrailingSpaces /\S\zs\s\+$/
  else
    match TrailingSpaces /\s\+$/
  endif
endfunction
autocmd vimrc_loading BufNew,BufRead * call s:highlight_trailing_spaces(0)
autocmd vimrc_loading InsertEnter * call s:highlight_trailing_spaces(1)
autocmd vimrc_loading InsertLeave * call s:highlight_trailing_spaces(0)
autocmd vimrc_loading ColorScheme * highlight TrailingSpaces ctermbg=red guibg=red
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
if v:version < 703 || (v:version == 7.3 && !has('patch336'))
  set notagbsearch
endif

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

" Automatic nopaste
autocmd vimrc_loading InsertLeave * if &paste | set nopaste mouse=a | echo 'nopaste' | endif

" Reset cursor position in COMMIT_EDITMSG
autocmd vimrc_loading BufReadPost COMMIT_EDITMSG exec "normal! gg"

nnoremap <silent> <Leader>w :<C-u>w<CR>

" Remove comment leaders when joining lines
set formatoptions+=j
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

filetype plugin indent on
syntax on
" }}}

if dein#tap('vim-colors-solarized') " {{{
  set background=light
  let g:solarized_termcolors=16
  let g:solarized_termtrans=1
  let g:solarized_italic=0
  colorscheme solarized
endif " }}}

if dein#tap('vim-indent-guides') " {{{
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_guide_size = 1
  let g:indent_guides_start_level = 2
  let g:indent_guides_auto_colors = 0
  autocmd vimrc_loading VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#fdf6e3 ctermbg=15
  autocmd vimrc_loading VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#eee8d5 ctermbg=7
endif " }}}

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

if dein#tap('vim-surround') " {{{
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
endif " }}}

if dein#tap('incsearch.vim') " {{{
  let g:incsearch#auto_nohlsearch = 1

  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
  map n  <Plug>(incsearch-nohl-n)
  map N  <Plug>(incsearch-nohl-N)
  map *  <Plug>(incsearch-nohl-*)
  map #  <Plug>(incsearch-nohl-#)
  map g* <Plug>(incsearch-nohl-g*)
  map g# <Plug>(incsearch-nohl-g#)
endif " }}}

if dein#tap('incsearch-fuzzy.vim') " {{{
  map z/ <Plug>(incsearch-fuzzy-/)
  map z? <Plug>(incsearch-fuzzy-?)
  map zg/ <Plug>(incsearch-fuzzy-stay)
endif " }}}

if dein#tap('incsearch-migemo.vim') " {{{
  map m/ <Plug>(incsearch-migemo-/)
  map m? <Plug>(incsearch-migemo-?)
  map mg/ <Plug>(incsearch-migemo-stay)
endif " }}}

if dein#tap('vim-marching') " {{{
  let g:marching_enable_neocomplete = 1
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
  "let g:deoplete#omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
  let g:deoplete#omni_patterns.typescript = '\h\w*\|[^. \t]\.\w*'
endif " }}}

if dein#tap('unite.vim') " {{{
  nnoremap <Leader>w :<C-u>Unite -buffer-name=files buffer<CR>
  nnoremap <C-w><C-w> :<C-u>Unite -buffer-name=files buffer<CR>
  nnoremap <silent> <Leader>f :<C-u>UniteWithCurrentDir file_mru file file/new -hide-source-names<CR>
  nnoremap <silent> <Leader>m :<C-u>Unite file_mru -hide-source-names<CR>
  nnoremap <silent> <Leader>e :<C-u>call <SID>unite_smart_file_rec()<CR>
  nnoremap <silent> <Leader>E :<C-u>Unite file_rec/async<CR>
  nnoremap <silent> <Leader>o :<C-u>Unite outline<CR>
  nnoremap <silent> <Leader>b :<C-u>Unite -no-start-insert build<CR>
  nnoremap <silent> <Leader>gg :<C-u>call <SID>unite_smart_grep()<CR>
  nnoremap <silent> <C-^> :<C-u>Unite jump<CR>
  nnoremap <silent> <C-j> :<C-u>Unite -immediately -no-start-insert gtags/context<CR>

  function! s:unite_smart_file_rec()
    if isdirectory(getcwd() . "/.git")
      Unite file_rec/git
    else
      Unite file_rec/async
    endif
  endfunction

  function! s:unite_smart_grep()
    if unite#sources#grep_git#is_available()
      Unite -no-start-insert grep/git:.
    elseif unite#sources#grep_hg#is_available()
      Unite -no-start-insert grep/hg:.
    else
      Unite -no-start-insert grep:.
    endif
  endfunction

  function! s:unite_on_source()
    set wildignore=*.exe,*.dll,*.class,*.jpg,*.jpeg,*.png,*.gif
    call unite#custom#source('file,file_rec/git,file_rec/async', 'ignore_globs',
      \ split(&wildignore, ','))

    call unite#custom#source(
      \ 'file,buffer,file_mru', 'matchers',
      \ ['matcher_context'])

    call unite#custom#source(
      \ 'file_rec/async,file_rec/git', 'matchers',
      \ ['matcher_context'])

    call unite#custom#source(
      \ 'file,file_mru,file_rec/async,file_rec/git', 'converters',
      \ ['converter_smart_path', 'converter_file_directory'])

    call unite#custom#profile('default', 'context', {
      \ 'start_insert': 1,
      \ })

    call unite#custom#profile('file,file_mru,file_rec/async,file_rec/git', 'context', {
      \ 'buffer_name': 'files',
      \ })

    call unite#custom#profile('grep,grep/git,grep/hg', 'context', {
      \ 'buffer_name': 'search-buffer',
      \ 'start_insert': 0,
      \ 'quit': 0,
      \ })

    call unite#custom#profile('outline', 'context', {
      \ 'buffer_name': 'outline',
      \ 'start_insert': 0,
      \ 'quit': 0,
      \ 'winwidth': 32,
      \ 'direction': 'botright',
      \ 'vertical': 1,
      \ })

    let g:unite_source_gtags_enable_nearness = 1
  endfunction
  execute 'autocmd vimrc_loading User' 'dein#source#' . g:dein#name 'call s:unite_on_source()'

  if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden'
    let g:unite_source_grep_recursive_opt = ''
  endif

  function! s:unite_my_settings()
    imap <buffer><expr> j unite#smart_map('j', '')

    imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  endfunction
  autocmd vimrc_loading FileType unite call s:unite_my_settings()
endif " }}}

if dein#tap('vim-fugitive') " {{{
  nnoremap <silent> <Leader>gc :<C-u>Gcommit<CR>
  nnoremap <silent> <Leader>gb :<C-u>Gblame<CR>
  nnoremap <silent> <Leader>gd :<C-u>Gdiff<CR>
  nnoremap <silent> <Leader>gs :<C-u>Gstatus<CR>
endif
" }}}

if dein#tap('yankround.vim') " {{{
  nmap p <Plug>(yankround-p)
  nmap P <Plug>(yankround-P)
  nmap gp <Plug>(yankround-gp)
  nmap gP <Plug>(yankround-gP)
  nmap <C-p> <Plug>(yankround-prev)
  nmap <C-n> <Plug>(yankround-next)
  xmap p <Plug>(yankround-p)
  xmap gp <Plug>(yankround-gp)

  let g:yankround_use_region_hl = 1
  let g:yankround_region_hl_groupname = 'YankRoundRegion'

  autocmd vimrc_loading ColorScheme *   call s:define_region_hl()
  function! s:define_region_hl()
    if &bg=='dark'
      highlight default YankRoundRegion   guibg=Brown ctermbg=Brown term=reverse
    else
      highlight default YankRoundRegion   guibg=LightRed ctermbg=LightRed term=reverse
    end
  endfunction

  if has('gui_running') && has('clipboard')
    if has('unnamedplus')
      set clipboard=unnamedplus,unnamed
    else
      set clipboard=unnamed
    endif
  endif
endif " }}}

if dein#tap('emmet-vim') " {{{
  let g:user_emmet_settings = {
  \ 'indentation': '  ',
  \ 'xslate': {
  \   'indentation': '    ',
  \ },
  \ 'tt2html': {
  \   'indentation': '    ',
  \ },
  \ }
endif " }}}

if dein#tap('echodoc') " {{{
  let g:echodoc_enable_at_startup = 1
endif " }}}

if dein#tap('vim-alignta') " {{{
  xnoremap <silent> <Leader>t: :Alignta <<0 \ /1<CR>
  xnoremap <silent> <Leader>t, :Alignta << -e ,<CR>
  xnoremap <silent> <Leader>t= :Alignta << -e =<CR>
  xnoremap <silent> <Leader>t> :Alignta << -e =><CR>

  xnoremap <silent> <Leader>T: :Alignta >>0 \ /1<CR>
  xnoremap <silent> <Leader>T, :Alignta >> -e ,<CR>
  xnoremap <silent> <Leader>T= :Alignta >> -e =<CR>
  xnoremap <silent> <Leader>T> :Alignta >> -e =><CR>
endif " }}}

if dein#tap('vim-markdown') " {{{
  let g:vim_markdown_liquid=1
  let g:vim_markdown_frontmatter=1
  let g:vim_markdown_folding_disabled=1
endif " }}}

if dein#tap('vim-markdown-quote-syntax') " {{{
  let g:markdown_quote_syntax_filetypes = {
    \ "coffee": { "start": "coffee" },
    \ "cpp": { "start": "cpp" },
    \ "css": { "start": "css" },
    \ "javascript": { "start": "javascript" },
    \ "ruby": { "start": "ruby" },
    \ "scss": { "start": "scss" },
    \ "sh": { "start": "sh" },
    \}
endif " }}}

if dein#tap('vim-go') " {{{
  let g:go_fmt_command = 'goimports'
  let g:go_fmt_fail_silently = 1

  function! s:go_settings()
    autocmd BufWritePre <buffer> GoFmt
    nnoremap <buffer> K :<C-u>GoDoc<CR>
  endfunction
  autocmd vimrc_loading FileType go call s:go_settings()

  function! s:godoc_settings()
    nnoremap <buffer> q :<C-u>q<CR>
  endfunction
  autocmd vimrc_loading FileType godoc call s:godoc_settings()
endif " }}}

if dein#tap('open-browser.vim') " {{{
  let g:netrw_nogx = 1
  nmap gx <Plug>(openbrowser-smart-search)
  vmap gx <Plug>(openbrowser-smart-search)
endif " }}}

if dein#tap('open-browser-github.vim') " {{{
  let g:openbrowser_github_always_use_commit_hash = 1
  let g:openbrowser_github_url_exists_check = 'ignore'
  nnoremap <silent> <Leader>gh :OpenGithubFile<CR>
  vnoremap <silent> <Leader>gh :OpenGithubFile<CR>

endif " }}}

if dein#tap('perlomni.vim') " {{{
  let $PATH.=':'.dein#get('perlomni.vim')['path'].'/bin'
endif " }}}
