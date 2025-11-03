require('telescope').setup{
    defaults = {
        file_ignore_patterns = {
            "%.pdf", "%.png"
        },
        pickers = {
            find_files = {
                hidden = true,
            },
            live_grep = {
                hidden = true,
            },
            grep_string = {
                hidden = true,
            },
        },
        layout_strategy = "vertical",
        mappings = {
            n = {
            ["<C-q>"] = require('telescope.actions').send_to_qflist,
            },
            i = {
            ["<C-q>"] = require('telescope.actions').send_to_qflist,
            },
        },
    },
}

pcall(require('telescope').load_extension, 'fzf')

local builtin = require('telescope.builtin')

-- files
vim.keymap.set('n', '<Leader>ff', builtin.find_files, {desc = '[F]ind [F]ile'})
vim.keymap.set('n', '<Leader>fs', builtin.live_grep, {desc = '[F]ind [S]tring'})
vim.keymap.set('n', '<Leader>fw', builtin.grep_string, {desc = '[F]ind [W]ord under cursor'})
vim.keymap.set('n', '<Leader>fo', builtin.oldfiles, {desc = '[F]ind [O]ld file'})
-- vim
vim.keymap.set('n', '<Leader>fc', builtin.commands, {desc = '[F]ind [C]ommand'})
vim.keymap.set('n', '<Leader>fh', builtin.help_tags, {desc = '[F]ind [H]elp'})
vim.keymap.set('n', '<Leader>fk', builtin.keymaps, {desc = '[F]ind [K]eymap'})
vim.keymap.set('n', '<Leader>fb', builtin.builtin, {desc = '[F]ind [B]uiltin'})
-- treesitter
vim.keymap.set('n', '<Leader>ft', builtin.treesitter, {desc = '[F]ind [T]reesitter'})
vim.keymap.set('n', '<Leader>fq', builtin.quickfix, {desc = '[F]ind [Q]uickfix'})
