
set nocompatible
filetype off

if has('win32')
  set rtp+=$HOME/.vim,$HOME/.vim/after
endif

if has('vim_starting')
  set rtp+=$HOME/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
if !(has('win32') && has('kaoriya'))
  NeoBundle 'Shougo/vimproc', {
    \   'build': {
    \     'mac': 'make -f make_mac.mak',
    \     'unix': 'make -f make_unix.mak',
    \   },
    \ }
endif

NeoBundle 'sudo.vim'

function! s:meet_neocomplete_requirements()
    return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction
if s:meet_neocomplete_requirements()
  NeoBundle 'Shougo/neocomplete'
else
  NeoBundle 'Shougo/neocomplcache'
  NeoBundleLazy 'Shougo/neocomplcache-rsense', {
    \   'autoload': { 'filetypes': [ 'ruby' ] },
    \ }
endif

NeoBundleLazy 'osyo-manga/vim-marching', {
  \   'autoload': { 'filetypes': [ 'c', 'cpp', 'objc', 'objcpp' ] },
  \ }
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'Shougo/echodoc'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle 'osyo-manga/vim-watchdogs'
NeoBundleLazy 'mattn/emmet-vim', {
  \   'autoload': { 'filetypes': [ 'html', 'haml', 'css' ] },
  \ }
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'thinca/vim-template'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'kana/vim-tabpagecd'
NeoBundle 'thinca/vim-visualstar'
NeoBundle 'anyakichi/vim-surround'
NeoBundle 'bkad/CamelCaseMotion'
NeoBundle 'thinca/vim-poslist'
NeoBundle 'jceb/vim-hier'
NeoBundle 'osyo-manga/vim-anzu'
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'LeafCage/yankround.vim'

NeoBundle 'thinca/vim-ref'
NeoBundleLazy 'taka84u9/vim-ref-ri', {
  \   'autoload': { 'filetypes': [ 'ruby' ] }
  \ }

" unite
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'sgur/unite-git_grep'
NeoBundle 'Shougo/unite-build'
NeoBundle 'hewes/unite-gtags'
NeoBundle 'Shougo/neomru.vim'

" syntax
NeoBundleLazy 'hail2u/vim-css3-syntax', {
  \   'autoload': { 'filetypes': [ 'css', 'sass', 'scss' ] }
  \  }
NeoBundleLazy 'othree/html5.vim', {
  \   'autoload': { 'filetypes': 'html' }
  \  }
NeoBundleLazy 'cakebaker/scss-syntax.vim', {
  \   'autoload': { 'filetypes': [ 'scss' ] }
  \  }
NeoBundle 'tpope/vim-liquid', {
  \   'autoload': { 'filetypes': 'liquid' }
  \  }
NeoBundleLazy 'tpope/vim-markdown', {
  \   'autoload': { 'filetypes': 'markdown' }
  \  }
NeoBundleLazy 'kchmck/vim-coffee-script', {
  \   'autoload': { 'filetypes': 'coffee' }
  \  }
NeoBundleLazy 'sophacles/vim-processing', {
  \   'autoload': { 'filetypes': 'processing' }
  \  }
NeoBundleLazy 'evanmiller/nginx-vim-syntax', {
  \   'autoload': { 'filetypes': 'nginx' }
  \  }
NeoBundleLazy 'gnuplot.vim', {
  \   'autoload': { 'filetypes': 'gnuplot' }
  \  }

augroup vimrc_loading
  autocmd!
augroup END

