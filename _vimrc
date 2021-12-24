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


highlight Comment ctermfg=green
highlight PreProc ctermfg=12
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
"Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
call plug#end()
