if !exists('g:loaded_telescope') | finish | endif

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader><Tab> <cmd>Telescope buffers<cr>

lua << EOF
local actions = require('telescope.actions')

require('telescope').setup()
EOF
