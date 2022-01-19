vim.cmd[[filetype plugin indent on]]
vim.cmd[[set path+=**]]
local opt = vim.opt

--opt.path = opt.path + **
opt.exrc = true

opt.hlsearch = false

opt.relativenumber = true
opt.number = true
opt.scrolloff=8

opt.tabstop=4
opt.softtabstop=4
opt.shiftwidth=4
opt.expandtab = true
opt.smartindent = true

opt.termguicolors = true
opt.wildmode='longest,list,full'
opt.guicursor='i:block'

opt.swapfile = false
opt.undodir= os.getenv("HOME") .. '/undo'
opt.undofile = true

opt.signcolumn = 'yes'
opt.colorcolumn = '80'
vim.cmd[[highlight ColorColumn ctermbg=0 guibg=lightgrey]]
opt.breakindent = true
opt.linebreak = true

opt.clipboard='unnamed'

opt.updatetime=50

opt.formatoptions = opt.formatoptions
    - "c"
    - "r"
    - "o"
