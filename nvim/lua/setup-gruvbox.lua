require("gruvbox").setup({
  contrast = "hard",
  italic = {
    strings = false,
    emphasis = false,
    comments = false,
    operators = false,
    folds = false,
  },
})

vim.cmd("colorscheme gruvbox")
vim.opt.background = "dark" -- or "light" for light mode
