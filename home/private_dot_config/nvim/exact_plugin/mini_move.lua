-- Move lines/selections (replaces vim-unimpaired [e/]e).
require('mini.move').setup({
  mappings = {
    -- normal mode
    line_up   = '[e', line_down = ']e',
    -- visual mode
    up   = '[e', down = ']e',
    -- disabled
    left = '', right = '', line_left = '', line_right = '',
  },
})
