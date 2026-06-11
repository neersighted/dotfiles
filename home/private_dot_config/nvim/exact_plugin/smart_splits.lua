local ss = require('smart-splits')

ss.setup({
  default_amount = 1,  -- Match the tmux side's 1-cell resize step.
  at_edge = 'stop',    -- Don't wrap; stop at the outermost edge.
  log_level = 'error', -- Silence the harmless "could not detect pane ID" warning in popups.
})

for _, map in ipairs({
  { '<M-h>', ss.resize_left,  'Resize left' },
  { '<M-j>', ss.resize_down,  'Resize down' },
  { '<M-k>', ss.resize_up,    'Resize up' },
  { '<M-l>', ss.resize_right, 'Resize right' },
  { '<C-h>', ss.move_cursor_left,  'Move to split left' },
  { '<C-j>', ss.move_cursor_down,  'Move to split below' },
  { '<C-k>', ss.move_cursor_up,    'Move to split above' },
  { '<C-l>', ss.move_cursor_right, 'Move to split right' },
}) do
  vim.keymap.set('n', map[1], map[2], { desc = map[3] })
end
