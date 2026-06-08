local function format()
  require('conform').format({ async = true, lsp_fallback = true })
end

-- Early register :Format and keybind; lazy load conform to keep startup fast.
vim.api.nvim_create_user_command('Format', format, { desc = 'Format buffer via conform.nvim' })
vim.keymap.set('n', '<leader>f', format, { desc = 'Format buffer' })
vim.schedule(function()
  -- Most filetypes use lsp_fallback (gopls, rust-analyzer, biome, etc. format natively).
  -- Only list filetypes where the LSP doesn't ship a formatter or we want a different one.
  require('conform').setup({
    formatters_by_ft = {
      python = { 'ruff_format', 'ruff_organize_imports' },
    },
  })
end)
