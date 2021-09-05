if !exists('g:lspconfig') | finish | endif

lua << EOF

-- Disable inline diagnotics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false
	}
)

-- LSP
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Mappings
  local opts = { noremap=true, silent=true }

	buf_set_keymap('n', '<space><space>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>r', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	buf_set_keymap('n', '<space>E', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

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