augroup vimrc_loading
  au BufRead,BufNewFile *.scss	set filetype=scss.css
  au BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} setf markdown
  au BufRead,BufNewFile *.pde setf processing

  au BufNewFile,BufRead *.liquid					set ft=liquid

  au BufNewFile,BufRead */_layouts/*.html,*/_includes/*.html	set ft=liquid
  au BufNewFile,BufRead *.html,*.xml,*.textile
        \ if getline(1) == '---' | set ft=liquid | endif
  au BufNewFile,BufRead *.markdown,*.mkd,*.mkdn,*.md
        \ if getline(1) == '---' |
        \   let b:liquid_subtype = 'markdown' |
        \   set ft=liquid |
        \ endif

  autocmd BufNewFile,BufRead *.coffee set filetype=coffee
  autocmd BufNewFile,BufRead *Cakefile set filetype=coffee
  autocmd BufNewFile,BufRead *.coffeekup,*.ck set filetype=coffee
  autocmd BufNewFile,BufRead *._coffee set filetype=coffee
augroup END

function! s:DetectCoffee()
    if getline(1) =~ '^#!.*\<coffee\>'
        set filetype=coffee
    endif
endfunction

augroup vimrc_loading
  autocmd BufNewFile,BufRead * call s:DetectCoffee()

  au BufRead,BufNewFile *.nginx set ft=nginx
  au BufRead,BufNewFile */etc/nginx/* set ft=nginx
  au BufRead,BufNewFile */usr/local/nginx/conf/* set ft=nginx

  au BufRead,BufNewFile *.plt set ft=gnuplot
augroup END

" colorscheme
NeoBundle 'altercation/vim-colors-solarized'

set t_Co=256
syntax enable

filetype plugin indent on

if neobundle#is_installed('vim-colors-solarized')
  set background=light
  let g:solarized_termcolors=16
  let g:solarized_termtrans=1
  let g:solarized_italic=0
  colorscheme solarized
endif

if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
endif

" terminal
set lazyredraw
set ttyfast

" leader
let mapleader = ' '

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_auto_colors = 0
autocmd vimrc_loading VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#fdf6e3 ctermbg=15
autocmd vimrc_loading VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#eee8d5 ctermbg=7

" lightline
set laststatus=2
if neobundle#is_installed('lightline.vim')
  let g:lightline = {
    \   'colorscheme': 'solarized',
    \   'active': {
    \     'left': [
    \       [ 'mode', 'paste', ],
    \       [ 'fugitive', 'readonly', 'filename', 'anzu', ],
    \     ],
    \     'right': [
    \        [ 'lineinfo', 'char_counter' ],
    \        [ 'percent' ],
    \        [ 'fileformat', 'fileencoding', 'filetype' ]
    \     ],
    \   },
    \   'component_function': {
    \     'fugitive': 'MyFugitive',
    \     'filename': 'MyFilename',
    \     'anzu': 'anzu#search_status',
    \     'char_counter': 'MyCharCounter',
    \   },
    \ }
else
  set statusline=%<[%n]%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%=%l,%c%V%8P
endif

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

function! MyCharCounter()
  let result = 0
  for linenum in range(0, line('$'))
    let line = getline(linenum)
    let result += strlen(substitute(line, '.', 'x', 'g'))
  endfor
  return result
endfunction

" vim-anzu
" http://qiita.com/shiena/items/f53959d62085b7980cb5
nmap n <Plug>(anzu-n)
nmap N <Plug>(anzu-N)
nmap * <Plug>(anzu-star)
nmap # <Plug>(anzu-sharp)
augroup vim-anzu
    autocmd!
    autocmd CursorHold,CursorHoldI,WinLeave,TabLeave * call anzu#clear_search_status()
augroup END

nnoremap <silent> <ESC><ESC> :<C-u>nohlsearch<CR>:AnzuClearSearchStatus<CR>

" Highlight trailing spaces
highlight TrailingSpaces ctermbg=1 guibg=red
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
endf
augroup TrailingSpaces
  autocmd!
  autocmd BufNew,BufRead * call s:highlight_trailing_spaces(0)
  autocmd InsertEnter * call s:highlight_trailing_spaces(1)
  autocmd InsertLeave * call s:highlight_trailing_spaces(0)
augroup END

set textwidth=0
autocmd vimrc_loading FileType text setlocal textwidth=0

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
function! s:au_recheck_fenc()
  if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
    let &fileencoding=&encoding
  endif
endfunction
autocmd vimrc_loading BufReadPost * call s:au_recheck_fenc()
set fileformats=unix,dos,mac

if exists('&ambiwidth')
  set ambiwidth=double
endif

set nobackup
set noundofile
set nowritebackup
set directory=~/.vimswap//
set history=100

set notagbsearch

set autoindent
set tabstop=8
set softtabstop=2
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

" vim-marching
let g:marching_backend = 'sync_clang_command'
let g:marching_enable_neocomplete = 1

" msvc
" http://d.hatena.ne.jp/osyo-manga/20121117/1353139064
if has('win32')
  let s:msvc_dirs = [
  \  "C:/Program\ Files (x86)/Microsoft\ Visual\ Studio\ 11.0",
  \  "C:/Program\ Files (x86)/Microsoft\ Visual\ Studio\ 10.0",
  \  "C:/Program\ Files (x86)/Microsoft\ Visual\ Studio\ 9.0",
  \  "C:/Program\ Files (x86)/Microsoft\ Visual\ Studio\ 8.0",
  \  "C:/Program\ Files/Microsoft\ Visual\ Studio\ 11.0",
  \  "C:/Program\ Files/Microsoft\ Visual\ Studio\ 10.0",
  \  "C:/Program\ Files/Microsoft\ Visual\ Studio\ 9.0",
  \  "C:/Program\ Files/Microsoft\ Visual\ Studio\ 8.0",
  \]
  function! s:set_msvc_path(msvc_path)
    if has_key(s:, "msvc_path") || !isdirectory(a:msvc_path)
      return
    endif

    let s:msvc_path = a:msvc_path
    let path = a:msvc_path

    let $VSINSTALLDIR=path
    let $VCINSTALLDIR=$VSINSTALLDIR."/VC"

    let $DevEnvDir=$VSINSTALLDIR."/Common7/IDE;"
    let $PATH=$VSINSTALLDIR."Common7/Tools;".$PATH
    let $PATH=$VCINSTALLDIR."/bin;".$PATH
    let $PATH=$DevEnvDir.";".$PATH

    let $INCLUDE=$VCINSTALLDIR."/include;".$INCLUDE
    let $LIB=$VCINSTALLDIR."/LIB;".$LIB
    let $LIBPATH=$VCINSTALLDIR."/LIB;".$LIBPATH
  endfunction
  function! s:setup_msvc_path()
    call s:set_msvc_path(get(filter(copy(s:msvc_dirs), "isdirectory(v:val)"), 0, ""))
  endfunction
  call s:setup_msvc_path()
endif

if s:meet_neocomplete_requirements()
  let g:neocomplete#enable_at_startup=1
  let g:neocomplete#enable_smart_case=1
  let g:neocomplete#sources#syntax#min_keyword_length=3
  inoremap <expr><C-g> neocomplete#undo_completion()
  inoremap <expr><C-l> neocomplete#complete_common_string()
  augroup vimrc_loading
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  augroup END
  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns={}
  endif
  let g:neocomplete#force_omni_input_patterns.c='[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplete#force_omni_input_patterns.cpp='[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
  let g:neocomplete#force_omni_input_patterns.objc='[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplete#force_omni_input_patterns.objcpp='[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
else
  let g:neocomplcache_enable_at_startup=1
  let g:neocomplcache_enable_smart_case=1
  let g:neocomplcache_enable_camel_case_completion=1
  let g:neocomplcache_enable_underbar_completion=1
  let g:neocomplcache_min_keyword_length=3
  let g:neocomplcache_force_overwrite_completefunc=1
  if !exists('g:neocomplcache_force_omni_patterns')
    let g:neocomplcache_force_omni_patterns={}
  endif
  let g:neocomplcache_force_omni_patterns.c='[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplcache_force_omni_patterns.cpp='[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
  let g:neocomplcache_force_omni_patterns.objc='[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplcache_force_omni_patterns.objcpp='[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
  inoremap <expr><C-g> neocomplcache#undo_completion()
  inoremap <expr><C-l> neocomplcache#complete_common_string()
  inoremap <expr><C-y> neocomplcache#close_popup()
  inoremap <expr><C-e> neocomplcache#cancel_popup()
endif

" unite
let g:unite_enable_start_insert=1
nnoremap <silent> <C-f> :<C-u>UniteWithCurrentDir -buffer-name=files buffer_tab file_mru bookmark file file/new<CR>
nnoremap [unite] <Nop>
nmap <Leader>u [unite]
nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=files file_rec/async<CR>
nnoremap <silent> [unite]h :<C-u>Unite -buffer-name=help help<CR>
nnoremap <silent> [unite]o :<C-u>Unite -no-quit -no-start-insert -vertical -winwidth=32 -buffer-name=outline outline<CR>
nnoremap <silent> <Leader>g :<C-u>Unite -no-quit vcs_grep<CR>
nnoremap <silent> <Leader>b :<C-u>Unite -no-start-insert build<CR>
nnoremap <silent> [unite]g :<C-u>Unite -no-quit grep<CR>
nnoremap <silent> [unite]t :<C-u>Unite tab:no-current<CR>
nnoremap <silent> [unite]r :<C-u>UniteResume<CR>
nnoremap <silent> [unite]p :<C-u>Unite yankround<CR>
nnoremap <silent> [unite]t :<C-u>Unite gtags/grep<CR>
nnoremap <silent> <C-^> :<C-u>Unite jump<CR>

noremap <silent> <C-j> :<C-u>Unite -immediately -no-start-insert gtags/context<CR>

call unite#custom#source('file_rec/async', 'ignore_pattern',
  \ '\%(^\|/\)\.$\|\~$\|\.\%(o\|exe\|dll\|bak\|sw[po]\|class\|jpg\|jpeg\|png\|gif\)$'.
  \ '\|\%(^\|/\)\%(\.hg\|\.git\|\.bzr\|\.svn\|tags\%(-.*\)\?\)\%($\|/\)\|lib/Cake'.
  \ '\|downloads/tmp\|templates_c')

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden'
  let g:unite_source_grep_recursive_opt = ''
endif

nnoremap <C-w><C-w> :<C-u>Unite -buffer-name=files buffer<CR>
nnoremap <C-w>n :bn<CR>
nnoremap <C-w>p :bp<CR>
nnoremap <C-w>d :bd<CR>
nnoremap <C-w>h <C-w>h:call <SID>good_width()<Cr>
nnoremap <C-w>l <C-w>l:call <SID>good_width()<Cr>
nnoremap <C-w>H <C-w>H:call <SID>good_width()<Cr>
nnoremap <C-w>L <C-w>L:call <SID>good_width()<Cr>
function! s:good_width()
  if &filetype == 'unite'
    return
  endif
  if winwidth(0) < 84
    vertical resize 84
  endif
endfunction

" yankround
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

autocmd vimrc_loading CmdwinEnter * call s:init_cmdwin()
function! s:init_cmdwin()
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
autocmd vimrc_loading FileType ruby call s:ref_ruby_settings()

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

" quickrun
if !exists('g:quickrun_config')
  let g:quickrun_config = {}
endif
let g:quickrun_config['_'] = {
  \   'runner': 'vimproc',
  \ }
let g:quickrun_config['hsp'] = {
  \   'command': 'D:/Documents/tools/hsp3/hscl',
  \   'exec': '%c %s',
  \   'hook/output_encode/encoding': 'cp932',
  \   'outputter': 'error',
  \   'error': 'quickfix',
  \   'errorformat': '%f\(%l)%*[^0-9]%n\ :\ %m',
  \ }

" vim-watchdogs
let g:watchdogs_check_BufWritePost_enable = 1
call watchdogs#setup(g:quickrun_config)

if has('win32')
  let $PATH=$PATH.';'.$HOME.'\.nvmw\v0.8.18'
endif

" markdown
let g:markdown_fenced_languages = [
  \   'c',
  \   'cpp',
  \   'css',
  \   'html',
  \   'javascript',
  \   'json=javascript',
  \   'make',
  \   'ruby',
  \   'sass',
  \   'sh',
  \   'xml',
  \ ]
