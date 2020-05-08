scriptencoding utf-8

" Backend
set undofile " Persist undo history.
set hidden " Allow backgrounding dirty buffers.

" Colors
set termguicolors " Use truecolor if available.
silent! colorscheme nord " Default to the nord theme.

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
set number relativenumber " Use relative line numbering.

" Search
set ignorecase smartcase " Ignore case when searching, unless a uppercase letter is present.

" Status
set noshowmode showtabline=2 " Hide mode, always show tabline.

" Splits
set splitright splitbelow " Open vertical splits to the right, horizontal below.

" Substitution
set inccommand=split " Show incomplete substitutions in a preview split.

" Whitespace
set list listchars=tab:→·,nbsp:·,trail:~,extends:»,precedes:« " Show hidden characters.
set showbreak=>\  " Show a character for wrapped lines.
let g:indentLine_char = '┊' " Use a small line to show space-based indentation.

" Wrapping
set colorcolumn=+1 " Show the wrapping column visually.
set linebreak breakindent " Enable visual line wrapping.

" Other
let g:loaded_netrwPlugin = 1 " Disable Netrw.
