vim.g.mapleader = " "

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- source current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
