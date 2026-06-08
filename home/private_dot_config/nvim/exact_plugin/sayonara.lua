-- Replacement for mhinz/vim-sayonara: close the current buffer without
-- closing its window unless the bang variant is used.
local function close_buffer(close_window)
  local buf = vim.api.nvim_get_current_buf()
  local alt = vim.fn.bufnr('#')
  if alt > 0 and vim.api.nvim_buf_is_loaded(alt) and alt ~= buf then
    vim.api.nvim_set_current_buf(alt)
  else
    vim.cmd('bprevious')
    if vim.api.nvim_get_current_buf() == buf then
      vim.cmd('enew')
    end
  end
  pcall(vim.api.nvim_buf_delete, buf, { force = false })
  if close_window then vim.cmd('quit') end
end

vim.api.nvim_create_user_command('Sayonara', function(opts)
  close_buffer(opts.bang)
end, { bang = true, desc = 'Close buffer (! also closes window)' })
