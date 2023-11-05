-- Editor config
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true            -- Tab to spaces
vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "yes"          -- Keep it on to avoid layout shift
vim.opt.hidden = true               -- New file hides modified buffer
vim.opt.ignorecase = true
vim.opt.smartcase = true            -- Case sentitive when there is upper case character. Override with \C or \c
vim.opt.swapfile = false
vim.opt.termguicolors = true        -- Inherit color scheme from terminal
vim.opt.mouse = vim.opt.mouse + "a" -- Mouse interaction in all modes
vim.opt.hlsearch = false            -- quiet search highlight


-- Cursor
vim.opt.guicursor = "n-v-c:block"
vim.opt.guicursor = vim.opt.guicursor + "i-ci-ve:ver25,r-cr:hor20,o:hor50"
vim.opt.guicursor = vim.opt.guicursor + "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
vim.opt.guicursor = vim.opt.guicursor + "sm:block-blinkwait175-blinkoff150-blinkon175"


-- Leader key
vim.g.mapleader = " " -- Space as leader key
vim.keymap.set("", "<space>", "<nop>", { noremap = true })

-- Alt hjkl window navigation
vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-N><C-w>h', { noremap = true })
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-N><C-w>j', { noremap = true })
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-N><C-w>k', { noremap = true })
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-N><C-w>l', { noremap = true })
vim.keymap.set('n', '<A-h>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<A-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<A-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<A-l>', '<C-w>l', { noremap = true })

-- Escape terminal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

-- Terminal behavior
vim.api.nvim_create_autocmd('TermOpen', {
  command = 'setlocal nonumber norelativenumber',
})
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '',
  command = 'startinsert'
})



-- Bootstrap packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

require("packer").startup(function(use)
  -- Package manager, must be first
  use { "wbthomason/packer.nvim" }

  -- Commentary
  use { "terrortylor/nvim-comment" }

  -- Theme
  use { "ellisonleao/gruvbox.nvim" }


  -- File explorer with fzf
  use { "junegunn/fzf", run = ":call fzf#install()" }
  use { "junegunn/fzf.vim" }

  -- Copilot, lazy loaded on insert
  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  }

  -- LSP is required by many other plugins
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

  -- Completion
  use {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",
    "hrsh7th/nvim-cmp",
  }

  -- Auto formatting
  -- Ref: https://github.com/lukas-reineke/lsp-format.nvim
  use { "lukas-reineke/lsp-format.nvim" }

  -- Rust Language
  use { "rust-lang/rust.vim" }
  use { "simrat39/rust-tools.nvim" }

  require("nvim_comment").setup()
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "rust_analyzer" }
  })
  require("lsp-format").setup()
  require("plugins/setup-gruvbox")
  require("plugins/setup-fzf")
  require("plugins/setup-cmp")
  require("plugins/setup-rust")
  require("plugins/setup-lua") -- require lspconfig, cmp_nvim_lsp, lsp-format
  require("plugins/setup-lsp")

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  -- Ref: https://github.com/wbthomason/packer.nvim#quickstart
  if packer_bootstrap then
    require('packer').sync()
  end
end)
