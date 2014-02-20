set nocompatible              " be iMproved, required
filetype off                  " required


"""""""""""""""""
"
" Vundle specific
"
"""""""""""""""""

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required
Bundle 'gmarik/vundle'

" Custom bundles
Bundle "vim-less"
Bundle "nanotech/jellybeans.vim"
Bundle "groenewege/vim-less"
Bundle "digitaltoad/vim-jade"
Bundle "scrooloose/syntastic"

filetype plugin indent on     " required
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.

"""""""""""""""""
"
" Custom settings
"
"""""""""""""""""

" Color
colorscheme jellybeans

" Tab options
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Indentation
set autoindent

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set nospell

" Syntax
syntax on

" Syntastic - Customize php settings
let g:syntastic_php_phpcs_args = '--report=csv --standard=PSR2 --encoding=utf-8'

" Navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

set scrolloff=15

" Viewport
set ruler
set number

" History
set history=500
set undolevels=500
