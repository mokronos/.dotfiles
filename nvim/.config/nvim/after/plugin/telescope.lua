require('telescope').setup{
    defaults = {
        file_ignore_patterns = {
            "%.git", "%.pdf", "%.png"
        },
        layout_strategy = "vertical",
    }
}

local builtin = require('telescope.builtin')
-- files
vim.keymap.set('n', '<Leader>ff', builtin.find_files, {desc = '[F]ind [F]ile'})
vim.keymap.set('n', '<Leader>fs', builtin.live_grep, {desc = '[F]ind [S]tring'})
vim.keymap.set('n', '<Leader>fw', builtin.grep_string, {desc = '[F]ind [W]ord under cursor'})
-- vim
vim.keymap.set('n', '<Leader>fc', builtin.commands, {desc = '[F]ind [C]ommand'})
vim.keymap.set('n', '<Leader>fh', builtin.help_tags, {desc = '[F]ind [H]elp'})
vim.keymap.set('n', '<Leader>fk', builtin.keymaps, {desc = '[F]ind [K]eymap'})
-- lsp
vim.keymap.set('n', '<Leader>fr', builtin.lsp_references, {desc = '[F]ind [R]eference'})
-- treesitter
vim.keymap.set('n', '<Leader>ft', builtin.treesitter, {desc = '[F]ind [T]reesitter'})
