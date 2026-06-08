-- Plugin manager: nvim's built-in vim.pack (0.12+).
-- Plugins live in ~/.local/share/nvim/site/pack/core/opt/<name>/

vim.pack.add({
  -- Colors
  'https://github.com/gbprod/nord.nvim',

  -- Editing
  'https://github.com/AndrewRadev/dsf.vim',
  'https://github.com/AndrewRadev/inline_edit.vim',
  'https://github.com/AndrewRadev/sideways.vim',
  'https://github.com/AndrewRadev/splitjoin.vim',
  'https://github.com/AndrewRadev/switch.vim',
  'https://github.com/AndrewRadev/tagalong.vim',
  'https://github.com/bfredl/nvim-miniyank',
  'https://github.com/chaoren/vim-wordmotion',
  'https://github.com/cohama/lexima.vim',
  'https://github.com/farmergreg/vim-lastplace',
  'https://github.com/junegunn/vim-easy-align',
  'https://github.com/justinmk/vim-sneak',
  'https://github.com/machakann/vim-sandwich',
  'https://github.com/tommcdo/vim-ninja-feet',
  'https://github.com/tpope/vim-rsi',
  'https://github.com/tpope/vim-unimpaired',

  -- Integration
  'https://github.com/APZelos/blamer.nvim',
  'https://github.com/airblade/vim-rooter',
  'https://github.com/christoomey/vim-tmux-navigator',
  'https://github.com/dense-analysis/ale',
  'https://github.com/direnv/direnv.vim',
  'https://github.com/ellisonleao/glow.nvim',
  'https://github.com/junegunn/fzf',
  'https://github.com/junegunn/fzf.vim',
  'https://github.com/justinmk/vim-gtfo',
  'https://github.com/kristijanhusak/vim-carbon-now-sh',
  'https://github.com/ludovicchabant/vim-gutentags',
  'https://github.com/mrossinek/vim-tmux-controller',
  'https://github.com/nanotee/zoxide.vim',
  'https://github.com/tpope/vim-eunuch',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/tpope/vim-sleuth',
  'https://github.com/tpope/vim-tbone',
  'https://github.com/wsdjeg/vim-fetch',

  -- Libraries
  'https://github.com/tpope/vim-repeat',
  'https://github.com/inkarkat/vim-visualrepeat',

  -- Syntax
  'https://github.com/alker0/chezmoi.vim',
  'https://github.com/blankname/vim-fish',
  'https://github.com/cespare/vim-toml',
  'https://github.com/chr4/nginx.vim',
  'https://github.com/chrisbra/Colorizer',
  'https://github.com/elzr/vim-json',
  'https://github.com/ericpruitt/tmux.vim',
  'https://github.com/fatih/vim-go',
  'https://github.com/gregjurman/vim-nc',
  'https://github.com/lifepillar/pgsql.vim',
  'https://github.com/luochen1990/rainbow',
  'https://github.com/mboughaba/i3config.vim',
  'https://github.com/pangloss/vim-javascript',
  'https://github.com/pprovost/vim-ps1',
  'https://github.com/rust-lang/rust.vim',
  'https://github.com/vim-python/python-syntax',
  'https://github.com/vim-ruby/vim-ruby',

  -- UI
  'https://github.com/airblade/vim-gitgutter',
  'https://github.com/andymass/vim-matchup',
  'https://github.com/chentoast/marks.nvim',
  'https://github.com/dstein64/vim-startuptime',
  'https://github.com/itchyny/lightline.vim',
  'https://github.com/junegunn/gv.vim',
  'https://github.com/junegunn/vim-peekaboo',
  'https://github.com/junegunn/vim-slash',
  'https://github.com/justinmk/vim-dirvish',
  'https://github.com/kristijanhusak/vim-dirvish-git',
  'https://github.com/liuchengxu/vista.vim',
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  'https://github.com/mhinz/vim-sayonara',
  'https://github.com/mhinz/vim-startify',
  'https://github.com/psliwka/vim-smoothie',
  'https://github.com/simnalamburt/vim-mundo',
  'https://github.com/talek/obvious-resize',
  'https://github.com/tommcdo/vim-kangaroo',
  'https://github.com/tpope/vim-characterize',
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
