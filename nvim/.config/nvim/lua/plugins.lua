local Plug = vim.fn['plug#']

vim.call ('plug#begin', '~/.nvim/plugged')

Plug 'gruvbox-community/gruvbox'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'preservim/nerdtree'

Plug 'tpope/vim-fugitive'

Plug 'vim-airline/vim-airline'

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-surround'

Plug 'mbbill/undotree'

Plug 'plasticboy/vim-markdown'

Plug 'nvim-treesitter/nvim-treesitter'

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

vim.call ('plug#end')
