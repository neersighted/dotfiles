require('neoscroll').setup({
  -- Skip <C-y>/<C-e>; init.vim overrides those for 5-line steps.
  mappings = { '<C-d>', '<C-u>', '<C-b>', '<C-f>', 'zt', 'zz', 'zb' },
})
