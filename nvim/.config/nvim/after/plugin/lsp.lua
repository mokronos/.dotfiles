local builtin = require('telescope.builtin')

local nmap = function(keys, func, desc)
    if desc then
        desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { desc = desc })
end

nmap('K', vim.lsp.buf.hover, '[H]over info')
nmap('<Leader>R', vim.lsp.buf.rename, '[R]ename something')
nmap('<Leader>va', vim.lsp.buf.code_action, '[V]iew Code [A]ctions')
nmap('<Leader>vh', vim.lsp.buf.signature_help, '[V]iew Signature [H]elp')
nmap('<Leader>vc', vim.diagnostic.open_float, '[V]iew [C]heck diagnostics')
nmap('<Leader>vD', vim.lsp.buf.declaration, '[V]iew [D]eclaration')
nmap('<Leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd folder')
nmap('<Leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove folder')
nmap('<Leader>F', vim.lsp.buf.format, '[F]ormat')
nmap('<Leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, '[W]orkspace [L]ist folders')

nmap('<Leader>vd', builtin.lsp_definitions, '[V]iew [D]efinition')
nmap('<Leader>vr', builtin.lsp_references, '[V]iew [R]eferences')
nmap('<Leader>vi', builtin.lsp_implementations, '[V]iew [I]mplementations')
nmap('<Leader>vt', builtin.lsp_type_definitions, '[V]iew [T]ype definitions')
nmap('<Leader>vs', builtin.lsp_document_symbols, '[V]iew [S]ymbols')
nmap('<Leader>vw', builtin.lsp_dynamic_workspace_symbols, '[V]iew [W]orkspace symbols')


require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'rust_analyzer' },
})
require('neodev').setup()
