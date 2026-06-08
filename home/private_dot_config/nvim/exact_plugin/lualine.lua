local function is_filelike()
  return vim.tbl_contains({ '', 'nowrite', 'acwrite' }, vim.bo.buftype)
end
local function has_filename()
  return vim.tbl_contains({ '', 'help' }, vim.bo.buftype)
end
local function show_lines()
  return not vim.tbl_contains({ 'terminal', 'nofile' }, vim.bo.buftype)
end
local function show_detail()
  return vim.fn.winwidth(0) > 70
end
local function detail_cond()
  return is_filelike() and show_detail()
end

local ft_overrides = {
  dirvish = 'DIR',
  fugitiveblame = 'BLAME',
  help = 'HELP',
  man = 'MAN',
  startify = 'STARTIFY',
  startuptime = 'STARTUPTIME',
  undotree = 'UNDO',
  undotreeDiff = 'UNDODIFF',
  vista = 'TAGS',
}

local mode_map = {
  n = 'N', i = 'I', R = 'R', v = 'V', V = '-V-',
  [vim.api.nvim_replace_termcodes('<C-v>', true, true, true)] = '[V]',
  c = ':', s = 'S', S = '-S-',
  [vim.api.nvim_replace_termcodes('<C-s>', true, true, true)] = '[S]',
  t = '$',
}

local function mode_text()
  if ft_overrides[vim.bo.filetype] then return ft_overrides[vim.bo.filetype] end
  if vim.bo.buftype == 'quickfix' then
    return vim.fn.getwininfo(vim.fn.win_getid())[1].loclist == 1 and 'LOC' or 'QF'
  end
  return mode_map[vim.fn.mode()] or vim.fn.mode():upper()
end

local function fileinfo()
  if not has_filename() then return '' end
  local name = vim.bo.buftype == 'help' and vim.fn.expand('%:t') or vim.fn.expand('%:~:.')
  if vim.fn.winwidth(0) < 79 then name = vim.fn.pathshorten(name) end
  if name == '' then name = '[No Name]' end
  if not is_filelike() then return name end
  return name
    .. (vim.bo.readonly and '!' or '')
    .. (not vim.bo.modifiable and '#' or '')
    .. (vim.bo.modified and '+' or '')
end

local function func_context()
  return vim.b.vista_nearest_method_or_function or ''
end

local function indent_indicator()
  if not detail_cond() then return '' end
  if vim.fn.exists('*SleuthIndicator') == 1 then return vim.fn.SleuthIndicator() end
  return ''
end

require('lualine').setup({
  options = {
    theme = 'nord',
    section_separators = '',
    component_separators = '',
    globalstatus = false,
  },
  sections = {
    lualine_a = { mode_text },
    lualine_b = { fileinfo },
    lualine_c = { func_context, 'diff' },
    lualine_x = {
      { 'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = 'x ', warn = '! ', info = 'i ', hint = '? ' } },
      { 'progress', cond = show_lines },
      { 'location', cond = show_lines },
    },
    lualine_y = {
      indent_indicator,
      { 'fileformat', cond = detail_cond },
      { 'encoding',   cond = detail_cond },
    },
    lualine_z = {
      { 'filetype', cond = detail_cond },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { mode_text, { 'filename', path = 1 } },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'progress', 'location' },
    lualine_z = {},
  },
  tabline = {
    lualine_a = { { 'tabs', mode = 2 } },
    lualine_z = {
      function() return vim.fn.fnamemodify(vim.fn.getcwd(), ':~') end,
      'branch',
    },
  },
})
