-- expose nvim capabilities to any LSP
local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Lua Language
lspconfig.lua_ls.setup({
  capabilities = lsp_capabilities,
  on_attach = require("lsp-format").on_attach
})
