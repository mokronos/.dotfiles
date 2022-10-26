require('telescope').setup{
    defaults = {
        file_ignore_patterns = {
            "%.git", "%.pdf", "%.png", "data/", "models/", "%.db", "%.pth", "__init__.py", "__pycache__/", "_site/"
        }
    }
}
-- vim.keymap.set('n', '<Leader>ps', '<cmd>lua require("telescope.builtin").find_files()<cr>', { noremap = true, silent = true })

local opts = { noremap=true, silent=true}

-- files
vim.keymap.set('n', '<Leader>ps', require("telescope.builtin").find_files, opts)
vim.keymap.set('n', '<Leader>fs', require("telescope.builtin").grep_string, opts)
vim.keymap.set('n', '<Leader>ff', require("telescope.builtin").live_grep, opts)
-- vim
vim.keymap.set('n', '<Leader>fc', require("telescope.builtin").commands, opts)
vim.keymap.set('n', '<Leader>fm', require("telescope.builtin").man_pages, opts)
vim.keymap.set('n', '<Leader>fk', require("telescope.builtin").keymaps, opts)
-- lsp
vim.keymap.set('n', '<Leader>fr', require("telescope.builtin").lsp_references, opts)
-- treesitter
vim.keymap.set('n', '<Leader>ft', require("telescope.builtin").treesitter, opts)
-- extra
-- vim.keymap.set('n', '<Leader>fp', require("telescope.builtin").planets, opts)
