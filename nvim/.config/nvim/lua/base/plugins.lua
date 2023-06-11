-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- colorscheme
    use { "ellisonleao/gruvbox.nvim" }

    -- navigation
    -- telescope, fuzzy finder
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- swapping files
    use {
        'ThePrimeagen/harpoon',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- better highlighting and language understanding
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/nvim-treesitter-context'

    -- undotree
    use 'mbbill/undotree'

    -- git
    use 'tpope/vim-fugitive'

    -- comments
    use 'tpope/vim-commentary'

    -- server manger
    use 'williamboman/mason.nvim'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason-lspconfig.nvim'

    -- linter
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'jay-babu/mason-null-ls.nvim'

    -- Autocompletion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lua'

    -- better description for completion
    use 'onsails/lspkind-nvim'

    -- -- Snippets
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'

    -- copilot
    use 'zbirenbaum/copilot.lua'

    -- statusline
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- debugging
    use 'mfussenegger/nvim-dap'

    -- markdown
    use({ "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" }, })

    -- latex
    -- not working, seems like a python issue
    use({ "xuhdev/vim-latex-live-preview",
    ft = { "tex", "latex" }, })

end)
