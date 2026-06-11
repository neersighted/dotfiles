vim.loader.enable() -- Cache compiled Lua modules to disk (~30% speedup on require chains).

--
-- Preferences
--

-- Backend
vim.opt.undofile = true -- Persist undo history.
vim.opt.hidden = true -- Allow backgrounding dirty buffers.

-- Colors (real setup happens at the bottom, after plugins load).
vim.opt.termguicolors = true -- Use 24-bit color.

-- Completion
vim.opt.completeopt = { 'menuone', 'noselect', 'popup', 'fuzzy' } -- Menu even for a single match, never preselect, docs popup, client-side fuzzy.

-- Cursor/Movement
vim.opt.scrolloff = 2 -- Keep the cursor two lines from the top/bottom.
vim.opt.virtualedit = 'onemore,block' -- Cursor past EOL, and anywhere in visual-block.
local redraw = vim.api.nvim_create_augroup('redraw', { clear = true })
vim.api.nvim_create_autocmd({ 'FocusGained', 'VimResized' }, {
  group = redraw, command = 'mode', desc = 'Redraw aggressively on focus gained/resize',
})

-- Folding
vim.opt.foldmethod = 'expr' -- Treesitter's expr fails gracefully.
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevelstart = 99 -- Start with all folds open.

-- Grep
vim.opt.grepprg = 'rg -i --vimgrep' -- Use ripgrep.
vim.opt.grepformat:prepend('%f:%l:%c:%m')

-- Mouse
vim.opt.mouse = 'a' -- Enable full mouse support.
vim.opt.mousemoveevent = true -- Report mouse moves/hover.

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

-- Sidebars
vim.keymap.set('n', '<leader>u', function() require('undotree').toggle() end, { silent = true, desc = 'Undotree' })

-- Keep the selection when indenting in visual mode.
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Toggle the diagnostics loclist (buffer) / quickfix (project).
vim.keymap.set('n', '<leader>q', function() require('lineutil').diag_toggle(true) end, { desc = 'Toggle buffer diagnostics' })
vim.keymap.set('n', '<leader>Q', function() require('lineutil').diag_toggle(false) end, { desc = 'Toggle project diagnostics' })

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
      hl.NormalFloat           = { fg = c.snow_storm.origin, bg = c.polar_night.bright }
      hl.NormalNC              = { link = 'NormalFloat' }
      hl.Pmenu                 = { link = 'NormalFloat' }
      hl.SignColumn            = { bg = c.polar_night.bright }

      hl.MiniStarterItemPrefix = { link = 'Delimiter' }
      -- The bufferline cwd and the faded statusline pwd both sit on lualine's
      -- section b, so both take that theme's background and stay in lockstep with
      -- the statusline. LualinePwd's fg is polar_night.light — nord's own muted
      -- shade, the colour it defines `Comment` and all dimmed text from (nord
      -- names it by shade; there's no 'comment' role alias to reference).
      local lualine_b = require('lualine.themes.nord').normal.b
      hl.BufferlineCwd = { fg = lualine_b.fg, bg = lualine_b.bg }
      hl.LualinePwd   = { fg = c.polar_night.light, bg = lualine_b.bg }
    end,
  })
  vim.cmd.colorscheme('nord')
end)
