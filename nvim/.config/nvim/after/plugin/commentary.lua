vim.keymap.set('', '<Leader>c', '<Plug>Commentary', {desc = '[C]ommentary operator'})
vim.keymap.set('n', '<Leader>cc', '<Plug>CommentaryLine', {desc = '[C]omment line toggle'})

-- works for now, but need better solution + some html not recognized as jinja template
vim.cmd([[
autocmd FileType htmldjango setlocal commentstring={#%s#}
]])
