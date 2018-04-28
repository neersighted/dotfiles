"
" Init
"

" Display start-up time.
let s:startup = reltime()
autocmd VimEnter * echo reltimestr(reltime(s:startup))

" Don't load unused cruft.
let g:loaded_2html_plugin      = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_gzip              = 1
let g:loaded_logipat           = 1
let g:loaded_matchparen        = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_rrhelper          = 1
let g:loaded_tarPlugin         = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_zipPlugin         = 1

"
" Preferences
"

" Clipboard
let g:clipboard = {
  \   'name': 'yankee',
  \   'copy': {
  \      '+': 'yankee-yank -w -s clipboard',
  \      '*': 'yankee-yank -w -s primary',
  \    },
  \   'paste': {
  \      '+': 'yankee-paste -w -s clipboard',
  \      '*': 'yankee-paste -w -s primary',
  \   },
  \   'cache_enabled': 1,
  \ }

" Backend
set undofile " Keep persistent undo information.
set hidden " Allow backgrounding buffers.

" Cursor
set virtualedit=onemore,block " Allow cursor to the end of the line (and anywhere in visual-block.)
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor " Change the cursor between modes.
autocmd VimLeave * set guicursor=a:block-blinkon0 " Reset on exit.

" Environment
if has('nvim')
  let $EDITOR = 'nvr -cc split --remote-wait' " Don't nest neovim, open a new split instead.
  let $VISUAL = $EDITOR
endif

" Mouse
set mouse=a " Enable full mouse support.

" Numbering
set number relativenumber " Use relative line numbering.

" Search
set ignorecase smartcase " Ignore case when searching, unless a uppercase letter is present.

" Status
set noshowmode " Disable the built-in mode indicator.

" Splits
set splitright splitbelow " Open vertical splits to the right, horizontal below.

" Substitution
if has('nvim')
  set inccommand=split " Show incomplete substitutions in a split.
endif

" Term
if !has('nvim') && $TERM =~# 'screen'
  set term=xterm-256color " Handle screen correctly in regular Vim.
endif

" Wrapping
set colorcolumn=+1 " Highlight the wrapping column.
set linebreak breakindent showbreak=\\ " Visually wrap (and indent wrapped lines).
set list listchars=tab:..,nbsp:~,trail:_,extends:>,precedes:< " Show hidden characters.
set conceallevel=1 " Enable conceal support.

"
" Maps
"

let g:mapleader = ' '

" move over virtual lines
nnoremap j gj
nnoremap k gk
" keep indent selection in visual mode
vnoremap < <gv
vnoremap > >gv
" yank to end of line
nnoremap Y y$

" open location/quickfix list
function! s:qftoggle(loc) abort
  let l:count = winnr('$')

  if a:loc | lclose | else | cclose | endif

  if winnr('$') == l:count
    if a:loc | lopen | else | copen | endif
  endif
endfunction
nnoremap <leader>q :silent! call <sid>qftoggle(0)<cr>
nnoremap <leader>l :silent! call <sid>qftoggle(1)<cr>

" navigate pop-up menu
inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<cr>"

" enter paste mode and leave once insert is finished.
function! s:pasteonce() abort
  set paste
  augroup pasteonce
    autocmd!
    autocmd InsertLeave * set nopaste | autocmd! pasteonce
  augroup end
endfunction
nnoremap yo :silent! call <sid>pasteonce()<cr>o
nnoremap yO :silent! call <sid>pasteonce()<cr>O

" terminal escape
tnoremap <esc> <c-\><c-n>

"
" Filetypes
"

" Quickfix
autocmd FileType qf setlocal number norelativenumber nowrap " Enable numbering, disable visual wrapping.

" Ractive
autocmd BufNewFile,BufRead *.ract set filetype=html

" Text
autocmd FileType gitcommit,markdown,text setlocal spell " Enable spellcheck.

" Vim
autocmd FileType vim setlocal keywordprg=:help

"
" Colors
"

" Use true color in non-basic terminals.
if $TERM !~# "^xterm$\|^linux"
  set termguicolors
endif

" Choose light/dark based on time of day.
if strftime('%H') < 12
    set background=dark
else
    set background=light
endif

" Use 16 colors when true color is not supported.
let g:solarized_use16 = 1

" Load solarized8 (preventing double-sourcing in neovim)
if has('nvim')
  let g:colors_name = 'solarized8'
