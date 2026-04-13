require("supermaven-nvim").setup({
  keymaps = {
    accept_suggestion = "<C-K>",
    clear_suggestion = "<C-]>",
    accept_word = "<S-Tab>",
  },
  ignore_filetypes = { cpp = false },
  color = {
    suggestion_color = "#8a8a8a",
    cterm = 244,
  },
  log_level = "info",
  disable_inline_completion = false,
  disable_keymaps = false,
  condition = function()
    return false
  end
})