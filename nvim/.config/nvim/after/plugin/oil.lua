require("oil").setup(
    {
        view_options = {
            show_hidden = true,
        },
    }
)
vim.keymap.set("n", "<Leader>o", "<CMD>Oil<CR>", { desc = "[O]pen File Tree" })
