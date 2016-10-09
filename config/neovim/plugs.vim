call plug#begin($XDG_CONFIG_HOME . '/nvim/bundles')

"Plug 'tpope/vim-sensible' " Sane defaults for Vim.
Plug 'tpope/vim-repeat' " Repeat support for arbitrary plugins.
Plug 'talek/obvious-resize', { 'on': ['ObviousResizeUp', 'ObviousResizeDown', 'ObviousResizeLeft', 'ObviousResizeRight'] } " Intiutive split resizing.
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' } " Intiuitive buffer closing.
Plug 'tpope/vim-vinegar' " Enhancements for netrw.
Plug 'romainl/vim-qf' " Enhancements for the quickfix window.
Plug 'kopischke/vim-stay' " Restore/preserve views.
Plug 'takac/vim-hardtime', { 'on': 'HardTimeOn' } " Hard mode (restrict hjkl).

" Integration
Plug 'christoomey/vim-tmux-navigator' " Unified movement in Vim and Tmux panes.
Plug 'tmux-plugins/vim-tmux-focus-events' " Fix focus events in Vim under Tmux.
Plug 'tpope/vim-eunuch' " Helpers for unix commands.
Plug 'tpope/vim-dispatch', { 'on': ['Make', 'Dispatch'] } " Async adapters for running Vim's compiler plugins, or arbitrary commands.
Plug 'kopischke/vim-fetch' " Open files to line:column.
Plug 'johnsyweb/vim-makeshift' " Auto detect the build command.
Plug 'ludovicchabant/vim-gutentags' " Automatic tag generation.
Plug 'airblade/vim-gitgutter' " git-diff directly in the gutter.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " The do-it-all fuzzy finder.
  let g:fzf_launcher = 'st -c fzf -g 50x25 -e bash -ic %s' " Use st for graphical GUIs.
Plug 'mhinz/vim-grepper', { 'on': 'Grepper' } " A wrapper around all things grep.
  let g:grepper = { 'tools': ['rg', 'git', 'grep'], 'open':  1, 'jump':  0 } " Use rg for grepper as well.

" Interface
Plug 'vim-airline/vim-airline' " A lightweight, well-integrated statusline.
Plug 'vim-airline/vim-airline-themes'
  let g:airline_theme='solarized' " Use solarized/flattened with airline.
  let g:airline_powerline_fonts = 1 " Use pretty fonts for airline.
  let g:airline#extensions#tabline#enabled = 1 " Use a simple tab/buffer line.
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

" Support
Plug 'sheerun/vim-polyglot' " Batterie-included language support pack.
Plug 'tpope/vim-fugitive' " Tools and syntax highlighting for Git.
Plug 'jamessan/vim-gnupg' " Support for GnuPG/PGP-encrypted files.

" Highlighting
Plug 'romainl/flattened' " A optimized, modern solarized.
Plug 'luochen1990/rainbow', { 'on': 'RainbowToggle' } " Parenthesis visualization.
  let g:rainbow_active = 0 " Manually enable rainbow parenthesis.
Plug 'Yggdroot/indentLine' " Show markers for indents.
  let g:indentLine_char = '┊' " Use a small line to show space-based indentation.

call plug#end()

" Install missing plugins at start.
autocmd VimEnter * if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall | endif
" Load sensible now so we can override things.
runtime plugin/sensible.vim
