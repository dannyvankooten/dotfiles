set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Plugin 'VundleVim/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-vinegar'

" All of your Plugins must be added before the following line
call vundle#end()            " required
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
set shiftwidth=4
set tabstop=4

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

" share system clipboard
set clipboard=unnamed

" optimize for fast terminal connections
set ttyfast

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" store swap files in /tmp instead of wd
set directory=/tmp

" run GoImport on save
let g:go_fmt_command = "goimports"
