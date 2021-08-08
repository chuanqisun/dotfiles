if !exists('g:lspconfig') | finish | endif

lua << EOF

-- LSP
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Mappings
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

	-- Completion
	require'completion'.on_attach(client, bufnr)

end

-- Typescript lang
nvim_lsp.tsserver.setup { on_attach = on_attach }

-- Rust lang
nvim_lsp.rust_analyzer.setup({ 
	on_attach=on_attach
})

EOF
