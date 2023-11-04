-- Lsp keybindings
-- ref: https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = { buffer = true }
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap("n", "<C-k><C-i>", "<cmd>lua vim.lsp.buf.hover()<cr>")

    -- Code actions
    bufmap("n", "<C-k><C-a>", "<cmd>lua vim.lsp.buf.code_action()<cr>")

    -- Jump to the definition
    bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")

    -- Lists all the references
    bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")

    -- Renames all references to the symbol under the cursor
    bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")

    -- Move to the next diagnostic
    bufmap("n", "<F8>", "<cmd>lua vim.diagnostic.goto_next()<cr>")
  end,
})
