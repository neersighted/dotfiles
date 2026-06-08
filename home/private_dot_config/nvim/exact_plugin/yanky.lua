require('yanky').setup({
  ring = {
    history_length = 100,
    storage = 'shada',
  },
})

local nx = {'n', 'x'}

vim.keymap.set(nx, 'p', '<Plug>(YankyPutAfter)',  { desc = 'Paste after (yank ring)' })
vim.keymap.set(nx, 'P', '<Plug>(YankyPutBefore)', { desc = 'Paste before (yank ring)' })

vim.keymap.set('n', '<leader>pn', '<Plug>(YankyNextEntry)',     { desc = 'Cycle yank ring forward' })
vim.keymap.set('n', '<leader>pp', '<Plug>(YankyPreviousEntry)', { desc = 'Cycle yank ring backward' })

vim.keymap.set('n', '<leader>py', '<Cmd>YankyRingHistory<CR>', { desc = 'Open yank ring picker' })
