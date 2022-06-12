" --- Plugins ---
call plug#begin()
Plug 'gruvbox-community/gruvbox'
Plug 'prettier/vim-prettier' 
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
set expandtab

set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkon100

set mouse+=a " Mouse interaction in all modes


" --- Global keymapping
nnoremap <SPACE> <Nop>
let mapleader=" "


" --- Styles
set termguicolors
colorscheme gruvbox " Requires `gruvbox-community/gruvbox` plugin

