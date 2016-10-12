scriptencoding utf8

call plug#begin($XDG_CONFIG_HOME . '/nvim/bundles')

" Enhancements/Tweaks
Plug 'tpope/vim-repeat' " Repeat support for arbitrary plugins.
Plug 'tpope/vim-rsi' " Readline-style mappings in insert mode.
Plug 'ajh17/VimCompletesMe' " Simple tab-completion.
Plug 'kopischke/vim-fetch' " Open files to line:column.
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' } " Intiuitive buffer closing.
Plug 'talek/obvious-resize', { 'on': ['ObviousResizeUp', 'ObviousResizeDown', 'ObviousResizeLeft', 'ObviousResizeRight'] } " Intiutive split resizing.
Plug 'justinmk/vim-dirvish' " A leaner, meaner file browser.
Plug 'romainl/vim-qf' " Enhancements for the quickfix window.
Plug 'kopischke/vim-stay' " Restore/preserve views.
Plug 'takac/vim-hardtime', { 'on': 'HardTimeOn' } " Hard mode (restrict hjkl).

" Integration
Plug 'w0rp/ale' " Async lint engine.
  let g:ale_lint_on_text_changed = 1
  let g:ale_lint_on_enter = 1
  let g:ale_lint_on_save = 1
  let g:ale_lint_delay = 100
  let g:ale_echo_msg_format = '[%linter%] %s'
  let g:ale_statusline_format = ['E:%s', 'W:%s', '']
  let g:ale_sign_warning = '❢'
  let g:ale_sign_error = '✗'
  autocmd vimrc User ALELint call lightline#update()
Plug 'tpope/vim-dispatch' " Async adapters for running Vim's compiler plugins, or arbitrary commands.
Plug 'radenling/vim-dispatch-neovim' " Neovim support for dispatch.
Plug 'johnsyweb/vim-makeshift' " Auto detect the build command.
Plug 'tpope/vim-eunuch' " Helpers for unix commands.
Plug 'christoomey/vim-tmux-navigator' " Unified movement in Vim and Tmux panes.
Plug 'justinmk/vim-gtfo' " Quickly open a terminal or a file manager.
Plug 'ludovicchabant/vim-gutentags' " Automatic tag generation.
Plug 'lambdalisue/vim-gita' " A toolgit for working with git, from vim.
Plug 'airblade/vim-gitgutter' " git-diff directly in the gutter.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " The do-it-all fuzzy finder.
Plug 'mhinz/vim-grepper', { 'on': 'Grepper' } " A wrapper around all things grep.
  let g:grepper = { 'tools': ['rg', 'git', 'grep'], 'open':  1, 'jump':  0 } " Use rg for grepper as well.
Plug 'jamessan/vim-gnupg' " Support for GnuPG/PGP-encrypted files.

" Interface
Plug 'romainl/flattened' " A optimized, modern solarized.
Plug 'itchyny/lightline.vim' " An ultra-minimal statusline builder.
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' } " A visualization of Vim's undo branches.

" Editing
Plug 'tpope/vim-unimpaired' " Pairs of complementary mappings.
Plug 'tpope/vim-commentary' " Bindings to comment/uncomment code.
Plug 'tpope/vim-speeddating' " Easily increment and decrement dates.
Plug 'tommcdo/vim-exchange' " Exchange text based on motions.
Plug 'AndrewRadev/splitjoin.vim' " Split and join statements intelligently.

" Selection
Plug 'terryma/vim-multiple-cursors' " Multiple cursors and selection.
Plug 'terryma/vim-expand-region' " Syntactically expand the selection.

" Formatting
Plug 'tpope/vim-sleuth' " Auto-detect indent settings.
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] } " Align text objects using verbs.
Plug 'jiangmiao/auto-pairs' " Automatically close delimiters (incl quotes, parenthesis, etc).
Plug 'tpope/vim-endwise' " Automatically end block constructs in supported languages.

" Search/Navigation
Plug 'pgdouyon/vim-evanesco' " A better, auto-clearing /...
Plug 'kshenoy/vim-signature' " Simple tool to manage and visualize marks.
Plug 'tommcdo/vim-kangaroo' " Simple, manual jump-stack.

" Motions/Text Objects
Plug 'justinmk/vim-sneak' " The missing motion, a mid-range two-character seek (and EasyMotion replacement).
  let g:sneak#streak = 1 " Enable streak (EasyMotion) mode.
  let g:sneak#s_next = 1 " Press again to skip to the next match.
Plug 'tpope/vim-surround' " Motions to manipulate the surroundings of a text object.
Plug 'tommcdo/vim-ninja-feet' " Motions to the ends of a text object.

" Syntax/Highlighting
Plug 'luochen1990/rainbow', { 'on': 'RainbowToggle' } " Parenthesis visualization.
  let g:rainbow_active = 0 " Manually enable rainbow parenthesis.
Plug 'Yggdroot/indentLine' " Show markers for indents.
  let g:indentLine_char = '┊' " Use a small line to show space-based indentation.
Plug 'sheerun/vim-polyglot' " Batterie-included language support pack.

call plug#end()

" Install missing plugins at start.
autocmd vimrc VimEnter * if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall | endif

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
let g:loaded_netrw             = 1 " Used to download spellfiles. Oh well.
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1
