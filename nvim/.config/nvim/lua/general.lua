local opts = { noremap=true, silent=true}
vim.api.nvim_set_keymap('n', '<Leader>t', '<cmd>NERDTreeToggle<cr>', opts)
vim.api.nvim_set_keymap('n', '<Leader>u', '<cmd>UndotreeToggle<cr>', opts)
vim.api.nvim_set_keymap('n', '<Leader>vt', '<cmd>Sex<cr>', opts)
