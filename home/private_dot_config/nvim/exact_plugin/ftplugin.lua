-- Per-filetype buffer-local options. Replaces the per-filetype
-- ftplugin/<ft>.vim files; b:undo_ftplugin is auto-derived so
-- `:set ft=other` reverts cleanly.
local ft_config = {
  gitcommit = { spell = true, autoindent = true, textwidth = 80 },
  markdown  = { spell = true, autoindent = true },
  qf        = { number = true, relativenumber = false, wrap = false },
  vim       = { keywordprg = ':help' },
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = vim.tbl_keys(ft_config),
  callback = function(args)
    local opts = ft_config[vim.bo[args.buf].filetype]
    local undo = { 'setlocal' }
    for opt, val in pairs(opts) do
      vim.opt_local[opt] = val
      table.insert(undo, opt .. '<')
    end
    local prev = vim.b[args.buf].undo_ftplugin
    vim.b[args.buf].undo_ftplugin = (prev and prev ~= '' and prev .. '|' or '') .. table.concat(undo, ' ')
  end,
})
