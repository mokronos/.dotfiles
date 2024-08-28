vim.keymap.set('', '<Leader>c', '<Plug>Commentary', {desc = '[C]ommentary operator'})
vim.keymap.set('n', '<Leader>cc', '<Plug>CommentaryLine', {desc = '[C]omment line toggle'})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "cuda",
    callback = function()
        vim.bo.commentstring = "// %s"
    end
})

-- works for now, but need better solution + some html not recognized as jinja template
vim.api.nvim_create_autocmd("FileType", {
    pattern = "htmldjango",
    callback = function()
        vim.bo.commentstring = "{# %s #}"
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "cpp",
    callback = function()
        vim.bo.commentstring = "// %s"
    end
})
