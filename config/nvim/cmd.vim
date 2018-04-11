" Rebuild configuration using Fresh.
function! s:fresh() abort
  let l:opts = {}
  function! l:opts.on_exit(job_id, exit_code, _)
    if a:exit_code == 0
      bdelete!
      source $MYVIMRC
    endif
  endfunction

  new
  call termopen('fresh', l:opts)
endfunction
command! Fresh call s:fresh()

" Manage packs with minpac.
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

" Enter paste mode and leave once insert is finished.
function! s:pasteonce() abort
  set paste
  augroup pasteonce
    autocmd!
    autocmd InsertLeave * set nopaste | autocmd! pasteonce
  augroup end
endfunction
command! PasteOnce call s:pasteonce()

" Toggle quickfix/loclist.
function! s:qftoggle(loc) abort
  let l:count = winnr('$')

  if a:loc | lclose | else | cclose | endif

  if winnr('$') == l:count
    if a:loc | lopen | else | copen | endif
  endif
endfunction
command! QFToggle call s:qftoggle(0)
command! LocToggle call s:qftoggle(1)

" Grep using rg.
command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1, <bang>0)
