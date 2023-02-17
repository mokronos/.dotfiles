require('telescope').setup{
    defaults = {
        file_ignore_patterns = {
            "%.git", "%.pdf", "%.png", "results/", "data/", "models/", "spell/", "%.db", "%.pth", "__init__.py", "__pycache__/", "_site/"
        }
    }
}

local builtin = require('telescope.builtin')
-- files
vim.keymap.set('n', '<Leader>ps', builtin.find_files)
vim.keymap.set('n', '<Leader>fs', builtin.grep_string)
vim.keymap.set('n', '<Leader>ff', builtin.live_grep)
-- vim
vim.keymap.set('n', '<Leader>fc', builtin.commands)
vim.keymap.set('n', '<Leader>fm', builtin.man_pages)
vim.keymap.set('n', '<Leader>fk', builtin.keymaps)
-- lsp
vim.keymap.set('n', '<Leader>fr', builtin.lsp_references)
-- treesitter
vim.keymap.set('n', '<Leader>ft', builtin.treesitter)
