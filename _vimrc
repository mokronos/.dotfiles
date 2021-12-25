filetype plugin indent on
syntax on

set number relativenumber
set ruler
set scrolloff=1

set tabstop=4
set shiftwidth=4
set expandtab

set ai
set hlsearch
set incsearch

set nobackup
set noswapfile
set noundofile

set encoding=utf-8

set belloff=all

set backspace=indent,eol,start

set completeopt+=menuone
set completeopt+=noselect
set shortmess+=c 
let g:mucomplete#enable_auto_at_startup = 1

highlight Comment ctermfg=green
highlight PreProc ctermfg=12
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

call plug#begin('~/.vim/plugged')
"Plug 'scrooloose/syntastic'
"Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'lifepillar/vim-mucomplete'
Plug 'tpope/vim-commentary'
call plug#end()
