-- might want to transfer to nvim_set_option
local opt = vim.opt

opt.guicursor='n-c-v:block-nCursor'

opt.relativenumber = true
opt.number = true

opt.tabstop=4
opt.softtabstop=4
opt.shiftwidth=4
opt.expandtab = true

opt.smartindent = true

opt.swapfile = false
opt.backup = false
opt.undodir= os.getenv("HOME") .. '/.vim/undodir'
opt.undofile = true

opt.wrap = false

opt.signcolumn = 'yes'
opt.colorcolumn = '80'
vim.cmd[[highlight ColorColumn ctermbg=0 guibg=lightgrey]]

opt.scrolloff=8

opt.termguicolors = true

opt.ignorecase = true
opt.smartcase = true

opt.hlsearch = false

-- opt.clipboard='unnamedplus'

opt.updatetime=50

opt.keywordprg=':help'

-- debugging
-- opt.verbose=0
