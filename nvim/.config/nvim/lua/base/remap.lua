vim.g.mapleader = " "

-- open file manager
vim.keymap.set('n', '<leader>pv', vim.cmd.Lex, {desc = '[P]roject [V]iew'})

-- source current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
    vim.cmd("echo 'Sourced current file'")
end, {desc = 'Source current file'})

-- paste over selection without copying selection
vim.keymap.set("x", "<leader>p", [["_dP]], {desc = '[P]aste over selection without losing it'})

-- copy to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], {desc = '[y]ank to system clipboard'})
vim.keymap.set("n", "<leader>Y", [["+Y]], {desc = '[Y]ank from cursor to end of line to system clipboard'})

-- move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc = 'Move selected lines down'})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {desc = 'Move selected lines up'})

vim.keymap.set("n", "<C-j>", "<C-^>", {desc = 'Jump to alternate file'})
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {desc = 'Jump to normal mode from terminal'})

-- no clue why this doesn't work
-- vim.keymap.set("n", "<leader>;", function()
--     vim.cmd("messages")
-- end, {desc = 'Show messages'})

