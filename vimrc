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
Bundle "tpope/vim-surround"
Bundle "airblade/vim-gitgutter"
Bundle "Townk/vim-autoclose"
Bundle "flazz/vim-colorschemes"

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

" Map leader
let mapleader = ","

" Ex
nmap ,e :Ex

" Color
colorscheme obsidian

" Always show the status line
set laststatus=2

" Bubble single lines
nmap <C-Up> ddkP
nmap <C-Down> ddp

" Bubble multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]

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

" Easier window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

set scrolloff=25

" Viewport
set ruler
set number

" History
set history=500
set undolevels=500

" Key bindings
inoremap ½ $

" Backup and swp
set backupdir=~/.vim/swap
set dir=~/.vim/swap

"""""""""""
"
" Functions
"
""""""""""

" When editing a file always jump to latest known cursor position.
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
