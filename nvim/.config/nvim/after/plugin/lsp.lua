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

vim.api.nvim_create_autocmd("FileType", {
    desc = "Comprehensively reformat Python with Ruff",
    pattern = "python",
    callback = function()
        vim.keymap.set('n', '<Leader>F', function()
            vim.lsp.buf.code_action {
                context = { only = { 'source.fixAll' }, diagnostics = {} },
                apply = true,
            }
            vim.lsp.buf.format { async = true }
        end, { desc = '[F]ormat (Python with Ruff)' })
    end
})

nmap('<Leader>vd', builtin.lsp_definitions, '[V]iew [D]efinition')
nmap('<Leader>vr', builtin.lsp_references, '[V]iew [R]eferences')
nmap('<Leader>vi', builtin.lsp_implementations, '[V]iew [I]mplementations')
nmap('<Leader>vt', builtin.lsp_type_definitions, '[V]iew [T]ype definitions')
nmap('<Leader>vs', builtin.lsp_document_symbols, '[V]iew [S]ymbols')
nmap('<Leader>vw', builtin.lsp_dynamic_workspace_symbols, '[V]iew [W]orkspace symbols')


require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'rust_analyzer', 'ts_ls' },
})
require('neodev').setup()

local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('ts_ls', {
    capabilities = capabilities,
    init_options = {
        preferences = {
            includeCompletionsForModuleExports = true,
            includeCompletionsForImportStatements = true,
            includeCompletionsWithInsertText = true,
            importModuleSpecifierPreference = 'non-relative',
        },
    },
    settings = {
        typescript = {
            preferences = {
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
                importModuleSpecifierPreference = 'non-relative',
            },
        },
        javascript = {
            preferences = {
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
                importModuleSpecifierPreference = 'non-relative',
            },
        },
    },
})
vim.lsp.enable('ts_ls')

vim.api.nvim_create_user_command('LspStart', function()
    vim.lsp.enable('ts_ls')
    vim.cmd('edit')
end, { force = true })

vim.api.nvim_create_user_command('LspStop', function()
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        client:stop()
    end
end, { force = true })

vim.api.nvim_create_user_command('LspRestart', function()
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        client:stop()
    end
    vim.defer_fn(function()
        vim.lsp.enable('ts_ls')
        vim.cmd('edit')
    end, 100)
end, { force = true })
