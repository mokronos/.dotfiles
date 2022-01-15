require'lspconfig'.pylsp.setup{}
vim.api.nvim_set_keymap('n', '<Leader>d', '<cmd>lua vim.lsp.buf.definition()<cr>', { noremap = true, silent = true })
