-- Plugin Manager Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


-- Plugins
require('lazy').setup({

    -- git
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    'lewis6991/gitsigns.nvim',

    -- comments
    'tpope/vim-commentary',

    -- colorscheme
    {
        'ellisonleao/gruvbox.nvim',
        priority = 1000,
        config = function()
            vim.o.background = 'dark'
            vim.cmd.colorscheme 'gruvbox'
        end
    },

    -- LSP Configuration
    {
        'mason-org/mason.nvim',
        'mason-org/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { 'j-hui/fidget.nvim',       opts = {} },
        -- Additional lua configuration, makes nvim stuff amazing!
        'folke/neodev.nvim',
    },

    -- Diagnostics
    {
        'folke/trouble.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',
            'FelipeLema/cmp-async-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-buffer',
            -- {
            --     'zbirenbaum/copilot-cmp',
            --     config = function()
            --         require('copilot_cmp').setup()
            --     end,
            -- },

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',

            -- Icons
            'onsails/lspkind-nvim',
        },
    },

    -- Statusline
    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = false,
                theme = 'gruvbox',
                component_separators = '|',
                section_separators = '',
            },
        },
    },

    -- Navigation
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        commit = "2eca9ba22002184ac05eddbe47a7fe2d5a384dfc",
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- Fuzzy Finder Algorithm which requires local dependencies to be built.
            -- Only load if `make` is available. Make sure you have the system
            -- requirements installed.
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- NOTE: If you are having trouble with this installation,
                --       refer to the README for telescope-fzf-native for more instructions.
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
    },
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
    },

    {
      'stevearc/oil.nvim',
      ---@module 'oil'
      ---@type oil.SetupOpts
      opts = {},
      -- Optional dependencies
      dependencies = { { "echasnovski/mini.icons", opts = {} } },
      -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    },

    -- Highlighting
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            local ts_runtime = vim.fn.stdpath('data') .. '/lazy/nvim-treesitter/runtime'
            if vim.uv.fs_stat(ts_runtime) then
                vim.opt.rtp:prepend(ts_runtime)
            end
        end,
    },

    -- Better undo
    'mbbill/undotree',

    -- LLM completion
    { 'zbirenbaum/copilot.lua',         enabled = false },
    { "supermaven-inc/supermaven-nvim", enabled = true },
    -- {
    --     "Exafunction/codeium.vim",
    --     event = 'BufEnter'
    -- },

    -- markdown
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    -- jupyter
    {
        'luk400/vim-jukit',
        -- need to run these before the plugin loads, would rather have them in
        -- the seperate config file, like just require the file here
        -- but doesnt work bc of pathing somehow
        init = function()
            vim.g.jukit_mappings = 0
        end,
        ft = { "python", "ipynb" },
    },

    {
        "amitds1997/remote-nvim.nvim",
        version = "*",                  -- Pin to GitHub releases
        dependencies = {
            "nvim-lua/plenary.nvim",    -- For standard functions
            "MunifTanjim/nui.nvim",     -- To build the plugin UI
            "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
        },
        config = true,
    },

    -- ai, getting tiktoken_core error, not sure if it doens't work because of that
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = false,
        enabled = false,
        version = false, -- set this if you want to always pull the latest change
        opts = {
            provider = "copilot",
        },
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = "make",
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            "zbirenbaum/copilot.lua",      -- for providers='copilot'
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- Make sure to set this up properly if you have lazy=true
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    },

    -- {
   -- "m4xshen/hardtime.nvim",
    --    lazy = false,
    --    dependencies = { "MunifTanjim/nui.nvim" },
    --    opts = {},
    -- },


}, {})
