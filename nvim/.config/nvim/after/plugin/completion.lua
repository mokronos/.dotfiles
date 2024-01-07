local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    completion = {
        completeopt = 'menuone,noselect',
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-t>'] = cmp.mapping.complete(),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
    }),

    sources = cmp.config.sources({
        -- { name = 'copilot', max_item_count = 3},
        { name = 'nvim_lsp', max_item_count = 10 },
        { name = 'path',     max_item_count = 5 },
        { name = 'luasnip',  max_item_count = 5 },
        { name = 'buffer',   keyword_length = 1, max_item_count = 5 },
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = "text",
            menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                path = "[Path]",
                copilot = "[Copilot]",
            }),
        }),
    },
})


-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' },
    }
})


-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' },
    }, {
        { name = 'cmdline' },
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = "text",
            menu = ({
                path = "[Path]",
                cmdline = "[Cmd]",
            }),
        }),
    },
})
