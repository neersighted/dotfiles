local bufferline = require('bufferline')
local sayonara = require('sayonara')
local groups = require('bufferline.groups')
local lu = require('lineutil')

-- Buffer navigation: [b/]b in tab order, [B/]B in bufnr order.
vim.keymap.set('n', '[b', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Previous buffer (tab order)' })
vim.keymap.set('n', ']b', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer (tab order)' })
vim.keymap.set('n', '[B', '<cmd>bprevious<cr>', { desc = 'Previous buffer (bufnr order)' })
vim.keymap.set('n', ']B', '<cmd>bnext<cr>', { desc = 'Next buffer (bufnr order)' })

-- Diagnostic levels (ERROR→HINT): severity, per-tab dict name, glyph, hl group.
local diag_levels = {
  { severity = vim.diagnostic.severity.ERROR, name = 'error',   glyph = lu.diag_symbols.error, hl = 'BufferLineErrorDiagnostic' },
  { severity = vim.diagnostic.severity.WARN,  name = 'warning', glyph = lu.diag_symbols.warn,  hl = 'BufferLineWarningDiagnostic' },
  { severity = vim.diagnostic.severity.INFO,  name = 'info',    glyph = lu.diag_symbols.info,  hl = 'BufferLineInfoDiagnostic' },
  { severity = vim.diagnostic.severity.HINT,  name = 'hint',    glyph = lu.diag_symbols.hint,  hl = 'BufferLineHintDiagnostic' },
}

-- Per-tab diagnostics indicator (empty on the focused buffer).
local function diag_indicator(_, _, errors, ctx)
  if ctx.buffer:current() then return '' end
  local parts = {}
  for _, level in ipairs(diag_levels) do
    local n = errors[level.name]
    if n then parts[#parts + 1] = level.glyph .. n end
  end
  return ' ' .. table.concat(parts, ' ')
end

-- Right-area string: project-wide diagnostic counts, each in its own %#hl#.
local function diag_segments()
  local parts, counts = {}, vim.diagnostic.count(nil)
  for _, level in ipairs(diag_levels) do
    local n = counts[level.severity]
    if n and n > 0 then parts[#parts + 1] = lu.hl(level.hl, ' ' .. level.glyph .. n) end
  end
  return table.concat(parts)
end

-- Right-area string: the cwd, shown only when the file is outside it.
local function cwd_segment()
  if lu.under_cwd() then return '' end
  return lu.hl('BufferlineCwd', ' ' .. lu.cwd_disp())
end

-- Join non-empty component strings into one custom-area item; clicks[i] (if set)
-- wraps that segment in a statusline %@…@ click region.
local function areaf(components, clicks)
  local wrap = {}
  for i = 1, #components do
    if clicks and clicks[i] then wrap[i] = lu.click_register(clicks[i]) end
  end
  return function()
    local parts = {}
    for i, component in ipairs(components) do
      local s = component()
      if s ~= '' then
        if wrap[i] then s = wrap[i](s) end
        parts[#parts + 1] = s
      end
    end
    if #parts == 0 then return {} end
    return { { text = table.concat(parts, ' ') .. ' ' } }
  end
end

bufferline.setup({
  highlights = require('nord.plugins.bufferline').akinsho(),
  options = {
    -- Hidden when ≤1 buffer; no filetype icons or global close icon.
    always_show_bufferline = false,
    show_buffer_icons = false,
    show_close_icon = false,
    -- Per-buffer close icon, shown on hover.
    show_buffer_close_icons = true,
    buffer_close_icon = '×',
    hover = { enabled = true, reveal = { 'close' }, delay = 100 },
    -- X button: safe close; middle-click: force close; right-click: pin.
    close_command = function(buf) sayonara.close(buf) end,
    middle_mouse_command = function(buf) sayonara.close(buf, false, true) end,
    right_mouse_command = function(buf)
      vim.api.nvim_set_current_buf(buf)
      groups.toggle_pin()
    end,
    -- Pinned-buffer marker; no emoji.
    groups = { items = { groups.builtin.pinned:with({ icon = '◆' }) } },
    -- LSP diagnostics, per-tab indicator.
    diagnostics = 'nvim_lsp',
    diagnostics_update_in_insert = false,
    diagnostics_indicator = diag_indicator,
    -- Overflow markers (default needs a nerdfont).
    left_trunc_marker = '«',
    right_trunc_marker = '»',
    -- Right area: project diagnostics (click → global qflist) + cwd.
    custom_areas = { right = areaf({ diag_segments, cwd_segment }, { function() lu.diag_toggle(false) end }) },
    -- Sidebar offsets, matched to sidebar widths.
    offsets = {
      { filetype = 'aerial', text = 'TAGS', highlight = 'Directory' },
      { filetype = 'undotree', text = 'UNDO', highlight = 'Directory' },
    },
  },
})
