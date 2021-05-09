let s:packager_path = stdpath('config').'/pack/packager/opt/vim-packager'
let s:packager_config = expand('<sfile>:p')

command!       PackInstall packadd vim-packager | execute 'source' s:packager_config | call packager#install()
command! -bang PackUpdate  packadd vim-packager | execute 'source' s:packager_config | call packager#update({'force_hooks': '<bang>'})
command!       PackClean   packadd vim-packager | execute 'source' s:packager_config | call packager#clean()
command!       PackStatus  packadd vim-packager | execute 'source' s:packager_config | call packager#status()

if empty(glob(s:packager_path))
  silent execute '!git clone https://github.com/kristijanhusak/vim-packager' s:packager_path
  augroup packager_bootstrap
    autocmd!
    autocmd VimEnter * packadd vim-packager | execute 'source' s:packager_config | call packager#install({'on_finish': 'echo "Restart to start using plugins!"'})
  augroup END
endif

if exists('*packager#init')
  call packager#init({'jobs': 0})

  " Colors
  call packager#add('arcticicestudio/nord-vim')

  " Editing
  call packager#add('AndrewRadev/dsf.vim')
  call packager#add('AndrewRadev/inline_edit.vim')
  call packager#add('AndrewRadev/sideways.vim')
  call packager#add('AndrewRadev/splitjoin.vim')
  call packager#add('AndrewRadev/switch.vim')
  call packager#add('AndrewRadev/tagalong.vim')
  call packager#add('bfredl/nvim-miniyank')
  call packager#add('chaoren/vim-wordmotion')
  call packager#add('cohama/lexima.vim')
  call packager#add('farmergreg/vim-lastplace')
  call packager#add('junegunn/vim-easy-align')
  call packager#add('justinmk/vim-sneak')
  call packager#add('machakann/vim-sandwich')
  call packager#add('tommcdo/vim-ninja-feet')
  call packager#add('tpope/vim-commentary')
  call packager#add('tpope/vim-rsi')
  call packager#add('tpope/vim-unimpaired')

  " Integration
  call packager#add('APZelos/blamer.nvim')
  call packager#add('airblade/vim-rooter')
  call packager#add('christoomey/vim-tmux-navigator')
  call packager#add('dense-analysis/ale')
  call packager#add('direnv/direnv.vim')
  call packager#add('editorconfig/editorconfig-vim')
  call packager#add('junegunn/fzf')
  call packager#add('junegunn/fzf.vim')
  call packager#add('justinmk/vim-gtfo')
  call packager#add('kristijanhusak/vim-carbon-now-sh')
  call packager#add('ludovicchabant/vim-gutentags')
  call packager#add('mrossinek/vim-tmux-controller')
  call packager#add('tpope/vim-eunuch')
  call packager#add('tpope/vim-fugitive')
  call packager#add('tpope/vim-sleuth')
  call packager#add('tpope/vim-tbone')
  call packager#add('wsdjeg/vim-fetch')

  " Libraries
  call packager#add('kristijanhusak/vim-packager', {'type': 'opt'})
  call packager#add('tpope/vim-repeat')
  call packager#add('inkarkat/vim-visualrepeat')

  " Syntax
  call packager#add('blankname/vim-fish')
  call packager#add('cespare/vim-toml')
  call packager#add('chr4/nginx.vim')
  call packager#add('chrisbra/Colorizer')
  call packager#add('elzr/vim-json', {'type': 'opt'})
  call packager#add('ericpruitt/tmux.vim')
  call packager#add('fatih/vim-go', {'type': 'opt'})
  call packager#add('gregjurman/vim-nc')
  call packager#add('lifepillar/pgsql.vim')
  call packager#add('pprovost/vim-ps1')
  call packager#add('luochen1990/rainbow')
  call packager#add('mboughaba/i3config.vim')
  call packager#add('pangloss/vim-javascript', {'type': 'opt'})
  call packager#add('rust-lang/rust.vim', {'type': 'opt'})
  call packager#add('vim-python/python-syntax', {'type': 'opt'})
  call packager#add('vim-ruby/vim-ruby', {'type': 'opt'})

  " UI
  call packager#add('airblade/vim-gitgutter')
  call packager#add('andymass/vim-matchup')
  call packager#add('dstein64/vim-startuptime', {'type': 'opt'})
  call packager#add('itchyny/lightline.vim')
  call packager#add('junegunn/gv.vim')
  call packager#add('junegunn/vim-peekaboo')
  call packager#add('junegunn/vim-slash')
  call packager#add('justinmk/vim-dirvish')
  call packager#add('kristijanhusak/vim-dirvish-git')
  call packager#add('liuchengxu/vista.vim')
  call packager#add('lukas-reineke/indent-blankline.nvim')
  call packager#add('machakann/vim-highlightedyank')
  call packager#add('mhinz/vim-sayonara')
  call packager#add('mhinz/vim-startify')
  call packager#add('psliwka/vim-smoothie')
  call packager#add('simnalamburt/vim-mundo')
  call packager#add('talek/obvious-resize')
  call packager#add('tommcdo/vim-kangaroo')
  call packager#add('tpope/vim-characterize')
  call packager#add('Yggdroot/indentLine')
  call packager#add('Yilin-Yang/vim-markbar')
endif

function! s:lazy_cmd(cmd, bang, start, end, args)
    exec printf('%s%s%s %s', (a:start == a:end ? '' : (a:start.','.a:end)), a:cmd, a:bang, a:args)
endfunction

augroup packager_lazy
  autocmd!

  " dstein64/vim-startuptime
  command! -nargs=* StartupTime packadd vim-startuptime | call startuptime#StartupTime(<q-mods>, <f-args>)

  " elzr/vim-json
  autocmd FileType json packadd vim-json

  " fatih/vim-go
  autocmd FileType go packadd vim-go

  " pangloss/vim-javascript
  autocmd FileType javascript packadd vim-javascript

  " rust-lang/rust.vim
  autocmd FileType rust packadd rust.vim

  " vim-python/python-syntax
  autocmd FileType python packadd python-syntax

  " vim-ruby/vim-ruby
  autocmd FileType ruby packadd vim-ruby
augroup END
