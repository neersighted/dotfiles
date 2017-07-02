scriptencoding utf8

"
" Core
"

" Color
if !exists('$MOSH')
  set termguicolors " Use true colors.
endif
  if strftime('%H') >= 5 && strftime('%H') <= 17 " Set colors based on the time of day.
  colorscheme flattened_light
else
  colorscheme flattened_dark
endif
set colorcolumn=+1 " Highlight the wrapping column.

" Font
set guifont=Source\ Code\ Pro\ 10 " Use my font of choice.
set guioptions=ai " Hide all GUI widgets.

" Status
set noshowmode noshowcmd " Disable the built in-status indicators.
set showtabline=2 " Always show the tabline.
"set guicursor= " Enable cursor shape changing.
  "\n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  "\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  "\,sm:block-blinkwait175-blinkoff150-blinkon175
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
autocmd vimrc VimLeave * set guicursor=a:block-blinkon0 " Reset on exit.

" Previews
set inccommand=split " Show incomplete commands in a split.

" Cursor
set virtualedit=onemore,all " Allow the cursor to select the end of the line, or form blocks in empty space.

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

" Clipboard
set clipboard=unnamedplus " Use the system clipboard.

" Search
set grepprg=rg\ --vimgrep grepformat=%f:%l:%c:%m " Use a faster grep.
set ignorecase smartcase " Ignore case when searching, unless a uppercase letter is present.

" Splits
set splitright splitbelow " Open vertical splits to the right, horizontal below.
set winminheight=0 " Allow squishing splits.

" Misc
set timeoutlen=300 ttimeoutlen=50 " Tighten map/keycode timings.
set undofile " Keep persistent undo information.
set hidden " Allow backgrounding buffers.

"
" Plugins
"

" ALE
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_sign_warning = '❢'
let g:ale_sign_error = '✗'

" indentLine
let g:indentLine_char = '┊' " Use a small line to show space-based indentation.

" Sneak
let g:sneak#streak = 1 " Enable streak (EasyMotion) mode.
let g:sneak#s_next = 1 " Press again to skip to the next match.

" Startify
let g:startify_session_dir = $XDG_DATA_HOME . '/nvim/session'
let g:startify_bookmarks = [ {'c': '~/.dotfiles/config/neovim'}, {'f': '~/.dotfiles/config/fish/config.fish'}, {'m': '~/.dotfiles/config/tmux/main.conf'} ]

" Lightline
autocmd vimrc User ALELint call lightline#update() " Update status bar on lint.
