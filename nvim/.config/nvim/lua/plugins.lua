return require('packer').startup(function()
    -- packer itself
    use 'wbthomason/packer.nvim'

    -- colorscheme
    use 'gruvbox-community/gruvbox'

    -- statusline
    use 'nvim-lualine/lualine.nvim'

    -- navigation
    -- telescope, fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}},
    }
    use 'nvim-telescope/telescope-fzy-native.nvim'

    -- filetree
    use 'preservim/nerdtree'

    -- undotree
    use 'mbbill/undotree'

    -- git
    use 'tpope/vim-fugitive'

    -- comments
    use 'tpope/vim-commentary'

    -- sourround stuff with stuff
    use 'tpope/vim-surround'

    -- better highlighting and language understanding
    -- produces weird error in python, where after a parenthesis, RETURN indents up to that perenthesis
    use 'nvim-treesitter/nvim-treesitter'

    -- lsp, language understanding, linting
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'

    -- completion, uses lsp as source
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- snippetengine(kinda required for nvim-cmp)
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    -- debugging
    use 'mfussenegger/nvim-dap'
    use 'mfussenegger/nvim-dap-python'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'nvim-telescope/telescope-dap.nvim'

    -- use 'ambv/black'
    -- use 'plasticboy/vim-markdown'

    -- enable jupyter notebook like behaviour in nvim
    use 'jpalardy/vim-slime'

end)
