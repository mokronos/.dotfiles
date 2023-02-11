local options = {
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
     accept = "<S-Tab>",
     next = "<M-]>",
     prev = "<M-[>",
     dismiss = "<C-]>",
    },
  },
  filetypes = {
    yaml = true,
    markdown = true,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = 'node', -- Node version must be < 18
  plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
  server_opts_overrides = {},
}

require("copilot").setup(options)


local opts = { noremap=true, silent=true}
vim.keymap.set('n', '<Leader>po', require'copilot.panel'.open , opts)
vim.keymap.set('n', '<Leader>pa', require'copilot.panel'.accept , opts)
