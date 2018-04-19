if exists('*minpac#init')
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Libraries
  call minpac#add('prabirshrestha/async.vim') " async support for asyncomplete
  call minpac#add('equalsraf/neovim-gui-shim') " gui configuration support
  call minpac#add('tpope/vim-repeat') " repeat support for plugins

  " Colorschemes
  call minpac#add('lifepillar/vim-solarized8') " simplified solarized port

  " Enhancements/Tweaks
  call minpac#add('jamessan/vim-gnupg') " encrypted file editing
  call minpac#add('ludovicchabant/vim-gutentags') " seamless ctags
  call minpac#add('Yggdroot/indentLine') " indentation visual aide
  call minpac#add('dietsche/vim-lastplace') " re-open files in the sample place
  call minpac#add('talek/obvious-resize') " simple window resizing
  call minpac#add('airblade/vim-rooter') " auto-cd to project root
  call minpac#add('mhinz/vim-sayonara') " simple window closing

  " Feature Additions
  call minpac#add('w0rp/ale') " async lint engine
  call minpac#add('itchyny/lightline.vim') " stupid light statusline framework
  call minpac#add('airblade/vim-gitgutter') " git diff gutter
  call minpac#add('simnalamburt/vim-mundo') " undo tree gui
  call minpac#add('mhinz/vim-startify') " simple start screen

  " Completion
  call minpac#add('prabirshrestha/asyncomplete.vim') " completion engine
  call minpac#add('prabirshrestha/asyncomplete-buffer.vim') " buffer-based completion
  call minpac#add('prabirshrestha/asyncomplete-file.vim') " file/directory completion
  call minpac#add('prabirshrestha/asyncomplete-gocode.vim') " go completion
  call minpac#add('prabirshrestha/asyncomplete-flow.vim') " javascript completion
  call minpac#add('keremc/asyncomplete-racer.vim') " rust completion
  call minpac#add('prabirshrestha/asyncomplete-necosyntax.vim') " syntax-based completion
  call minpac#add('prabirshrestha/asyncomplete-necovim.vim') " viml completion
  call minpac#add('prabirshrestha/asyncomplete-lsp.vim') " lsp-based completion
  call minpac#add('yami-beta/asyncomplete-omni.vim') " omnifunc-based completion
  call minpac#add('prabirshrestha/asyncomplete-tags.vim') " tag-based completion
  call minpac#add('prabirshrestha/vim-lsp') " lsp engine
  call minpac#add('Shougo/neco-syntax') " syntax-based completion engine
  call minpac#add('Shougo/neco-vim') " viml completion engine
  call minpac#add('wellle/tmux-complete.vim') " tmux-based completion engine

  " Environment Integration
  call minpac#add('tpope/vim-eunuch') " unix addons
  call minpac#add('tpope/vim-fugitive') " git integration
  call minpac#add('justinmk/vim-gtfo') " quickly open terminal or file manager
  call minpac#add('christoomey/vim-tmux-navigator') " seamless vim/tmux splits

  " Editing Addons
  call minpac#add('tpope/vim-commentary') " quickly comment/uncomment
  call minpac#add('tommcdo/vim-exchange') " exchange lines

  " Formatting Addons
  call minpac#add('jiangmiao/auto-pairs') " auto-close delimiters
  call minpac#add('junegunn/vim-easy-align') " align text objects
  call minpac#add('tpope/vim-sleuth') " auto-determine buffer formatting

  " Search/Navigation Tools
  call minpac#add('justinmk/vim-dirvish') " ultra-minimal directory browser
  call minpac#add('junegunn/fzf') " fuzzy finder
  call minpac#add('junegunn/fzf.vim') " fuzzy finder
  call minpac#add('tommcdo/vim-kangaroo') " small manual jump-stack
  call minpac#add('kshenoy/vim-signature') " enhanced mark navigation
  call minpac#add('junegunn/vim-slash') " enhanced '/'

  " Motions/Text Objects
  call minpac#add('justinmk/vim-sneak') " enhanced character seeking
  call minpac#add('machakann/vim-sandwich') " (un)surround text objects
  call minpac#add('tommcdo/vim-ninja-feet') " motions to the end of text objects

  " Language Syntax/Integration
  call minpac#add('stevearc/vim-arduino') " arduino syntax/integration
  call minpac#add('ccraciun/vim-dreammaker') " dream maker syntax
  call minpac#add('dag/vim-fish') " fish syntax
  call minpac#add('fatih/vim-go') " enhanced go support
  call minpac#add('mboughaba/i3config.vim') " i3 config syntax
  call minpac#add('chr4/nginx.vim') " nginx syntax
  call minpac#add('pangloss/vim-javascript') " enhanced javascript syntax
  call minpac#add('exu/pgsql.vim') " postgres syntax
  call minpac#add('vim-python/python-syntax') " enhanced python syntax
  call minpac#add('vim-ruby/vim-ruby') " enhanced ruby support
  call minpac#add('rust-lang/rust.vim') " enhanced rust support
  call minpac#add('iloginow/vim-stylus') " stylus support
  call minpac#add('wgwoods/vim-systemd-syntax') " systemd syntax
  call minpac#add('tmux-plugins/vim-tmux') " tmux config syntax
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
