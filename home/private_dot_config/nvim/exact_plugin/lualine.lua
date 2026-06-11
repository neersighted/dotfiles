local lu = require('lineutil')

-- Add a colour ({fg,bg} table or hl-group name) to a component.
local function colored(comp, color)
  return vim.tbl_extend('force', comp, { color = color })
end

-- on_click handler that runs an ex-command.
local function click_cmd(cmd) return function() vim.cmd(cmd) end end

-- Extension showing just `label` (for sidebars).
local function extf_ft_label(label, filetypes)
  return {
    sections = { lualine_a = { function() return label end } },
    filetypes = filetypes,
  }
end

-- man-style extension (label + filename + progress + location) with a custom label.
local man = require('lualine.extensions.man')
local function man_like(label, filetypes)
  local ext = vim.deepcopy(man)
  ext.sections.lualine_a = { function() return label end }
  ext.filetypes = filetypes
  return ext
end

-- Quickfix extension with the dismiss click on its label.
local qf = require('lualine.extensions.quickfix')
local quickfix = {
  init = qf.init,
  filetypes = qf.filetypes,
  sections = {
    lualine_a = vim.tbl_map(function(c) return { c, on_click = lu.diag_close } end, qf.sections.lualine_a),
    lualine_b = qf.sections.lualine_b,
    lualine_z = qf.sections.lualine_z,
  },
}

-- Use lualine's search/selection counts in place of the native ones.
vim.opt.shortmess:append('S')
vim.opt.showcmd = false

require('lualine').setup({
  options = {
    theme = 'nord',
    icons_enabled = false,
    section_separators = '',
    component_separators = '│',
    globalstatus = false,
  },
  sections = {
    lualine_a = { { 'mode', fmt = lu.abbr_mode } },
    lualine_b = {
      colored({ lu.cwd_prefix, separator = '', padding = { left = 1, right = 0 }, cond = lu.under_cwd, on_click = click_cmd('Dirvish') }, 'LualinePwd'),
      { lu.path_file, separator = '', padding = { left = 0, right = 0 }, on_click = click_cmd('Dirvish') },
      { lu.status_symbol, separator = '', padding = { left = 0, right = 0 }, on_click = click_cmd('Dirvish') },
      colored({ lu.cwd_disp, fmt = lu.fmt_parens, separator = '', padding = { left = 0, right = 1 }, cond = lu.one_buffer_not_under_cwd, on_click = click_cmd('Dirvish') }, 'LualinePwd'),
      {'diagnostics', separator = '', padding = { left = 0, right = 1 }, sources = { 'nvim_diagnostic' }, symbols = lu.diag_symbols, on_click = function() lu.diag_toggle(true) end, }, -- click: loclist
    },
    lualine_c = {
      { 'diff', separator = '', padding = { left = 1, right = 0 }, on_click = click_cmd('Gdiffsplit') },
      { 'branch', fmt = lu.fmt_parens, cond = lu.width_min(120), on_click = click_cmd('FzfLua git_status') },
    },
    lualine_x = {
      { lu.indentline, cond = lu.width_min(100) },
      { 'encoding',    cond = lu.width_min(90) },
      { 'fileformat',  cond = lu.width_min(85) },
      { 'filetype',    cond = lu.width_min(80), on_click = click_cmd('checkhealth vim.lsp') },
    },
    lualine_y = {
      'selectioncount',
      { 'searchcount', separator = '', on_click = click_cmd('nohlsearch') },
      'progress',
    },
    lualine_z = {
      { lu.aerial_crumbs({ max = 60, frac = 0.4 }), cond = lu.width_min(160), on_click = click_cmd('AerialToggle') },
      'location',
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { { 'filename', file_status = false, on_click = lu.diag_close } },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  extensions = {
    'aerial', 'man', quickfix,
    extf_ft_label('DIR', { 'dirvish' }),
    extf_ft_label('NVIM', { 'ministarter' }),
    extf_ft_label('STARTUPTIME', { 'startuptime' }),
    extf_ft_label('UNDO', { 'undotree' }),
    extf_ft_label('UNDODIFF', { 'undotreeDiff' }),
    man_like('HELP', { 'help' }),
  },
})
