-- init.lua
---@diagnostic disable: inject-field

-- matchit
if vim.fn.filereadable(vim.fn.expand('$VIMRUNTIME/macros/matchit.vim')) == 1 then
  vim.cmd('source $VIMRUNTIME/macros/matchit.vim')
end

-- Base
vim.api.nvim_create_augroup('vimrc_loading', {})

-- leader
vim.g.mapleader = ' '

-- wrapping
vim.opt.textwidth = 0
vim.api.nvim_create_autocmd('FileType', {
  group = 'vimrc_loading',
  pattern = { 'text' },
  callback = function()
    vim.opt_local.textwidth = 0
  end,
})

-- Encoding
vim.opt.encoding = 'utf-8'
if vim.fn.has('win32') then
  vim.opt.termencoding = 'cp932'
end
vim.opt.fileencodings = 'utf-8,cp932,euc-jp'
vim.opt.fileformats = 'unix,dos,mac'

-- Backup and history
vim.opt.backup = false
vim.opt.undofile = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.history = 100

-- Indent
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 8
vim.g.vim_indent_cont = 2

-- Search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true

-- Movements
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })
vim.api.nvim_set_keymap('n', 'gj', 'j', { noremap = true })
vim.api.nvim_set_keymap('n', 'gk', 'k', { noremap = true })
vim.api.nvim_set_keymap('n', '<Down>', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', '<Up>', 'gk', { noremap = true })

vim.opt.whichwrap = 'b,s,h,l,<,>,[,]'
vim.opt.virtualedit = vim.opt.virtualedit + 'block'

vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

vim.api.nvim_set_keymap('i', '<C-b>', '<Left>', {})
vim.api.nvim_set_keymap('i', '<C-f>', '<Right>', {})
vim.api.nvim_set_keymap('i', '<C-d>', '<Delete>', {})

-- Appearances
vim.opt.colorcolumn = '112'
vim.opt.cursorline = true
vim.opt.display = 'lastline'
vim.opt.hidden = true
vim.opt.list = true
vim.opt.listchars = 'tab:> ,extends:>,precedes:<'
vim.opt.matchtime = 1
vim.opt.number = false
vim.opt.showmatch = false
vim.opt.pumheight = 10
vim.opt.synmaxcol = 256
vim.opt.wildmenu = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.showcmd = true
vim.opt.statusline = "%<[%n]%f %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%=%l,%c%V%8P"
vim.opt.termguicolors = true

if vim.fn.exists('&ambiwidth') then
  vim.opt.ambiwidth = 'double'
end

-- Edit
vim.opt.backspace = 'indent,eol,start'
vim.opt.infercase = true
vim.opt.scrolloff = 10
vim.opt.updatetime = 1000
vim.opt.wildignore = '*.exe,*.dll,*.class,*.jpg,*.jpeg,*.png,*.gif'

-- Reset cursor position in COMMIT_EDITMSG
vim.api.nvim_create_autocmd('BufReadPost', {
  group = 'vimrc_loading',
  pattern = { 'COMMIT_EDITMSG' },
  command = [[
  exec "normal! gg"
  ]],
})

-- Clipboard
if vim.fn.has('clipboard') then
  if vim.fn.has('unnamedplus') then
    vim.opt.clipboard = 'unnamedplus,unnamed'
  else
    vim.opt.clipboard = 'unnamed'
  end
end

-- Surround
vim.g.surround_no_mappings = 1
vim.cmd([[
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
]])

-- Solarized
vim.opt.background = 'light'
require('solarized').set()

-- Terminal
if vim.fn.has('nvim') then
  vim.api.nvim_set_keymap('t', '<silent> <Esc>', '<C-\\><C-n>', {})
end

vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')

vim.opt.showmode = false

-- Copilot
vim.g.copilot_filetypes = {
  gitcommit = true,
}

-- Lualine
require('lualine').setup({
  options = {
    icons_enabled        = false,
    component_separators = { left = '', right = '' },
    section_separators   = { left = '', right = '' },
    theme                = 'solarized_light',
  },
})
