local aerial = require('aerial')
aerial.setup({
  show_guides = false,
  nerd_font = false,
})

vim.keymap.set('n', '<leader>t', aerial.toggle, { desc = 'Toggle the symbol sidebar (Aerial)' })
