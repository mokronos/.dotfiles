local lsp_installer = require("nvim-lsp-installer")
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
            }
        }
    end
    server:setup(opts)
end)


local opts = { noremap=true, silent=true}


vim.api.nvim_set_keymap('n', '<Leader>vd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
vim.api.nvim_set_keymap('n', '<Leader>vh', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
vim.api.nvim_set_keymap('n', '<Leader>vi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
vim.api.nvim_set_keymap('n', '<Leader>vc', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)

