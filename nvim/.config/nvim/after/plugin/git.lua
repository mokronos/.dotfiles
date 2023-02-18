vim.keymap.set('n', '<Leader>gd', ':Gvdiffsplit!<cr>', {desc = '[G]it [D]iff'})
vim.keymap.set('n', '<Leader>gh', ':diffget //2<cr>', {desc = 'take left git diff'})
vim.keymap.set('n', '<Leader>gl', ':diffget //3<cr>', {desc = 'take right git diff'})
vim.keymap.set('n', '<Leader>gp', vim.cmd.Git, {desc = '[G]it panel'})
