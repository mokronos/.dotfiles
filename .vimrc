filetype plugin indent on
syntax on
set number relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set ai
set hlsearch
set ruler
set nobackup
set noswapfile
set noundofile
set encoding=utf-8
set belloff=all

highlight Comment ctermfg=green
highlight PreProc ctermfg=12
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
