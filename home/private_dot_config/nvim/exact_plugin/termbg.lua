-- Match the terminal background to Neovim, restoring the captured original on exit.

-- One-shot; do not clobber state.
if vim.g.loaded_termbg then return end
vim.g.loaded_termbg = true

local has_tty = false
for _, ui in ipairs(vim.api.nvim_list_uis()) do
  has_tty = has_tty or ui.stdout_tty
end
if not has_tty then return end

local group = vim.api.nvim_create_augroup('termbg_sync', { clear = true })

local function osc11(value)
  io.stdout:write('\027]11;' .. value .. '\007')
end

local function osc11_hex(c)
  return #c == 1 and c .. c or c:sub(1, 2)
end

-- OSC 11 replies use 1-4 hex digits per channel; keep the high byte.
local function parse_osc11(seq)
  local r, g, b = seq:match('^\027%]11;rgb:(%x+)/(%x+)/(%x+)$')
  if not (r and g and b) then
    local a
    r, g, b, a = seq:match('^\027%]11;rgba:(%x+)/(%x+)/(%x+)/(%x+)$')
    if not (r and g and b and a and #a <= 4) then return end
  end
  if not (#r <= 4 and #g <= 4 and #b <= 4) then return end
  return '#' .. osc11_hex(r) .. osc11_hex(g) .. osc11_hex(b)
end

local initial

local function sync()
  local bg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg
  if bg == nil then return end
  osc11(('#%06x'):format(bg))
end

local function reset()
  if initial then osc11(initial) end
end

-- Capture exactly one usable OSC 11 reply; other terminal responses are ignored.
local track
local function on_response(args)
  if initial then return end
  local seq = type(args.data) == 'table' and args.data.sequence or args.data
  if type(seq) ~= 'string' then return end
  local bg = parse_osc11(seq)
  if not bg then return end
  initial = bg
  pcall(vim.api.nvim_del_autocmd, track)

  vim.api.nvim_create_autocmd({ 'VimLeavePre', 'VimSuspend' }, { group = group, callback = reset })
  vim.api.nvim_create_autocmd({ 'VimResume', 'ColorScheme' }, { group = group, callback = sync })
  sync() -- Sync now, after the original is safely captured.
end

track = vim.api.nvim_create_autocmd('TermResponse', { group = group, callback = on_response, nested = true })
osc11('?')

-- Unsupported terminals should leave the terminal background unchanged.
vim.defer_fn(function()
  if initial then return end
  pcall(vim.api.nvim_del_augroup_by_id, group)
end, 1000)
