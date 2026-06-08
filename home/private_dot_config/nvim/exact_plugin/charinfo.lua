-- `ga`: character info under the cursor (replaces tpope/vim-characterize)
local function char_info()
  local ch = vim.fn.strcharpart(vim.api.nvim_get_current_line(), vim.fn.charcol('.') - 1, 1)
  if ch == '' then return end
  local cp = vim.fn.char2nr(ch)

  local digraph
  for _, d in ipairs(vim.fn.digraph_getlist(1)) do
    if d[2] == ch then digraph = d[1] break end
  end

  local name = vim.trim(vim.fn.system({ 'python3', '-c',
    'import unicodedata; print(unicodedata.name(chr(' .. cp .. '), "?"))' }))

  local parts = { ch, ('U+%04X'):format(cp), ('dec %d'):format(cp), ('&#%d;'):format(cp) }
  if digraph then table.insert(parts, 'digr ' .. digraph) end
  table.insert(parts, name)
  vim.notify(table.concat(parts, '  '))
end

vim.keymap.set('n', 'ga', char_info, { desc = 'Character info' })
