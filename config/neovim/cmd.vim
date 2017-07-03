" Kill trailing whitespace (bang for lines).
function! KillTrailingWhitespace(lines)
  let l:search = @/
  let l:view = winsaveview()
  execute '%s/\s\+$//e'
  if a:lines
    execute '%s/\($\n\s*\)\+\%$//e'
  endif
  let @/ = l:search
  call winrestview(l:view)
endfunction
command! -bang -nargs=* KillTrailingWhitespace call KillTrailingWhitespace(<bang>0)

" Rebuild configuration using Fresh.
function! Fresh()
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
command! Fresh call Fresh()

" Grep using rg.
command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1, <bang>0)

" Toggle quickfix/loclist.
function! QFToggle(loc) abort
  let l:count = winnr('$')

  if a:loc | lclose | else | cclose | endif

  if winnr('$') == l:count
    if a:loc | lopen | else | copen | endif
  endif
endfunction
command! QFToggle call QFToggle(0)
command! LocToggle call QFToggle(1)
