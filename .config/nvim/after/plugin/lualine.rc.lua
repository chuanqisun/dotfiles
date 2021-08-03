-- Load once
local status, lualine = pcall(require, "lualine")
if (not status) then return end

require'lualine'.setup {
  sections = {
		lualine_c = {'filename', 'diff'},
    lualine_x = {
			{ "diagnostics", sources = {"nvim_lsp"}},
			'filetype'
		},
  },
}
