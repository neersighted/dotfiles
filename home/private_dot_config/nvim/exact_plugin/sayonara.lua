local sayonara = require('sayonara')

-- :Sayonara closes the buffer; `!` also closes the window; `!!` force-discards.
vim.api.nvim_create_user_command('Sayonara', function(opts)
  if opts.args ~= '' and opts.args ~= '!' then
    vim.notify("Sayonara: expected no argument or '!' (e.g. :Sayonara!!)", vim.log.levels.ERROR)
    return
  end
  local force = opts.args == '!'
  sayonara.close(nil, opts.bang and not force, force)
end, { bang = true, nargs = '?', desc = 'Close buffer (! closes window; !! force-discards dirty)' })

vim.keymap.set('n', '<leader>x', function() sayonara.close(nil, false, false) end, { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>d', function() sayonara.close(nil, true, false) end, { desc = 'Close buffer + window' })
