scriptencoding utf8

" Color
set termguicolors " Use true colors.
if strftime('%H') >= 5 && strftime('%H') <= 17 " Set colors based on the time of day.
  colorscheme flattened_light
else
  colorscheme flattened_dark
endif
set t_8f=[38;2;%lu;%lu;%lum " Fix 24-bit color escape sequences.
set t_8b=[48;2;%lu;%lu;%lum " This supports st, tmux, and iterm2.
set colorcolumn=+1 " Highlight the wrapping column.

" Font
set guifont=Source\ Code\ Pro\ 10 " Use my font of choice.
set guioptions=ai " Hide all GUI widgets.

" Status
set noerrorbells novisualbell " Turn off bells.
set noshowmode noshowcmd " Disable the built in-status indicators.
set showtabline=2 " Always show the tabline.
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1 " Enable cursor shape changing.

" Numbering
set number relativenumber " Use relative line numbering.

" Wrapping
set linebreak " Wrap on whitelisted, non-disruptive characters.
set showbreak=⇉ " Indicate wrapped lines with a marker.
set breakindent " ...and indent them to match.

" Hidden
set list " Show hidden characters...
set listchars=tab:»·,trail:·,eol:¬,nbsp:_ " ...with nice indicators.
set conceallevel=1 " Enable conceal support.

" Input
set timeoutlen=300 " Tighten binding timings.
set ttimeoutlen=50 " Make escape sequences shorter as well.

" Clipboard
set clipboard=unnamedplus " Use the system clipboard.

" Search
set grepprg=rg\ --vimgrep grepformat=%f:%l:%c:%m " Use a faster grep.
set ignorecase smartcase " Ignore case when searching, unless a uppercase letter is present.

" Splits
set splitright splitbelow " Open vertical splits to the right, horizontal below.
set winminheight=0 " Allow squishing splits.

" Misc
set diffopt=filler,vertical
set virtualedit=onemore,all " Allow the cursor to select the end of the line, or form blocks in empty space.
set undofile " Keep persistent undo information.
set hidden " Allow backgrounding buffers.
