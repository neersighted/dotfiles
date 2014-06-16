"
" I/O
"

" Enable filetype detection, and autoload ftplugin/indent scripts.
filetype plugin indent on

" Background buffers.
set hidden
" Automatically read files from disk.
set autoread

" Default to Unix line endings.
set fileformats=unix,dos,mac
" Use UTF-8 for everything.
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

" Save the marks for the last 50 files, and 1000 register lines; but don't save
" global variables, search highlighting status, or the buffer list.
set viminfo='50,<1000,h
" Save 100 lines of command-line and search history.
set history=100
" Save view/session to view/session files.
set viewoptions=cursor,folds
set sessionoptions=curdir,folds,blank,buffers,tabpages,resize,winsize,winpos

" Use swapfiles, backups, and persist undo data.
set swapfile
set backup
set undofile

" Store backend files in a central directory, and ensure they exist.
let &directory = expand(g:dir)."/swap"
call EnsureDir(&directory)

let &backupdir = expand(g:dir)."/backups"
call EnsureDir(&backupdir) 

if has("persistent_undo")
    let &undodir = expand(g:dir)."/undo"
    call EnsureDir(&undodir)
endif

if has("mksession")
    let &viewdir = expand(g:dir)."/view"
    call EnsureDir(&viewdir)
endif

"
" Appearance
"

" Enable syntax highlighting.
syntax on

" Default to light colors.
set background=light
" Use Solarized as the default colorscheme (and fail silently).
silent! colorscheme solarized
" Change colors based on the time.
if strftime("%H") >= 6 && strftime("%H") <= 18
  set background=light
  silent! AirlineRefresh
else
  set background=dark
  silent! AirlineRefresh
endif

" Enable folding.
set foldenable
" Use syntax plugins to determine where to fold.
set foldmethod=syntax
" Automatically unfold when these commands are run.
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo

" Use visual error bells.
set noerrorbells
set visualbell
" Use abbreviations and disable 'Press Enter to Continue' messages.
set shortmess+=filmnrxoOtT

" Use hybrid line numbers.
set number
set relativenumber

" Highlight the wrapping column.
let &colorcolumn=&textwidth
" Show 'crosshairs' on the cursor.
set cursorline
set cursorcolumn
if has("autocmd")
    augroup rulers
        au!
        autocmd WinEnter,FocusGained,InsertLeave * setlocal cursorline cursorcolumn
        autocmd WinLeave,FocusLost,InsertEnter * setlocal nocursorline nocursorcolumn
    augroup end
endif

" Show hidden characters.
set list
" Show matched characters.
set showmatch

if has("+conceal")
    " Totally conceal if no replacement exists.
    set conceallevel=2

    " Only conceal the cursor line in normal and command mode.
    set concealcursor=nc
endif

" Disable the built-in mode indicator.
set noshowmode
" Disable command displaying in status bar
set noshowcmd
" Disable the built in ruler.
set noruler

" Airline: Use pretty Powerline fonts.
let g:airline_powerline_fonts = 1
" Airline: Use abbreviated mode indicators.
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }
" Airline: extensions.
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 1

" Bufferline: Only show Bufferline in the statusbar.
let g:bufferline_echo = 0

" indentLine: Like SLT2:
let g:indentLine_char = '┊'

"
" GUI Appearance
"

" Disable GUI menus.
set guioptions-=m
" Disable the toolbar.
set guioptions-=T
" Disable GUI tabs.
set guioptions-=e
" Hide scrollbars.
set guioptions-=r
set guioptions-=L

" This is my font. There are many like it, but this one is mine.
if has("gui_macvim")
  set guifont=Source\ Code\ Pro\ Light:h10
else
  set guifont=Source\ Code\ Pro\ Light\ 7.5
endif

if has("gui_macvim")
    " Antialias the font in MacVim.
    set antialias
endif

"
" Editing
"

" Enable spell checking.
set spell
set spelllang=en_us

