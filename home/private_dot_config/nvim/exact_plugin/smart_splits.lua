local ss = require('smart-splits')
ss.setup({})

vim.keymap.set('n', '<M-h>', ss.resize_left,  { desc = 'Resize left' })
vim.keymap.set('n', '<M-j>', ss.resize_down,  { desc = 'Resize down' })
vim.keymap.set('n', '<M-k>', ss.resize_up,    { desc = 'Resize up' })
vim.keymap.set('n', '<M-l>', ss.resize_right, { desc = 'Resize right' })

vim.keymap.set('n', '<C-h>', ss.move_cursor_left,  { desc = 'Move to split left' })
vim.keymap.set('n', '<C-j>', ss.move_cursor_down,  { desc = 'Move to split below' })
vim.keymap.set('n', '<C-k>', ss.move_cursor_up,    { desc = 'Move to split above' })
vim.keymap.set('n', '<C-l>', ss.move_cursor_right, { desc = 'Move to split right' })
