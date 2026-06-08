-- tree-sitter driven split/join
local treesj = require('treesj')
treesj.setup({
  use_default_keymaps = false,
})

-- Match splitjoin.vim's gS/gJ
vim.keymap.set('n', 'gS', treesj.split, { desc = 'Split node under cursor' })
vim.keymap.set('n', 'gJ', treesj.join, { desc = 'Join node under cursor' })
