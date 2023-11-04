require("rust-tools").setup({
  tools = {
    inlay_hints = {
      auto = false,
    },
    hover_actions = {
      auto_focus = true, -- Issue: https://github.com/simrat39/rust-tools.nvim/issues/273
    },
  }
})

vim.g.rustfmt_autosave = 1
