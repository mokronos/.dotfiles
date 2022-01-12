"Sets
filetype plugin indent on

set exrc

set path+=**
set nohlsearch

set number relativenumber
set scrolloff=8

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set termguicolors
set wildmode=longest,list,full
set guicursor=i:block

set nobackup
set noswapfile
set undodir=~/.nvim/undodir
set undofile
set shortmess+=c 

set signcolumn=yes
set colorcolumn=80
set breakindent
set linebreak

set completeopt=menu,menuone,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

set updatetime=50

autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
au BufNewFile,BufFilePre,BufRead *.md setlocal colorcolumn=""

set clipboard=unnamed

"*************************************************
call plug#begin('~/.nvim/plugged')

Plug 'gruvbox-community/gruvbox'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'preservim/nerdtree'

Plug 'tpope/vim-fugitive'

Plug 'vim-airline/vim-airline'

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-surround'

Plug 'mbbill/undotree'

Plug 'dense-analysis/ale'

Plug 'neovim/nvim-lspconfig'

Plug 'plasticboy/vim-markdown'

call plug#end()
"*************************************************
colorscheme gruvbox
set t_Co=256

let mapleader = " "

" terminal
tnoremap <Esc> <C-\><C-n>
command! -nargs=* T split | terminal <args>
command! -nargs=* VT vsplit | terminal <args>

"Ale
let g:ale_lint_on_insert_leave=1

" remaps
nnoremap <leader>ps <cmd>Telescope find_files<cr>
nnoremap <leader>t <cmd>NERDTreeToggle<cr>
nnoremap <leader>u <cmd>UndotreeToggle<cr>
nnoremap <leader>vt <cmd>Sex<cr>
nnoremap <leader>d <cmd>lua vim.lsp.buf.definition()<cr>
nmap <leader>c <Plug>Commentary
nmap <leader>cc <Plug>CommentaryLine
nnoremap <leader>oc :exe ':silent !start chrome %:p'<CR>
nmap <leader>gl :diffget //3<cr>
nmap <leader>gh :diffget //3<cr>
nmap <leader>gs :G<cr>

" markdown
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_folding_disabled = 1

lua <<EOF
require'lspconfig'.pylsp.setup{}
require('telescope').setup{  defaults = { file_ignore_patterns = { "%.git", "%.pdf" }} }
EOF
