vim.opt.clipboard:append('unnamedplus')

-- Workaround: https://github.com/vscode-neovim/vscode-neovim/issues/259
vim.keymap.set('', 'j', 'gj', { remap = true })
vim.keymap.set('', 'k', 'gk', { remap = true })
