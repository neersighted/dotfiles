-- gl matches vim-easy-align muscle memory (binds normal + visual)
-- gL adds the live-preview variant
-- ga is used for charinfo
require('mini.align').setup({
  mappings = {
    start = 'gl',
    start_with_preview = 'gL',
  },
})

-- Add <cr> aligns the visual selection" from vim-easy-align.
vim.keymap.set('x', '<cr>', 'gl', { remap = true, desc = 'Align selection' })
