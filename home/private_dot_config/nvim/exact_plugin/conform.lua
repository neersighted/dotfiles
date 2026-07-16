local function format()
  require('conform').format({ async = true, lsp_fallback = true })
end

-- Early register :Format and keybind; lazy load conform to keep startup fast.
vim.api.nvim_create_user_command('Format', format, { desc = 'Format buffer via conform.nvim' })
vim.keymap.set('n', '<leader>f', format, { desc = 'Format buffer' })
