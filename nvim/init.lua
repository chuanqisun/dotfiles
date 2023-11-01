-- Editor config
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true -- Tab to spaces
vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "yes" -- Keep it on to avoid layout shift
vim.opt.hidden = true -- New file hides modified buffer
vim.opt.ignorecase = true
vim.opt.smartcase = true -- Case sentitive when there is upper case character. Override with \C or \c
vim.opt.swapfile = false
vim.opt.termguicolors = true -- Inherit color scheme from terminal
vim.opt.mouse = vim.opt.mouse + "a" -- Mouse interaction in all modes
vim.opt.hlsearch = false -- quiet search highlight


-- Cursor
vim.opt.guicursor = "n-v-c:block"
vim.opt.guicursor = vim.opt.guicursor + "i-ci-ve:ver25,r-cr:hor20,o:hor50"
vim.opt.guicursor = vim.opt.guicursor + "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
vim.opt.guicursor = vim.opt.guicursor + "sm:block-blinkwait175-blinkoff150-blinkon175"

-- Theme
vim.cmd("colorscheme slate")
vim.o.background = "dark" -- or "light" for light mode

-- PlugIn specific (Todo: move into modules)
require("packer").startup(function(use)
	-- Package manager, must be first
	use("wbthomason/packer.nvim")

  -- Commentary
	use("terrortylor/nvim-comment")
  require("nvim_comment").setup()

  -- Copilot, lazy loaded on insert
  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  }

	-- required by many other plugins
  use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
  }

  require("mason").setup()
  require("mason-lspconfig").setup()

end)
