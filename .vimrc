set nocompatible              " be iMproved, required
filetype off                  " required

filetype plugin indent on    " required

" enable syntax highlighting
syntax on

" utf-8 everywhere
set encoding=utf-8
set binary

" relative line numbers
set ruler
set relativenumber

" tab = 4 spaces
set expandtab 
set shiftwidth=4
set tabstop=4

" allow backspace in insert mode
set backspace=indent,eol,start

" Show the filename in the window titlebar
set title

" show current mode
set showmode
set showcmd

" Disable error bells
set noerrorbells

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" search highlighting
set hlsearch

" command completion
set wildmenu
set wildmode=longest:list,full

" mouse
set mouse=a

" don't move to start of newline but keep indentation level
set autoindent

" share system clipboard
set clipboard=unnamed

" optimize for fast terminal connections
set ttyfast

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" store swap files in /tmp instead of wd
set directory=/tmp

" enable closetag in these files
let g:closetag_filenames = '*.html,*.php'

" use a project specific tag file first
set tags=./.tags;,~/.vimtags

" Python specific set-up:
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix
