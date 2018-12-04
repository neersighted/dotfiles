" Backend
set undofile " Persist undo history.
set hidden " Allow backgrounding dirty buffers.

" Colors
if $COLORTERM ==# 'truecolor'
  set termguicolors " Use truecolor if available.
endif

" Completion
set completeopt=menuone,noselect " Always show a menu, and don't auto-select completions.

" Cursor/Movement
set scrolloff=2 " Keep the cursor two lines from the top/bottom.
set virtualedit=onemore,block " Allow cursor to the end of the line (and anywhere in visual-block.)

" Editing
set autoindent " Indent blocks automatically.
set smarttab " <tab> inserts 'shiftwidth' at the start of the line.
set nojoinspaces " Don't double space after joining punctuation.

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

" Wrapping
set colorcolumn=+1 " Show the wrapping column visually.
set linebreak breakindent showbreak=\\ " Wrap lines visually.
set list listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+ " Show hidden characters.

" indentLine
let g:indentLine_char = '┊' " Use a small line to show space-based indentation.
