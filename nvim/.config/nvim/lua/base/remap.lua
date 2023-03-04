vim.g.mapleader = " "

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, {desc = '[P]roject [V]iew'})

-- source current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
    vim.cmd("echo 'Sourced current file'")
end, {desc = 'Source current file'})


-- no clue why this doesn't work
-- vim.keymap.set("n", "<leader>;", function()
--     vim.cmd("messages")
-- end, {desc = 'Show messages'})
