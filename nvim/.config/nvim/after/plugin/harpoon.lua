require("harpoon").setup({
    global_settings = {
        -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
        save_on_toggle = false,

        -- saves the harpoon file upon every change. disabling is unrecommended.
        save_on_change = true,

        -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
        enter_on_sendcmd = false,

        -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
        tmux_autoclose_windows = false,

        -- filetypes that you want to prevent from adding to the harpoon list menu.
        excluded_filetypes = { "harpoon" },

        -- set marks specific to each git branch inside git repository
        mark_branch = false,
    }
}
)

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<Leader>hm", function () mark.add_file() end , {desc = "[H]arpoon [M]ark file"})
vim.keymap.set("n", "<Leader>hs", function () ui.toggle_quick_menu() end , {desc = "[H]arpoon [S]tatus"})

vim.keymap.set("n", "<Leader>hj", function () ui.nav_file(1) end , {desc = "[H]arpoon jump to mark 1"})
vim.keymap.set("n", "<Leader>hk", function () ui.nav_file(2) end , {desc = "[H]arpoon jump to mark 2"})
vim.keymap.set("n", "<Leader>hl", function () ui.nav_file(3) end , {desc = "[H]arpoon jump to mark 3"})
vim.keymap.set("n", "<Leader>h;", function () ui.nav_file(4) end , {desc = "[H]arpoon jump to mark 4"})
