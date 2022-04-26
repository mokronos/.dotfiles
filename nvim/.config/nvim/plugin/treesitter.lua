require'nvim-treesitter.configs'.setup {

  ensure_installed = "all",

  highlight = {
    enable = true,

  },
-- produces weird error in python, where after a parenthesis, RETURN indents up to that perenthesis
  indent = {
    enable = false,

  },
}
