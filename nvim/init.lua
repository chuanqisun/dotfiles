-- Editing
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2 
vim.opt.expandtab = true -- Tab to spaces
vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "yes"  -- Keep it on to avoid layout shift
vim.opt.hidden = true -- New file hides modified buffer
vim.opt.ignorecase = true
vim.opt.smartcase = true -- Case sentitive when there is upper case character. Override with \C or \c

-- System
vim.opt.swapfile = false

-- Style
vim.opt.termguicolors = true -- Inherit color scheme from terminal


-- Mouse
vim.opt.mouse = vim.opt.mouse + "a"  -- Mouse interaction in all modes

-- Cursor 
vim.opt.guicursor = "n-v-c:block-Cursor"
vim.opt.guicursor = vim.opt.guicursor + "i:ver100-iCursor"
vim.opt.guicursor = vim.opt.guicursor + "n-v-c:blinkon0"
vim.opt.guicursor = vim.opt.guicursor + "i:blinkon100"

-- Keyboard
vim.g.mapleader = ' ' -- Space as leader key
vim.keymap.set('', '<space>', '<nop>', { noremap = true})


-- PlugIn specific (Todo: move into modules)
require('packer').startup(function(use)
  -- Package manager, must be first
  use { "wbthomason/packer.nvim" }

  -- Theme
  use { "ellisonleao/gruvbox.nvim" }
  vim.o.background = "dark" -- or "light" for light mode
  vim.cmd([[colorscheme gruvbox]])

  -- Search
  use { 'junegunn/fzf', run = ":call fzf#install()" }
  use { 'junegunn/fzf.vim' }
  vim.keymap.set('n', '<leader>p', ':FZF<CR>', { noremap = true})
  vim.keymap.set('n', '<leader>f', ':Rg<CR>', { noremap = true})
end)
