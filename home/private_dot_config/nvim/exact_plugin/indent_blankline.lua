-- Deferred: ibl's require chain transitively pulls vim.lsp at startup
-- (~5ms savings). Indent guides appear a tick after first paint.
vim.schedule(function()
  require('ibl').setup({ indent = { char = '┊' } })
end)
