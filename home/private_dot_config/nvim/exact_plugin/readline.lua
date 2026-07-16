-- More readline/emacs-style motions in command mode.

vim.keymap.set('c', '<C-a>', '<Home>', { desc = 'Move to line start' })
vim.keymap.set('c', '<C-e>', '<End>', { desc = 'Move to line end' })
vim.keymap.set('c', '<M-b>', '<S-Left>', { desc = 'Move word backward' })
vim.keymap.set('c', '<M-f>', '<S-Right>', { desc = 'Move word forward' })

vim.keymap.set('c', '<M-d>', '<C-Right><Backspace>', { desc = 'Delete word forward' })
vim.keymap.set('c', '<C-k>', function()
  local cmd = vim.fn.getcmdline()
  local pos = vim.fn.getcmdpos()
  vim.fn.setcmdline(cmd:sub(1, pos - 1))
end, { desc = 'Kill to end of line' })
