function! Preserve(cmd) " Execute a command without altering position/history.
  let old_search = @/
  let cursor_l = line('.')
  let cursor_c = col('.')
  execute a:cmd
  let @/ = old_search
  call cursor(cursor_l, cursor_c)
endfunction

" kill trailing whitespace
command! -bang -nargs=* KillTrailingWhitespace call Preserve('%s/\s\+$//e')
" ripgrep
command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
