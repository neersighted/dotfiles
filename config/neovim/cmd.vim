function! Preserve(cmd) " Execute a command without altering position/history.
  let l:old_search = @/
  let l:cursor_l = line('.')
  let l:cursor_c = col('.')
  execute a:cmd
  let @/ = l:old_search
  call cursor(l:cursor_l, l:cursor_c)
endfunction

" kill trailing whitespace
command! -bang -nargs=* KillTrailingWhitespace call Preserve('%s/\s\+$//e')
" ripgrep
command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
