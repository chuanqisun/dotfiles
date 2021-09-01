" --- Plugins ---
call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'hoob3rt/lualine.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'romgrk/barbar.nvim' " requires nvim-web-devicons
Plug 'kyazdani42/nvim-tree.lua' " requires nvim-web-devicons
Plug 'prettier/vim-prettier' 
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " Plugin author recommend updating the parsers on update
Plug 'tpope/vim-commentary' 
Plug 'JoosepAlviste/nvim-ts-context-commentstring' " Uses tpope/vim-commentary


" Language specific
Plug 'cespare/vim-toml' " toml

"Plug 'pangloss/vim-javascript' " javascript
"Plug 'leafgarland/typescript-vim' " typescript
Plug 'jonsmithers/vim-html-template-literals' " javascript/typescript
call plug#end()

" --- Vim features ---
set number " number on
set relativenumber " smart relative number

set autoindent
set clipboard=unnamedplus " System clipboard integration

set signcolumn=yes " Keep it on to avoid distraction
"set hidden " Allow modified buffer to be hidden

set ignorecase
set smartcase " Case sentitive when there is upper case character. Override with \C or \c

set tabstop=2
set shiftwidth=2 

set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkon100

set mouse+=a " Mouse interaction in all modes

" --- Styles
set termguicolors
colorscheme gruvbox " Requires `gruvbox-community/gruvbox` plugin

