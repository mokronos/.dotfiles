vim.g.slime_target = "tmux"
vim.g.slime_bracketed_paste = 1
vim.g.slime_dont_ask_default = 1
vim.g.slime_default_config = {
  ['socket_name'] = 'default',
  ['target_pane'] = '{bottom}',
}

-- shit is not working, need to rebind sending stuff over with vim-slime to different key (with leader)
-- vim.cmd([[nmap <Leader>ss <Plug>SlimeRegionSend]])

-- local opts = { noremap=true, silent=true}
-- vim.keymap.set('n', '<Leader>ss', <Plug>SlimeRegionSend , opts)
