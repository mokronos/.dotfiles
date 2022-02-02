local Plug = vim.fn['plug#']

vim.call ('plug#begin', '~/.nvim/plugged')

Plug 'gruvbox-community/gruvbox'

-- statusline
Plug 'nvim-lualine/lualine.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'preservim/nerdtree'

Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-surround'

Plug 'mbbill/undotree'

-- Plug 'plasticboy/vim-markdown'

Plug 'nvim-treesitter/nvim-treesitter'

-- lsp
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

-- completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

-- snippetengine(kinda required for nvim-cmp)
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
-- snipets
Plug 'honza/vim-snippets'

-- Plug 'ambv/black'

vim.call ('plug#end')
