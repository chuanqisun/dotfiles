if !exists('g:loaded_telescope') | finish | endif

nnoremap <silent> <C-p> <cmd>Telescope find_files<cr>
nnoremap <silent> <C-_> <cmd>Telescope live_grep<cr>

lua << EOF
local actions = require('telescope.actions')

require('telescope').setup()
EOF
