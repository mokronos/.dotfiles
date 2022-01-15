require('telescope').setup{  defaults = { file_ignore_patterns = { "%.git", "%.pdf" }} }
vim.api.nvim_set_keymap('n', '<Leader>ps', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true })
