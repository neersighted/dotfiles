vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('chezmoi', { clear = true }),
  pattern = vim.fn.expand('~') .. '/.local/share/chezmoi/*',
  callback = function(args)
    vim.system({ 'chezmoi', 'apply', '--exclude', 'scripts', '--source-path', args.file })
  end,
})
