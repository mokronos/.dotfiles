local trouble = require("trouble")
trouble.setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
}

vim.keymap.set("n", "<Leader>tt", function() trouble.toggle() end , {desc = "[T]rouble [T]oggle"})
vim.keymap.set("n", "<Leader>tw", function() trouble.toggle("workspace_diagnostics") end , {desc = "[T]rouble [W]orkspace diagnostics"})
vim.keymap.set("n", "<Leader>tq", function() trouble.toggle("quickfix") end , {desc = "[T]rouble [Q]uickfix"})
vim.keymap.set("n", "<Leader>td", function() trouble.toggle("document_diagnostics") end , {desc = "[T]rouble [D]ocument diagnostics"})
vim.keymap.set("n", "<Leader>tl", function() trouble.toggle("loclist") end , {desc = "[T]rouble [L]oclist"})

vim.keymap.set("n", "<Leader>tn", function() trouble.next({skip_groups = true, jump = true}) end , {desc = "[T]rouble Jump to [N]ext"})
vim.keymap.set("n", "<Leader>tp", function() trouble.previous({skip_groups = true, jump = true}) end , {desc = "[T]rouble Jump to [P]revious"})
