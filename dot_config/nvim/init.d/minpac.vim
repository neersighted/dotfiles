let s:minpac_path = fnamemodify($MYVIMRC, ':p:h') . '/pack/minpac/opt/minpac'
let s:minpac_config = expand('<sfile>:p')

command! -bang PackSync   packadd minpac | execute 'source' s:minpac_config | call minpac#clean() | call minpac#update('', <bang>0 ? {'do': 'quit'} : {'do': 'call minpac#status()'})
command! -bang PackUpdate packadd minpac | execute 'source' s:minpac_config | call minpac#update('', <bang>0 ? {'do': 'quit'} : {'do': 'call minpac#status()'})
command!       PackClean  packadd minpac | execute 'source' s:minpac_config | call minpac#clean()
command!       PackStatus packadd minpac | execute 'source' s:minpac_config | call minpac#status()

if empty(glob(s:minpac_path))
  silent execute '!mkdir -p ' . s:minpac_path
  silent execute '!git clone https://github.com/k-takata/minpac.git ' . s:minpac_path
  augroup minpac_bootstrap
    autocmd!
    autocmd VimEnter * execute 'PackUpdate' | packloadall | source $MYVIMRC
  augroup END
endif

if exists('*minpac#init')
  call minpac#init()

  " Colors
  call minpac#add('arcticicestudio/nord-vim')

  " Completion
  call minpac#add('Rip-Rip/clang_complete', {'type': 'opt'})
  call minpac#add('davidhalter/jedi-vim')
  call minpac#add('lifepillar/vim-mucomplete')

  " Editing
  call minpac#add('AndrewRadev/splitjoin.vim')
  call minpac#add('AndrewRadev/switch.vim')
  call minpac#add('bfredl/nvim-miniyank')
  call minpac#add('chaoren/vim-wordmotion')
  call minpac#add('farmergreg/vim-lastplace')
  call minpac#add('junegunn/vim-easy-align')
  call minpac#add('justinmk/vim-sneak')
  call minpac#add('machakann/vim-sandwich')
  call minpac#add('rstacruz/vim-closer')
  call minpac#add('tommcdo/vim-ninja-feet')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-endwise')
  call minpac#add('tpope/vim-rsi')
  call minpac#add('tpope/vim-unimpaired')

  " Integration
  call minpac#add('dense-analysis/ale')
  call minpac#add('jamessan/vim-gnupg')
  call minpac#add('junegunn/fzf')
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('junegunn/vader.vim', {'type': 'opt'})
  call minpac#add('justinmk/vim-gtfo')
  call minpac#add('ludovicchabant/vim-gutentags')
  call minpac#add('tpope/vim-eunuch')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-sleuth')

  " Libraries
  call minpac#add('k-takata/minpac', {'type': 'opt'})
  call minpac#add('tpope/vim-repeat')

  " Syntax
  call minpac#add('cespare/vim-toml')
  call minpac#add('chr4/nginx.vim')
  call minpac#add('chrisbra/Colorizer')
  call minpac#add('dag/vim-fish')
  call minpac#add('elzr/vim-json', {'type': 'opt'})
  call minpac#add('fatih/vim-go', {'type': 'opt'})
  call minpac#add('gregjurman/vim-nc')
  call minpac#add('lifepillar/pgsql.vim')
  call minpac#add('mboughaba/i3config.vim')
  call minpac#add('pangloss/vim-javascript', {'type': 'opt'})
  call minpac#add('rust-lang/rust.vim', {'type': 'opt'})
  call minpac#add('tmux-plugins/vim-tmux')
  call minpac#add('vim-python/python-syntax', {'type': 'opt'})
  call minpac#add('vim-ruby/vim-ruby', {'type': 'opt'})
  call minpac#add('wgwoods/vim-systemd-syntax')

  " UI
  call minpac#add('Yggdroot/indentLine')
  call minpac#add('airblade/vim-gitgutter')
  call minpac#add('itchyny/lightline.vim')
  call minpac#add('junegunn/vim-peekaboo')
  call minpac#add('junegunn/vim-slash')
  call minpac#add('justinmk/vim-dirvish')
  call minpac#add('kristijanhusak/vim-dirvish-git')
  call minpac#add('kshenoy/vim-signature')
  call minpac#add('majutsushi/tagbar', {'type': 'opt'})
  call minpac#add('mhinz/vim-sayonara')
  call minpac#add('mhinz/vim-startify')
  call minpac#add('simnalamburt/vim-mundo', {'type': 'opt'})
  call minpac#add('talek/obvious-resize')
  call minpac#add('tommcdo/vim-kangaroo')
  call minpac#add('tpope/vim-characterize')
endif

function! s:lazy_cmd(cmd, bang, start, end, args)
    exec printf('%s%s%s %s', (a:start == a:end ? '' : (a:start.','.a:end)), a:cmd, a:bang, a:args)
endfunction

augroup minpac_lazy
  autocmd!

  " Rip-Rip/clang_complete
  autocmd FileType c,cpp packadd clang_complete

  " elzr/vim-json
  autocmd FileType json packadd vim-json

  " fatih/vim-go
  autocmd FileType go packadd vim-go

  " junegunn/vader.vim
  command! -nargs=* -range -bang Vader packadd vader.vim | call s:lazy_cmd('Vader', "<bang>", <line1>, <line2>, <q-args>)

  " majutsushi/tagbar
  command! -nargs=* -range -bang TagbarToggle packadd tagbar | call s:lazy_cmd('TagbarToggle', "<bang>", <line1>, <line2>, <q-args>)

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
