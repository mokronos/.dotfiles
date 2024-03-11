local builtin = require('telescope.builtin')

local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('K', vim.lsp.buf.hover, '[H]over info')
    nmap('<Leader>R', vim.lsp.buf.rename, '[R]ename something')
    nmap('<Leader>va', vim.lsp.buf.code_action, '[V]iew Code [A]ctions')
    nmap('<Leader>vh', vim.lsp.buf.signature_help, '[V]iew Signature [H]elp')
    nmap('<Leader>vc', vim.diagnostic.open_float, '[V]iew [C]heck diagnostics')
    nmap('<Leader>vD', vim.lsp.buf.declaration, '[V]iew [D]eclaration')
    nmap('<Leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd folder')
    nmap('<Leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove folder')
    nmap('<Leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist folders')

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'LSP: Format current buffer' })

    nmap('<Leader>vd', builtin.lsp_definitions, '[V]iew [D]efinition')
    nmap('<Leader>vr', builtin.lsp_references, '[V]iew [R]eferences')
    nmap('<Leader>vi', builtin.lsp_implementations, '[V]iew [I]mplementations')
    nmap('<Leader>vt', builtin.lsp_type_definitions, '[V]iew [T]ype definitions')
    nmap('<Leader>vs', builtin.lsp_document_symbols, '[V]iew [S]ymbols')
    nmap('<Leader>vw', builtin.lsp_dynamic_workspace_symbols, '[V]iew [W]orkspace symbols')
end


require('mason').setup()
require('mason-lspconfig').setup()

local servers = {
    pyright = {},
    rust_analyzer = {},
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
        },
    },
}

require('neodev').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
-- capabilities.offsetEncoding = { "utf-16" }

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