" Use the system clipboard for yank/paste.
if has("unnamedplus")
    set clipboard=unnamedplus,autoselectplus
else
    set clipboard=unnamed,autoselect
endif

" Default to 4-space(!!!) indents
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
" Automatically indent new lines based on the last one.
set autoindent
if has("smartindent")
    " Indent further when language blocks (such as {}/do and end) are found.
    set smartindent
endif
" Round the indent.
set shiftround

" Wrap the cursor over lines.
set whichwrap=h,l,<,>,[,],b,s
set backspace=indent,eol,start
if has("virtualedit")
    set virtualedit=onemore,block
endif

" Wrap inserted text at 80 characters
set textwidth=79
" Enable virtual wrapping, but only between words, and only when out of room.
set wrap
set linebreak
set wrapmargin=0

" Open splits in the top-right corner.
set splitright
" Let splits get squished down to one line.
set winminheight=0

if has("autocmd")
    " Resize splits when Vim is resized:
    augroup resize
        au!
        autocmd VimResized * :wincmd =
    augroup end
endif

" Seek: Include the bundled jumps.
let g:seek_enable_jumps = 1

" UtiliSnips: Use honza's snippets.
let g:UltiSnipsSnippetsDir = g:bundle_dir."/vim-snippets/snippets"

"
" Search
"

" Use Ag instead of grep.
if executable("ag")
    let &grepprg = "ag --nogroup --nocolor"
endif

" Enable escape characters.
set magic

if has("extra_search")
" Highlight searches as they are typed.
    set hlsearch
    set incsearch
endif

" Automatically infer case options.
set ignorecase
set smartcase
set infercase

"
" Tools
"

" CtrlP:
" Use the VCS root, then Vim's pwd.
let g:ctrlp_working_path_mode = "rw"
" Follow symlinks.
let g:ctrlp_follow_symlinks = 1

" Enable extensions.
let g:ctrlp_extensions = ['mixed']

" Reuse buffers if a file is already open.
let g:ctrlp_switch_buffer = "ET"
" Open new files in vertical split.
let g:ctrlp_open_new_file = "v" " When opening multiple files, open two vertical splits, then use hidden
" buffers.
let g:ctrlp_open_multiple_files = "r2vj"

" Use Ag for blazing fast indexing, respecting VCS ignores.
if executable("ag")
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
    let g:ctrlp_user_command = {
        \ 'types': {
            \ 1: ['.git', 'cd %s && git ls-files'],
            \ 2: ['.hg', 'hg --cwd %s locate -I .'],
            \ },
        \ 'fallback': 'find %s -type f'
        \ }
endif

" Cache the index.
let g:ctrlp_use_caching = 1
" Let the cache persist after quitting.
let g:ctrlp_clear_cache_on_exit = 0

" NERDTree:
" Show all files.
let g:NERDTreeShowFiles  = 1
let g:NERDTreeShowHidden = 1
" Use fancy UTF-8 arrows.
let g:NERDTreeDirArrows = 1
" Hide help.
let g:NERDTreeMinimalUI = 1
" Sync NERDTree's root with Vim's pwd.
let g:NERDTreeChDirMode = 2

" Startify:
" Show these categories.
let g:startify_list_order = ['files', 'bookmarks', 'sessions']

" Show X number of files.
let g:startify_files_number = 10
" Always show these files.
let g:startify_bookmarks = [
            \ "~/.freshrc",
            \ "~/.dotfiles/config/vim" ]

" Save the cursor position.
let g:startify_restore_position = 1
" Save session files here.
let g:startify_session_dir = expand(g:dir)."/session"

" Syntastic:
" Enable error indicators (via signs).
let g:syntastic_enable_signs = 1
" Auto-show the Syntastic LOC.
let g:syntastic_auto_loc_list = 1
"
" Don't check on write-quit.
let g:syntastic_check_on_wq = 0

"
" Input
"

" Make mapping timeouts faster, and keycode timeouts even faster.
set timeout
set timeoutlen=500
set ttimeout
set ttimeoutlen=50
