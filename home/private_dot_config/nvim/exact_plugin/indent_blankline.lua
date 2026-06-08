-- Defer ibl load to speed up startup.
vim.schedule(function()
  require('ibl').setup({ indent = { char = '┊' } })
end)
