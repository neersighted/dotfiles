local gitsigns = require('gitsigns')
gitsigns.setup({
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 500,
  },
})

vim.keymap.set('n', '<leader>B', function()
  gitsigns.blame_line({ full = true })
end, { desc = 'Blame current line (popup)' })
