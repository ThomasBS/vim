set nocompatible              " be iMproved, required
filetype off                  " required

"""""""""""""""""
" Vundle specific
"""""""""""""""""

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" remove conflict warnings
let g:ale_emit_conflict_warnings = 0

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
" Bundle "jistr/vim-nerdtree-tabs"
Bundle "kien/ctrlp.vim"
Bundle "mattn/emmet-vim"
Bundle "mhinz/vim-startify"
" Bundle "scrooloose/nerdtree"
Bundle "scrooloose/syntastic"
Bundle "terryma/vim-expand-region"
Bundle "tpope/vim-fugitive"

" Zen mode, simplicity etc.
Bundle "junegunn/goyo.vim"
Bundle "junegunn/seoul256.vim"
Bundle "junegunn/limelight.vim"

" php docs
Bundle "tobyS/pdv"
Bundle "tobyS/vmustache"
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates"
nnoremap <buffer> <C-i> :call pdv#DocumentCurrentLine()<CR>

" Language specific
" Bundle "groenewege/vim-less"
Bundle "fatih/vim-go"

" go configurations
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1

" PHP ENV SETUP ATTEMPT
" (https://robertbasic.com/blog/current-vim-setup-for-php-development/)
" Bundle "bronson/vim-trailing-whitespace"
"
"
" tags
" Bundle "ludovicchabant/vim-gutentags"
" Auto use statements and namespaces
" Bundle "arnaud-lb/vim-php-namespace"
" asynchronous lint engine
" Bundle "w0rp/ale"
" PHP Completion daemon
" Bundle "lvht/phpcd.vim"

" ==== gutentags settings ====
" Exclude css, html, js files from generating tag files
let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.js', '*.json', '*.xml', '*.go',
                            \ '*.phar', '*.ini', '*.rst', '*.md',
                            \ '*vendor/*/test*', '*vendor/*/Test*',
                            \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
                            \ '*var/cache*', '*var/log*']
" Where to store tag files
let g:gutentags_cache_dir = '~/.vim/gutentags'
" ==== End gutentags settings ====

let g:ale_linters = {
\   'php': ['php'],
\}

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0

" ==== vim-php-namespace settings ====
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>pnu <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>pnu :call PhpInsertUse()<CR>
function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction
autocmd FileType php inoremap <Leader>pne <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>pne :call PhpExpandClass()<CR>
autocmd FileType php inoremap <Leader>pns <Esc>:call PhpSortUse()<CR>
autocmd FileType php noremap <Leader>pns :call PhpSortUse()<CR>
let g:php_namespace_sort_after_insert=1

" ==== End plugin settings ====

" ==== Custom functions ====
function! FixSyntax()
    " nmap <silent> <leader><leader>fs :syntax sync fromstart<cr>
    syntax sync fromstart
endfun

function! OpenTestFile()
    let b:file = expand("%:p:r")
    let b:root_dir = getbufvar('%', 'rootDir')
    let b:tests_dir = b:root_dir . "/tests"
    let b:test_file = substitute(b:file, b:root_dir, b:tests_dir, "") . "Test.php"
    exe ":vsp " b:test_file
endfun

function! OpenTestMethodFile()
    let b:file = expand("%:p:r")
    let b:root_dir = getbufvar('%', 'rootDir')
    let b:tests_dir = b:root_dir . "/tests"
    let b:class_test_dir = substitute(b:file, b:root_dir, b:tests_dir, "")
    let b:current_method = substitute(tagbar#currenttag('%s',''), '\(^.\)', '\u&', 'g')
    if !isdirectory(b:class_test_dir)
        call mkdir(b:class_test_dir, 'p')
    endif
    let b:test_file = b:class_test_dir . "/" . b:current_method . "Test.php"
    exe ":vsp " b:test_file
endfun

function! CopyPasteMethodBody(from_line, to_line)
    execute a:from_line
    normal! yiB
    execute a:to_line
    normal! p
endfun

function! IndentHtmlFile()
    set ft=html
    normal! ggVG=<cr>
    set ft=php
endfun

function! SectionLink()
    exe "normal! ^wi[\elv$hyA](#)\ePvibu"
endfun

function! CreateNamespace()
    let b:file = expand("%:p:h")
    let b:root_dir = getbufvar('%', 'rootDir')
    let b:class = substitute(b:file, b:root_dir . '/src', '', "")
    let b:namespace = substitute(b:class, '/', '\\', 'g')
    let b:namespace = substitute(b:namespace, '\\', '', '')
    exe "normal! Inamespace " . b:namespace . ";"
endfun

" ==== End custom functions ====

" Make backspace behave like normal editors
set backspace=indent,eol,start

" Call OpenTestFile() custom function
nnoremap <leader>otf :call OpenTestFile()<cr>
nnoremap <leader>otmf :call OpenTestMethodFile()<cr>

" ==== Automatic ====
" Automatically change cwd to the directory of the file in the current buffer
" autocmd BufEnter * silent! lcd %:p:h

" ----------------------------------------------------------------------------------------

filetype plugin indent on     " required

" Goyo settings for entering and leaving
function! s:goyo_enter()
  silent !tmux set status off
  " silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set cursorline!
  set cursorcolumn!
  set scrolloff=999
  " Limelight
  " ...
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  " Limelight!
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

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
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_php_phpcs_args = '--report=csv --standard=PSR2 --encoding=utf-8'

" nerd tree
let g:nerdtree_tabs_open_on_console_startup=0

" -- make ctrlp great again! --
" use git to exclude some files and folders
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" use persistent cache location
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
" keep cache even when exiting vim
" let g:ctrlp_clear_cache_on_exit = 0
" custom ignore files/folders
let g:ctrlp_custom_ignore = {'dir': 'vendor'}

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

" Use arrow keys to resize windows
 noremap <Up> <C-W>+
 noremap <Down> <C-W>-
 noremap <Left> 3<C-W><
 noremap <Right> 3<C-W>>

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
set runtimepath+=~/.vim/my-snippets

"""""""""""
" Functions
""""""""""

" When editing a file always jump to latest known cursor position.
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
