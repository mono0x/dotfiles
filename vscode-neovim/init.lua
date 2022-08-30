vim.opt.clipboard:append('unnamedplus')

vim.g.mapleader = ' '

-- Workaround: https://github.com/vscode-neovim/vscode-neovim/issues/259
-- https://github.com/vscode-neovim/vscode-neovim/issues/576
vim.keymap.set('', 'j', 'gj', { remap = true })
vim.keymap.set('', 'k', 'gk', { remap = true })

vim.cmd [[
  noremap <leader>gb <Cmd>call VSCodeNotify('gitlens.toggleFileBlame')<CR>
  noremap <leader>gh <Cmd>call VSCodeNotifyVisual('gitlens.openFileOnRemote', 0)<CR>
]]

vim.cmd [[
  filetype off
]]

local dein_root_dir = vim.fn.expand('~/.cache/dein-vscode-neovim')

if vim.fn.isdirectory(dein_root_dir) == 0 then
  vim.fn.mkdir(dein_root_dir, 'p')
end

if not string.find(vim.api.nvim_get_option('runtimepath'), '/dein.vim') then
  local dein_dir = vim.fn.fnamemodify('dein.vim', ':p')
  if vim.fn.isdirectory(dein_dir) == 0 then
    dein_dir = dein_root_dir .. '/repos/github.com/Shougo/dein.vim'
    if vim.fn.isdirectory(a) == 0 then
      os.execute('git clone https://github.com/Shougo/dein.vim ' .. dein_dir)
    end
  end
  vim.o.runtimepath = dein_dir .. ',' .. vim.o.runtimepath
end

if vim.call('dein#min#load_state', dein_root_dir) ~= 0 then
  local dein_lua = vim.fn.expand('<sfile>')
  local dein_toml_dir = vim.fn.fnamemodify(dein_lua, ':h') .. '/'
  local dein_toml = dein_toml_dir .. 'dein.toml'
  local dein_lazy_toml = dein_toml_dir .. 'dein_lazy.toml'

  vim.call('dein#begin', dein_root_dir, { dein_lua, dein_toml, dein_lazy })
  vim.call('dein#load_toml', dein_toml, { lazy = false })
  vim.call('dein#load_toml', dein_lazy_toml, { lazy = true })
  vim.call('dein#end')
  vim.call('dein#save_state')
end
