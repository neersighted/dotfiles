local leap = require('leap')
local leap_user = require('leap.user')

local nxo = { 'n', 'x', 'o' }

-- Bidirectional 2-char motion with labels built in (replaces vim-sneak).
vim.keymap.set(nxo, 's', '<Plug>(leap)')
vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')

-- Sneak clever-s (aka s_next): 's' forward and 'S' backward.
-- Group binds remain vanilla.
leap.opts.keys = {
  next_target = { '<enter>', 's' },
  prev_target = { '<backspace>', 'S' },
  next_group = '<space>',
  prev_group = '<backspace>',
}

-- Sneak-style f/F/t/T (single-char) clever-s style repeat movement.
local function clever(traversal_keys, kwargs)
  return function()
    leap.leap(vim.tbl_deep_extend('keep', kwargs, {
      inputlen = 1,
      inclusive = true,
      opts = vim.tbl_extend('keep', traversal_keys, {
        labels = '',
        safe_labels = vim.fn.mode(1):match('no?') and '' or nil,
      }),
    }))
  end
end

local tk_f = leap_user.with_traversal_keys('f', 'F')
local tk_t = leap_user.with_traversal_keys('t', 'T')

vim.keymap.set(nxo, 'f', clever(tk_f, {}))
vim.keymap.set(nxo, 'F', clever(tk_f, { backward = true }))
vim.keymap.set(nxo, 't', clever(tk_t, { offset = -1 }))
vim.keymap.set(nxo, 'T', clever(tk_t, { backward = true, offset = 1 }))
