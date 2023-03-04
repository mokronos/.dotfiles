local table1 = {noremap = true, silent = true}
local table2 = {description = '[H]over info LSP'}

local tablecombined = vim.tbl_extend('force', table1, table2)

table.foreach(tablecombined, print)
