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
" Tabs and indent
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Expands tab
set expandtab

" Auto-indent
set ai
set si
set ci

" Auto-indent amount
set shiftwidth=2
set shiftround

" Tabs
set tabstop=2
set softtabstop=2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

" General Plugins
Plug 'mhinz/vim-signify'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'

" Languages
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'williamboman/mason.nvim'

" Colorscheme
Plug 'morhetz/gruvbox'

" Tmux integration
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'

" Nvim Tree
Plug 'nvim-tree/nvim-tree.lua'

" Needed for other plugins
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.x' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

" Vsnips
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme
autocmd vimenter * ++nested colorscheme gruvbox

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load Lua Configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require('config')

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

" Nvim Tree toggle
nmap <leader>n :NvimTreeFindFileToggle<CR>

" Telescope mappings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" nvim cmp
set completeopt=menu,menuone,noselect
