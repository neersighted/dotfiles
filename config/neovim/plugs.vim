scriptencoding utf8

command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

if exists('*minpac#init')
  call minpac#init() " minpac is updated using fresh

  " Enhancements/Tweaks
  call minpac#add('tpope/vim-repeat')
  call minpac#add('tpope/vim-rsi')
  call minpac#add('ajh17/VimCompletesMe')
  call minpac#add('kopischke/vim-fetch')
  call minpac#add('mhinz/vim-sayonara')
  call minpac#add('talek/obvious-resize')
  call minpac#add('justinmk/vim-dirvish')
  call minpac#add('romainl/vim-qf')
  call minpac#add('dietsche/vim-lastplace')
  call minpac#add('takac/vim-hardtime')

  " Integration
  call minpac#add('w0rp/ale')
  call minpac#add('johnsyweb/vim-makeshift')
  call minpac#add('airblade/vim-rooter')
  call minpac#add('justinmk/vim-gtfo')
  call minpac#add('tpope/vim-eunuch')
  call minpac#add('christoomey/vim-tmux-navigator')
  call minpac#add('ludovicchabant/vim-gutentags')
  call minpac#add('lambdalisue/vim-gita')
  call minpac#add('airblade/vim-gitgutter')
  call minpac#add('junegunn/fzf')
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('mhinz/vim-grepper')
  call minpac#add('jamessan/vim-gnupg')
  call minpac#add('junegunn/vader.vim')

  " Interface
  call minpac#add('romainl/flattened')
  call minpac#add('mhinz/vim-startify')
  call minpac#add('itchyny/lightline.vim')
  call minpac#add('mbbill/undotree')

  " Editing
  call minpac#add('tpope/vim-unimpaired')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-speeddating')
  call minpac#add('tommcdo/vim-exchange')
  call minpac#add('AndrewRadev/splitjoin.vim')

  " Selection
  call minpac#add('terryma/vim-multiple-cursors')
  call minpac#add('terryma/vim-expand-region')

  " Formatting
  call minpac#add('tpope/vim-sleuth')
  call minpac#add('junegunn/vim-easy-align')
  call minpac#add('jiangmiao/auto-pairs')
  call minpac#add('tpope/vim-endwise')

  " Search/Navigation
  call minpac#add('pgdouyon/vim-evanesco')
  call minpac#add('kshenoy/vim-signature')
  call minpac#add('tommcdo/vim-kangaroo')

  " Motions/Text Objects
  call minpac#add('justinmk/vim-sneak')
  call minpac#add('tpope/vim-surround')
  call minpac#add('tommcdo/vim-ninja-feet')

  " Syntax/Highlighting
  call minpac#add('luochen1990/rainbow')
  call minpac#add('Yggdroot/indentLine')
  call minpac#add('sheerun/vim-polyglot')

endif

" Don't load unused cruft.
let g:loaded_gzip              = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:loaded_rrhelper          = 1
let g:loaded_2html_plugin      = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_logipat           = 1
let g:loaded_matchparen        = 1
"let g:loaded_netrw             = 1 " Used to download spellfiles. Oh well.
"let g:loaded_netrwPlugin       = 1
"let g:loaded_netrwSettings     = 1
"let g:loaded_netrwFileHandlers = 1
