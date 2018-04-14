if exists('*minpac#init')
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Libraries
  call minpac#add('equalsraf/neovim-gui-shim') " gui configuration support
  call minpac#add('MarcWeber/vim-addon-mw-utils') " utility functions
  call minpac#add('tpope/vim-repeat') " repeat support for plugins
  call minpac#add('tomtom/tlib_vim') " utility functions

  " Enhancements/Tweaks
  call minpac#add('jamessan/vim-gnupg') " encrypted file editing
  call minpac#add('ludovicchabant/vim-gutentags') " seamless ctags
  call minpac#add('dietsche/vim-lastplace') " re-open files in the sample place
  call minpac#add('airblade/vim-rooter') " auto-cd to project root
  call minpac#add('mhinz/vim-sayonara') " simple window closing

  " Interface
  call minpac#add('tpope/vim-eunuch') " unix addons
  call minpac#add('tpope/vim-fugitive') " git integration
  call minpac#add('airblade/vim-gitgutter') " git diff gutter
  call minpac#add('justinmk/vim-gtfo') " quickly open terminal or file manager
  call minpac#add('itchyny/lightline.vim') " stupid light statusline framework
  call minpac#add('simnalamburt/vim-mundo') " undo tree gui
  call minpac#add('talek/obvious-resize') " simple window resizing
  call minpac#add('lifepillar/vim-solarized8') " simplified solarized port
  call minpac#add('mhinz/vim-startify') " simple start screen
  call minpac#add('christoomey/vim-tmux-navigator') " seamless vim/tmux splits

  " Editing
  call minpac#add('tpope/vim-commentary') " quickly comment/uncomment
  call minpac#add('tommcdo/vim-exchange') " exchange lines

  " Formatting
  call minpac#add('jiangmiao/auto-pairs') " auto-close delimiters
  call minpac#add('junegunn/vim-easy-align') " align text objects
  call minpac#add('tpope/vim-sleuth') " auto-determine buffer formatting

  " Search/Navigation
  call minpac#add('yuttie/comfortable-motion.vim') " intertia-based scrolling
  call minpac#add('justinmk/vim-dirvish') " ultra-minimal directory browser
  call minpac#add('junegunn/fzf') " fuzzy finder
  call minpac#add('junegunn/fzf.vim') " fuzzy finder
  call minpac#add('tommcdo/vim-kangaroo') " small manual jump-stack
  call minpac#add('kshenoy/vim-signature') " enhanced mark navigation
  call minpac#add('junegunn/vim-slash') " enhanced '/'

  " Motions/Text Objects
  call minpac#add('justinmk/vim-sneak') " enhanced character seeking
  call minpac#add('tpope/vim-surround') " (un)surround with delimiters
  call minpac#add('tommcdo/vim-ninja-feet') " motions to the end of text objects

  " Language Support/Integration
  call minpac#add('w0rp/ale') " async lint engine
  call minpac#add('stevearc/vim-arduino') " arduino syntax/integration
  call minpac#add('ap/vim-css-color') " highlight CSS colors
  call minpac#add('ccraciun/vim-dreammaker') " dream maker syntax
  call minpac#add('dag/vim-fish') " fish syntax
  call minpac#add('fatih/vim-go') " enhanced go support
  call minpac#add('PotatoesMaster/i3-vim-syntax') " i3 config syntax
  call minpac#add('Yggdroot/indentLine') " indentation visual aide
  call minpac#add('davidhalter/jedi-vim') " python autocompletion
  call minpac#add('roxma/ncm-github') " completion for github
  call minpac#add('chr4/nginx.vim') " nginx syntax
  call minpac#add('roxma/ncm-clang') " c/c++ completion
  call minpac#add('roxma/nvim-completion-manager') " async completion engine
  call minpac#add('Shougo/neco-vim') " vim completion
  call minpac#add('Shougo/neco-syntax') " syntax-based completion
  call minpac#add('pangloss/vim-javascript') " enhanced javascript syntax
  call minpac#add('exu/pgsql.vim') " postgres syntax
  call minpac#add('vim-python/python-syntax') " enhanced python syntax
  call minpac#add('vim-ruby/vim-ruby') " enhanced ruby support
  call minpac#add('rust-lang/rust.vim') " enhanced rust support
  call minpac#add('iloginow/vim-stylus') " stylus support
  call minpac#add('chr4/sslsecure.vim') " cipher highlighting
  call minpac#add('kurayama/systemd-vim-syntax') " systemd syntax
  call minpac#add('keith/tmux.vim') " tmux config syntax
  call minpac#add('cespare/vim-toml') " toml syntax
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
