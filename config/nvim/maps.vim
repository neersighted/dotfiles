let g:mapleader = ' '

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

" alternate between buffers
nnoremap <backspace> :buffer #<cr>

" open location/quickfix list
nnoremap <leader>l :LocToggle<cr>
nnoremap <leader>q :QFToggle<cr>

" unimapired-style pairs
" argument list
nnoremap [v :previous<cr>
nnoremap ]v :next<cr>
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
nnoremap ]L :llast<cr>
nnoremap [L :lfirst<cr>
" exchange lines up/down
nnoremap [e :move .-2<cr>==
nnoremap ]e :move .+1<cr>==
vnoremap [e :move '<-2<cr>gv=gv
vnoremap ]e :move '>+1<cr>gv=gv
" insert whitespace
nnoremap [<space> m`O<esc>``
nnoremap ]<space> m`o<esc>``
" ale errors
nmap ]a <plug>(ale_next)
nmap [a <plug>(ale_previous)
nmap ]A <plug>(ale_first)
nmap ]A <plug>(ale_last)

" paste and leave when finished (You Only Paste Once)
nnoremap yo :PasteOnce<cr>o
nnoremap yO :PasteOnce<cr>O

" terminal escape
tnoremap <esc> <c-\><c-n>

"
" Plugins
"

"
" ALE
"
nnoremap <leader>a <plug>(ale_fix)

" asyncomplete
imap <c-g> <plug>(asyncomplete_force_refresh)
inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<cr>"

" EasyAlign
nmap gl   <plug>(EasyAlign)
xmap gl   <plug>(EasyAlign)
vmap <cr> <plug>(EasyAlign)

" FZF
nnoremap <leader><leader> :Buffers<cr>
nnoremap <leader>o :Files<cr>
nnoremap <leader>O :GFiles<cr>
nnoremap <leader>C :GFiles?<cr>
nnoremap <leader>r :Rg<cr>
nnoremap <leader>G :GGrep<cr>
nnoremap <leader>f :BLines<cr>
nnoremap <leader>F :Lines<cr>
nnoremap <leader>t :BTags<cr>
nnoremap <leader>T :Tags<cr>
nnoremap <leader>h :BCommits<cr>
nnoremap <leader>H :Commits<cr>
nnoremap <leader>` :Marks<cr>
nnoremap <leader>? :Helptags<cr>
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
map f <plug>Sneak_f
map F <plug>Sneak_F
map t <plug>Sneak_t
map T <plug>Sneak_T
nmap <leader>s <Plug>SneakLabel_s
nmap <leader>S <Plug>SneakLabel_S
