-- autocomplete --> lsp connection
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- lsp
local lsp_installer = require("nvim-lsp-installer")

-- does not make sence yet, capabilities work with python even if only given to sumneko_lua
lsp_installer.on_server_ready(function(server)
    local opts = {}
    if server.name == "sumneko_lua" then
        opts = {
            settings = {
                Lua ={
                    diagnostics = {
                        globals = {"vim", "use"}
                    },
                }
            },
            capabilities = capabilities
        }
    end
    if server.name == "pyright" then
        opts = {
            settings = {
            },
            capabilities = capabilities
        }
    end
    server:setup(opts)
end)

local lsp = vim.lsp
local handlers = lsp.handlers

-- Hover doc popup
local pop_opts = { border = "rounded", max_width = 80 }
handlers["textDocument/hover"] = lsp.with(handlers.hover, pop_opts)
handlers["textDocument/signatureHelp"] = lsp.with(handlers.signature_help, pop_opts)


local opts = { noremap=true, silent=true}


vim.api.nvim_set_keymap('n', '<Leader>d', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
vim.api.nvim_set_keymap('n', '<Leader>K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
vim.api.nvim_set_keymap('n', '<Leader>R', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
vim.api.nvim_set_keymap('n', '<Leader>vs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
vim.api.nvim_set_keymap('n', '<Leader>vi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
vim.api.nvim_set_keymap('n', '<Leader>vc', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)