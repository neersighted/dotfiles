let g:mapleader = ' ' " Use an easy leader.

" Core
" move across delimiters
nmap <tab> %
" move over virtual lines
nnoremap j gj
nnoremap k gk
" keep indent selection in visual mode
vnoremap < <gv
vnoremap > >gv
" yank to end of line
nnoremap Y y$
" keep paste in visual mode
nnoremap pv V`]
vnoremap p p`]
" toggle paste mode
set pastetoggle=<f1>
" alternate between buffers
nnoremap <backspace> :buffer #<cr>
" open location/quickfix list
nnoremap <leader>l :lopen<cr>
nnoremap <leader>q :copen<cr>

" EasyAlign
nmap gl   <Plug>(EasyAlign)
xmap gl   <Plug>(EasyAlign)
vmap <cr> <Plug>(EasyAlign)

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

" FZF Completion
inoremap <expr> <c-x><c-x> fzf#vim#complete('tmuxwords.rb --all-but-current --scroll 500 --min 5')
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')
inoremap <expr> <c-x><c-g> fzf#vim#complete#path('find -L . -type d -mindepth 1 -print')
inoremap <expr> <c-x><c-k> fzf#vim#complete#word()
inoremap <expr> <c-x><c-l> fzf#vim#complete#line()

" Gita
nnoremap <leader>g :Gita status<cr>
nnoremap <leader>G :Gita patch<cr>
nnoremap <leader>d :Gita diff-ls<cr>
nnoremap <leader>D :Gita diff<cr>

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

