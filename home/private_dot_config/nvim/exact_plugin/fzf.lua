local fzf = require('fzf-lua')

fzf.setup({
  winopts = { width = 0.9, height = 0.6 },
})

vim.keymap.set('n', '<leader><leader>', fzf.builtin, { desc = 'Pickers' })
vim.keymap.set('n', '<leader>b', fzf.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>o', fzf.files, { desc = 'Files' })
vim.keymap.set('n', "<leader>'", fzf.marks, { desc = 'Marks' })
vim.keymap.set('n', '<leader>/', fzf.blines, { desc = 'Lines (buffer)' })
vim.keymap.set('n', '<leader><c-/>', fzf.lines, { desc = 'Lines (open buffers)' })
vim.keymap.set('n', '<leader>g', fzf.live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>G', function() fzf.live_grep({ cwd = require('rooter').find() }) end, { desc = 'Live grep (project root)' })
vim.keymap.set('n', '<leader>]', fzf.lsp_workspace_symbols, { desc = 'Workspace symbols' })
vim.keymap.set('n', '<leader>\\', fzf.lsp_document_symbols, { desc = 'Document symbols' })
vim.keymap.set('n', '<leader>?', fzf.keymaps, { desc = 'Keymaps' })
