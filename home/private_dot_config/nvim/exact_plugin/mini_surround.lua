-- mini.surround with treesitter and respect for leap.nvim
local ts_input = require('mini.surround').gen_spec.input.treesitter

require('mini.surround').setup({
  -- enables treesitter functions [@call.outer/@call.inner)] as a surrounding
  -- (replaces andrewradev/dsf.vim)
  custom_surroundings = {
    f = { input = ts_input({ outer = '@call.outer', inner = '@call.inner' }) },
  },
  mappings = {
    -- Bare `s`/`f`/`F` are provided by leap.nvim
    find = '',
    find_left = '',
    highlight = '',
    update_n_lines = '',
  },
})
