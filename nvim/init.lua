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
  use {"wbthomason/packer.nvim", config = function()
    require('packer').init{ max_jobs = 10 } -- Ref: https://github.com/wbthomason/packer.nvim/issues/756
  end}

  -- Theme
  use "ellisonleao/gruvbox.nvim"
  vim.o.background = "dark" -- or "light" for light mode
  vim.cmd("colorscheme gruvbox")

  -- Search
  use { 'junegunn/fzf', run = ":call fzf#install()" }
  use { 'junegunn/fzf.vim' }
  vim.keymap.set('n', '<leader>p', ':FZF<CR>', { noremap = true})
  vim.keymap.set('n', '<leader>f', ':Rg<CR>', { noremap = true})


  -- Deps
  use "nvim-lua/plenary.nvim" -- required by prettier

  -- external languages
  use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "rust-lang/rust.vim",
      "simrat39/rust-tools.nvim"
  }
  require("mason").setup()
  require("mason-lspconfig").setup()


  require("mason-lspconfig").setup_handlers {
      -- The first entry (without a key) will be the default handler
      -- and will be called for each installed server that doesn't have
      -- a dedicated handler.
      function (server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {}
      end,
      -- Next, you can provide a dedicated handler for specific servers.
      -- For example, a handler override for the `rust_analyzer`:
      ["rust_analyzer"] = function ()
          local rt = require("rust-tools")
          rt.setup {
            server = {
              on_attach = function(_, bufnr)
                -- Hover actions
                vim.keymap.set("n", "<C-k><C-i>", rt.hover_actions.hover_actions, { buffer = bufnr })
                -- Code action groups
                vim.keymap.set("n", "<C-k><C-a>", rt.code_action_group.code_action_group, { buffer = bufnr })
              end,
            },
          }
      end
  }

  -- Prettier
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'MunifTanjim/prettier.nvim'

  local null_ls = require("null-ls")

  local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
  local event = "BufWritePre" -- or "BufWritePost"
  local async = event == "BufWritePost"

  null_ls.setup({
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.keymap.set("n", "<C-k>f", function()
          vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
        end, { buffer = bufnr, desc = "[lsp] format" })

        -- format on save
        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
        vim.api.nvim_create_autocmd(event, {
          buffer = bufnr,
          group = group,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr, async = async })
          end,
          desc = "[lsp] format on save",
        })
      end

      if client.supports_method("textDocument/rangeFormatting") then
        vim.keymap.set("x", "<C-k>f", function()
          vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
        end, { buffer = bufnr, desc = "[lsp] format" })
      end
    end,
  })

  local prettier = require("prettier")

  prettier.setup({
    bin = 'prettier',
    cli_options = {
      print_width = 160,
      tab_width = 2,
      use_tabs = false,
    },
    filetypes = {
      "css",
      "html",
      "javascript",
      "javascriptreact",
      "json",
      "typescript",
      "typescriptreact",
      "yaml",
      "toml",
    },
  })

end)
