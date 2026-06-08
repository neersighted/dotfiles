-- Show the cursorline in Startify, and don't treat it as a file buffer.
vim.api.nvim_create_autocmd('User', {
  pattern = 'Startified',
  command = 'setlocal cursorline buftype=nofile',
})

vim.g.startify_commands = {
  { T = ':terminal' },
  { h = ':checkhealth' },
}

vim.g.startify_change_to_vcs_root = 1 -- Switch to root when opening file.
vim.g.startify_files_number = 12      -- Show more files.
