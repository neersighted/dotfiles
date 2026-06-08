-- gl matches the old vim-easy-align muscle memory (binds normal + visual);
-- gL adds the live-preview variant. Avoid the ga/gA defaults — ga is taken
-- by vim-characterize.
require('mini.align').setup({
  mappings = {
    start = 'gl',
    start_with_preview = 'gL',
  },
})

-- Keep the old "<cr> aligns the visual selection" convenience.
vim.keymap.set('x', '<cr>', 'gl', { remap = true, desc = 'Align selection' })
