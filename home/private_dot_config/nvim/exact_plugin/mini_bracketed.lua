-- Bracketed navigation (replaces vim-unimpaired's ]x/[x motions), plus extra
-- targets unimpaired lacked: diagnostic, treesitter, yank, indent, jump, etc.
require('mini.bracketed').setup({
  -- The undo target remaps u/<C-R> to track undo history; leave core keys alone.
  undo = { suffix = '' },
  -- Buffer nav ([b/]b) is owned by bufferline (visual tab order).
  buffer = { suffix = '' },
})