else
  colorscheme solarized8
endif

"
" Status
"

let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '|', 'right': '|' },
  \ 'mode_map': {
  \   'n': 'N', 'i': 'I', 'R': 'R', 'v': 'V', 'V': '-V-', "\<C-v>": '[V]',
  \   'c': ':', 's': 'S', 'S': '-S-', "\<C-s>": '[S]', 't': '$'
  \ },
  \ 'active': {
  \     'left': [
  \       [ 'mode', 'paste' ],
  \       [ 'fugitive', 'fileinfo' ],
  \     ],
  \     'right': [
  \       [ 'ale', 'lineinfo' ],
  \       [ 'percent' ],
  \       [ 'fileformat', 'fileencoding', 'filetype' ],
  \     ],
  \   },
  \   'inactive': {
  \     'left': [
  \       [ 'filename' ],
  \     ],
  \     'right': [
  \       [ 'percent' ],
  \     ],
  \   },
  \   'tabline': {
  \     'left': [
  \       [ 'tabs' ],
  \     ],
  \     'right': [
  \       [ 'cwd' ],
  \     ],
  \   },
  \   'component': {},
  \   'component_function': {
  \     'cwd':          'status#cwd',
  \     'fileencoding': 'status#fileencoding',
  \     'fileformat':   'status#fileformat',
  \     'fileinfo':     'status#fileinfo',
  \     'filename':     'status#filename',
  \     'filetype':     'status#filetype',
  \     'fugitive':     'fugitive#head',
  \     'mode':         'status#mode',
  \     'paste':        'status#paste',
  \   },
  \   'component_expand': {
  \     'ale':      'status#ale',
  \     'lineinfo': 'status#lineinfo',
  \     'percent':  'status#percent',
  \   },
  \   'component_type': {
  \     'ale': 'error',
  \   },
  \ }

"
" Completion
"

autocmd User asyncomplete_setup call s:register_completions()
function! s:register_completions() abort
  " Buffer
  call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ }))

  " Filename
  call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor'),
    \ }))

  " Go
  call asyncomplete#register_source(asyncomplete#sources#gocode#get_source_options({
    \ 'name': 'gocode',
    \ 'whitelist': ['go'],
    \ 'completor': function('asyncomplete#sources#gocode#completor'),
    \ }))

  " Javascript
  call asyncomplete#register_source(asyncomplete#sources#flow#get_source_options({
    \ 'name': 'flow',
    \ 'whitelist': ['javascript'],
    \ 'config': { 'prefer_local': 1, 'show_typeinfo': 1 },
    \ 'completor': function('asyncomplete#sources#flow#completor'),
    \ }))

  " Rust
  call asyncomplete#register_source(asyncomplete#sources#racer#get_source_options({
    \ 'name': 'racer',
    \ 'whitelist': ['rust'],
    \ 'completor': function('asyncomplete#sources#racer#completor'),
    \ }))

  " Syntax
  call asyncomplete#register_source(asyncomplete#sources#necosyntax#get_source_options({
    \ 'name': 'necosyntax',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#necosyntax#completor'),
    \ }))

  " Omnifunc
  call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
    \ 'name': 'omni',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['c', 'cpp', 'html'],
    \ 'completor': function('asyncomplete#sources#omni#completor'),
    \ }))

  " Tags
  call asyncomplete#register_source(asyncomplete#sources#tags#get_source_options({
    \ 'name': 'tags',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#tags#completor'),
    \ }))

  " VimL
  call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
    \ 'name': 'necovim',
    \ 'whitelist': ['vim'],
    \ 'completor': function('asyncomplete#sources#necovim#completor'),
    \ }))
endfunction

autocmd User lsp_setup call s:register_lsp_completions()
function! s:register_lsp_completions() abort
  " C/C++ (clangd)
  if executable('clangd')
    call lsp#register_server({
      \ 'name': 'clangd',
      \ 'cmd': {server_info->['clangd']},
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
      \ })
  endif

  " C/C++ (cquery)
  if executable('cquery')
    call lsp#register_server({
      \ 'name': 'cquery',
      \ 'cmd': {server_info->['cquery']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
      \ })
  endif

  " Python
  if executable('pyls')
    call lsp#register_server({
      \ 'name': 'pyls',
      \ 'cmd': {server_info->['pyls']},
      \ 'whitelist': ['python'],
      \ })
  endif
endfunction
