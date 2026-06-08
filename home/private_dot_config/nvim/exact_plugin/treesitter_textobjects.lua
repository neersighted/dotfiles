require('nvim-treesitter-textobjects').setup()

local select = require('nvim-treesitter-textobjects.select')
local move = require('nvim-treesitter-textobjects.move')
local swap = require('nvim-treesitter-textobjects.swap')

-- Select (operator-pending + visual)
local objects = {
  ac = '@class.outer',
  ic = '@class.inner',
  aa = '@parameter.outer',
  ia = '@parameter.inner',
  af = '@call.outer',
  ['if'] = '@call.inner', -- if is a keyword
}
for key, query in pairs(objects) do
  vim.keymap.set({ 'x', 'o' }, key, function()
    select.select_textobject(query, 'textobjects')
  end, { desc = 'Select ' .. query })
end

-- Movements (unimpaired-style)
local moves = {
  [']m'] = { move.goto_next_start, '@function.outer', 'Next function start' },
  [']M'] = { move.goto_next_end, '@function.outer', 'Next function end' },
  ['[m'] = { move.goto_previous_start, '@function.outer', 'Prev function start' },
  ['[M'] = { move.goto_previous_end, '@function.outer', 'Prev function end' },
  [']]'] = { move.goto_next_start, '@class.outer', 'Next class start' },
  ['[['] = { move.goto_previous_start, '@class.outer', 'Prev class start' },
}
for key, spec in pairs(moves) do
  vim.keymap.set({ 'n', 'x', 'o' }, key, function()
    spec[1](spec[2], 'textobjects')
  end, { desc = spec[3] })
end

-- Move the argument under the cursor (replaces sideways.vim's ]v/[v).
vim.keymap.set('n', ']v', function()
  swap.swap_next('@parameter.inner', 'textobjects')
end, { desc = 'Move argument right' })
vim.keymap.set('n', '[v', function()
  swap.swap_previous('@parameter.inner', 'textobjects')
end, { desc = 'Move argument left' })
