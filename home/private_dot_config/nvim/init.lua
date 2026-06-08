vim.loader.enable() -- Cache compiled Lua modules to disk (~30% speedup on require chains).

--
-- Preferences
--

-- Backend
vim.opt.undofile = true -- Persist undo history.
vim.opt.hidden = true -- Allow backgrounding dirty buffers.

-- Colors (real setup happens at the bottom, after plugins load).
vim.opt.termguicolors = true -- Use 24-bit color.

-- Cursor/Movement
vim.opt.scrolloff = 2 -- Keep the cursor two lines from the top/bottom.
vim.opt.virtualedit = 'onemore,block' -- Cursor past EOL, and anywhere in visual-block.
local redraw = vim.api.nvim_create_augroup('redraw', { clear = true })
vim.api.nvim_create_autocmd({ 'FocusGained', 'VimResized' }, {
  group = redraw, command = 'mode', desc = 'Redraw aggressively on focus gained/resize',
})

-- Grep
vim.opt.grepprg = 'rg -i --vimgrep' -- Use ripgrep.
vim.opt.grepformat:prepend('%f:%l:%c:%m')

-- Mouse
vim.opt.mouse = 'a' -- Enable full mouse support.

-- Numbering
vim.opt.number = true -- Show (relative) line numbers.
vim.opt.relativenumber = true
local numbertoggle = vim.api.nvim_create_augroup('numbertoggle', { clear = true })
vim.api.nvim_create_autocmd({ 'InsertEnter', 'BufLeave', 'WinLeave', 'FocusLost' }, {
  group = numbertoggle, nested = true,
  callback = function()
    if vim.wo.number and vim.bo.buftype == '' then vim.wo.relativenumber = false end
  end,
})
vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufEnter', 'WinEnter', 'FocusGained' }, {
  group = numbertoggle, nested = true,
  callback = function()
    if vim.wo.number and vim.fn.mode() ~= 'i' and vim.bo.buftype == '' then
      vim.wo.relativenumber = true
    end
  end,
})

-- Remote Plugins
vim.g.loaded_node_provider = 0 -- Disable Node.js.
vim.g.loaded_perl_provider = 0 -- Disable Perl.
vim.g.loaded_python3_provider = 0 -- Disable Python 3.
vim.g.loaded_python_provider = 0 -- Disable Python 2.
vim.g.loaded_ruby_provider = 0 -- Disable Ruby.

-- Search
vim.opt.ignorecase = true -- Ignore case when searching, unless an uppercase letter is present.
vim.opt.smartcase = true
-- Center + blink after a vim-slash search.
vim.keymap.set('', '<Plug>(slash-after)', function()
  return 'zz' .. vim.fn['slash#blink'](2, 50)
end, { expr = true })

-- Status
vim.opt.showmode = false -- Hide mode, always show tabline.
vim.opt.showtabline = 2

-- Splits
vim.opt.splitright = true -- Open vertical splits to the right, horizontal below.
vim.opt.splitbelow = true

-- Substitution
vim.opt.inccommand = 'split' -- Show incomplete substitutions in a preview split.

-- Terminal
vim.opt.title = true
vim.opt.titlestring = "nvim %t%( %m%r%) (%{fnamemodify(getcwd(),':~')})"

-- Whitespace
vim.opt.list = true -- Show hidden characters.
vim.opt.listchars = { tab = '→·', nbsp = '·', trail = '~', extends = '»', precedes = '«' }
vim.opt.showbreak = '> ' -- Mark wrapped lines.

-- Wrapping
vim.opt.colorcolumn = '+1' -- Show the wrapping column visually.
vim.opt.linebreak = true -- Enable visual line wrapping.
vim.opt.breakindent = true

-- Yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
  callback = function() pcall(vim.hl.on_yank) end,
  desc = 'Briefly highlight yanked text',
})

