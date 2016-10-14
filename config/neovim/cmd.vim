function! KillTrailingWhitespace(lines) " Kill trailing whitespace/lines.
  let l:search = @/
  let l:view = winsaveview()
  execute '%s/\s\+$//e'
  if a:lines
    execute '%s/\($\n\s*\)\+\%$//e'
  endif
  let @/ = l:search
  call winrestview(l:view)
endfunction

" kill trailing whitespace (bang for lines)
command! -bang -nargs=* KillTrailingWhitespace call KillTrailingWhitespace(<bang>0)
" rehash configuration
command! -bang -nargs=* Rehash terminal fresh; nvr -c 'source \$MYVIMRC' -c Sayonara
" ripgrep
command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
