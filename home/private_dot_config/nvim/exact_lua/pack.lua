vim.pack.add({
  -- Colors
  'https://github.com/gbprod/nord.nvim',

  -- Editing
  'https://github.com/nvim-mini/mini.splitjoin',
  'https://github.com/AndrewRadev/switch.vim',
  'https://github.com/windwp/nvim-ts-autotag',
  'https://github.com/gbprod/yanky.nvim',
  'https://github.com/chaoren/vim-wordmotion',
  'https://github.com/cohama/lexima.vim',
  'https://github.com/nvim-mini/mini.align',
  'https://codeberg.org/andyg/leap.nvim',
  'https://github.com/nvim-mini/mini.surround',
  'https://github.com/nvim-mini/mini.bracketed',
  'https://github.com/nvim-mini/mini.move',

  -- Integration
  'https://github.com/NotAShelf/direnv.nvim',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/nanotee/zoxide.vim',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/tpope/vim-eunuch',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/NMAC427/guess-indent.nvim',

  -- Libraries
  'https://github.com/b0o/SchemaStore.nvim',
  'https://github.com/tpope/vim-repeat',

  -- Syntax
  'https://github.com/romus204/tree-sitter-manager.nvim',
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
  'https://github.com/HiPhish/rainbow-delimiters.nvim',
  'https://github.com/alker0/chezmoi.vim',
  'https://github.com/nvim-mini/mini.hipatterns',
  'https://github.com/mboughaba/i3config.vim',

  -- UI
  'https://github.com/akinsho/bufferline.nvim',
  'https://github.com/andymass/vim-matchup',
  'https://github.com/dstein64/vim-startuptime',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/junegunn/vim-peekaboo',
  'https://github.com/junegunn/vim-slash',
  'https://github.com/justinmk/vim-dirvish',
  'https://github.com/karb94/neoscroll.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/stevearc/aerial.nvim',
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  'https://github.com/nvim-mini/mini.starter',
  'https://github.com/mrjones2014/smart-splits.nvim',
  'https://github.com/jiaoshijie/undotree',
})

vim.api.nvim_create_user_command('PackUpdate', function(opts)
  vim.pack.update(nil, { target = opts.bang and 'lockfile' or 'version' })
end, { bang = true, desc = 'Update plugins via vim.pack (! use lockfile versions)' })

vim.api.nvim_create_user_command('PackStatus', function(opts)
  if not opts.bang then
    return vim.pack.update(nil, { offline = true }) -- Report state without fetching.
  end
  -- Dump raw plugin data to a throwaway scratch buffer.
  local lines = vim.split(vim.inspect(vim.pack.get()), '\n', { plain = true })
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].filetype = 'lua'
  vim.cmd.sbuffer(buf)
end, { bang = true, desc = 'List plugins registered via vim.pack (! dump debug data)' })

vim.api.nvim_create_user_command('PackClean', function(opts)
  local orphans = vim.iter(vim.pack.get())
    :filter(function(p) return not p.active end)
    :map(function(p) return p.spec.name end)
    :totable()
  if #orphans == 0 then
    vim.notify('No unregistered plugins', vim.log.levels.INFO)
    return
  end
  if opts.bang then
    vim.pack.del(orphans)
  else
    vim.notify('Would remove (:PackClean! to execute): ' .. table.concat(orphans, ', '), vim.log.levels.INFO)
  end
end, { bang = true, desc = 'List plugins not in vim.pack.add (! remove them)' })
