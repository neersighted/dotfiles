-- Handle `nvim file:line:col` notation (replaces wsdjeg/vim-fetch)
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufReadPre' }, {
  pattern = { '*:*', '*:*:*' },
  callback = function(args)
    local name = args.file
    local file, line, col = name:match('^(.-):(%d+):?(%d*)$')
    if not file or vim.fn.filereadable(file) ~= 1 then return end
    local buf = args.buf
    vim.schedule(function()
      vim.cmd.edit(file)
      pcall(vim.api.nvim_win_set_cursor, 0, { tonumber(line), tonumber(col) or 0 })
      if vim.api.nvim_buf_is_valid(buf) and buf ~= vim.api.nvim_get_current_buf() then
        pcall(vim.api.nvim_buf_delete, buf, { force = true })
      end
    end)
  end,
})
