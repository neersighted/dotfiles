local nxo = { 'n', 'x', 'o' }

-- Bidirectional 2-char motion with labels built in (replaces vim-sneak).
vim.keymap.set(nxo, 's', '<Plug>(leap)')
vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')

-- Clever-s (sneak's s_next): once the full pattern is entered, repeat the
-- search forward with `s` and backward with `S`.
local keys = require('leap').opts.keys
keys.next_target = { '<enter>', 's' }
keys.prev_target = { '<backspace>', 'S' }

-- Native f/F/t/T (single-char) with sneak-style clever traversal on repeat.
local function ft(kwargs)
  require('leap').leap(vim.tbl_deep_extend('keep', kwargs, {
    inputlen = 1,
    inclusive = true,
    opts = { labels = '', safe_labels = vim.fn.mode(1):match('no?') and '' or nil },
  }))
end

local clever_f = require('leap.user').with_traversal_keys('f', 'F')
local clever_t = require('leap.user').with_traversal_keys('t', 'T')

vim.keymap.set(nxo, 'f', function() ft({ opts = clever_f }) end)
vim.keymap.set(nxo, 'F', function() ft({ backward = true, opts = clever_f }) end)
vim.keymap.set(nxo, 't', function() ft({ offset = -1, opts = clever_t }) end)
vim.keymap.set(nxo, 'T', function() ft({ backward = true, offset = 1, opts = clever_t }) end)
