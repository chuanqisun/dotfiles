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

-- Cursor
vim.opt.guicursor = "n-v-c:block"
vim.opt.guicursor = vim.opt.guicursor + "i-ci-ve:ver25,r-cr:hor20,o:hor50"
vim.opt.guicursor = vim.opt.guicursor + "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
vim.opt.guicursor = vim.opt.guicursor + "sm:block-blinkwait175-blinkoff150-blinkon175"

-- Keyboard
vim.g.mapleader = " " -- Space as leader key
vim.keymap.set("", "<space>", "<nop>", { noremap = true })

-- Indent
vim.keymap.set("i", "<M-h>", "<C-o><<", { noremap = true })
vim.keymap.set("i", "<M-l>", "<C-o>>>", { noremap = true })
vim.keymap.set("n", "<M-h>", "<<", { noremap = true })
vim.keymap.set("n", "<M-l>", ">>", { noremap = true })
vim.keymap.set("v", "<M-h>", "<gv", { noremap = true })
vim.keymap.set("v", "<M-l>", ">gv", { noremap = true })

-- Swap
vim.keymap.set("i", "<M-j>", "<C-o>:m+1<CR>", { noremap = true })
vim.keymap.set("i", "<M-k>", "<C-o>:m-2<CR>", { noremap = true })
vim.keymap.set("n", "<M-j>", ":m+1<CR>", { noremap = true })
vim.keymap.set("n", "<M-k>", ":m-2<CR>", { noremap = true })
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv", { noremap = true })
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv", { noremap = true })

-- Duplicate
vim.keymap.set("i", "<M-J>", "<C-o>:co+0<CR>", { noremap = true })
vim.keymap.set("i", "<M-K>", "<C-o>:co-1<CR>", { noremap = true })
vim.keymap.set("n", "<M-J>", ":co+0<CR>", { noremap = true })
vim.keymap.set("n", "<M-K>", ":co-1<CR>", { noremap = true })
vim.keymap.set("v", "<M-K>", ":co '>+0<CR>gv", { noremap = true })
vim.keymap.set("v", "<M-J>", ":co '<-1<CR>gv", { noremap = true })

-- copilot
-- Ctrl-l and Tab both accept the suggestion
vim.cmd([[
  imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
  imap <silent> <C-h> <plug>(copilot-dismiss)
  imap <silent> <C-j> <plug>(copilot-next)
  imap <silent> <C-k> <plug>(copilot-previous)
  imap <silent> <C-\> <plug>(copilot-suggest)
]])

local copilot_on = true
vim.api.nvim_create_user_command("CopilotToggle", function()
	copilot_on = not copilot_on
	if copilot_on then
		vim.cmd("Copilot disable")
		print("Copilot OFF")
	else
		vim.cmd("Copilot enable")
		print("Copilot ON")
	end
end, { nargs = 0 })
vim.keymap.set("n", "<C-\\>", ":CopilotToggle<CR>", { noremap = true, silent = true })

-- Spell check
vim.api.nvim_create_user_command("SpellToggle", function()
	vim.opt.spell = not (vim.opt.spell:get())
	if vim.opt.spell:get() then
		print("Spell ON")
	else
		print("Spell OFF")
	end
end, { nargs = 0 })

-- PlugIn specific (Todo: move into modules)
require("packer").startup(function(use)
	-- Package manager, must be first
	use("wbthomason/packer.nvim")

	-- Theme
	use("ellisonleao/gruvbox.nvim")
	vim.cmd("colorscheme gruvbox")
	vim.o.background = "dark" -- or "light" for light mode

	-- Search
	use({ "junegunn/fzf", run = ":call fzf#install()" })
	use({ "junegunn/fzf.vim" })
	vim.keymap.set("n", "<leader>p", ":FZF<CR>", { noremap = true })
	vim.keymap.set("n", "<leader>f", ":Rg<CR>", { noremap = true })

	use("neovim/nvim-lspconfig") -- required by many other plugins

	use("nvim-lua/plenary.nvim") -- required by null-ls
	use("jose-elias-alvarez/null-ls.nvim")

	-- Copilot
	use("github/copilot.vim")

	-- LSP installer
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	})

	-- Completion
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")

	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/vim-vsnip")

	-- Rust
	use({
		"rust-lang/rust.vim",
		"simrat39/rust-tools.nvim",
	})

	-- LSP
	require("mason").setup()
	require("mason-lspconfig").setup()

	require("mason-lspconfig").setup_handlers({
		-- The first entry (without a key) will be the default handler
		-- and will be called for each installed server that doesn't have
		-- a dedicated handler.
		function(server_name) -- default handler (optional)
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			require("lspconfig")[server_name].setup({
				capabilities = capabilities,
			})
		end,
		-- Next, you can provide a dedicated handler for specific servers.
		-- For example, a handler override for the `rust_analyzer`:
		-- ["rust_analyzer"] = function()
		--   local rt = require("rust-tools")
		--   rt.setup({
		--     server = {
		--       on_attach = function(_, bufnr)
		--         -- Hover actions
		--         vim.keymap.set("n", "<C-k><C-i>", rt.hover_actions.hover_actions, { buffer = bufnr })
		--         -- Code action groups
		--         vim.keymap.set("n", "<C-k><C-a>", rt.code_action_group.code_action_group, { buffer = bufnr })
		--       end,
		--     },
		--   })
		-- end,
	})

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

			-- Jump to declaration
			-- bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")

			-- Lists all the implementations for the symbol under the cursor
			-- bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")

			-- Jumps to the definition of the type symbol
			-- bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")

			-- Lists all the references
			bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")

			-- Displays a function's signature information
			-- bufmap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")

			-- Renames all references to the symbol under the cursor
			bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")

			-- Selects a code action available at the current cursor position
			-- bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
			-- bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

			-- Show diagnostics in a floating window
			-- bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

			-- Move to the previous diagnostic
			-- bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

			-- Move to the next diagnostic
			bufmap("n", "<F8>", "<cmd>lua vim.diagnostic.goto_next()<cr>")
		end,
	})

	-- Formatters
	local null_ls = require("null-ls")
	local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
	local event = "BufWritePre" -- or "BufWritePost"
	local async = event == "BufWritePost"

	null_ls.setup({
		sources = {
			null_ls.builtins.formatting.prettierd,
			null_ls.builtins.formatting.rustfmt,
			null_ls.builtins.formatting.stylua,
		},
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
						print("formatted with prettierd")
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

	-- Completion
	local cmp = require("cmp")
	cmp.setup({
		snippet = {
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body) -- Not in use, but required by author
			end,
		},
		mapping = cmp.mapping.preset.insert({
			["<CR>"] = cmp.mapping.confirm({ select = true }),
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
		}),
	})
end)
