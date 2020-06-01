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
