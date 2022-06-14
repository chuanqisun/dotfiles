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


" --- File tree customization
let g:netrw_liststyle = 3
let g:netrw_keepdir = 0


" --- Global keymapping
nnoremap <SPACE> <Nop>
let mapleader=" "

" leader + p: list buffers 
nnoremap <leader>p :buffers<CR>:buffer<Space>
" leader + e: open file tree
nnoremap <leader>e :e .<CR> 
" leader + h/l focus tab
nnoremap <leader>h :tabprevious<CR>
nnoremap <leader>l :tabnext<CR>
" leader + t + h/l 
nnoremap <leader>th :tabm -1<CR>
nnoremap <leader>tl :tabm +1<CR>


" --- Styles
set termguicolors
colorscheme gruvbox " Requires `gruvbox-community/gruvbox` plugin

