-- make options local
-- local opt = vim.opt_local
-- opt.spell = true
-- opt.spelllang = en_us,de_de

-- convert to lua (above stuff is not working for some reason)
vim.api.nvim_command('setlocal spell spelllang=en_us,de_de')


local opts = {noremap=true, silent=true}
vim.api.nvim_set_keymap('i', '<C-s>', '<C-g>u<Esc>[s1z=`]a<C-g>u', opts)

print("markdown file loaded")

-- spellfile probably should be cleaned at some point, but spellclean.vim is not in neovim. could do it myself (regex)
