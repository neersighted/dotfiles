local gitsigns = require('gitsigns')
gitsigns.setup({
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 500,
  },
})

vim.keymap.set('n', '<leader>B', function() gitsigns.blame_line({ full = true }) end, { desc = 'Blame current line (popup)' })

for _, map in ipairs({
  { ']h', 'next',  'Next git hunk' },
  { '[h', 'prev',  'Previous git hunk' },
  { ']H', 'last',  'Last git hunk' },
  { '[H', 'first', 'First git hunk' },
}) do
  vim.keymap.set('n', map[1], function() gitsigns.nav_hunk(map[2]) end, { desc = map[3] })
end
