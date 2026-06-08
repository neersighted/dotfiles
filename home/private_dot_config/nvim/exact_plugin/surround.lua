-- vim-sandwich-style keymaps (sa/sd/sr) on nvim-surround. Default surrounds;
-- only the keymaps are customized, so no setup() call is needed.
vim.g.nvim_surround_no_mappings = true

vim.keymap.set('n', 'sa', '<Plug>(nvim-surround-normal)', { desc = 'Add a surrounding pair (motion)' })
vim.keymap.set('x', 'sa', '<Plug>(nvim-surround-visual)', { desc = 'Add a surrounding pair (visual)' })
vim.keymap.set('n', 'sd', '<Plug>(nvim-surround-delete)', { desc = 'Delete a surrounding pair' })
vim.keymap.set('n', 'sr', '<Plug>(nvim-surround-change)', { desc = 'Change a surrounding pair' })
