"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set default shell
set shell=/bin/zsh

" Show current position
set ruler

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ingnore case when searching
set ignorecase
set smartcase

" Improve search
nnoremap <esc><esc> :noh<return>
set incsearch
set hlsearch

" Show matching bracets
set showmatch

" Set numbers
set nu

" Better command autocompletion
set wildmenu

" No redraw
set lazyredraw

" No linespace between rows
set linespace=0

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Always display status line
set laststatus=2

" Show column max
set colorcolumn=120
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files and backup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn off backup
set nobackup
set nowb
set noswapfile
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Define the map leader
let mapleader = ","

" Stop using <esc>
inoremap jk <esc>
inoremap <esc> <nop>

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

" General Plugins
Plug 'mhinz/vim-signify'

" Languages
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load Lua Configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require('config')