-- Other
vim.g.loaded_2html_plugin = 1 -- Disable :TOhtml.
vim.g.loaded_matchit = 1 -- Disable matchit (replaced by vim-matchup).
vim.g.loaded_matchparen = 1 -- Disable matchparen (replaced by vim-matchup).
vim.g.loaded_netrwPlugin = 1 -- Disable Netrw (replaced by dirvish).
vim.g.loaded_tarPlugin = 1 -- Disable in-nvim .tar handling.
vim.g.loaded_tohtml = 1 -- Disable :TOhtml (alt name).
vim.g.loaded_tutor = 1 -- Disable :Tutor.
vim.g.loaded_zipPlugin = 1 -- Disable in-nvim .zip handling.
vim.g.startuptime_self = 1 -- Use 'self' time when profiling.

--
-- Maps
--

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- fzf-lua
vim.keymap.set('n', '<leader><leader>', function() FzfLua.builtin() end, { desc = 'Pickers' })
vim.keymap.set('n', '<leader>b', function() FzfLua.buffers() end, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>o', function() FzfLua.files() end, { desc = 'Files' })
vim.keymap.set('n', "<leader>'", function() FzfLua.marks() end, { desc = 'Marks' })
vim.keymap.set('n', '<leader>/', function() FzfLua.blines() end, { desc = 'Lines (buffer)' })
vim.keymap.set('n', '<leader><c-/>', function() FzfLua.lines() end, { desc = 'Lines (open buffers)' })
vim.keymap.set('n', '<leader>g', function() FzfLua.live_grep() end, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>G', function() FzfLua.live_grep({ cwd = require('rooter').find() }) end, { desc = 'Live grep (project root)' })
vim.keymap.set('n', '<leader>]', function() FzfLua.lsp_workspace_symbols() end, { desc = 'Workspace symbols' })
vim.keymap.set('n', '<leader>\\', function() FzfLua.lsp_document_symbols() end, { desc = 'Document symbols' })
vim.keymap.set('n', '<leader>?', function() FzfLua.keymaps() end, { desc = 'Keymaps' })

-- Sidebars
vim.keymap.set('n', '<leader>u', function() require('undotree').toggle() end, { silent = true, desc = 'Undotree' })

-- Move arguments/list items around.
vim.keymap.set('n', ']v', '<cmd>SidewaysRight<cr>', { desc = 'Move argument right' })
vim.keymap.set('n', '[v', '<cmd>SidewaysLeft<cr>', { desc = 'Move argument left' })

-- Keep the selection when indenting in visual mode.
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Simple buffer/window management.
vim.keymap.set('n', '<leader>x', '<cmd>Sayonara<cr>', { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>d', '<cmd>Sayonara!<cr>', { desc = 'Close buffer + window' })

-- Make <c-e>/<c-y> faster.
vim.keymap.set('n', '<c-e>', '5<c-e>')
vim.keymap.set('n', '<c-y>', '5<c-y>')

-- Toggle loclist/quickfix.
local function qftoggle(loc)
  local key = loc and 'loclist' or 'quickfix'
  local open = false
  for _, w in ipairs(vim.fn.getwininfo()) do
    if w[key] == 1 then open = true; break end
  end
  vim.cmd(open and (loc and 'lclose' or 'cclose') or (loc and 'lopen' or 'copen'))
end
vim.keymap.set('n', '<leader>q', function() qftoggle(true) end, { desc = 'Toggle loclist' })
vim.keymap.set('n', '<leader>Q', function() qftoggle(false) end, { desc = 'Toggle quickfix' })

-- Ergonomic :terminal escape.
vim.keymap.set('t', '<esc>', '<c-\\><c-n>')
vim.keymap.set('t', '<a-[>', '<esc>')

--
-- Colors
--

-- Plugins must load before :colorscheme.
require('pack')

-- Eager-load the colorscheme, but defer customization to do less at startup.
vim.cmd.colorscheme('nord')
vim.schedule(function()
  require('nord').setup({
    borders = true,
    on_highlights = function(hl, c)
      hl.MiniStarterItemPrefix = { link = 'Delimiter' } -- index prefix
      hl.NormalFloat           = { fg = c.snow_storm.origin, bg = c.polar_night.bright }
      hl.NormalNC              = { fg = c.snow_storm.origin, bg = c.polar_night.bright }
      hl.Pmenu                 = { fg = c.snow_storm.origin, bg = c.polar_night.bright }
      hl.SignColumn            = { bg = c.polar_night.bright }
    end,
  })
  vim.cmd.colorscheme('nord')
end)
