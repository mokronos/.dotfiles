vim.api.nvim_command('filetype plugin indent on')
vim.api.nvim_command('set path+=**')
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
opt.undodir='~/.nvim/undodir'
opt.undofile = true

opt.signcolumn = 'yes'
opt.colorcolumn = '80' 
opt.breakindent = true
opt.linebreak = true


opt.clipboard='unnamed'
opt.completeopt='menu,menuone,noselect'
vim.g.completion_matching_strategy_list = 'exact, substring, fuzzy'

opt.updatetime=50

opt.formatoptions = opt.formatoptions
    - "c"
    - "r"
    - "o"

