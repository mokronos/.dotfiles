vim.keymap.set('n', '<Leader>Gd', ':Gvdiffsplit!<cr>', {desc = '[G]it [D]iff'})
vim.keymap.set('n', '<Leader>Gh', ':diffget //2<cr>', {desc = 'take left git diff'})
vim.keymap.set('n', '<Leader>Gl', ':diffget //3<cr>', {desc = 'take right git diff'})
vim.keymap.set('n', '<Leader>Gp', vim.cmd.Git, {desc = '[G]it panel'})
