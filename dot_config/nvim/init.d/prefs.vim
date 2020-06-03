scriptencoding utf-8

" Backend
set undofile " Persist undo history.
set hidden " Allow backgrounding dirty buffers.

" Colors
set termguicolors " Use 24-bit color.
let g:colors_name = 'nord' " Use nord theme.

" Cursor/Movement
set scrolloff=2 " Keep the cursor two lines from the top/bottom.
set virtualedit=onemore,block " Allow cursor to the end of the line (and anywhere in visual-block.)
let g:tmux_navigator_disable_when_zoomed = 1 " Disable Tmux integration when zoomed.

" Grep
set grepprg=rg\ -i\ --vimgrep " Use ripgrep.
set grepformat^=%f:%l:%c:%m

" Mouse
set mouse=a " Enable full mouse support.

" Numbering
set number " Show line numbers.
augroup numbertoggle " Show relative numbers in normal mode.
  autocmd!
  autocmd InsertEnter * set norelativenumber
  autocmd VimEnter,InsertLeave * set relativenumber
augroup END

" Remote Plugins
let g:loaded_python_provider = 0 " Disable Python 2.
let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim/bin/python' " Locate Python 3 venv.

" Search
set ignorecase smartcase " Ignore case when searching, unless a uppercase letter is present.

" Status
set noshowmode showtabline=2 " Hide mode, always show tabline.

" Splits
set splitright splitbelow " Open vertical splits to the right, horizontal below.
let g:obvious_resize_run_tmux = 1 " Enable Tmux resizing integration.

" Substitution
set inccommand=split " Show incomplete substitutions in a preview split.

" Terminal
let $GIT_EDITOR = 'nvr --remote-wait -cc split' " Open commits in a split.

" Whitespace
set list listchars=tab:→·,nbsp:·,trail:~,extends:»,precedes:« " Show hidden characters.
set showbreak=>\  " Show a character for wrapped lines.
let g:indentLine_char = '┊' " Use a small line to show space-based indentation.

" Wrapping
set colorcolumn=+1 " Show the wrapping column visually.
set linebreak breakindent " Enable visual line wrapping.

" Other
let g:loaded_netrwPlugin = 1 " Disable Netrw.
let g:startuptime_self = 1 " Use 'self' time when profiling.
