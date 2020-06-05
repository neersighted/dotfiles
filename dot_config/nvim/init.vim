scriptencoding utf-8

"
" Profiling
"

let s:start_time = reltime()
augroup startup
  autocmd!
  autocmd VimEnter * if !empty(nvim_list_uis()) | echo reltimestr(reltime(s:start_time)) | endif
augroup end

"
" Preferences
"

" Backend
set undofile " Persist undo history.
set hidden " Allow backgrounding dirty buffers.

" Colors
set termguicolors " Use 24-bit color.
let g:colors_name = util#has_colorscheme('nord') ? 'nord' : 'default' " Use nord if available.

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
set number relativenumber " Show (relative) line numbers.
augroup numbertoggle " Toggle 'relativenumber' on insert.
  autocmd!
  autocmd InsertEnter,BufLeave,WinLeave,FocusLost * nested
            \ if &l:number && empty(&buftype) |
            \ setlocal norelativenumber |
            \ endif
  autocmd InsertLeave,BufEnter,WinEnter,FocusGained * nested
              \ if &l:number && mode() != 'i' && empty(&buftype) |
              \ setlocal relativenumber |
              \ endif
augroup END

" Remote Plugins
let g:loaded_python_provider = 0 " Disable Python 2.
let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim/bin/python' " Locate Python 3 venv.

" Search
set ignorecase smartcase " Ignore case when searching, unless a uppercase letter is present.
noremap <expr> <plug>(slash-after) 'zz'.slash#blink(2, 50)| " Center/blink after search.

" Status
set noshowmode showtabline=2 " Hide mode, always show tabline.

" Splits
set splitright splitbelow " Open vertical splits to the right, horizontal below.
let g:obvious_resize_run_tmux = 1 " Enable Tmux resizing integration.

" Sneak
let g:sneak#s_next = 1 " Enable 'clever s' jumping.
let g:sneak#f_reset = 1 " Set ; and , when f is used...
let g:sneak#t_reset = 1 " ...same for t.
let g:sneak#absolute_dir = 1 " Make ; and , move in a consistent direction.

" Substitution
set inccommand=split " Show incomplete substitutions in a preview split.

" Syntax
let g:go_highlight_build_constraints = 1
let g:python_highlight_all = 1

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
let g:carbon_now_sh_options = {
      \ 't': g:colors_name,
      \ 'fm': 'Source Code Pro',
      \ }
let g:loaded_matchit = 1 " Disable matchit.
let g:loaded_matchparen = 1 " Disable matchparen.
let g:loaded_netrwPlugin = 1 " Disable Netrw.
let g:startuptime_self = 1 " Use 'self' time when profiling.

"
" Maps
"

" fzf
nnoremap <c-s><c-s> :Buffers<cr>
nnoremap <m-o> :Files<cr>
nnoremap <c-s>o :Files<cr>
nnoremap <c-s>' :Marks<cr>
nnoremap <c-s>/ :BLines<cr>
nnoremap <c-s><c-/> :Lines<cr>
nnoremap <c-s>r :Rg<cr>
nnoremap <c-s><c-r> :Ggrep<cr>
nnoremap <c-s>t :BTags<cr>
nnoremap <c-s><c-t> :Tags<cr>

nmap <c-s>? <plug>(fzf-maps-n)
omap <c-s>? <plug>(fzf-maps-o)
xmap <c-s>? <plug>(fzf-maps-x)

" Sidebars
nnoremap <c-s>m :ToggleMarkbar<cr>
nnoremap <c-s>u :MundoToggle<cr>
nnoremap <c-s>y :TagbarToggle<cr>

" Align text using EasyAlign.
nmap gl   <plug>(EasyAlign)
xmap gl   <plug>(EasyAlign)
vmap <cr> <plug>(EasyAlign)

" EasyMotion-style Sneak.
nmap <c-s>s <Plug>SneakLabel_s
nmap <c-s>S <Plug>SneakLabel_S

" Sneak on s (and better f/t).
map s <plug>Sneak_s
map S <plug>Sneak_S
map f <plug>Sneak_f
map F <plug>Sneak_F
map t <plug>Sneak_t
map T <plug>Sneak_T

" Keep indent selection in visual mode.
vnoremap < <gv
vnoremap > >gv

" Yank to end of line.
nnoremap Y y$

" Put (tracking history).
map p <plug>(miniyank-autoput)
map P <plug>(miniyank-autoPut)

" Put from shared register.
map <c-s>p <plug>(miniyank-startput)
map <c-s>P <plug>(miniyank-startPut)

" Cycle yank history
map <c-s>pn <plug>(miniyank-cycle)
map <c-s>pp <Plug>(miniyank-cycleback)

" Force register type.
map <c-s>pc <plug>(miniyank-tochar)
map <c-s>pl <plug>(miniyank-toline)
map <c-s>pb <plug>(miniyank-toblock)

" Enter paste mode and leave once insert is finished.
nnoremap <silent> yo :call maps#pasteonce()<cr>o
nnoremap <silent> yO :call maps#pasteonce()<cr>O

" Simple buffer/window management.
nnoremap <c-s>x :Sayonara<cr>
nnoremap <c-s>d :Sayonara!<cr>

" Simple resizing.
noremap <silent> <c-up>    :<c-u>ObviousResizeUp<cr>
noremap <silent> <c-down>  :<c-u>ObviousResizeDown<cr>
noremap <silent> <c-left>  :<c-u>ObviousResizeLeft<cr>
noremap <silent> <c-right> :<c-u>ObviousResizeRight<cr>

" Make <c-e>/<c-y> faster.
nnoremap <c-e> 5<c-e>
nnoremap <c-y> 5<c-y>

" Toggle loclist/quickfix.
nnoremap <c-s>q :call maps#qftoggle(1)<cr>
nnoremap <c-s>Q :call maps#qftoggle(0)<cr>

" Ergonomic :terminal escape.
tnoremap <esc> <c-\><c-n>
tnoremap <a-[> <esc>
