local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<Leader>hm", function() harpoon:list():append() end , {desc = "[H]arpoon [M]ark file"})
vim.keymap.set("n", "<Leader>hs", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end , {desc = "[H]arpoon [S]tatus"})

vim.keymap.set("n", "<Leader>hj", function() harpoon:list():select(1) end , {desc = "[H]arpoon jump to mark 1"})
vim.keymap.set("n", "<Leader>hk", function() harpoon:list():select(2) end , {desc = "[H]arpoon jump to mark 2"})
vim.keymap.set("n", "<Leader>hl", function() harpoon:list():select(3) end , {desc = "[H]arpoon jump to mark 3"})
vim.keymap.set("n", "<Leader>h;", function() harpoon:list():select(4) end , {desc = "[H]arpoon jump to mark 4"})
