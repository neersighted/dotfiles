local function format()
  require('conform').format({ async = true, lsp_fallback = true })
end

vim.api.nvim_create_user_command('Format', format, { desc = 'Format buffer via conform.nvim' })
vim.keymap.set('n', '<leader>f', format, { desc = 'Format buffer' })

-- conform.setup pulls in a heavy chain of formatter registrations;
-- defer to keep startup snappy. Format keymap + :Format command are
-- registered eagerly so they're available immediately (require() inside
-- the format() function is cached after first call).
vim.schedule(function()
  -- Most filetypes use lsp_fallback (gopls, rust-analyzer, biome, etc. format natively).
  -- Only list filetypes where the LSP doesn't ship a formatter or we want a different one.
  require('conform').setup({
    formatters_by_ft = {
      python = { 'ruff_format', 'ruff_organize_imports' },
    },
  })
end)
