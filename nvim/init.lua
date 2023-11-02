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

-- PlugIn specific (Todo: move into modules)
require("packer").startup(function(use)
  -- Package manager, must be first
  use("wbthomason/packer.nvim")

  -- Commentary
  use("terrortylor/nvim-comment")
  require("nvim_comment").setup()

  -- Theme
  use("ellisonleao/gruvbox.nvim")
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

  -- File explorer with fzf
  use({ "junegunn/fzf", run = ":call fzf#install()" })
  use({ "junegunn/fzf.vim" })

  vim.api.nvim_create_user_command('OmniMenu', function()
    vim.cmd(#vim.fn.system('git rev-parse') > 0 and 'Files' or 'GFiles')
  end, { nargs = 0 })
  vim.api.nvim_set_keymap('n', '<C-p>', ':OmniMenu<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<C-f>', ':Rg<CR>', { noremap = true, silent = true })

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

  require("mason").setup()
  require("mason-lspconfig").setup()




  use("rust-lang/rust.vim")
  vim.g.rustfmt_autosave = 1

  use("simrat39/rust-tools.nvim")
  local rt = require("rust-tools");
  rt.setup({
    tools = {
      inlay_hints = {
        auto = false,
      },
      hover_actions = {
        auto_focus = true, -- Issue: https://github.com/simrat39/rust-tools.nvim/issues/273
      },
    }
  })

  -- Completion
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/cmp-vsnip")
  use("hrsh7th/vim-vsnip")
  use("hrsh7th/nvim-cmp")

  -- menuone: popup even when there's only one match
  -- noinsert: Do not insert text until a selection is made
  -- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
  vim.o.completeopt = "menuone,noinsert,noselect"

  local cmp = require("cmp")

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- Not in use, but required by author
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        end
      end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
    }),
  })

  -- expose nvim capabilities to any LSP
  local lspconfig = require('lspconfig')
  local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()


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

  -- Auto formatting
  -- Ref: https://github.com/lukas-reineke/lsp-format.nvim
  require("lsp-format").setup {}
  use("lukas-reineke/lsp-format.nvim")

  -- Lua Language support
  lspconfig.lua_ls.setup({
    capabilities = lsp_capabilities,
    on_attach = require("lsp-format").on_attach
  })
end)
