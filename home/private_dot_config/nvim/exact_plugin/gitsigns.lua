local gitsigns = require('gitsigns')
gitsigns.setup({
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 500,
  },
})

vim.keymap.set('n', '<leader>B', function() gitsigns.blame_line({ full = true }) end, { desc = 'Blame current line (popup)' })

vim.keymap.set('n', ']h', function() gitsigns.nav_hunk('next') end, { desc = 'Next git hunk' })
vim.keymap.set('n', '[h', function() gitsigns.nav_hunk('prev') end, { desc = 'Previous git hunk' })
vim.keymap.set('n', ']H', function() gitsigns.nav_hunk('last') end, { desc = 'Last git hunk' })
vim.keymap.set('n', '[H', function() gitsigns.nav_hunk('first') end, { desc = 'First git hunk' })
