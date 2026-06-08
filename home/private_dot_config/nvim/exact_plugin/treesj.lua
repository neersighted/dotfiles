-- Tree-sitter-accurate split/join. Keep splitjoin.vim's gS/gJ muscle memory.
require('treesj').setup({
  use_default_keymaps = false,
})

local treesj = require('treesj')
vim.keymap.set('n', 'gS', treesj.split, { desc = 'Split node under cursor' })
vim.keymap.set('n', 'gJ', treesj.join, { desc = 'Join node under cursor' })
