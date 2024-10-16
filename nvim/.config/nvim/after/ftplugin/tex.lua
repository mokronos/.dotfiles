local opt = vim.opt_local
opt.wrap = true
opt.linebreak = true

vim.opt_local.spell = true
vim.opt_local.spelllang = { "en_us", "de_de" }

-- quick fix last wrong word in insert mode
vim.keymap.set('i', '<C-s>', '<C-g>u<Esc>[s1z=`]a<C-g>u', {desc = 'fix last spelling error'})

-- open dictionary autocomplete
vim.keymap.set('i', '<C-c>', '<C-x><C-k>', {desc = 'dictionary autocomplete'})
