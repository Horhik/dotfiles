"
"░█░█░█▀█░█▀▄░█░█░▀█▀░█░█░░░░█▀▄░█▀▀░█░█
"░█▀█░█░█░█▀▄░█▀█░░█░░█▀▄░░░░█░█░█▀▀░▀▄▀
"░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░▀░▀░░▀▀░░▀▀▀░░▀░
"
"
syntax enable
syntax on
set nocompatible
set relativenumber
set nu rnu
set wildmenu
set mouse=a
set noshowmode
set tabstop=2
set shiftwidth=2
set expandtab
set guifont="Fira Mono for Powerline"\ 14
set encoding=UTF-8
set path+=**


"---Plugins---"
call plug#begin('~/.vim/plugged')
Plug 'dracula/vim'
call plug#end()
