vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('chezmoi', { clear = true }),
  pattern = vim.fn.expand('~') .. '/.local/share/chezmoi/*',
  command = 'silent !chezmoi apply --exclude scripts --source-path "%"',
})
