" ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
" ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
" ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
" ░░░░░░░░░░░░░░░░░░░░░█░█░█▀█░█▀▄░█░█░▀█▀░█░█░▀░█▀▀░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
" ░░░░░░░░░░░░░░░░░░░░░█▀█░█░█░█▀▄░█▀█░░█░░█▀▄░░░▀▀█░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
" ░░░░░░░░░░░░░░░░░░░░░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░▀░░░▀▀▀░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
" ░░░░░░░░░░░░░░░░░░░░░█▀▄░█▀█░▀█▀░█▀▀░▀█▀░█░░░█▀▀░█▀▀░░░░░░░░░░░░░░░░░░░░░░░░░░░░
" ░░░░░░░░░░░░░░░░░░░░░█░█░█░█░░█░░█▀▀░░█░░█░░░█▀▀░▀▀█░░░░░░░░░░░░░░░░░░░░░░░░░░░░
" ░░░░░░░░░░░░░░░░░░░░░▀▀░░▀▀▀░░▀░░▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░░░░░░░░░░░░░░░░░░░░░░░░░░░░
" ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
" ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
" ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
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
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'mboughaba/i3config.vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'gchrisdone/hindent'
Plug 'gjaspervdj/stylish-haskell'
Plug 'jaspervdj/stylish-haskell'
Plug 'chrisdone/hindent'
Plug 'dense-analysis/ale'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'phanviet/vim-monokai-pro'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'sheerun/vim-polyglot'
Plug 'ayu-theme/ayu-vim' " or other package manager
Plug 'sickill/vim-monokai'
Plug 'yarisgutierrez/ayu-lightline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'arcticicestudio/nord-vim'
Plug 'autozimu/LanguageClient-neovim'
Plug 'lervag/vimtex'
Plug 'ap/vim-css-color'
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim'
call plug#end()

aug i3config_ft_detection
	  au!
	    au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end

if !has('gui_running')
  set t_Co=256
endif
let g:molokai_original = 1
" ---AirLine--- "
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif



set termguicolors     " enable true colors support
"let ayucolor="mirage" " for mirage version of theme
let ayucolor="dark"   " for dark version of theme
" colorscheme onedark
colorscheme dracula
let g:airline_theme='onedark'
let g:onedark_terminal_italics = 1


"keybuildings"
map <C-o> :NERDTreeToggle<CR>


let g:prettier#config#print_width = 'auto'
let g:prettier#config#tab_width = 'auto'
let g:prettier#config#use_tabs = 'auto'
let g:prettier#config#parser = ''
let g:prettier#config#config_precedence = 'file-override'
let g:prettier#config#prose_wrap = 'preserve'
let g:prettier#config#html_whitespace_sensitivity = 'css'
let g:prettier#config#require_pragma = 'false'

" Prettier 
let g:prettier#autoformat = 1
let g:prettier#exec_cmd_path = "/usr/bin/prettier"
let g:prettier#config#trailing_comma = 'none'


"--Ale--"
let g:ale_fix_on_save = 1
let b:ale_fixers = ['prettier', 'eslint']
