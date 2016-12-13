set nocompatible              " be iMproved, required
filetype off                  " required

"""""""""""""""""
" Vundle specific
"""""""""""""""""

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required
Bundle 'gmarik/vundle'

" Bundle 'FredKSchott/CoVim'
" Custom bundles

" Themes
Bundle "zenorocha/dracula-theme"
Bundle "nanotech/jellybeans.vim"
Bundle "whatyouhide/vim-gotham"

" Misc
Bundle "SirVer/ultisnips"
Bundle "Townk/vim-autoclose"
Bundle "airblade/vim-gitgutter"
Bundle "bling/vim-airline"
Bundle "flazz/vim-colorschemes"
Bundle "honza/vim-snippets"
Bundle "jistr/vim-nerdtree-tabs"
Bundle "kien/ctrlp.vim"
Bundle "mattn/emmet-vim"
Bundle "mhinz/vim-startify"
Bundle "scrooloose/nerdtree"
Bundle "scrooloose/syntastic"
Bundle "terryma/vim-expand-region"
Bundle "tpope/vim-fugitive"

" Language specific
Bundle "groenewege/vim-less"
Bundle "fatih/vim-go"


filetype plugin indent on     " required

"""""""""""""""""
"
" Custom settings
"
"""""""""""""""""

" Only enable emmet for html/css
" let g:user_emmet_install_global = 0
" autocmd FileType html,css EmmetInstall

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Map leader
let mapleader = ","

" Ex
nmap ,e :Ex<CR>

" NERDTree
map <C-1> :NERDTreeToggle<CR>

" Color
colorscheme obsidian

" Add 256 colors
set t_Co=256

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

" startify
let g:startify_custom_header =
  \ map(split(system('fortune | cowsay'), '\n'), '"   ". v:val') + ['','']

" Set airline powerline fonts on
let g:airline_powerline_fonts = 1

" Syntastic - Customize php settings
let g:syntastic_php_phpcs_args = '--report=csv --standard=PSR2 --encoding=utf-8'

" nerd tree
let g:nerdtree_tabs_open_on_console_startup=0

" Syntastic - JSCS styleguide
autocmd FileType javascript let b:syntastic_checkers = findfile('.jscsrc', '.;') != '' ? ['jscs'] : ['jshint']

" Easier window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Easier closing tags
imap ,,, <esc>bdwa<<esc>pa><cr></<esc>pa><esc>kA<cr>

set scrolloff=25

" Viewport
set ruler
set number

" History
set history=500
set undolevels=500

" Key bindings
inoremap ½ $

" Disable arrow keys
" http://vimcasts.org/blog/2013/02/habit-breaking-habit-making/
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>

" Backup and swp
set backupdir=~/.vim/swap
set dir=~/.vim/swap

" Custom settings for transparent background
" hi Normal ctermbg=NONE
" hi LineNr ctermbg=NONE

" Custom color settings for active cursorline
set cursorline
set cursorcolumn
set relativenumber
hi CursorLineNr ctermfg=255 ctermbg=none
"

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

set runtimepath+=~/.vim/ultisnips

"""""""""""
" Functions
""""""""""

" When editing a file always jump to latest known cursor position.
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
