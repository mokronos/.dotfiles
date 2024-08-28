vim.o.guicursor='n-c-v:block-nCursor'

vim.wo.number = true
vim.wo.relativenumber = true

vim.o.tabstop=4
vim.o.softtabstop=4
vim.o.shiftwidth=4
vim.o.expandtab = true

-- vim.o.smartindent = true

vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir= os.getenv("HOME") .. '/.vim/undodir'
vim.o.undofile = true

vim.o.wrap = true
vim.o.breakindent = true

-- add line at x chars to enforce line length
vim.o.signcolumn = 'yes'
vim.o.colorcolumn = '80'
-- vim.cmd[[highlight ColorColumn ctermbg=0 guibg=darkgrey]]

vim.o.scrolloff=8

vim.o.termguicolors = true

vim.o.ignorecase = true
vim.o.smartcase = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- make all clipboards the same
-- vim.o.clipboard='unnamedplus'

vim.o.updatetime=250
-- vim.o.timeoutlen=500

-- makes K open the help page for the word under the cursor
vim.o.keywordprg=':help'

-- debugging
-- vim.o.verbose=0

-- make latex be the default filetype for .tex files
-- so that ftplugin/tex.lua is loaded
vim.g.tex_flavor='latex'

-- don't add comment to line when using o on a commented line
vim.opt.formatoptions:remove 'o'

-- make system python the default, otherwise it uses the one from the venv
-- vim.g.python3_host_prog='/usr/bin/python3'
