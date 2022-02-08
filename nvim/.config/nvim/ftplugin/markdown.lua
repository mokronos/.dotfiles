-- make options local
local opt = vim.opt_local
opt.spell = true


local opts = {noremap=true, silent=true}
vim.api.nvim_set_keymap('i', '<C-s>', '<C-g>u<Esc>[s1z=`]a<C-g>u', opts)

-- spellfile probably should be cleaned at some point, but spellclean.vim is not in neovim. could do it myself (regex)
