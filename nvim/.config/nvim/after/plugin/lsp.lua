vim.opt.completeopt='menuone,noselect'
vim.g.completion_matching_strategy_list = 'exact, substring, fuzzy'

local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'pyright',
    'lua_ls',
})

-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})


local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})
-- set up keybinds, only use them on attach to server
lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set('n', '<Leader>H', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<Leader>R', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<Leader>gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<Leader>gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<Leader>vs', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<Leader>vi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<Leader>vc', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<Leader>vr', vim.lsp.buf.rename, opts)
end)

lsp.setup()


vim.diagnostic.config({
    virtual_text = true
})

