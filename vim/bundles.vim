set nocompatible               " be iMproved
filetype off                   " required!

" Init vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'SudoEdit.vim'
Bundle 'itspriddle/vim-marked'

" Snippets
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"

" Programming
Bundle 'snipMate'
Bundle 'gregsexton/MatchTag'
Bundle 'matchit.zip'
Bundle 'rking/ag.vim'
Bundle 'scrooloose/syntastic'
Bundle 'rizzatti/dash.vim'

" Git integration
Bundle 'git.zip'
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'

" Indentation
Bundle 'IndentAnything'
Bundle 'trailing-whitespace'

" Syntax
Bundle 'tpope/vim-markdown'

" Color schemes
Bundle 'Wombat'
Bundle 'wombat256.vim'

" Style
Bundle 'Lokaltog/vim-powerline.git'

filetype plugin indent on     " required!
