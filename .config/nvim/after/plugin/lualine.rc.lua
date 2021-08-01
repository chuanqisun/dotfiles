-- Load once
local status, lualine = pcall(require, "lualine")
if (not status) then return end


local lualine = require 'lualine'
lualine.setup()
