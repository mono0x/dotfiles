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

if has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
  NeoBundleLazy 'Shougo/neocomplete.vim', {
    \ 'insert': 1,
    \ }
else
  NeoBundleFetch 'Shougo/neocomplete.vim'
endif
NeoBundleLazy 'osyo-manga/vim-marching', {
  \ 'filetypes': [ 'c', 'cpp', 'objc', 'objcpp' ],
  \ }
NeoBundleLazy 'h1mesuke/vim-alignta', {
  \ 'commands': 'Alignta',
  \ }
NeoBundleLazy 'Shougo/echodoc', {
  \ 'insert': 1,
  \ }
NeoBundleLazy 'thinca/vim-quickrun', {
  \ 'mappings': '<Plug>',
  \ }
NeoBundleLazy 'cohama/vim-hier'
NeoBundleLazy 'osyo-manga/shabadou.vim'
NeoBundleLazy 'osyo-manga/vim-watchdogs', {
  \ 'depends': [ 'thinca/vim-quickrun', 'osyo-manga/shabadou.vim', 'cohama/vim-hier', ],
  \ 'filetypes': [
  \   'c',
  \   'cpanfile',
  \   'cpp',
  \   'javascript',
  \   'perl',
  \   'ruby',
  \ ],
  \ }
NeoBundleLazy 'mattn/emmet-vim', {
  \ 'filetypes': [
  \   'css',
  \   'haml',
  \   'html',
  \   'markdown',
  \   'scss',
  \   'tt2html',
  \   'xml',
  \   'xslate',
  \ ],
  \ }
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundleLazy 'anyakichi/vim-surround', {
  \ 'mappings': [
  \   '<Plug>SurroundRepeat',
  \   '<Plug>Dsurround',
  \   '<Plug>Csurround',
  \   '<Plug>Yssurround',
  \   '<Plug>Ygssurround',
  \   '<Plug>Ysurround',
  \   '<Plug>Ygsurround',
  \   '<Plug>Vsurround',
  \   '<Plug>VSurround',
  \   '<Plug>Vgsurround',
  \   '<Plug>VgSurround',
  \   '<Plug>Isurround',
  \   '<Plug>ISurround',
  \ ],
  \ }
NeoBundle 'LeafCage/yankround.vim', {
  \ 'mappings': '<Plug>',
  \ }
NeoBundleLazy 'haya14busa/incsearch.vim', {
  \ 'mappings': '<Plug>',
  \ }
NeoBundleLazy 'godlygeek/tabular', {
  \ 'commands': 'Tabularize',
  \ }
NeoBundle 'thinca/vim-template'
NeoBundle 'thinca/vim-localrc'

" Unite {{{
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/tabpagebuffer.vim'
NeoBundleLazy 'Shougo/unite.vim', {
  \ 'commands': [{ 'name': 'Unite', 'complete': 'customlist,unite#complete_source' }],
  \ }
NeoBundleLazy 'Shougo/unite-outline'
NeoBundleLazy 'Shougo/unite-build'
NeoBundleLazy 'hewes/unite-gtags'
NeoBundleLazy 'lambdalisue/unite-grep-vcs', {
  \ 'unite_sources': [ 'grep/git', 'grep/hg' ],
  \ 'functions': [
  \   'unite#sources#grep_git#is_available',
  \   'unite#sources#grep_hg#is_available',
  \ ],
  \ }
" }}}

" Syntax {{{
NeoBundleLazy 'hail2u/vim-css3-syntax', {
  \ 'filetypes': [ 'css', 'sass', 'scss', 'markdown' ],
  \ }
NeoBundleLazy 'othree/html5.vim', {
  \ 'filetypes': [ 'html', 'markdown' ],
  \ }
NeoBundleLazy 'joker1007/vim-markdown-quote-syntax', {
  \ 'filetypes': 'markdown',
  \ }
NeoBundleLazy 'rcmdnk/vim-markdown', {
  \ 'filetypes': 'markdown',
  \ }
NeoBundleLazy 'kchmck/vim-coffee-script', {
  \ 'filetypes': [ 'coffee', 'markdown' ],
  \ }
NeoBundleLazy 'sophacles/vim-processing', {
  \ 'filetypes': 'processing',
  \ }
NeoBundleLazy 'evanmiller/nginx-vim-syntax', {
  \ 'filetypes': 'nginx',
  \ }
NeoBundleLazy 'gnuplot.vim', {
  \ 'filetypes': 'gnuplot',
  \ }
NeoBundleLazy 'honza/dockerfile.vim', {
  \ 'filetypes': 'dockerfile',
  \ }
NeoBundleLazy 'pangloss/vim-javascript', {
  \ 'filetypes': [ 'javascript', 'markdown' ],
  \ }
NeoBundleLazy 'leafgarland/typescript-vim', {
  \ 'filetypes': 'typescript',
  \ }
NeoBundleLazy 'clausreinke/typescript-tools.vim', {
  \ 'filetypes': 'typescript',
  \ }
NeoBundleLazy 'vim-perl/vim-perl', {
  \ 'filetypes': [ 'perl', 'cpanfile', 'tt2html' ]
  \ }
NeoBundleLazy 'motemen/xslate-vim', {
  \ 'filetypes': 'xslate',
  \ }
NeoBundleLazy 'moznion/vim-cpanfile', {
  \ 'filetypes': 'cpanfile',
  \ }
" }}}

" colorscheme {{{
NeoBundle 'altercation/vim-colors-solarized'
" }}}
