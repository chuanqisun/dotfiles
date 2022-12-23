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

-- copilot 
vim.cmd [[
  imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
  imap <silent> <C-h> <plug>(copilot-dismiss)
  imap <silent> <C-j> <plug>(copilot-next)
  imap <silent> <C-k> <plug>(copilot-previous)
  imap <silent> <C-\> <plug>(copilot-suggest)
  let g:copilot_no_tab_map = v:true
]]


vim.api.nvim_create_user_command('CopilotToggle', function ()
  vim.g.copilot_enabled = not vim.g.copilot_enabled
  if vim.g.copilot_enabled then
    vim.cmd('Copilot disable')
    print("Copilot OFF")
  else 
    vim.cmd('Copilot enable')
    print("Copilot ON")
  end
end, {nargs = 0})
vim.keymap.set('', '<M-\\>', ':CopilotToggle<CR>', { noremap = true, silent = true })

-- PlugIn specific (Todo: move into modules)
require('packer').startup(function(use)
  -- Package manager, must be first
  use "wbthomason/packer.nvim"
  use "ellisonleao/gruvbox.nvim"
  use { 'junegunn/fzf', run = ":call fzf#install()" }
  use { 'junegunn/fzf.vim' }

  -- Deps
  use "nvim-lua/plenary.nvim" -- required by prettier
  use "jose-elias-alvarez/null-ls.nvim" -- required by prettier
  use "neovim/nvim-lspconfig" -- required by many other plugins

  -- Prettier
  use "MunifTanjim/prettier.nvim"

  -- Copilot
  use "github/copilot.vim"

  -- LSP installer
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  }

  -- Completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  -- Rust
  use {
    "rust-lang/rust.vim",
    "simrat39/rust-tools.nvim"
  }

  -- Theme
  vim.o.background = "dark" -- or "light" for light mode
  vim.cmd("colorscheme gruvbox")

  -- Search
  vim.keymap.set('n', '<leader>p', ':FZF<CR>', { noremap = true})
  vim.keymap.set('n', '<leader>f', ':Rg<CR>', { noremap = true})

  -- Indent
  vim.keymap.set('i', '<M-h>', '<C-o><<', { noremap = true})
  vim.keymap.set('i', '<M-l>', '<C-o>>>', { noremap = true})
  vim.keymap.set('n', '<M-h>', '<<', { noremap = true})
  vim.keymap.set('n', '<M-l>', '>>', { noremap = true})
  vim.keymap.set('v', '<M-h>', '<gv', { noremap = true})
  vim.keymap.set('v', '<M-l>', '>gv', { noremap = true})

  -- Swap
  vim.keymap.set('i', '<M-j>', '<C-o>:m+1<CR>', { noremap = true})
  vim.keymap.set('i', '<M-k>', '<C-o>:m-2<CR>', { noremap = true})
  vim.keymap.set('n', '<M-j>', ':m+1<CR>', { noremap = true})
  vim.keymap.set('n', '<M-k>', ':m-2<CR>', { noremap = true})
  vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv", { noremap = true})
  vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv", { noremap = true})
  
  -- Duplicate
  vim.keymap.set('i', '<M-J>', '<C-o>:co+0<CR>', { noremap = true})
  vim.keymap.set('i', '<M-K>', '<C-o>:co-1<CR>', { noremap = true})
  vim.keymap.set('n', '<M-J>', ':co+0<CR>', { noremap = true})
  vim.keymap.set('n', '<M-K>', ':co-1<CR>', { noremap = true})
  vim.keymap.set('v', '<M-K>', ":co '>+0<CR>gv", { noremap = true})
  vim.keymap.set('v', '<M-J>', ":co '<-1<CR>gv", { noremap = true})


  -- external languages
  require("mason").setup()
  require("mason-lspconfig").setup()


  require("mason-lspconfig").setup_handlers {
      -- The first entry (without a key) will be the default handler
      -- and will be called for each installed server that doesn't have
      -- a dedicated handler.
      function (server_name) -- default handler (optional)
          local capabilities = require('cmp_nvim_lsp').default_capabilities()
          require("lspconfig")[server_name].setup {
            capabilities = capabilities
          }
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

  -- Formatters
  vim.g.rustfmt_autosave = 1

  local null_ls = require("null-ls")

  local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
  local event = "BufWritePre" -- or "BufWritePost"
  local async = event == "BufWritePost"

  null_ls.setup({
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.keymap.set("n", "<Leader>kf", function()
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
        vim.keymap.set("x", "<Leader>kf", function()
          vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
        end, { buffer = bufnr, desc = "[lsp] format" })
      end
    end,
  })
  local prettier = require("prettier")
  prettier.setup({
    bin = 'prettierd'
  })

  -- Completion
  local cmp = require("cmp")
  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({
      -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
      -- ['<C-Space>'] = cmp.mapping.complete(),
      -- ['<C-e>'] = cmp.mapping.abort(),
      ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      {name = 'nvim_lsp'}
    })
  })

end)
