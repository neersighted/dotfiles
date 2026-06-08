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

  -- Integration
  'https://github.com/NotAShelf/direnv.nvim',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/nanotee/zoxide.vim',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/tpope/vim-eunuch',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/tpope/vim-sleuth',

  -- Libraries
  'https://github.com/tpope/vim-repeat',

  -- Syntax
  'https://github.com/romus204/tree-sitter-manager.nvim',
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
  'https://github.com/HiPhish/rainbow-delimiters.nvim',
  'https://github.com/alker0/chezmoi.vim',
  'https://github.com/nvim-mini/mini.hipatterns',
  'https://github.com/mboughaba/i3config.vim',

  -- UI
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

vim.api.nvim_create_user_command('PackUpdate', function()
  vim.pack.update()
end, { desc = 'Update plugins via vim.pack' })

vim.api.nvim_create_user_command('PackStatus', function()
  vim.print(vim.pack.get())
end, { desc = 'List installed plugins' })

vim.api.nvim_create_user_command('PackClean', function()
  local orphans = vim.iter(vim.pack.get())
    :filter(function(p) return not p.active end)
    :map(function(p) return p.spec.name end)
    :totable()
  if #orphans == 0 then
    print('No orphan plugins')
    return
  end
  vim.pack.del(orphans)
end, { desc = 'Remove plugins not in vim.pack.add' })
