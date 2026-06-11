-- Statusline/bufferline helpers.
local M = {}

-- Escape % for statusline-safe text.
local function esc(s) return (s:gsub('%%', '%%%%')) end

-- Wrap text in a highlight-group region: %#Group#text.
function M.hl(group, s) return '%#' .. group .. '#' .. s end

-- Wrap non-empty text in parens.
function M.fmt_parens(s) return s ~= '' and '(' .. s .. ')' or '' end

-- Shorten all but the last `keep` path segments, fish-style.
local DOT = string.byte('.')
local function fishy_path(path, keep)
  local segs = vim.split(path, '/', { plain = true })
  for i = 1, #segs - (keep or 1) do
    local s = segs[i]
    segs[i] = s:sub(1, s:byte(1) == DOT and 2 or 1)
  end
  return table.concat(segs, '/')
end

-- True when the current file is under cwd.
function M.under_cwd()
  return vim.startswith(vim.fn.expand('%:p'), vim.fn.getcwd() .. '/')
end

-- True when at most one buffer is listed.
function M.one_buffer()
  return #vim.fn.getbufinfo({ buflisted = 1 }) <= 1
end

-- True when one buffer and the file is outside cwd.
function M.one_buffer_not_under_cwd()
  return M.one_buffer() and not M.under_cwd()
end

-- Cond: window is at least `n` columns wide.
function M.width_min(n)
  return function() return vim.fn.winwidth(0) >= n end
end

-- cwd, ~-reduced and shortened.
function M.cwd_disp()
  return esc(fishy_path(vim.fn.fnamemodify(vim.fn.getcwd(), ':~')))
end

-- cwd as a path prefix.
function M.cwd_prefix()
  return M.cwd_disp() .. '/'
end

-- Virtual/scheme buffer (fugitive://, …) as basename + tag, else nil.
local function scheme_path(abs)
  local scheme = abs:match('^(%a[%w+.-]*)://')
  if not scheme then return nil end
  return ' ' .. esc(vim.fn.fnamemodify(abs, ':t')) .. ' @' .. scheme
end

-- Current file: scheme-tagged, cwd-relative (shortened), or ~-absolute.
function M.path_file()
  local abs = vim.fn.expand('%:p')
  if abs == '' then return ' [No Name]' end
  local s = scheme_path(abs)
  if s then return s end
  if M.under_cwd() then
    return esc(fishy_path(abs:sub(#vim.fn.getcwd() + 2), 2))
  end
  return ' ' .. esc(vim.fn.fnamemodify(abs, ':~'))
end

-- Buffer flags (!#+), trailing-spaced.
local symbols = { readonly = '!', nomodifiable = '#', modified = '+' }
function M.status_symbol()
  local flags = (vim.bo.readonly and symbols.readonly or '')
    .. (not vim.bo.modifiable and symbols.nomodifiable or '')
    .. (vim.bo.modified and symbols.modified or '')
  return flags .. ' '
end

-- Width-aware Aerial breadcrumb factory. Returns a render fn that keeps the
-- most-specific (rightmost) symbols within a column budget (the lesser of `max`
-- and `frac` of the window), dropping leading ones behind a … and truncating
-- the current symbol if it alone overflows. opts: max (60), frac (0.4),
-- sep (' > '), ellipsis ('…').
function M.aerial_crumbs(opts)
  opts = opts or {}
  local max = opts.max or 60
  local frac = opts.frac or 0.4
  local SEP = opts.sep or ' > '
  local ELL = opts.ellipsis or '…'
  local sepw = vim.fn.strdisplaywidth(SEP)

  return function()
    local ok, aerial = pcall(require, 'aerial')
    if not ok then return '' end
    local syms = aerial.get_location(true)
    if vim.tbl_isempty(syms) then return '' end

    local budget = math.min(max, math.floor(vim.fn.winwidth(0) * frac))
    local kept, width = {}, 0
    for i = #syms, 1, -1 do
      local name = syms[i].name
      if #kept == 0 then
        -- Always show the current symbol, truncated to the budget.
        if vim.fn.strdisplaywidth(name) > budget then
          name = vim.fn.strcharpart(name, 0, budget - 1) .. ELL
        end
        kept[1] = name
        width = vim.fn.strdisplaywidth(name)
      elseif width + sepw + vim.fn.strdisplaywidth(name) > budget then
        table.insert(kept, 1, ELL)
        break
      else
        table.insert(kept, 1, name)
        width = width + sepw + vim.fn.strdisplaywidth(name)
      end
    end
    return esc(table.concat(kept, SEP))
  end
end

-- Indent settings, modeline-style (sw=/ts=/tw=/noeol).
function M.indentline()
  local sw = vim.bo.shiftwidth ~= 0 and vim.bo.shiftwidth or vim.bo.tabstop
  local parts = {}
  if vim.bo.expandtab then
    parts[1] = 'sw=' .. sw
  else
    if sw ~= vim.bo.tabstop then parts[1] = 'sw=' .. sw end
    parts[#parts + 1] = 'ts=' .. vim.bo.tabstop
  end
  if vim.bo.textwidth ~= 0 then parts[#parts + 1] = 'tw=' .. vim.bo.textwidth end
  if not vim.bo.fixendofline and not vim.bo.endofline then parts[#parts + 1] = 'noeol' end
  return table.concat(parts, ',')
end

-- Abbreviate a lualine mode name.
local mode_abbr = {
  NORMAL = 'N', INSERT = 'I', REPLACE = 'R',
  VISUAL = 'V', ['V-LINE'] = '-V-', ['V-BLOCK'] = '[V]',
  SELECT = 'S', ['S-LINE'] = '-S-', ['S-BLOCK'] = '[S]',
  COMMAND = ':', TERMINAL = '$',
}
function M.abbr_mode(s) return mode_abbr[s] or s end

-- Diagnostic glyphs.
M.diag_symbols = { error = 'x ', warn = '! ', info = 'i ', hint = '? ' }

-- Toggle the diagnostics loclist (buffer) or quickfix (all).
function M.diag_toggle(loc)
  local key = loc and 'loclist' or 'quickfix'
  for _, w in ipairs(vim.fn.getwininfo()) do
    if w[key] == 1 then return vim.cmd(loc and 'lclose' or 'cclose') end
  end
  if loc then vim.diagnostic.setloclist() else vim.diagnostic.setqflist() end
end

-- Close both diagnostic lists.
function M.diag_close()
  vim.cmd('silent! lclose')
  vim.cmd('silent! cclose')
end

-- Invoke a registered click handler by id.
local click_fns = {}
function M.click_dispatch(id) local fn = click_fns[id]; if fn then fn() end end

-- Register a click handler; return a wrapper that wraps text in a %@…@ region.
function M.click_register(fn)
  click_fns[#click_fns + 1] = fn
  local pre = '%' .. #click_fns .. "@v:lua.require'lineutil'.click_dispatch@"
  return function(text) return pre .. text .. '%X' end
end

return M
