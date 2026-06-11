-- gof/got: open file manager / terminal at current buffer's dir (replaces justinmk/vim-gtfo)
vim.keymap.set('n', 'gof', function()
  vim.ui.open(vim.fn.expand('%:p:h'))
end, { desc = 'Open file manager at buffer dir' })

vim.keymap.set('n', 'got', function()
  vim.cmd.tcd(vim.fn.fnameescape(vim.fn.expand('%:p:h')))
  vim.cmd.terminal()
end, { desc = 'Open terminal at buffer dir' })
