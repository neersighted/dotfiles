function! maps#pasteonce() abort
  set paste
  augroup pasteonce
    autocmd!
    autocmd InsertLeave * set nopaste | autocmd! pasteonce
  augroup end
endfunction

function! maps#qftoggle(loc) abort
  let l:count = winnr('$')

  if a:loc | lclose | else | cclose | endif

  if winnr('$') == l:count
    if a:loc | lopen | else | copen | endif
  endif
endfunction

function! maps#smooth_scroll(up)
  execute 'normal! '.(a:up ? "\<c-y>" : "\<c-e>")
  redraw
  for l:count in range(3, &scroll, 2)
    sleep 10m
    execute 'normal! '.(a:up ? "\<c-y>" : "\<c-e>")
    redraw
  endfor
endf
