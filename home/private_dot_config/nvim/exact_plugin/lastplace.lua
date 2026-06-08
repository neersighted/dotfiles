-- Restore cursor to last edit position (replaces farmergreg/vim-lastplace).
local ignore_ft = { gitcommit = true, gitrebase = true, hgcommit = true, svn = true }
local ignore_bt = { quickfix = true, nofile = true, help = true, terminal = true }

vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function(args)
    if ignore_ft[vim.bo[args.buf].filetype] or ignore_bt[vim.bo[args.buf].buftype] then
      return
    end
    local line, col = unpack(vim.api.nvim_buf_get_mark(args.buf, '"'))
    if line > 0 and line <= vim.api.nvim_buf_line_count(args.buf) then
      pcall(vim.api.nvim_win_set_cursor, 0, { line, col })
    end
  end,
})
