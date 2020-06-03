"
" Accessories
"

" ALE
nnoremap <c-s>F <plug>(ale_fix)
nnoremap <c-s>d <plug>(ale_detail)
nnoremap <c-s>f <plug>(ale_find_references)
nnoremap <c-s>g <plug>(ale_go_to_definition)
nnoremap <c-s>i <plug>(ale_hover)

" fzf
nnoremap <c-s><c-s> :Buffers<cr>
nnoremap <c-s>` :Marks<cr>
nnoremap <c-s>/ :BLines<cr>
nnoremap <c-s>? :Lines<cr>
nnoremap <m-o> :Files<cr>
nnoremap <c-s>o :Files<cr>
nnoremap <c-s>O :GFiles?<cr>
nnoremap <c-s>T :Tags<cr>
nnoremap <c-s>r :Rg<cr>
nnoremap <c-s>Gg :GGrep<cr>
nnoremap <c-s>t :BTags<cr>

nmap <c-s>m <plug>(fzf-maps-n)
omap <c-s>m <plug>(fzf-maps-o)
xmap <c-s>m <plug>(fzf-maps-x)

" fugitive
nnoremap <c-s>Gc :Gcommit<cr>
nnoremap <c-s>Gp :Gpush<cr>
nnoremap <c-s>GP :Gpull<cr>
nnoremap <c-s>Gs :Gstatus<cr>
nnoremap <c-s>Gd :Gdiff<cr>
nnoremap <c-s>Gb :Gblame<cr>

" Sidebars
nnoremap <c-s>u :MundoToggle<cr>
nnoremap <c-s>y :TagbarToggle<cr>

"
" Alignment
"

nmap gl   <plug>(EasyAlign)
xmap gl   <plug>(EasyAlign)
vmap <cr> <plug>(EasyAlign)

"
" Buffers
"

" Get rid of this window and buffer!
nnoremap <c-s>x :Sayonara<cr>
" Get rid of this buffer but keep the window!
nnoremap <c-s>d :Sayonara!<cr>

"
" Navigation
"

" Move the viewport more quickly.
nnoremap <c-e> 5<c-e>
nnoremap <c-y> 5<c-y>

" Enter paste mode and leave once insert is finished.
nnoremap <silent> yo :call maps#pasteonce()<cr>o
nnoremap <silent> yO :call maps#pasteonce()<cr>O

" Center/blink after search.
noremap <expr> <plug>(slash-after) 'zz'.slash#blink(2, 50)

" Sneak on s (and better f/t).
map s <plug>Sneak_s
map S <plug>Sneak_S
map f <plug>Sneak_f
map F <plug>Sneak_F
map t <plug>Sneak_t
map T <plug>Sneak_T
nmap <c-s>s <Plug>SneakLabel_s
nmap <c-s>S <Plug>SneakLabel_S

let g:sneak#s_next = 1 " Enable 'clever s' jumping.
let g:sneak#f_reset = 1 " Set ; and , when f is used...
let g:sneak#t_reset = 1 " ...same for t.
let g:sneak#absolute_dir = 1 " Make ; and , move in a consistent direction.

"
" Quickfix
"

" Toggle loclist/quickfix.
nnoremap <c-s>q :call maps#qftoggle(1)<cr>
nnoremap <c-s>Q :call maps#qftoggle(0)<cr>

"
" Terminal
"

" :terminal escape.
tnoremap <esc> <c-\><c-n>
" :terminal <esc>.
tnoremap <a-[> <esc>

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

map <c-s>p <plug>(miniyank-startput)
map <c-s>P <plug>(miniyank-startPut)

map <c-s>n <plug>(miniyank-cycle)
map <c-s>N <Plug>(miniyank-cycleback)

map <c-s>c <plug>(miniyank-tochar)
map <c-s>l <plug>(miniyank-toline)
map <c-s>b <plug>(miniyank-toblock)
