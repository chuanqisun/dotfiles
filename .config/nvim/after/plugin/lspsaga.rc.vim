if !exists('g:loaded_lspsaga') | finish | endif

lua << EOF

local saga = require 'lspsaga'

saga.init_lsp_saga {
  border_style = "round",
}

EOF

nnoremap <silent>K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
nnoremap <silent>gr <cmd>lua require('lspsaga.rename').rename()<CR>
nnoremap <silent> gd <cmd>lua require'lspsaga.provider'.preview_definition()<CR>
nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
nnoremap <silent> gh <Cmd>Lspsaga lsp_finder<CR>
