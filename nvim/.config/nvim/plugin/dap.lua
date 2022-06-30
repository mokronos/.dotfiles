require('dap-python').setup('/usr/bin/python3')
require('dapui').setup()

-- open dapui automatically when dap session starts
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end


local opts = { noremap=true, silent=true}
-- debugging
vim.keymap.set('n', '<Leader>db', require'dap'.toggle_breakpoint, opts)
vim.keymap.set('n', '<Leader>dc', require'dap'.continue, opts)
vim.keymap.set('n', '<Leader>dt', require'dap'.terminate, opts)
vim.keymap.set('n', '<Leader>do', require'dap'.step_over, opts)
vim.keymap.set('n', '<Leader>di', require'dap'.step_into, opts)
vim.keymap.set('n', '<Leader>du', require'dap'.step_out, opts)
vim.keymap.set('n', '<Leader>dr', require'dap'.step_back, opts)
-- toggle ui
vim.keymap.set('n', '<Leader>du', require'dapui'.toggle, opts)
