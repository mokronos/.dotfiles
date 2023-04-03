vim.keymap.set('n', '<Leader>gd', ':Gvdiffsplit!<cr>', {desc = '[G]it [D]iff'})
vim.keymap.set('n', '<Leader>gh', ':diffget //2<cr>', {desc = 'accept git [D]iff [L]eft'})
vim.keymap.set('n', '<Leader>gl', ':diffget //3<cr>', {desc = 'accept git [D]iff [R]ight'})
vim.keymap.set('n', '<Leader>gs', vim.cmd.Git, {desc = '[G]it [S]tatus'})
