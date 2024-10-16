local opt = vim.opt_local

vim.opt_local.spell = true
vim.opt_local.spelllang = { "en_us", "de_de" }

-- quick fix last wrong word in insert mode
vim.keymap.set('i', '<C-s>', '<C-g>u<Esc>[s1z=`]a<C-g>u', {desc = 'fix last spelling error'})

-- open dictionary autocomplete
vim.keymap.set('i', '<C-c>', '<C-x><C-k>', {desc = 'dictionary autocomplete'})

-- spellfile probably should be cleaned at some point, but spellclean.vim is not in neovim. could do it myself (regex)

opt.wrap = true
opt.linebreak = true


local function pairsByKeys (t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0
    local iter = function ()
        i = i + 1
        if a[i] == nil then return nil
        else return a[i], t[a[i]]
        end
    end
    return iter
end

local function sortHeadings()
    print("Sorting headings")
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local headings = {}
    local cur_heading = nil
    local first_heading_idx = nil

    for i = 1, #lines do
        local line = lines[i]
        if line:match("^## ") then
            if first_heading_idx == nil then
                first_heading_idx = i - 1
            end
            cur_heading = line.sub(line, 4)
            headings[cur_heading] = {}
        else
            if cur_heading ~= nil then
                table.insert(headings[cur_heading], line)
            end
        end
    end

    local sorted_headings = {}
    for k, v in pairsByKeys(headings) do
        table.insert(sorted_headings, "## " .. k)
        for i = 1, #v do
            table.insert(sorted_headings, v[i])
        end
    end

    vim.api.nvim_buf_set_lines(bufnr, first_heading_idx, -1, false, sorted_headings)

end

-- local augroup = vim.api.nvim_create_augroup('mdau', { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     pattern = "*.md",
--     callback = sortHeadings,
--     group = augroup,
--     desc="Sort headings in markdown glossary",
-- })

vim.api.nvim_buf_create_user_command(
    0,
    "SortHeadings",
    sortHeadings,
    {}
)
