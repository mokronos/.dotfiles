local languages = { "vimdoc", "python", "c", "lua", "rust" }

vim.defer_fn(function()
    require('nvim-treesitter').install(languages)
end, 0)

vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
        local ok = pcall(vim.treesitter.start, args.buf)
        if ok then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end,
})
