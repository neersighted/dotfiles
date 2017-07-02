command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

if exists('*minpac#init')
  call minpac#init() " minpac is updated using fresh

  " Enhancements/Tweaks
  call minpac#add('justinmk/vim-dirvish') " ultra-minimal directory browser
  call minpac#add('kopischke/vim-fetch') " open file:line:col
  call minpac#add('dietsche/vim-lastplace') " re-open files in the sample place
  call minpac#add('talek/obvious-resize') " simple window resizing
  call minpac#add('romainl/vim-qf') " simple defaults for the quickfix window
  call minpac#add('tpope/vim-repeat') " repeat support for plugins
  call minpac#add('tpope/vim-rsi') " readline-style insert
  call minpac#add('mhinz/vim-sayonara') " simple window closing
  call minpac#add('tpope/vim-unimpaired') " simple complementary map pairs

  " Integration
  call minpac#add('w0rp/ale') " async lint engine
  call minpac#add('tpope/vim-eunuch') " unix addons
  call minpac#add('tpope/vim-fugitive') " git addons
  call minpac#add('junegunn/fzf') " fuzzy finder
  call minpac#add('junegunn/fzf.vim') " fuzzy finder
  call minpac#add('airblade/vim-gitgutter') " git diff gutter
  call minpac#add('justinmk/vim-gtfo') " open terminal or file manager
  call minpac#add('ludovicchabant/vim-gutentags') " seamless ctags
  call minpac#add('airblade/vim-rooter') " auto-cd to project root
  call minpac#add('christoomey/vim-tmux-navigator') " seamless vim/tmux splits

  " Interface
  call minpac#add('romainl/flattened') " simplified solarized port
  call minpac#add('itchyny/lightline.vim') " stupid light statusline framework
  call minpac#add('simnalamburt/vim-mundo') " undo tree gui
  call minpac#add('mhinz/vim-startify') " simple start screen

  " Editing
  call minpac#add('tpope/vim-commentary') " quickly comment/uncomment
  call minpac#add('tpope/vim-speeddating') " increment/decrement dates
  call minpac#add('tommcdo/vim-exchange') " exchange lines

  " Formatting
  call minpac#add('jiangmiao/auto-pairs') " auto-close delimiters
  call minpac#add('junegunn/vim-easy-align') " align text objects
  call minpac#add('tpope/vim-sleuth') " auto-determine buffer formatting

  " Search/Navigation
  call minpac#add('tommcdo/vim-kangaroo') " small manual jump-stack
  call minpac#add('kshenoy/vim-signature') " enhanced mark navigation
  call minpac#add('junegunn/vim-slash') " enhanced '/'

  " Motions/Text Objects
  call minpac#add('justinmk/vim-sneak') " enhanced character seeking
  call minpac#add('tpope/vim-surround') " (un)surround with delimiters
  call minpac#add('tommcdo/vim-ninja-feet') " motions to the end of text objects

  " Syntax/Highlighting
  call minpac#add('Yggdroot/indentLine') " indentation visual aide
  call minpac#add('sheerun/vim-polyglot') " compilation of language files

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
"let g:loaded_netrw             = 1
"let g:loaded_netrwPlugin       = 1
"let g:loaded_netrwSettings     = 1
"let g:loaded_netrwFileHandlers = 1
