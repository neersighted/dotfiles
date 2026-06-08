-- Map our terminal-color palette onto rainbow-delimiter highlights so the
-- bracket colors track the active colorscheme.
local function reload()
  if vim.g.terminal_color_1 == nil then return end
  local set = function(name, fg) vim.api.nvim_set_hl(0, name, { fg = fg }) end
  set('RainbowDelimiterCustom1', vim.g.terminal_color_4)
  set('RainbowDelimiterCustom2', vim.g.terminal_color_3)
  set('RainbowDelimiterCustom3', vim.g.terminal_color_5)
  set('RainbowDelimiterCustom4', vim.g.terminal_color_6)
  set('RainbowDelimiterCustom5', vim.g.terminal_color_2)
end

reload()
vim.api.nvim_create_autocmd('ColorScheme', { callback = reload })

vim.g.rainbow_delimiters = {
  highlight = {
    'RainbowDelimiterCustom1',
    'RainbowDelimiterCustom2',
    'RainbowDelimiterCustom3',
    'RainbowDelimiterCustom4',
    'RainbowDelimiterCustom5',
  },
}
