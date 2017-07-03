let g:mapleader = ' ' " Use an easy leader.

"
" Core
"

" move over virtual lines
nnoremap j gj
nnoremap k gk
" keep indent selection in visual mode
vnoremap < <gv
vnoremap > >gv
" yank to end of line
nnoremap Y y$
" format instead of ex mode
nnoremap Q gq
" keep paste in visual mode
nnoremap pv V`]
vnoremap p p`]

" move across delimiters
nmap <tab> %
" alternate between buffers
nnoremap <backspace> :buffer #<cr>

" open location/quickfix list
nnoremap <leader>l :LocToggle<cr>
nnoremap <leader>q :QFToggle<cr>

" unimapired-style pairs
" argument list
nnoremap [a :previous<cr>
nnoremap ]a :next<cr>
" buffer list
nnoremap [b :bprevious<cr>
nnoremap ]b :bnext<cr>
nnoremap [B :bfirst<cr>
nnoremap ]B :blast<cr>
" tab list
nnoremap [t :tprevious<cr>
nnoremap ]t :tnext<cr>
nnoremap [T :tfirst<cr>
nnoremap ]T :tlast<cr>
" quickfix list
nnoremap ]q :cnext<cr>
nnoremap [q :cprevious<cr>
nnoremap ]Q :clast<cr>
nnoremap [Q :cfirst<cr>
" loclist
nnoremap ]l :lnext<cr>
nnoremap [l :lprevious<cr>
nnoremap ]l :llast<cr>
nnoremap [l :lfirst<cr>
" exchange lines up/down
nnoremap [e :move .-2<cr>==
nnoremap ]e :move .+1<cr>==
vnoremap [e :move '<-2<cr>gv=gv
vnoremap ]e :move '>+1<cr>gv=gv
" insert whitespace
nnoremap [<space> m`o<esc>``
nnoremap ]<space> m`O<esc>``
" ale errors
nmap ]w <plug>(ale_next)
nmap [w <plug>(ale_previous)
nmap ]W <plug>(ale_first)
nmap ]W <plug>(ale_last)

" paste and leave when finished (You Only Paste Once)
nnoremap yo :PasteOnce<cr>o
nnoremap yO :PasteOnce<cr>O

"
" Plugins
"

" EasyAlign
nmap gl   <plug>(EasyAlign)
xmap gl   <plug>(EasyAlign)
vmap <cr> <plug>(EasyAlign)

" FZF
nnoremap <leader><leader> :Buffers<cr>
nnoremap <leader>o :Files<cr>
nnoremap <leader>O :GFiles<cr>
nnoremap <leader>t :BTags<cr>
nnoremap <leader>T :Tags<cr>
nnoremap <leader>` :Marks<cr>
nnoremap <leader>h :Helptags<cr>
nnoremap <leader>a :Ag<cr>
nnoremap <leader>r :Rg<cr>
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Fugitive
nnoremap <leader>c :Gcommit<cr>
nnoremap <leader>p :Gpush<cr>
nnoremap <leader>P :Gpull<cr>
nnoremap <leader>g :Gstatus<cr>
nnoremap <leader>d :Gdiff<cr>
nnoremap <leader>b :Gblame<cr>

" Mundo
nnoremap <leader>u :MundoToggle<cr>

" Obvious Resize
noremap <silent> <c-up>    :<c-u>ObviousResizeUp<cr>
noremap <silent> <c-down>  :<c-u>ObviousResizeDown<cr>
noremap <silent> <c-left>  :<c-u>ObviousResizeLeft<cr>
noremap <silent> <c-right> :<c-u>ObviousResizeRight<cr>

" Sayonara
nnoremap <leader>x :Sayonara<cr>
nnoremap <leader>X :tabclose<cr>

" Sneak
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

