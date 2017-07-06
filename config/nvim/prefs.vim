"
" Core
"

" Status
set noshowmode noshowcmd " Disable the built in-status indicators.
set showtabline=2 " Always show the tabline.
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor " Change the cursor between modes.
autocmd vimrc VimLeave * set guicursor=a:block-blinkon0 " Reset on exit.

" Cursor
set virtualedit=onemore,block " Allow cursor to the end of the line (and anywhere in visual-block.)

" Numbering
set number relativenumber " Use relative line numbering.

" Wrapping
set linebreak breakindent showbreak=\\ " Visually wrap (and indent wrapped lines).
set list listchars=tab:..,nbsp:~,trail:_,extends:>,precedes:< " Show hidden characters.
set conceallevel=1 " Enable conceal support.

" Clipboard
set clipboard=unnamedplus " Use the system clipboard.

" Search
set ignorecase smartcase " Ignore case when searching, unless a uppercase letter is present.

" Previews
set inccommand=split " Show incomplete commands in a split.
set colorcolumn=+1 " Highlight the wrapping column.

" Splits
set splitright splitbelow " Open vertical splits to the right, horizontal below.
set winminheight=0 " Allow squishing splits.

" Misc
set undofile " Keep persistent undo information.
set hidden " Allow backgrounding buffers.

" Quickfix
autocmd vimrc QuitPre * if &filetype != 'qf' | silent! lclose | endif " Autoclose.

"
" Plugins
"

" ALE
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_sign_warning = '!'
let g:ale_sign_error = 'x'

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
let g:sneak#label = 1 " Enable EasyMotion-style mode.
let g:sneak#s_next = 1 " Press 's' again to skip to the next match.
let g:sneak#f_reset = 1 " Set ; and , when f is used...
let g:sneak#t_reset = 1 " ...same for t.
let g:sneak#absolute_dir = 0 " ; always goes forward, , always goes back.

" Startify
let g:startify_session_dir = $XDG_DATA_HOME . '/nvim/session'
let g:startify_bookmarks = [ 
      \ {'f': '~/.dotfiles/freshrc'}, 
      \ {'v': '~/.dotfiles/config/neovim/init.vim'}, 
      \ {'s': '~/.dotfiles/config/fish/config.fish'}, 
      \ {'t': '~/.dotfiles/config/tmux/main.conf'}, 
      \ {'g': '~/.dotfiles/config/git/config'}, 
      \ ]
let g:startify_commands = [
      \ {'h': ':CheckHealth'},
      \ {'p': ':PackUpdate'},
      \ {'P': ':PackClean'},
      \ {'T': ':terminal'},
      \ ]
autocmd vimrc User Startified setlocal cursorline " Show the cursorline in Startify.
autocmd vimrc User Startified setlocal buftype=nofile " Set the startup buffer to nofile.


" Lightline
autocmd vimrc User ALELint call lightline#update() " Update status bar on lint.
