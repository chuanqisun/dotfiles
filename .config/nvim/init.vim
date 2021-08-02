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
Plug 'nvim-lua/lsp-status.nvim'
Plug 'romgrk/barbar.nvim'
call plug#end()

" --- Vim features ---
set number " number on
set relativenumber " smart relative number

set autoindent
set clipboard=unnamedplus " System clipboard integration

set hidden " Allow modified buffer to be hidden

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
colorscheme gruvbox " Requires `morhetz/gruvbox` plugin

