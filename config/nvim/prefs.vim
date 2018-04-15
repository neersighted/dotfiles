"
" Core
"

" Clipboard
set clipboard=unnamedplus " Use the system clipboard.
let g:clipboard = {
  \   'name': 'yankee',
  \   'copy': {
  \      '+': 'yankee-yank clipboard',
  \      '*': 'yankee-yank primary',
  \    },
  \   'paste': {
  \      '+': 'yankee-paste clipboard',
  \      '*': 'yankee-paste primary',
  \   },
  \   'cache_enabled': 0,
  \ }

" Cursor
set virtualedit=onemore,block " Allow cursor to the end of the line (and anywhere in visual-block.)

" Backend
set undofile " Keep persistent undo information.
set hidden " Allow backgrounding buffers.

" Mouse
set mouse=a mousemodel=popup " Enable full mouse support.

" Numbering
set number relativenumber " Use relative line numbering.

" Previews
set inccommand=split " Show incomplete commands in a split.
set colorcolumn=+1 " Highlight the wrapping column.

" Quickfix
autocmd vimrc QuitPre * if &filetype != 'qf' | silent! lclose | endif " Autoclose.

" Search
set ignorecase smartcase " Ignore case when searching, unless a uppercase letter is present.

" Status
set noshowmode noshowcmd " Disable the built in-status indicators.
set showtabline=2 " Always show the tabline.
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor " Change the cursor between modes.
autocmd vimrc VimLeave * set guicursor=a:block-blinkon0 " Reset on exit.

" Splits
set splitright splitbelow " Open vertical splits to the right, horizontal below.
set winminheight=0 " Allow squishing splits.

" Wrapping
set linebreak breakindent showbreak=\\ " Visually wrap (and indent wrapped lines).
set list listchars=tab:..,nbsp:~,trail:_,extends:>,precedes:< " Show hidden characters.
set conceallevel=1 " Enable conceal support.

" Environment
let $VISUAL = 'nvr -cc split --remote-wait' " Don't nest neovim, open a new split instead.
"
" Plugins
"

" ALE
let g:ale_echo_msg_format = '[%linter%:%severity%] %s'
let g:ale_sign_warning = '!'
let g:ale_sign_error = 'x'
let g:ale_linters = {'rust': ['rls', 'rustfmt']}

" fzf
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Go
let g:go_auto_type_info=1 " Show info for word under cursor.
let g:go_highlight_functions = 1 " Highlight all the things.
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" indentLine
let g:indentLine_char = '┊' " Use a small line to show space-based indentation.

" Jedi
let g:jedi#auto_initialization = 0 " Disable autoconfig.
let g:jedi#auto_vim_configuration = 0
let g:jedi#show_call_signatures = 0

" Sneak
let g:sneak#f_reset = 1 " Set ; and , when f is used...
let g:sneak#t_reset = 1 " ...same for t.
let g:sneak#absolute_dir = 0 " Use standard ;/, behavior.

" Startify
let g:startify_session_dir = $XDG_DATA_HOME . '/nvim/session'
let g:startify_bookmarks = [
      \ {'f': '~/.dotfiles/freshrc'}, 
      \ {'v': '~/.dotfiles/config/neovim/init.vim'}, 
      \ {'s': '~/.dotfiles/config/fish/config.fish'}, 
      \ {'t': '~/.dotfiles/config/tmux.conf'}, 
      \ {'g': '~/.dotfiles/config/git/config'}, 
      \ ]
let g:startify_commands = [
      \ {'T': ':terminal'},
      \ {'h': ':checkhealth'},
      \ {'p': ':PackUpdate'},
      \ {'P': ':PackClean'},
      \ ]
autocmd vimrc User Startified setlocal cursorline " Show the cursorline in Startify.
autocmd vimrc User Startified setlocal buftype=nofile " Set the startup buffer to nofile.

" Tmux Navigator
let g:tmux_navigator_disable_when_zoomed = 1

" Lightline
autocmd vimrc User ALELint call lightline#update() " Update status bar on lint.
