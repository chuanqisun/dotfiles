vim.api.nvim_create_user_command('OmniMenu', function()
  vim.cmd(#vim.fn.system('git rev-parse') > 0 and 'Files' or 'GFiles')
end, { nargs = 0 })

vim.api.nvim_set_keymap('n', '<C-p>', ':OmniMenu<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-f>', ':Rg<CR>', { noremap = true, silent = true })
