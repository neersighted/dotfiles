-- Close a buffer without disturbing its window (replaces mhinz/vim-sayonara).
local M = {}

-- Close `buf` (default: current). When it's the buffer shown in the current
-- window, switch that window to the alternate/previous first so the window
-- survives. `close_window` quits the window after; `force` discards changes.
function M.close(buf, close_window, force)
  buf = buf or vim.api.nvim_get_current_buf()
  if buf == vim.api.nvim_get_current_buf() then
    local alt = vim.fn.bufnr('#')
    if alt > 0 and vim.api.nvim_buf_is_loaded(alt) and alt ~= buf then
      vim.api.nvim_set_current_buf(alt)
    else
      vim.cmd('bprevious')
      if vim.api.nvim_get_current_buf() == buf then vim.cmd('enew') end
    end
  end
  pcall(vim.api.nvim_buf_delete, buf, { force = force })
  if close_window then vim.cmd('quit') end
end

return M
