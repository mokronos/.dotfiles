require("mason-null-ls").setup({
    ensure_installed = {
        -- Opt to list sources here, when available in mason.
    },
    automatic_installation = false,
    automatic_setup = true, -- Recommended, but optional
})

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        -- Anything not supported by mason.

        -- might be good to only have diagnostics on save to improve
        -- performance for pyright, but this is not working:
        null_ls.builtins.diagnostics.flake8.with({
            diagnostic_config  = { underline = false },
            method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
            extra_args = { "--ignore=" },
        }),
    }
})

-- require 'mason-null-ls'.setup_handlers() -- If `automatic_setup` is true.
