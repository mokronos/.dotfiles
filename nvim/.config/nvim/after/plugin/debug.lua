-- local dap = require('dap')

-- dap.adapters.python = {
--     type = 'executable',
--     command = 'python',
--     args = { '-m', 'debugpy.adapter' },
-- }

-- dap.configurations.python = {
--   {
--     -- The first three options are required by nvim-dap
--     type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
--     request = 'launch';
--     name = "Launch file";

--     -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

--     program = "${file}"; -- This configuration will launch the current file if used.
--     pythonPath = function()
--       -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
--       -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
--       -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
--       local cwd = vim.fn.getcwd()
--       if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
--         return cwd .. '/venv/bin/python'
--       elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
--         return cwd .. '/.venv/bin/python'
--       else
--         return '/usr/bin/python'
--       end
--     end;
--   },
-- }


-- vim.keymap.set('n', '<Leader>db', function() dap.toggle_breakpoint() end, {desc = '[D]ebugger [B]reakpoint'})
-- vim.keymap.set('n', '<Leader>dc', function() dap.continue() end, {desc = '[D]ebugger [C]ontinue'})
-- vim.keymap.set('n', '<Leader>di', function() dap.step_into() end, {desc = '[D]ebugger [I]nto'})
-- vim.keymap.set('n', '<Leader>do', function() dap.step_over() end, {desc = '[D]ebugger [O]ver'})
-- vim.keymap.set('n', '<Leader>du', function() dap.step_out() end, {desc = '[D]ebugger [U]p'})
-- vim.keymap.set('n', '<Leader>dr', function() dap.repl.toggle() end, {desc = '[D]ebugger [R]epl'})
