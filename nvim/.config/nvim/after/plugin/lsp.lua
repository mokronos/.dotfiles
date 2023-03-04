require('mason').setup()

local mason = require('mason-lspconfig')
local lspconfig = require('lspconfig')

mason.setup({
  ensure_installed = {
    -- Replace these with whatever servers you want to install
    'pyright',
    'lua_ls',
  }
})

-- get capabilities from cmp
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local lsp_attach = function(client, bufnr)
    local opts = {buffer = bufnr, silent = true}
    vim.keymap.set('n', '<Leader>H', vim.lsp.buf.hover, vim.tbl_extend('force',opts,{desc = '[H]over info LSP'}))
    vim.keymap.set('n', '<Leader>R', vim.lsp.buf.references, vim.tbl_extend('force', opts, {desc = '[R]eferences LSP'}))
    vim.keymap.set('n', '<Leader>gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, {desc = '[g]o to [D]eclaration LSP'}))
    vim.keymap.set('n', '<Leader>gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, {desc = '[g]o to [d]efinition LSP'}))
    vim.keymap.set('n', '<Leader>vs', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, {desc = '[v]iew [s]ignature_help LSP'}))
    vim.keymap.set('n', '<Leader>vi', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, {desc = '[v]iew [i]mplementation LSP'}))
    vim.keymap.set('n', '<Leader>vc', vim.diagnostic.open_float, vim.tbl_extend('force', opts, {desc = '[v]iew [c]heck diagnostics LSP'}))
    vim.keymap.set('n', '<Leader>vr', vim.lsp.buf.rename, vim.tbl_extend('force', opts, {desc = '[r]ename something LSP'}))
end

-- Setup installed servers
mason.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      on_attach = lsp_attach,
      capabilities = lsp_capabilities,
    })
  end,
})

-- Fix Undefined global 'vim'
lspconfig.lua_ls.setup{
    on_attach = lsp_attach,
    capabilities = lsp_capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}
