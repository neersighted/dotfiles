require('conform').setup({
  formatters_by_ft = {
    python = { 'ruff_format', 'ruff_organize_imports' },
    rust = { 'rustfmt' },
  },
})

local function format()
  require('conform').format({ async = true, lsp_fallback = true })
end

vim.api.nvim_create_user_command('Format', format, { desc = 'Format buffer via conform.nvim' })
vim.keymap.set('n', '<leader>f', format, { desc = 'Format buffer' })
