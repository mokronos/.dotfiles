vim.g.mapleader = " "

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, {desc = '[P]roject [V]iew'})

-- source current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end, {desc = 'Source current file'})
