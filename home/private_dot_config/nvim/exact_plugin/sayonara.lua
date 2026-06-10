-- Close the current buffer without closing its window
-- (replaces mhinz/vim-sayonara)
--
-- `!` also closes the window; `!!` force-discards a dirty buffer
-- (keeping the window open).
local function close_buffer(close_window, force)
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
  pcall(vim.api.nvim_buf_delete, buf, { force = force })
  if close_window then vim.cmd('quit') end
end

vim.api.nvim_create_user_command('Sayonara', function(opts)
  if opts.args ~= '' and opts.args ~= '!' then
    vim.notify("Sayonara: expected no argument or '!' (e.g. :Sayonara!!)", vim.log.levels.ERROR)
    return
  end
  local force = opts.args == '!'
  close_buffer(opts.bang and not force, force)
end, { bang = true, nargs = '?', desc = 'Close buffer (! closes window; !! force-discards dirty)' })

vim.keymap.set('n', '<leader>x', function() close_buffer(false, false) end, { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>d', function() close_buffer(true, false) end, { desc = 'Close buffer + window' })
