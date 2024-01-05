-- require('mason').setup()

-- local mason = require('mason-lspconfig')
-- local lspconfig = require('lspconfig')

-- mason.setup({
--   ensure_installed = {
--     -- Replace these with whatever servers you want to install
--     'pyright',
--     'lua_ls',
--     'rust_analyzer',
--   }
-- })

-- -- get capabilities from cmp
-- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- local lsp_attach = function(client, bufnr)
--     local opts = {buffer = bufnr, silent = true}
--     vim.keymap.set('n', '<Leader>H', vim.lsp.buf.hover, vim.tbl_extend('force',opts,{desc = '[H]over info LSP'}))
--     vim.keymap.set('n', '<Leader>R', vim.lsp.buf.references, vim.tbl_extend('force', opts, {desc = '[R]eferences LSP'}))
--     vim.keymap.set('n', '<Leader>vD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, {desc = '[V]iew [D]eclaration LSP'}))
--     vim.keymap.set('n', '<Leader>vd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, {desc = '[V]iew [D]efinition LSP'}))
--     vim.keymap.set('n', '<Leader>vs', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, {desc = '[V]iew [S]ignature_help LSP'}))
--     vim.keymap.set('n', '<Leader>vi', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, {desc = '[V]iew [I]mplementation LSP'}))
--     vim.keymap.set('n', '<Leader>vc', vim.diagnostic.open_float, vim.tbl_extend('force', opts, {desc = '[V]iew [C]heck diagnostics LSP'}))
--     vim.keymap.set('n', '<Leader>vr', vim.lsp.buf.rename, vim.tbl_extend('force', opts, {desc = '[R]ename something LSP'}))
--     vim.keymap.set('n', '<Leader>va', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, {desc = '[V]iew [A]ctions LSP'}))
-- end

-- -- Setup installed servers
-- mason.setup_handlers({
--   function(server_name)
--     lspconfig[server_name].setup({
--       on_attach = lsp_attach,
--       capabilities = lsp_capabilities,
--     })
--   end,
-- })

-- -- Fix Undefined global 'vim'
-- lspconfig.lua_ls.setup{
--     on_attach = lsp_attach,
--     capabilities = lsp_capabilities,
--     settings = {
--         Lua = {
--             diagnostics = {
--                 globals = { 'vim' }
--             }
--         }
--     }
-- }

local builtin = require('telescope.builtin')

local on_attach = function(_, bufnr)

    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func { buffer = bufnr, desc = desc })
    end

    -- nmap('<Leader>H', vim.lsp.buf.hover, vim.tbl_extend('force',opts,{desc = '[H]over info LSP'}))
    -- nmap('<Leader>R', vim.lsp.buf.references, vim.tbl_extend('force', opts, {desc = '[R]eferences LSP'}))
    -- nmap('<Leader>vD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, {desc = '[V]iew [D]eclaration LSP'}))
    nmap('<Leader>vd', builtin.lsp_definitions, '[V]iew [D]efinition')
    nmap('<Leader>H', vim.lsp.buf.hover, '[H]over info')
    -- nmap('<Leader>vs', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, {desc = '[V]iew [S]ignature_help LSP'}))
    -- nmap('<Leader>vi', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, {desc = '[V]iew [I]mplementation LSP'}))
    -- nmap('<Leader>vc', vim.diagnostic.open_float, vim.tbl_extend('force', opts, {desc = '[V]iew [C]heck diagnostics LSP'}))
    -- nmap('<Leader>vr', vim.lsp.buf.rename, vim.tbl_extend('force', opts, {desc = '[R]ename something LSP'}))
    -- nmap('<Leader>va', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, {desc = '[V]iew [A]ctions LSP'}))
end

require('mason').setup()
require('mason-lspconfig').setup()

local servers = {
    pyright = {},
    rust_analyzer = {},
    lua_ls = {}
}
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
        }
    end,
}
