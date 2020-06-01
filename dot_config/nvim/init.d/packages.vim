let s:packager_path = fnamemodify($MYVIMRC, ':p:h') . '/pack/packager/opt/vim-packager'
let s:packager_config = expand('<sfile>:p')

command!       PackInstall packadd vim-packager | execute 'source' s:packager_config | call packager#install()
command! -bang PackUpdate  packadd vim-packager | execute 'source' s:packager_config | call packager#update({'force_hooks': '<bang>'})
command!       PackClean   packadd vim-packager | execute 'source' s:packager_config | call packager#clean()
command!       PackStatus  packadd vim-packager | execute 'source' s:packager_config | call packager#status()

if empty(glob(s:packager_path))
  silent execute '!git clone https://github.com/kristijanhusak/vim-packager ' . s:packager_path
  augroup packager_bootstrap
    autocmd!
    autocmd VimEnter * execute 'PackInstall' | packloadall | source $MYVIMRC
  augroup END
endif

if exists('*packager#init')
  call packager#init({'jobs': 0})

  " Colors
  call packager#add('arcticicestudio/nord-vim')

  " Editing
  call packager#add('AndrewRadev/splitjoin.vim')
  call packager#add('AndrewRadev/switch.vim')
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
  call packager#add('christoomey/vim-tmux-navigator')
  call packager#add('dense-analysis/ale')
  call packager#add('jamessan/vim-gnupg')
  call packager#add('junegunn/fzf')
  call packager#add('junegunn/fzf.vim')
  call packager#add('junegunn/vader.vim', {'type': 'opt'})
  call packager#add('justinmk/vim-gtfo')
  call packager#add('ludovicchabant/vim-gutentags')
  call packager#add('tpope/vim-eunuch')
  call packager#add('tpope/vim-fugitive')
  call packager#add('tpope/vim-sleuth')

  " Libraries
  call packager#add('kristijanhusak/vim-packager', {'type': 'opt'})
  call packager#add('tpope/vim-repeat')

  " Syntax
  call packager#add('cespare/vim-toml')
  call packager#add('chr4/nginx.vim')
  call packager#add('chrisbra/Colorizer')
  call packager#add('dag/vim-fish')
  call packager#add('elzr/vim-json', {'type': 'opt'})
  call packager#add('fatih/vim-go', {'type': 'opt'})
  call packager#add('gregjurman/vim-nc')
  call packager#add('lifepillar/pgsql.vim')
  call packager#add('luochen1990/rainbow')
  call packager#add('mboughaba/i3config.vim')
  call packager#add('pangloss/vim-javascript', {'type': 'opt'})
  call packager#add('rust-lang/rust.vim', {'type': 'opt'})
  call packager#add('tmux-plugins/vim-tmux')
  call packager#add('vim-python/python-syntax', {'type': 'opt'})
  call packager#add('vim-ruby/vim-ruby', {'type': 'opt'})
  call packager#add('wgwoods/vim-systemd-syntax')

  " UI
  call packager#add('Yggdroot/indentLine')
  call packager#add('airblade/vim-gitgutter')
  call packager#add('itchyny/lightline.vim')
  call packager#add('junegunn/vim-peekaboo')
  call packager#add('junegunn/vim-slash')
  call packager#add('justinmk/vim-dirvish')
  call packager#add('kristijanhusak/vim-dirvish-git')
  call packager#add('kshenoy/vim-signature')
  call packager#add('majutsushi/tagbar', {'type': 'opt'})
  call packager#add('mhinz/vim-sayonara', {'type': 'opt'})
  call packager#add('mhinz/vim-startify')
  call packager#add('simnalamburt/vim-mundo', {'type': 'opt'})
  call packager#add('talek/obvious-resize')
  call packager#add('tommcdo/vim-kangaroo')
  call packager#add('tpope/vim-characterize')
endif

function! s:lazy_cmd(cmd, bang, start, end, args)
    exec printf('%s%s%s %s', (a:start == a:end ? '' : (a:start.','.a:end)), a:cmd, a:bang, a:args)
endfunction

augroup packager_lazy
  autocmd!

  " elzr/vim-json
  autocmd FileType json packadd vim-json

  " fatih/vim-go
  autocmd FileType go packadd vim-go

  " junegunn/vader.vim
  command! -nargs=* -range -bang Vader packadd vader.vim | call s:lazy_cmd('Vader', "<bang>", <line1>, <line2>, <q-args>)

  " majutsushi/tagbar
  command! -nargs=* -range -bang TagbarToggle packadd tagbar | call s:lazy_cmd('TagbarToggle', "<bang>", <line1>, <line2>, <q-args>)

  " mhinz/vim-sayonara
  command! -nargs=* -range -bang Sayonara packadd vim-sayonara | call s:lazy_cmd('Sayonara', "<bang>", <line1>, <line2>, <q-args>)

  " pangloss/vim-javascript
  autocmd FileType javascript packadd vim-javascript

  " rust-lang/rust.vim
  autocmd FileType rust packadd rust.vim

  " simnalamburt/vim-mundo
  command! -nargs=* -range -bang MundoToggle packadd vim-mundo | call s:lazy_cmd('MundoToggle', "<bang>", <line1>, <line2>, <q-args>)

  " vim-python/python-syntax
  autocmd FileType python packadd python-syntax

  " vim-ruby/vim-ruby
  autocmd FileType ruby packadd vim-ruby
augroup END
