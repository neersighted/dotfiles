let g:mapleader = ' '

"
" Accessories
"

" ALE
nnoremap <leader>F <plug>(ale_fix)
nnoremap <leader>d <plug>(ale_detail)
nnoremap <leader>f <plug>(ale_find_references)
nnoremap <leader>g <plug>(ale_go_to_definition)
nnoremap <leader>i <plug>(ale_hover)

" fzf
nnoremap <leader><leader> :Buffers<cr>
nnoremap <leader>` :Marks<cr>
nnoremap <leader>/ :BLines<cr>
nnoremap <leader>? :Lines<cr>
nnoremap <leader>Gg :GGrep<cr>
nnoremap <leader>O :GFiles?<cr>
nnoremap <leader>T :Tags<cr>
nnoremap <leader>o :Files<cr>
nnoremap <leader>r :Rg<cr>
nnoremap <leader>t :BTags<cr>

nmap <leader>m <plug>(fzf-maps-n)
omap <leader>m <plug>(fzf-maps-o)
xmap <leader>m <plug>(fzf-maps-x)

" fugitive
nnoremap <leader>Gc :Gcommit<cr>
nnoremap <leader>Gp :Gpush<cr>
nnoremap <leader>GP :Gpull<cr>
nnoremap <leader>Gs :Gstatus<cr>
nnoremap <leader>Gd :Gdiff<cr>
nnoremap <leader>Gb :Gblame<cr>

" Sidebars
nnoremap <leader>u :MundoToggle<cr>
nnoremap <leader>y :TagbarToggle<cr>

"
" Alignment
"

nmap gl   <plug>(EasyAlign)
xmap gl   <plug>(EasyAlign)
vmap <cr> <plug>(EasyAlign)

"
" Buffers
"

" Just delete this buffer!
nnoremap <leader>x :Sayonara<cr>
nnoremap <leader>X :Sayonara!<cr>

"
" Navigation
"

" Move the viewport more quickly.
nnoremap <c-e> 5<c-e>
nnoremap <c-y> 5<c-y>

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

" Center/blink after search.
noremap <expr> <plug>(slash-after) 'zz'.slash#blink(2, 50)

" Sneak on s (and better f/t).
map s <plug>Sneak_s
map S <plug>Sneak_S
map f <plug>Sneak_f
map F <plug>Sneak_F
map t <plug>Sneak_t
map T <plug>Sneak_T
nmap <leader>s <Plug>SneakLabel_s
nmap <leader>S <Plug>SneakLabel_S

let g:sneak#f_reset = 1 " Set ; and , when f is used...
let g:sneak#t_reset = 1 " ...same for t.
let g:sneak#absolute_dir = 0 " Use standard ; and , behavior.

"
" Quickfix
"

" Toggle loclist/quickfix.
nnoremap <leader>q :call maps#qftoggle(1)<cr>
nnoremap <leader>Q :call maps#qftoggle(0)<cr>

"
" Terminal
"

" :terminal escape.
tnoremap <esc> <c-\><c-n>

"
" Visual/Selection
"

" Keep indent selection in visual mode.
vnoremap < <gv
vnoremap > >gv

"
" Windows
"

noremap <silent> <c-up>    :<c-u>ObviousResizeUp<cr>
noremap <silent> <c-down>  :<c-u>ObviousResizeDown<cr>
noremap <silent> <c-left>  :<c-u>ObviousResizeLeft<cr>
noremap <silent> <c-right> :<c-u>ObviousResizeRight<cr>

"
" Yank/Put
"

" Yank to end of line.
nnoremap Y y$

map p <plug>(miniyank-autoput)
map P <plug>(miniyank-autoPut)

map <leader>p <plug>(miniyank-startput)
map <leader>P <plug>(miniyank-startPut)

map <leader>n <plug>(miniyank-cycle)

map <Leader>c <plug>(miniyank-tochar)
map <Leader>l <plug>(miniyank-toline)
map <Leader>b <plug>(miniyank-toblock)
