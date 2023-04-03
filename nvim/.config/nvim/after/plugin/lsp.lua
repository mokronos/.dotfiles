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
    vim.keymap.set('n', '<Leader>vD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, {desc = '[V]iew [D]eclaration LSP'}))
    vim.keymap.set('n', '<Leader>vd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, {desc = '[V]iew [D]efinition LSP'}))
    vim.keymap.set('n', '<Leader>vs', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, {desc = '[V]iew [S]ignature_help LSP'}))
    vim.keymap.set('n', '<Leader>vi', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, {desc = '[V]iew [I]mplementation LSP'}))
    vim.keymap.set('n', '<Leader>vc', vim.diagnostic.open_float, vim.tbl_extend('force', opts, {desc = '[V]iew [C]heck diagnostics LSP'}))
    vim.keymap.set('n', '<Leader>vr', vim.lsp.buf.rename, vim.tbl_extend('force', opts, {desc = '[R]ename something LSP'}))
    vim.keymap.set('n', '<Leader>va', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, {desc = '[V]iew [A]ctions LSP'}))
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
