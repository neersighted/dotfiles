"
" Init
"

" Display start-up time.
let s:start_time = reltime()
augroup startup
  autocmd!
  autocmd VimEnter * echo reltimestr(reltime(s:start_time))
augroup end

" Use the proper virtual environments for python support.
let g:python_host_prog = $PYENV_ROOT . '/versions/neovim2/bin/python'
let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim3/bin/python'

" Don't load unused cruft.
let g:loaded_2html_plugin      = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_gzip              = 1
let g:loaded_logiPat           = 1
let g:loaded_matchparen        = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_rrhelper          = 1
let g:loaded_tarPlugin         = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_zipPlugin         = 1

"
" Preferences
"

" Backend
set undofile " Persist undo history.
set hidden " Allow backgrounding dirty buffers.

" Colors
if $COLORTERM ==# 'truecolor'
  set termguicolors " Use truecolor if available.
endif

" Completion
set completeopt=menuone,noselect " Always show a menu, and don't auto-select completions.
set shortmess+=c " Disable completion messages.
set belloff+=ctrlg " Disable completion bells.

" Cursor/Movement
set scrolloff=2 " Keep the cursor two lines from the top/bottom.
set virtualedit=onemore,block " Allow cursor to the end of the line (and anywhere in visual-block.)

" Editing
set autoindent " Indent blocks automatically.
set smarttab " <tab> inserts 'shiftwidth' at the start of the line.
set nojoinspaces " Don't double space after joining punctuation.

" Environment
let $VISUAL = 'nvr -cc split --remote-wait'
let $EDITOR = $VISUAL " Don't nest editors, open a new split instead.

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
set noshowmode laststatus=2 showtabline=2 " Use lightline for the statusline/tabline.

" Splits
set splitright splitbelow " Open vertical splits to the right, horizontal below.

" Substitution
set inccommand=split " Show incomplete substitutions in a preview split.

" Wrapping
set colorcolumn=+1 " Show the wrapping column visually.
set linebreak breakindent showbreak=\\ " Wrap lines visually.
set list listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+ " Show hidden characters.

"
" Maps
"

let g:mapleader = ' '

" :terminal escape.
tnoremap <esc> <c-\><c-n>

" Yank to end of line.
nnoremap Y y$

" Keep indent selection in visual mode.
vnoremap < <gv
vnoremap > >gv

" Move the viewport more quickly.
nnoremap <c-e> <c-e><c-e>
nnoremap <c-y> <c-y><c-y>

" Smooth scrolling.
nnoremap <silent> <c-u> :call maps#smooth_scroll(1)<cr>
nnoremap <silent> <c-d> :call maps#smooth_scroll(0)<cr>

" Enter paste mode and leave once insert is finished.
nnoremap <silent> yo :call maps#pasteonce()<cr>o
nnoremap <silent> yO :call maps#pasteonce()<cr>O

" Navigate Vim/Tmux splits seamlessly.
nnoremap <silent> <c-h> :call maps#navigate('h')<cr>
nnoremap <silent> <c-j> :call maps#navigate('j')<cr>
nnoremap <silent> <c-k> :call maps#navigate('k')<cr>
nnoremap <silent> <c-l> :call maps#navigate('l')<cr>

" Toggle loclist/quickfix.
nnoremap <leader>f :call maps#qftoggle(1)<cr>
nnoremap <leader>F :call maps#qftoggle(0)<cr>

"
" Colors
"

let g:solarized_use16 = 1 " Use 16 colors when true color is not supported.

if strftime('%H') < 12 " Choose light/dark based on time of day.
    set background=dark
else
    set background=light
endif

colorscheme solarized8 " Load colors.
